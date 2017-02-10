import Foundation

class MLinearEquationsSolutionStrategyReduction:MLinearEquationsSolutionStrategy
{
    private let equationIndex:Int
    private let polynomialIndexA:Int
    private let polynomialIndexB:Int
    
    init(
        step:MLinearEquationsSolutionStep,
        equationIndex:Int,
        polynomialIndexA:Int,
        polynomialIndexB:Int)
    {
        self.equationIndex = equationIndex
        self.polynomialIndexA = polynomialIndexA
        self.polynomialIndexB = polynomialIndexB
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        reduction()
    }
    
    //MARK: private
    
    private func reduction()
    {
        
    }
}
