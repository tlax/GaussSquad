import UIKit

class MLinearEquationsSolutionStepProcess:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 40
    
    init(
        equations:[MLinearEquationsSolutionEquation],
        descr:String)
    {
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:descr,
            attributes:attributes)
        
        super.init(
            title:stringTitle,
            equations:equations,
            headerHeight:kHeaderHeight)
    }
}
