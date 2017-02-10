import UIKit

class MLinearEquationsSolutionEquationItem
{
    class func polynomial(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        index:Int,
        showAsDivision:Bool) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let item:MLinearEquationsSolutionEquationItemPolynomial
        let showSign:Bool
        
        if coefficientDividend >= 0
        {
            if index > 0
            {
                showSign = true
            }
            else
            {
                showSign = false
            }
        }
        else
        {
            showSign = true
        }
        
        if showAsDivision && coefficientDivisor != 1
        {
            item = MLinearEquationsSolutionEquationItemPolynomialDivision(
                indeterminate:indeterminate,
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                showSign:showSign)
        }
        else
        {
            item = MLinearEquationsSolutionEquationItemPolynomialDecimal(
                indeterminate:indeterminate,
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                showSign:showSign)
        }
        
        return item
    }
    
    class func coefficient(
        coefficientDividend:Double,
        coefficientDivisor:Double,
        index:Int,
        showAsDivision:Bool) -> MLinearEquationsSolutionEquationItemConstant
    {
        let item:MLinearEquationsSolutionEquationItemConstant
        let showSign:Bool
        
        if coefficientDividend >= 0
        {
            if index > 0
            {
                showSign = true
            }
            else
            {
                showSign = false
            }
        }
        else
        {
            showSign = true
        }
        
        if showAsDivision && coefficientDivisor != 1
        {
            item = MLinearEquationsSolutionEquationItemConstantDivision(
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                showSign:showSign)
        }
        else
        {
            item = MLinearEquationsSolutionEquationItemConstantDecimal(
                coefficientDividend:coefficientDividend,
                coefficientDivisor:coefficientDivisor,
                showSign:showSign)
        }
        
        return item
    }
    
    class func polynomial(
        rawPolynomial:DPolynomial,
        indeterminates:MLinearEquationsSolutionIndeterminates,
        index:Int) -> MLinearEquationsSolutionEquationItem?
    {
        let polynomial:MLinearEquationsSolutionEquationItem?
        let coefficientDividend:Double = rawPolynomial.signedDividend()
        let coefficientDivisor:Double = rawPolynomial.coefficientDivisor
        let showSign:Bool
        
        if coefficientDividend >= 0
        {
            if index > 0
            {
                showSign = true
            }
            else
            {
                showSign = false
            }
        }
        else
        {
            showSign = true
        }
        
        if let rawIndeterminate:DIndeterminate = rawPolynomial.indeterminate
        {
            guard
                
                let indeterminate:MLinearEquationsSolutionIndeterminatesItem = indeterminates.indeterminateFor(
                    rawIndeterminate:rawIndeterminate)
                
                else
            {
                return nil
            }
            
            if rawPolynomial.showAsDivision && coefficientDivisor != 1
            {
                polynomial = MLinearEquationsSolutionEquationItemPolynomialDivision(
                    indeterminate:indeterminate,
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    showSign:showSign)
            }
            else
            {
                polynomial = MLinearEquationsSolutionEquationItemPolynomialDecimal(
                    indeterminate:indeterminate,
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    showSign:showSign)
            }
        }
        else
        {
            if rawPolynomial.showAsDivision && coefficientDivisor != 1
            {
                polynomial = MLinearEquationsSolutionEquationItemConstantDivision(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    showSign:showSign)
            }
            else
            {
                polynomial = MLinearEquationsSolutionEquationItemConstantDecimal(
                    coefficientDividend:coefficientDividend,
                    coefficientDivisor:coefficientDivisor,
                    showSign:showSign)
            }
        }
        
        return polynomial
    }
    
    let reusableIdentifier:String
    let cellWidth:CGFloat
    
    init(
        reusableIdentifier:String,
        cellWidth:CGFloat)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellWidth = cellWidth
    }
}
