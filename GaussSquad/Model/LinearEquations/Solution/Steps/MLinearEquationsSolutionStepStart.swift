import UIKit

class MLinearEquationsSolutionStepStart:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 50
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:16),
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
