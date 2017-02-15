import Foundation

class MLinearEquationsSolutionStrategyOnlyPivots:MLinearEquationsSolutionStrategy
{
    class func pivotRepeated(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyOnlyPivots?
    {
        let countEquations:Int = step.equations.count
        
        if countEquations > 1
        {
            for indexEquation:Int in 1 ..< countEquations
            {
                let indexItem:Int = countEquations - indexEquation
                let equation:MLinearEquationsSolutionEquation = step.equations[indexItem]
                let pivotIndex:Int = equation.pivotIndex()
                
                guard
                    
                    let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = equation.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                    
                else
                {
                    continue
                }
                
                for prevIndex:Int in 0 ..< indexItem
                {
                    let equationAbove:MLinearEquationsSolutionEquation = step.equations[prevIndex]
                    
                    guard
                        
                        let itemAbove:MLinearEquationsSolutionEquationItemPolynomial = equationAbove.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                        
                    else
                    {
                        continue
                    }
                    
                    if abs(itemAbove.coefficient) > MSession.sharedInstance.kMinNumber
                    {
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
                                indexPivot:indexItem,
                                indexAbove:prevIndex,
                                scalar:scalar)
                            
                            return strategy
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private let indexPivot:Int
    private let indexAbove:Int
    private let scalar:Double
    
    private init(
        step:MLinearEquationsSolutionStep,
        indexPivot:Int,
        indexAbove:Int,
        scalar:Double)
    {
        self.indexPivot = indexPivot
        self.indexAbove = indexAbove
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
            "\(indexAbove + 1)",
            "\(indexAbove + 1)",
            "\((indexPivot + 1))",
            scalarString)
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == indexAbove
            {
                let pivotEquation:MLinearEquationsSolutionEquation = self.step.equations[indexPivot]
                let scaledPivot:MLinearEquationsSolutionEquation = pivotEquation.multiplyScalar(
                    scalar:scalar)
                
                newEquation = equation.addEquation(
                    equation:scaledPivot)
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
