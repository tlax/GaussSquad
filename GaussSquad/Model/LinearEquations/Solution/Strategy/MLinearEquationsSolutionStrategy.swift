import Foundation

class MLinearEquationsSolutionStrategy
{
    weak var step:MLinearEquationsSolutionStep!
    private weak var delegate:MLinearEquationsSolutionStrategyDelegate?
    
    class func strategyFor(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategy?
    {
        if let reduction:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReduction.reducible(
            step:step)
        {
            return reduction
        }
        else if let removeZeros:MLinearEquationsSolutionStrategyRemoveZeros = MLinearEquationsSolutionStrategyRemoveZeros.hasZeros(
            step:step)
        {
            return removeZeros
        }
        
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
