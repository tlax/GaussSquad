import UIKit

class MLinearEquationsSolutionStepStart:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 60
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:18),
            NSForegroundColorAttributeName:UIColor.squadBlue]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("MLinearEquationsSolutionStepStart_label", comment:""),
            attributes:attributesTitle)
        
        super.init(
            title:stringTitle,
            equations:equations,
            headerHeight:kHeaderHeight)
    }
}
