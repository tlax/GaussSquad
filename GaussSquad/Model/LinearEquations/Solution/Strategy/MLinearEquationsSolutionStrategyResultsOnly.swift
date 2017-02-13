import Foundation

class MLinearEquationsSolutionStrategyResultsOnly:MLinearEquationsSolutionStrategy
{
    class func finished(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyResultsOnly?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let pivotIndex:Int = equation.pivotIndex()
            
            guard
                
                let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = equation.items[pivotIndex] as? MLinearEquationsSolutionEquationItemPolynomial
                
                else
            {
                continue
            }
            
            let coefficient:Double = pivotItem.coefficient
            
            if coefficient != 1
            {
                let scalar:Double = 1 / coefficient
                let strategy:MLinearEquationsSolutionStrategyRemoveCoefficients = MLinearEquationsSolutionStrategyRemoveCoefficients(
                    step:step,
                    indexRow:indexEquation,
                    scalar:scalar)
                
                return strategy
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
        
        removeCoefficient()
    }
    
    //MARK: private
    
    private func removeCoefficient()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        let scalarString:String = MSession.sharedInstance.stringFrom(number:scalar)
        let descr:String = String(
            format:NSLocalizedString("MLinearEquationsSolutionStrategyRemoveCoefficients_descr", comment:""),
            "\(indexRow + 1)",
            scalarString)
        
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            let newEquation:MLinearEquationsSolutionEquation
            
            if indexEquation == indexRow
            {
                newEquation = equation.multiplyScalar(
                    scalar:scalar)
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
