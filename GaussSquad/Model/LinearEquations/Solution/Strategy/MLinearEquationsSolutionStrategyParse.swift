import Foundation

class MLinearEquationsSolutionStrategyParse:MLinearEquationsSolutionStrategy
{
    private weak var project:DProject?
    
    init(project:DProject?)
    {
        super.init(step:nil)
        self.project = project
    }
    
    override func process(delegate:MLinearEquationsSolutionStrategyDelegate)
    {
        super.process(delegate:delegate)
        
        findIndeterminates()
    }
    
    //MARK: private
    
    private func findIndeterminates()
    {
        var indeterminatesItems:[MLinearEquationsSolutionIndeterminatesItem] = []
        
        if let rawIndeterminates:[DIndeterminate] = project?.indeterminates?.array as? [DIndeterminate]
        {
            for rawIndeterminate:DIndeterminate in rawIndeterminates
            {
                let indeterminate:MLinearEquationsSolutionIndeterminatesItem = MLinearEquationsSolutionIndeterminatesItem(
                    indeterminate:rawIndeterminate)
                indeterminatesItems.append(indeterminate)
            }
        }
        
        let indeterminates:MLinearEquationsSolutionIndeterminates = MLinearEquationsSolutionIndeterminates(
            items:indeterminatesItems)
        
        foundIndeterminates(
            indeterminates:indeterminates)
        
        findEquations(indeterminates:indeterminates)
    }
    
    private func findEquations(indeterminates:MLinearEquationsSolutionIndeterminates)
    {
        var equations:[MLinearEquationsSolutionEquation] = []
        
        if let rawEquations:[DEquation] = project?.equations?.array as? [DEquation]
        {
            for rawEquation:DEquation in rawEquations
            {
                guard
                    
                    let rawPolynomials:[DPolynomial] = rawEquation.polynomials?.array as? [DPolynomial],
                    let rawResult:DPolynomial = rawEquation.result,
                    let result:MLinearEquationsSolutionEquationItem = findPolynomial(
                        rawPolynomial:rawResult,
                        indeterminates:indeterminates)
                
                else
                {
                    continue
                }
                
                var items:[MLinearEquationsSolutionEquationItem] = []
                
                for rawPolynomial:DPolynomial in rawPolynomials
                {
                    guard
                    
                        let polynomial:MLinearEquationsSolutionEquationItem = findPolynomial(
                            rawPolynomial:rawPolynomial,
                            indeterminates:indeterminates)
                    
                    else
                    {
                        continue
                    }
                    
                    items.append(polynomial)
                }
                
                let equation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
                    items:items,
                    result:result)
                equations.append(equation)
            }
        }
        
        let step:MLinearEquationsSolutionStepStart = MLinearEquationsSolutionStepStart(
            equations:equations)
        completed(step:step)
    }
    
    private func findPolynomial(
        rawPolynomial:DPolynomial,
        indeterminates:MLinearEquationsSolutionIndeterminates) -> MLinearEquationsSolutionEquationItem?
    {
        let polynomial:MLinearEquationsSolutionEquationItem?
        let coefficientDividend:Double = rawPolynomial.signedDividend()
        let coefficientDivisor:Double = rawPolynomial.coefficientDivisor
        
        if let rawIndeterminate:DIndeterminate = rawPolynomial.indeterminate
        {
            guard
            
                let indeterminate:MLinearEquationsSolutionIndeterminatesItem = indeterminates.indeterminateFor(
                    rawIndeterminate:rawIndeterminate)
            
            else
            {
                return nil
            }
            
            if rawPolynomial.showAsDivision
            {
                polynomial = MLinearEquationsSolutionEquationItemPolynomialDivision(
                    indeterminate:indeterminate,
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor)
            }
            else
            {
                polynomial = MLinearEquationsSolutionEquationItemPolynomialDecimal(
                    indeterminate:indeterminate,
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor)
            }
        }
        else
        {
            if rawPolynomial.showAsDivision
            {
                polynomial = MLinearEquationsSolutionEquationItemConstantDivision(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor)
            }
            else
            {
                polynomial = MLinearEquationsSolutionEquationItemConstantDecimal(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor)
            }
        }
        
        return polynomial
    }
}
