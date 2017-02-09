import Foundation

protocol MLinearEquationsSolutionStrategyDelegate
{
    func solutionStrategyDone(equations:[MLinearEquationsSolutionEquation])
    func solutionStrategyError(error:String)
}
