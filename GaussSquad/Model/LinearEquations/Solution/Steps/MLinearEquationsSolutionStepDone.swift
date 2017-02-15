import UIKit

class MLinearEquationsSolutionStepDone:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 60
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:20),
            NSForegroundColorAttributeName:UIColor.squadBlue]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MLinearEquationsSolutionStepDone_title", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MLinearEquationsSolutionStepDone_subtitle", comment:""),
            attributes:attributesSubtitle)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        super.init(
            title:mutableString,
            equations:equations,
            headerHeight:kHeaderHeight)
    }
}
