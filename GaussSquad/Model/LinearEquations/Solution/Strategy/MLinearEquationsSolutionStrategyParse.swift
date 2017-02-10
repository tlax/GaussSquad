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
            var equationIndex:Int = 0
            
            for rawEquation:DEquation in rawEquations
            {
                var index:Int = 0
                
                guard
                    
                    let rawPolynomials:[DPolynomial] = rawEquation.polynomials?.array as? [DPolynomial],
                    let rawResult:DPolynomial = rawEquation.result,
                    let result:MLinearEquationsSolutionEquationItem = findPolynomial(
                        rawPolynomial:rawResult,
                        indeterminates:indeterminates,
                        index:index)
                
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
                            indeterminates:indeterminates,
                            index:index)
                    
                    else
                    {
                        continue
                    }
                    
                    index += 1
                    items.append(polynomial)
                }
                
                let equation:MLinearEquationsSolutionEquation = MLinearEquationsSolutionEquation(
                    items:items,
                    result:result,
                    equationIndex:equationIndex)
                equations.append(equation)
                equationIndex += 1
            }
        }
        
        let step:MLinearEquationsSolutionStepStart = MLinearEquationsSolutionStepStart(
            equations:equations)
        completed(step:step)
    }
    
    private func findPolynomial(
        rawPolynomial:DPolynomial,
        indeterminates:MLinearEquationsSolutionIndeterminates,
        index:Int) -> MLinearEquationsSolutionEquationItem?
    {
        let polynomial:MLinearEquationsSolutionEquationItem?
        let coefficientDividend:Double = rawPolynomial.signedDividend()
        let coefficientDivisor:Double = rawPolynomial.coefficientDivisor
        let showAsDivision:Bool = rawPolynomial.showAsDivision

        if let rawIndeterminate:DIndeterminate = rawPolynomial.indeterminate
        {
            guard
                
                let indeterminate:MLinearEquationsSolutionIndeterminatesItem = indeterminates.indeterminateFor(
                    rawIndeterminate:rawIndeterminate)
                
            else
            {
                return nil
            }
            
            polynomial = MLinearEquationsSolutionEquationItem.polynomial(
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                indeterminate:indeterminate,
                index:index,
                showAsDivision:showAsDivision)
        }
        else
        {
            polynomial = MLinearEquationsSolutionEquationItem.coefficient(
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                index:index,
                showAsDivision:showAsDivision)
        }
        
        return polynomial
    }
}
