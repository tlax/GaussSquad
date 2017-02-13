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
                    let nextIndex:Int = indexEquation + 1
                    let equationBelow:MLinearEquationsSolutionEquation = step.equations[nextIndex]
                    
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
                            
                            let topCoefficient:Double = topPolynomial.coefficient
                            let bottomCoefficient:Double = bottomPolynomial.coefficient
                            var scalar:Double = abs(bottomCoefficient / topCoefficient)
                            
                            if topCoefficient > 0
                            {
                                if bottomCoefficient > 0
                                {
                                    scalar = -scalar
                                }
                            }
                            else
                            {
                                if bottomCoefficient < 0
                                {
                                    scalar = -scalar
                                }
                            }
                            
                            let strategy:MLinearEquationsSolutionStrategyRowAddition = MLinearEquationsSolutionStrategyRowAddition(
                                step:step,
                                indexRow:nextIndex,
                                scalar:scalar)
                            
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
    private let scalar:Double
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexRow:Int,
        scalar:Double)
    {
        self.indexRow = indexRow
        self.scalar = scalar
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
        let scalarString:String = MSession.sharedInstance.stringFrom(number:scalar)
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyRowAddition_descr", comment:""),
            "\(indexRow + 1)",
            "\(indexRow + 1)",
            "\((indexRow))",
            scalarString)
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == indexRow
            {
                let previousEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation - 1]
                let scaledPrevious:MLinearEquationsSolutionEquation = previousEquation.multiplyScalar(
                    scalar:scalar)
                
                newEquation = equation.addEquation(
                    equation:scaledPrevious)
            }
            else
            {
                newEquation = equation
            }
            
            equations.append(newEquation)
            
            indexEquation += 1
        }
        
        let step:MLinearEquationsSolutionStepProcess = MLinearEquationsSolutionStepProcess(
            equations:equations,
            descr:descr)
        completed(step:step)
    }
}
