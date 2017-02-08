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
        
        print("\(dividend) + \(polynomialDividend)")
        
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
    
    func makePositive()
    {
        isPositive = true
        DManager.sharedInstance?.save()
    }
    
    func makeNegative()
    {
        isPositive = false
        DManager.sharedInstance?.save()
    }
    
    func makeDivision()
    {
        showAsDivision = true
        DManager.sharedInstance?.save()
    }
    
    func makeDecimal()
    {
        showAsDivision = false
        DManager.sharedInstance?.save()
    }
    
    func selectIndeterminate(indeterminate:DIndeterminate?)
    {
        self.indeterminate = indeterminate
        DManager.sharedInstance?.save()
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
        
        DManager.sharedInstance?.save()
    }
    
    func moveToLeft()
    {
        guard
        
            let equation:DEquation = equationResult
        
        else
        {
            return
        }
        
        DManager.sharedInstance?.createManagedObject(
            entityName:DPolynomial.entityName)
        { [weak self] (created:NSManagedObject?) in
            
            guard
            
                let newPolynomial:DPolynomial = created as? DPolynomial,
                let oldPolynomial:DPolynomial = self
            
            else
            {
                return
            }
            
            newPolynomial.equationPolynomials = equation
            newPolynomial.coefficientDividend = oldPolynomial.coefficientDividend
            newPolynomial.coefficientDivisor = oldPolynomial.coefficientDivisor
            newPolynomial.isPositive = !oldPolynomial.isPositive
            newPolynomial.showAsDivision = oldPolynomial.showAsDivision
            newPolynomial.indeterminate = oldPolynomial.indeterminate
            
            equation.restartResult()
        }
    }
    
    func moveToRight()
    {
        guard
            
            let equation:DEquation = equationResult,
            let result:DPolynomial = equation.result,
            let selfInversed:DPolynomial = inversed()
            
        else
        {
            return
        }
        
        result.add(polynomial:selfInversed)
        equation.deletePolynomial(polynomial:self)
    }
}
