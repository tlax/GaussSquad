import Foundation

class MLinearEquationsSolutionStrategy
{
    weak var step:MLinearEquationsSolutionStep!
    private weak var delegate:MLinearEquationsSolutionStrategyDelegate?
    
    class func strategyFor(
        step:MLinearEquationsSolutionStep,
        indeterminates:MLinearEquationsSolutionIndeterminates?) -> MLinearEquationsSolutionStrategy?
    {
        if let reduction:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReduction.reducible(
            step:step)
        {
            return reduction
        }
        else if let indeterminatesLeft:MLinearEquationsSolutionStrategyIndeterminatesLeft = MLinearEquationsSolutionStrategyIndeterminatesLeft.indeterminatesRight(
            step:step)
        {
            return indeterminatesLeft
        }
        else if let makeZero:MLinearEquationsSolutionStrategyMakeZero = MLinearEquationsSolutionStrategyMakeZero.onlyZeros(
            step:step)
        {
            return makeZero
        }
        else if let fractionReduction:MLinearEquationsSolutionStrategyFractionReduction = MLinearEquationsSolutionStrategyFractionReduction.reducible(
            step:step)
        {
            return fractionReduction
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
