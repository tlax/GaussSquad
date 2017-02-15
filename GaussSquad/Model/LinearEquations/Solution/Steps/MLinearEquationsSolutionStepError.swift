import UIKit

class MLinearEquationsSolutionStepError:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 45
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:14),
            NSForegroundColorAttributeName:UIColor.squadRed]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MLinearEquationsSolutionStepError_title", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:descr,
            attributes:attributesSubtitle)
        
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        super.init(
            title:mutableString,
            equations:equations,
            headerHeight:kHeaderHeight)
    }
}
