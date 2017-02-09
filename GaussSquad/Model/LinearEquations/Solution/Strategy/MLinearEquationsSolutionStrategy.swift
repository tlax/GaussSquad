import Foundation

class MLinearEquationsSolutionStrategy
{
    private weak var delegate:MLinearEquationsSolutionStrategyDelegate?
    
    class func strategyFor(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategy.Type?
    {
        return nil
    }
    
    init(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        self.delegate = delegate
    }
    
    //MARK: public
    
    func completed(step:MLinearEquationsSolutionStep)
    {
        delegate?.solutionStrategyCompleted(step:step)
    }
}
