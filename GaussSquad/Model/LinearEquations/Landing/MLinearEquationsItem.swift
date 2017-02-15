import UIKit

class MLinearEquationsItem
{
    let descr:NSAttributedString
    let age:String
    let attributes:[String:AnyObject]
    private(set) var project:DProject!
    
    init(project:DProject)
    {
        self.project = project
        
        attributes = [
            NSFontAttributeName:UIFont.numeric(size:20),
            NSForegroundColorAttributeName:UIColor.black]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let equation:DEquation = project.equations?.array.first as? DEquation
        {
            if let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial]
            {
                for polynomial:DPolynomial in polynomials
                {
                    let forcePositive:Bool
                    
                    if mutableString.string.isEmpty
                    {
                        forcePositive = false
                    }
                    else
                    {
                        forcePositive = true
                    }
                    
                    if let strOperator:NSAttributedString = MLinearEquationsItem.stringOperator(
                        polynomial:polynomial,
                        attributes:attributes,
                        forcePositive:forcePositive)
                    {
                        mutableString.append(strOperator)
                    }
                    
                    let strPolynomial:NSAttributedString = MLinearEquationsItem.stringPolynomial(
                        polynomial:polynomial,
                        attributes:attributes)
                    mutableString.append(strPolynomial)
                }
            }
            
            if let result:DPolynomial = equation.result
            {
                let stringEquals:NSAttributedString = NSAttributedString(
                    string:NSLocalizedString("MLinearEquationsItem_equals", comment:""),
                    attributes:attributes)
                
                mutableString.append(stringEquals)
                
                if let strOperator:NSAttributedString = MLinearEquationsItem.stringOperator(
                    polynomial:result,
                    attributes:attributes,
                    forcePositive:false)
                {
                    mutableString.append(strOperator)
                }
                
                let strPolynomial:NSAttributedString = MLinearEquationsItem.stringPolynomial(
                    polynomial:result,
                    attributes:attributes)
                mutableString.append(strPolynomial)
            }
        }
        
        descr = mutableString
        age = "2 hours"
    }
    
    //MARK: private
    
    private class func stringOperator(
        polynomial:DPolynomial,
        attributes:[String:AnyObject],
        forcePositive:Bool) -> NSAttributedString?
    {
        let rawOperator:String
        
        if polynomial.isPositive
        {
            if forcePositive
            {
                rawOperator = NSLocalizedString("MLinearEquationsItem_positive", comment:"")
            }
            else
            {
                return nil
            }
        }
        else
        {
            rawOperator = NSLocalizedString("MLinearEquationsItem_negative", comment:"")
        }
        
        let stringOperator:NSAttributedString = NSAttributedString(
            string:rawOperator,
            attributes:attributes)
        
        return stringOperator
    }
    
    private class func stringPolynomial(
        polynomial:DPolynomial,
        attributes:[String:AnyObject]) -> NSAttributedString
    {
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let dividend:Double = polynomial.coefficientDividend
        let divisor:Double = polynomial.coefficientDivisor
        
        if polynomial.showAsDivision
        {
            let rawStringDividend:String = MSession.sharedInstance.stringFrom(
                number:dividend)
            let rawStringDivisor:String = MSession.sharedInstance.stringFrom(
                number:divisor)
            let stringDivision:NSAttributedString = NSAttributedString(
                string:NSLocalizedString("MLinearEquationsItem_division", comment:""),
                attributes:attributes)
            let stringDividend:NSAttributedString = NSAttributedString(
                string:rawStringDividend,
                attributes:attributes)
            let stringDivisor:NSAttributedString = NSAttributedString(
                string:rawStringDivisor,
                attributes:attributes)
            
            mutableString.append(stringDividend)
            mutableString.append(stringDivision)
            mutableString.append(stringDivisor)
        }
        else
        {
            let coefficient:Double = dividend / divisor
            let rawStringCoefficient:String = MSession.sharedInstance.stringFrom(
                number:coefficient)
            let stringCoefficient:NSAttributedString = NSAttributedString(
                string:rawStringCoefficient,
                attributes:attributes)
            
            mutableString.append(stringCoefficient)
        }
        
        guard
            
            let indeterminateSymbol:String = polynomial.indeterminate?.symbol
            
        else
        {
            return mutableString
        }
        
        let stringIndeterminate:NSAttributedString = NSAttributedString(
            string:indeterminateSymbol,
            attributes:attributes)
        mutableString.append(stringIndeterminate)
        
        return mutableString
    }
}
