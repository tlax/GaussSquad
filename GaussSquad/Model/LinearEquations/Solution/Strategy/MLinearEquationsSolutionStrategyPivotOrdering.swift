import Foundation

class MLinearEquationsSolutionStrategyPivotOrdering:MLinearEquationsSolutionStrategy
{
    class func indeterminateUnordered(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyPivotOrdering?
    {
        var indexEquationA:Int = 0
        let countEquations:Int = step.equations.count
        
        for equationA:MLinearEquationsSolutionEquation in step.equations
        {
            let pivotIndexA:Int = equationA.pivotIndex()
            
            for indexEquationB:Int in indexEquationA + 1 ..< countEquations
            {
                let equationB:MLinearEquationsSolutionEquation = step.equations[indexEquationB]
                let pivotIndexB:Int = equationB.pivotIndex()
                
                if pivotIndexA > pivotIndexB
                {
                    let strategy:MLinearEquationsSolutionStrategyPivotOrdering = MLinearEquationsSolutionStrategyPivotOrdering(
                        step:step,
                        indexRowA:indexEquationA,
                        indexRowB:indexEquationB)
                    
                    return strategy
                }
            }
            
            indexEquationA += 1
        }
        
        return nil
    }
    
    private let indexRowA:Int
    private let indexRowB:Int
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexRowA:Int,
        indexRowB:Int)
    {
        self.indexRowA = indexRowA
        self.indexRowB = indexRowB
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        order()
    }
    
    //MARK: private
    
    private func order()
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
