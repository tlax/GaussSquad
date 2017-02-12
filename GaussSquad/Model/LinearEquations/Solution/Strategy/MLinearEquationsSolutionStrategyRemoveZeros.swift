import Foundation

class MLinearEquationsSolutionStrategyRemoveZeros:MLinearEquationsSolutionStrategy
{
    class func hasZeros(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyRemoveZeros?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let countPolynomials:Int = equation.items.count
            
            for indexPolynomial:Int in 0 ..< countPolynomials
            {
                
            }
            
            indexEquation += 1
        }
        
        return nil
    }
    
    let indexEquation:Int
    let indexPolynomial:Int
    
    init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomial:Int)
    {
        self.indexEquation = indexEquation
        self.indexPolynomial = indexPolynomial
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        removeZero()
    }
    
    //MARK: private
    
    private func removeZero()
    {
    }
}
