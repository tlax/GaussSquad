import Foundation
import CoreData

extension DPolynomial
{
    //MARK: public
    
    func coefficient() -> Double
    {
        let sign:Double
        
        if isPositive
        {
            sign = 1
        }
        else
        {
            sign = -1
        }
        
        var coefficientValue:Double = coefficientDividend / coefficientDivisor
        coefficientValue *= sign
        
        return coefficientValue
    }
    
    func inversed() -> DPolynomial?
    {
        let managedObject:NSManagedObject = NSManagedObject(
            entity:entity,
            insertInto:nil)
    
        guard
            
            let polynomial:DPolynomial = managedObject as? DPolynomial
        
        else
        {
            return nil
        }
        
        polynomial.isPositive = !isPositive
        
        return polynomial
    }
    
    func signedDividend() -> Double
    {
        let sign:Double
        
        if isPositive
        {
            sign = 1
        }
        else
        {
            sign = -1
        }
        
        let signed:Double = coefficientDividend * sign
        
        return signed
    }
    
    func add(polynomial:DPolynomial)
    {
        let dividend:Double = signedDividend()
        let polynomialDividend:Double = polynomial.signedDividend()
        
        if coefficientDivisor == polynomial.coefficientDivisor
        {
            let newDividend:Double = dividend + polynomialDividend
            coefficientDividend = abs(newDividend)
            
            if newDividend < 0
            {
                isPositive = false
            }
            else
            {
                isPositive = true
            }
        }
    }
}
