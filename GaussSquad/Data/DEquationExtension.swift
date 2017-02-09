import Foundation
import CoreData

extension DEquation
{
    //MARK: public
    
    func restartResult()
    {
        DManager.sharedInstance?.createManagedObject(
            entityName:DPolynomial.entityName)
        { [weak self] (created) in
            
            guard
                
                let newResult:DPolynomial = created as? DPolynomial,
                let oldResult:DPolynomial = self?.result
                
            else
            {
                return
            }
            
            self?.result = newResult
            DManager.sharedInstance?.delete(object:oldResult)
            DManager.sharedInstance?.save()
        }
    }
    
    func deletePolynomial(polynomial:DPolynomial)
    {
        removeFromPolynomials(polynomial)
        DManager.sharedInstance?.delete(object:polynomial)
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
            DManager.sharedInstance?.createManagedObject(
                entityName:DPolynomial.entityName)
            { (created:NSManagedObject?) in
                
                guard
                    
                    let newPolynomial:DPolynomial = created as? DPolynomial
                    
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
