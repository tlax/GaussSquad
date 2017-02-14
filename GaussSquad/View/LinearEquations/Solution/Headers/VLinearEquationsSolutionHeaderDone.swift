import UIKit

class VLinearEquationsSolutionHeaderDone:VLinearEquationsSolutionHeader
{
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 280
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:22),
            NSForegroundColorAttributeName:UIColor.squadBlue]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:13),
            NSForegroundColorAttributeName:UIColor.black]
        let stringTitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsSolutionHeaderDone_title", comment:""),
            attributes:attributesTitle)
        let stringSubtitle:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsSolutionHeaderDone_subtitle", comment:""),
            attributes:attributesSubtitle)
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringTitle)
        mutableString.append(stringSubtitle)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.attributedText = mutableString
        
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
}
