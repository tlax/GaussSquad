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
        else if let removeZero:MLinearEquationsSolutionStrategyRemoveZero = MLinearEquationsSolutionStrategyRemoveZero.onlyZeros(
            step:step)
        {
            return removeZero
        }
        else if let fractionReduction:MLinearEquationsSolutionStrategyFractionReduction = MLinearEquationsSolutionStrategyFractionReduction.reducible(
            step:step)
        {
            return fractionReduction
        }
        else if let zeroFill:MLinearEquationsSolutionStrategyZeroFill = MLinearEquationsSolutionStrategyZeroFill.missingIndeterminate(
            step:step,
            indeterminates:indeterminates)
        {
            return zeroFill
        }
        else if let orderIndeterminates:MLinearEquationsSolutionStrategyOrderIndeterminates = MLinearEquationsSolutionStrategyOrderIndeterminates.indeterminateUnordered(
            step:step,
            indeterminates:indeterminates)
        {
            return orderIndeterminates
        }
        else if let rowAddition:MLinearEquationsSolutionStrategyRowAddition = MLinearEquationsSolutionStrategyRowAddition.samePivot(
            step:step)
        {
            return rowAddition
        }
        else if let pivotOrdering:MLinearEquationsSolutionStrategyPivotOrdering = MLinearEquationsSolutionStrategyPivotOrdering.rowUnordered(
            step:step)
        {
            return pivotOrdering
        }
        else if let onlyPivots:MLinearEquationsSolutionStrategyOnlyPivots = MLinearEquationsSolutionStrategyOnlyPivots.pivotRepeated(
            step:step)
        {
            return onlyPivots
        }
        else if let removeCoefficient:MLinearEquationsSolutionStrategyRemoveCoefficients = MLinearEquationsSolutionStrategyRemoveCoefficients.coefficientPivot(
            step:step)
        {
            return removeCoefficient
        }
        else if let validateRows:MLinearEquationsSolutionStrategyValidateRows = MLinearEquationsSolutionStrategyValidateRows.rowsError(
            step:step)
        {
            return validateRows
        }
        else if let resultsOnly:MLinearEquationsSolutionStrategyResultsOnly = MLinearEquationsSolutionStrategyResultsOnly.finished(
            step:step)
        {
            return resultsOnly
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
