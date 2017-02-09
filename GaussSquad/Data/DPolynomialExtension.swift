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
        
        polynomial.coefficientDividend = coefficientDividend
        polynomial.coefficientDivisor = coefficientDivisor
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
        let polynomialDivisor:Double = polynomial.coefficientDivisor
        
        if coefficientDivisor == polynomialDivisor
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
        else
        {
            let newDivisor:Double = coefficientDivisor * polynomialDivisor
            let newDividend:Double = dividend * polynomialDivisor
            let newPolynomialDividend:Double = polynomialDividend * coefficientDivisor
            
            let totalDividend:Double = newDividend + newPolynomialDividend
            coefficientDividend = abs(totalDividend)
            coefficientDivisor = newDivisor
            
            print("\(coefficientDividend) \(coefficientDivisor)")
            
            if totalDividend < 0
            {
                isPositive = false
            }
            else
            {
                isPositive = true
            }
            
            showAsDivision = true
        }
    }
    
    func deleteFromEquation()
    {
        if let equationResult:DEquation = self.equationResult
        {
            guard
                
                let countPolynomials:Int = equationResult.polynomials?.count
                
            else
            {
                return
            }
            
            if countPolynomials > 0
            {
                equationResult.restartResult()
            }
            else
            {
                guard
                    
                    let project:DProject = equationResult.project
                    
                else
                {
                    return
                }
                
                project.deleteEquation(equation:equationResult)
            }
        }
        else if let equationPolynomials:DEquation = self.equationPolynomials
        {
            equationPolynomials.deletePolynomial(polynomial:self)
        }
    }
}
