import UIKit

class VLinearEquationsSolutionHeaderError:VLinearEquationsSolutionHeader
{
    private weak var label:UILabel!
    private let attributesSubtitle:[String:AnyObject]
    private let stringTitle:NSAttributedString
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 280
    
    override init(frame:CGRect)
    {
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:17),
            NSForegroundColorAttributeName:UIColor.squadRed]
        attributesSubtitle = [
            NSFontAttributeName:UIFont.medium(size:14),
            NSForegroundColorAttributeName:UIColor.black]
        
        stringTitle = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsSolutionHeaderError_title", comment:""),
            attributes:attributesTitle)
        
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(step:MLinearEquationsSolutionStep, indexPath:IndexPath)
    {
        guard
            
            let step:MLinearEquationsSolutionStepError = step as? MLinearEquationsSolutionStepError
        
        else
        {
            return
        }
        
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:step.descr,
            attributes:attributesSubtitle)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        label.attributedText = mutableString
    }
}
