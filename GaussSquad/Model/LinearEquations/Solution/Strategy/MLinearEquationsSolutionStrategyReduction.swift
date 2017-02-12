import Foundation

class MLinearEquationsSolutionStrategyReduction:MLinearEquationsSolutionStrategy
{
    class func reducible(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyReduction?
    {
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            let countPolynomials:Int = equation.items.count
            
            for indexPolynomial:Int in 0 ..< countPolynomials
            {
                let rawItem:MLinearEquationsSolutionEquationItem = equation.items[indexPolynomial]
                
                if let _:MLinearEquationsSolutionEquationItemConstant = rawItem as? MLinearEquationsSolutionEquationItemConstant
                {
                    for indexComparison:Int in indexPolynomial + 1 ..< countPolynomials
                    {
                        let rawComparing:MLinearEquationsSolutionEquationItem = equation.items[indexComparison]
                        
                        if let _:MLinearEquationsSolutionEquationItemConstant = rawComparing as? MLinearEquationsSolutionEquationItemConstant
                        {
                            let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReductionConstants(
                                step:step,
                                indexEquation:indexEquation,
                                indexPolynomialA:indexPolynomial,
                                indexPolynomialB:indexComparison)
                            
                            return strategy
                        }
                    }
                    
                    if let _:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
                    {
                        let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReductionConstants(
                            step:step,
                            indexEquation:indexEquation,
                            indexPolynomialA:indexPolynomial,
                            indexPolynomialB:countPolynomials)
                        
                        return strategy
                    }
                }
                else if let polynomial:MLinearEquationsSolutionEquationItemPolynomial = rawItem as? MLinearEquationsSolutionEquationItemPolynomial
                {
                    for indexComparison:Int in indexPolynomial + 1 ..< countPolynomials
                    {
                        let rawComparing:MLinearEquationsSolutionEquationItem = equation.items[indexComparison]
                        
                        if let polynomialCompare:MLinearEquationsSolutionEquationItemPolynomial = rawComparing as? MLinearEquationsSolutionEquationItemPolynomial
                        {
                            if polynomial.indeterminate === polynomialCompare.indeterminate
                            {
                                let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReductionIndeterminates(
                                    step:step,
                                    indexEquation:indexEquation,
                                    indexPolynomialA:indexPolynomial,
                                    indexPolynomialB:indexComparison)
                                
                                return strategy
                            }
                        }
                    }
                    
                    if let resultCompare:MLinearEquationsSolutionEquationItemPolynomial = equation.result as? MLinearEquationsSolutionEquationItemPolynomial
                    {
                        if polynomial.indeterminate === resultCompare.indeterminate
                        {
                            let strategy:MLinearEquationsSolutionStrategyReduction = MLinearEquationsSolutionStrategyReductionIndeterminates(
                                step:step,
                                indexEquation:indexEquation,
                                indexPolynomialA:indexPolynomial,
                                indexPolynomialB:countPolynomials)
                            
                            return strategy
                        }
                    }
                }
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
    
    //MARK: public
    
    public func reduction()
    {
    }
}
