import Foundation

class MLinearEquationsSolutionStrategy
{
    private weak var delegate:MLinearEquationsSolutionStrategyDelegate?
    private weak var step:MLinearEquationsSolutionStep?
    
    class func strategyFor(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategy?
    {
        return nil
    }
    
    init(step:MLinearEquationsSolutionStep?)
    {
        self.step = step
    }
    
    //MARK: public
    
    func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        self.delegate = delegate
    }
    
    func completed(step:MLinearEquationsSolutionStep)
    {
        delegate?.solutionStrategyCompleted(step:step)
    }
    
    func foundIndeterminates(indeterminates:MLinearEquationsSolutionIndeterminates)
    {
        delegate?.solutionStrategyIndeterminates(
            indeterminates:indeterminates)
    }
}
