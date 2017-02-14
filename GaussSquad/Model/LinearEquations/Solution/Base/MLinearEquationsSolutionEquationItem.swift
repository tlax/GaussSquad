import UIKit

class MLinearEquationsSolutionEquationItem:MLinearEquationsSolutionShareProtocol
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
    
    class func emptyCoefficient(index:Int) -> MLinearEquationsSolutionEquationItemConstant
    {
        let newCoefficient:MLinearEquationsSolutionEquationItemConstant = coefficient(
            coefficientDividend:0,
            coefficientDivisor:1,
            index:index,
            showAsDivision:false)
        
        return newCoefficient
    }
    
    class func emptyPolynomial(
        indeterminate:MLinearEquationsSolutionIndeterminatesItem,
        index:Int) -> MLinearEquationsSolutionEquationItemPolynomial
    {
        let newPolynomial:MLinearEquationsSolutionEquationItemPolynomial = polynomial(
            coefficientDividend:0,
            coefficientDivisor:1,
            indeterminate:indeterminate,
            index:index,
            showAsDivision:false)
        
        return newPolynomial
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
    
    //MARK: share protocol
    
    func shareText() -> String?
    {
        return nil
    }
    
    func shareImage() -> UIImage?
    {
        return nil
    }
}
