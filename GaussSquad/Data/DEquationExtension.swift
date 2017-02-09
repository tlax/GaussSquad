import Foundation
import CoreData

extension DEquation
{
    //MARK: public
    
    func restartResult()
    {
        guard
            
            let result:DPolynomial = DManager.sharedInstance?.createDataAndWait(
                entityName:DPolynomial.entityName) as? DPolynomial,
            let oldResult:DPolynomial = self.result
        
        else
        {
            return
        }
        
        self.result = result
        DManager.sharedInstance?.deleteAndWait(data:oldResult)
    }
    
    func deletePolynomial(polynomial:DPolynomial)
    {
        removeFromPolynomials(polynomial)
        DManager.sharedInstance?.deleteAndWait(data:polynomial)
    }
    
    func moveToLeft(polynomial:DPolynomial)
    {
        guard
            
            let equation:DEquation = polynomial.equationResult
            
        else
        {
            return
        }
        
        if equation == self
        {
            guard
                
                let newPolynomial:DPolynomial = DManager.sharedInstance?.createDataAndWait(
                    entityName:DPolynomial.entityName) as? DPolynomial
            
            else
            {
                return
            }
            
            newPolynomial.equationPolynomials = equation
            newPolynomial.coefficientDividend = polynomial.coefficientDividend
            newPolynomial.coefficientDivisor = polynomial.coefficientDivisor
            newPolynomial.isPositive = !polynomial.isPositive
            newPolynomial.showAsDivision = polynomial.showAsDivision
            newPolynomial.indeterminate = polynomial.indeterminate
            
            equation.restartResult()
        }
    }
    
    func moveToRight(polynomial:DPolynomial)
    {
        guard
            
            let equation:DEquation = polynomial.equationPolynomials,
            let result:DPolynomial = self.result,
            let inversed:DPolynomial = polynomial.inversed()
            
        else
        {
            return
        }
        
        if equation == self
        {
            result.add(polynomial:inversed)
            equation.deletePolynomial(polynomial:polynomial)
        }
    }
}
