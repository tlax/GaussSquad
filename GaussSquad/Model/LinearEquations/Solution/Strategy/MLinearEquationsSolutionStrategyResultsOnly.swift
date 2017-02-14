import Foundation

class MLinearEquationsSolutionStrategyResultsOnly:MLinearEquationsSolutionStrategy
{
    class func finished(step:MLinearEquationsSolutionStep) -> MLinearEquationsSolutionStrategyResultsOnly?
    {
        for equation:MLinearEquationsSolutionEquation in step.equations
        {
            guard
                
                let polynomials:[MLinearEquationsSolutionEquationItemPolynomial] = equation.items as? [MLinearEquationsSolutionEquationItemPolynomial],
                let _:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
            
            else
            {
                return nil
            }
            
            let pivotIndex:Int = equation.pivotIndex()
            let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = polynomials[pivotIndex]
            let pivotCoefficient:Double = pivotItem.coefficient
            
            if pivotCoefficient != 1
            {
                return nil
            }
            
            for polynomial:MLinearEquationsSolutionEquationItemPolynomial in polynomials
            {
                if polynomial !== pivotItem
                {
                    let polynomialCoefficient:Double = polynomial.coefficient
                    
                    if abs(polynomialCoefficient) > MSession.sharedInstance.kMinNumber
                    {
                        return nil
                    }
                }
            }
        }
        
        let strategy:MLinearEquationsSolutionStrategyResultsOnly = MLinearEquationsSolutionStrategyResultsOnly(
            step:step)
        
        return strategy
    }
    
    private init(step:MLinearEquationsSolutionStep)
    {
        super.init(step:step)
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        showResults()
    }
    
    //MARK: private
    
    private func showResults()
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        var indexEquation:Int = 0
        
        for equation:MLinearEquationsSolutionEquation in self.step.equations
        {
            guard
                
                let polynomials:[MLinearEquationsSolutionEquationItemPolynomial] = equation.items as? [MLinearEquationsSolutionEquationItemPolynomial],
                let result:MLinearEquationsSolutionEquationItemConstant = equation.result as? MLinearEquationsSolutionEquationItemConstant
            
            else
            {
                continue
            }
            
            let pivotIndex:Int = equation.pivotIndex()
            let pivotItem:MLinearEquationsSolutionEquationItemPolynomial = polynomials[pivotIndex]
            let finalItem:MLinearEquationsSolutionEquationItemPolynomial = pivotItem.reIndexed(
                newIndex:0)
            let newItems:[MLinearEquationsSolutionEquationItem] = [
                finalItem
            ]
            
            let newEquation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
                items:newItems,
                result:result,
                equationIndex:indexEquation)
            
            equations.append(newEquation)
            indexEquation += 1
        }
        
        let step:MLinearEquationsSolutionStepDone = MLinearEquationsSolutionStepDone(
            equations:equations)
        completed(step:step)
    }
}
