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
    let indexPolynomialA:Int
    let indexPolynomialB:Int
    
    init(
        step:MLinearEquationsSolutionStep,
        indexEquation:Int,
        indexPolynomialA:Int,
        indexPolynomialB:Int)
    {
        self.indexEquation = indexEquation
        self.indexPolynomialA = indexPolynomialA
        self.indexPolynomialB = indexPolynomialB
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        reduction()
    }
    
    //MARK: private
    
    public func reduction()
    {
    }
}
