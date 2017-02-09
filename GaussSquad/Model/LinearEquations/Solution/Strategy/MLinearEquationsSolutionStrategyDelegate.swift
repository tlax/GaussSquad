import Foundation

protocol MLinearEquationsSolutionStrategyDelegate:class
{
    func solutionStrategyCompleted(step:MLinearEquationsSolutionStep)
    func solutionStrategyIndeterminates(indeterminates:MLinearEquationsSolutionIndeterminates)
}
