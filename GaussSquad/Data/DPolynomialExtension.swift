import Foundation

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
        let copied:DPolynomial? = self.copy() as? DPolynomial
        copied?.isPositive = !isPositive
        
        return copied
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
