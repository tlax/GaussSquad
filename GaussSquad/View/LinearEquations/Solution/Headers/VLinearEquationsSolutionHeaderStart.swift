import UIKit

class VLinearEquationsSolutionHeaderStart:VLinearEquationsSolutionHeader
{
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 280
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:17)
        label.textColor = UIColor.squadBlue
        label.text = NSLocalizedString("VLinearEquationsSolutionHeaderStart_label", comment:"")
        
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
