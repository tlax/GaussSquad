import Foundation

class MLinearEquationsSolutionStrategyRowAddition:MLinearEquationsSolutionStrategy
{
    class func samePivot(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRowAddition?
    {
        var indexEquation:Int = 0
        let countEquations:Int = step.equations.count
        let maxEquation:Int = countEquations - 1
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            if indexEquation < maxEquation
            {
                if equation.nonZero()
                {
                    let equationBelow:MLinearEquationsSolutionEquation = step.equations[indexEquation + 1]
                    
                    if equationBelow.nonZero()
                    {
                        let pivotIndex:Int = equation.pivotIndex()
                        let pivotIndexBelow:Int = equationBelow.pivotIndex()
                        
                        if pivotIndex == pivotIndexBelow
                        {
                            guard
                                
                                let topPolynomial:MLinearEquationsSolutionEquationItemPolynomial = equation.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial,
                                let bottomPolynomial:MLinearEquationsSolutionEquationItemPolynomial = equationBelow.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                            
                            else
                            {
                                return nil
                            }
                            
                            let scalar:Double
                            
                            
                            if
                            
                            let strategy:MLinearEquationsSolutionStrategyRowAddition = MLinearEquationsSolutionStrategyRowAddition(
                                step:step,
                                indexRow:indexEquation)
                            
                            return strategy
                        }
                    }
                }
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    private let indexRow:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexRow:Int)
    {
        self.indexRow = indexRow
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        addRows()
    }
    
    //MARK: private
    
    private func addRows()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyPivotOrdering_descr", comment:""),
            "\((indexRowA + 1))",
            "\((indexRowB + 1))")
        
        let totalEquations:Int = self.step.equations.count
        
        for indexEquation:Int in 0 ..< totalEquations
        {
            if indexEquation == indexRowA
            {
                let equationB:MLinearEquationsSolutionEquation = self.step.equations[indexRowB]
                let indexedEquation:MLinearEquationsSolutionEquation = equationB.reIndexed(
                    newIndex:indexEquation)
                equations.append(indexedEquation)
            }
            else if indexEquation == indexRowB
            {
                let equationA:MLinearEquationsSolutionEquation = self.step.equations[indexRowA]
                let indexedEquation:MLinearEquationsSolutionEquation = equationA.reIndexed(
                    newIndex:indexEquation)
                equations.append(indexedEquation)
            }
            else
            {
                let equation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation]
                equations.append(equation)
            }
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
