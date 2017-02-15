import UIKit

class MLinearEquationsSolutionStepProcess:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 50
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:14),
            NSForegroundColorAttributeName:UIColor(white:0, alpha:0.8)]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:descr,
            attributes:attributes)
        
        super.init(
            title:stringTitle,
            equations:equations,
            headerHeight:kHeaderHeight)
    }
}
