import Foundation

class MLinearEquationsSolutionStrategyOnlyPivots:MLinearEquationsSolutionStrategy
{
    class func pivotRepeated(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyOnlyPivots?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            if indexEquation > 0
            {
                let prevIndex:Int = indexEquation - 1
                let equationAbove:MLinearEquationsSolutionEquation = step.equations[prevIndex]
                let pivotIndex:Int = equation.pivotIndex()
                
                guard
                
                    let itemAbove:MLinearEquationsSolutionEquationItemPolynomial = equationAbove.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                
                else
                {
                    continue
                }
                
                if abs(itemAbove.coefficient) > MSession.sharedInstance.kMinNumber
                {
                    guard
                    
                        let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = equation.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                    
                    else
                    {
                        continue
                    }
                    
                    if pivotItem.indeterminate === itemAbove.indeterminate
                    {
                        let topCoefficient:Double = itemAbove.coefficient
                        let bottomCoefficient:Double = pivotItem.coefficient
                        var scalar:Double = abs(topCoefficient / bottomCoefficient)
                        
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
                        
                        let strategy:MLinearEquationsSolutionStrategyOnlyPivots = MLinearEquationsSolutionStrategyOnlyPivots(
                            step:step,
                            indexRow:prevIndex,
                            scalar:scalar)
                        
                        return strategy
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
            format:NSLocalizedString("MLinearEquationsSolutionStrategyOnlyPivots_descr", comment:""),
            "\(indexRow + 1)",
            "\(indexRow + 1)",
            "\((indexRow + 2))",
            scalarString)
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == indexRow
            {
                let nextEquation:MLinearEquationsSolutionEquation = self.step.equations[indexEquation + 1]
                let scaledNext:MLinearEquationsSolutionEquation = nextEquation.multiplyScalar(
                    scalar:scalar)
                
                newEquation = equation.addEquation(
                    equation:scaledNext)
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
