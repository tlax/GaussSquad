import Foundation

class MLinearEquationsSolutionStrategyValidateRows:MLinearEquationsSolutionStrategy
{
    class func rowsError(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyValidateRows?
    {
        let countRows:Int = step.equations.count
        
        if countRows < 1
        {
            let descr:String = NSLocalizedString("MLinearEquationsSolutionStrategyValidateTotalRows_emptyRows", comment:"")
            let strategy:MLinearEquationsSolutionStrategyValidateRows = MLinearEquationsSolutionStrategyValidateRows(
                step:step,
                descr:descr)
            
            return strategy
        }
        
        return nil
    }
    
    private let descr:String
    
    private init(
        step:MLinearEquationsSolutionStep,
        descr:String)
    {
        self.descr = descr
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        showError()
    }
    
    //MARK: private
    
    private func showError()
    {
        let equations:[MLinearEquationsSolutionEquation] = self.step.equations
        let step:MLinearEquationsSolutionStepError = MLinearEquationsSolutionStepError(
            equations:equations,
            descr:descr)
        
        completed(step:step)
    }
}
