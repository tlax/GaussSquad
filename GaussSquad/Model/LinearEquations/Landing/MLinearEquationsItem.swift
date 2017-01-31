import UIKit

class MLinearEquationsItem
{
    let descr:NSAttributedString
    let age:String
    private(set) weak var project:DProject!
    
    init(project:DProject)
    {
        self.project = project
        
        let attrCoefficient:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:20)]
        let attrIndeterminate:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:18)]
        let attrOperator:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:12)]
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        if let equations:[DEquation] = project.equations?.array as? [DEquation]
        {
            for equation:DEquation in equations
            {
                let mutableEquation:NSMutableAttributedString = NSMutableAttributedString()
                
                if !mutableString.string.isEmpty
                {
                    let stringJump:NSAttributedString = NSAttributedString(
                        string:NSLocalizedString("MLinearEquationsItem_jump", comment:""),
                        attributes:attrOperator)
                    mutableString.append(stringJump)
                }
                
                if let polynomials:[DPolynomial] = equation.polynomials?.array as? [DPolynomial]
                {
                    for polynomial:DPolynomial in polynomials
                    {
                        let rawStringOperator:String?
                        
                        if polynomial.isPositive
                        {
                            if mutableEquation.string.isEmpty
                            {
                                rawStringOperator = nil
                            }
                            else
                            {
                                rawStringOperator = NSLocalizedString("MLinearEquationsItem_positive", comment:"")
                            }
                        }
                        else
                        {
                            rawStringOperator = NSLocalizedString("MLinearEquationsItem_negative", comment:"")
                        }
                        
                        if let rawStringOperator:String = rawStringOperator
                        {
                            let stringOperator:NSAttributedString = NSAttributedString(
                                string:rawStringOperator,
                                attributes:attrOperator)
                            mutableEquation.append(stringOperator)
                        }
                        
                        guard
                        
                            let indeterminateSymbol:String = polynomial.indeterminate?.symbol
                        
                        else
                        {
                            continue
                        }
                        
                        let mutableCoefficient:NSMutableAttributedString = NSMutableAttributedString()
                        let dividend:Double = polynomial.coefficientDividend
                        let divisor:Double = polynomial.coefficientDivisor
                        
                        if polynomial.showAsDivision
                        {
                            let rawStringDividend:String = "\(dividend)"
                            let rawStringDivisor:String = "\(divisor)"
                            let stringDivision:NSAttributedString = NSAttributedString(
                                string:NSLocalizedString("MLinearEquationsItem_division", comment:""),
                                attributes:attrOperator)
                            let stringDividend:NSAttributedString = NSAttributedString(
                                string:rawStringDividend,
                                attributes:attrCoefficient)
                            let stringDivisor:NSAttributedString = NSAttributedString(
                                string:rawStringDivisor,
                                attributes:attrCoefficient)
                            
                            mutableCoefficient.append(stringDividend)
                            mutableCoefficient.append(stringDivision)
                            mutableCoefficient.append(stringDivisor)
                        }
                        else
                        {
                            let dividedCoefficient:Double = dividend / divisor
                            let rawStringCoefficient:String = "\(dividedCoefficient)"
                            let stringCoefficient:NSAttributedString = NSAttributedString(
                                string:rawStringCoefficient,
                                attributes:attrCoefficient)
                            
                            mutableCoefficient.append(stringCoefficient)
                        }
                        
                        mutableEquation.append(mutableCoefficient)
                        
                        let stringIndeterminate:NSAttributedString = NSAttributedString(
                            string:indeterminateSymbol,
                            attributes:attrIndeterminate)
                        mutableEquation.append(stringIndeterminate)
                    }
                }
                
                mutableString.append(mutableEquation)
            }
        }
        
        descr = mutableString
        age = "2 hours"
    }
}
