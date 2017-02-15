import UIKit

class VLinearEquationsSolutionHeader:UICollectionReusableView
{
    private weak var label:UILabel!
    private weak var layoutLabelLeft:NSLayoutConstraint!
    private weak var layoutLabelWidth:NSLayoutConstraint!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
        clipsToBounds = true
        
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
        layoutLabelLeft = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        layoutLabelWidth = NSLayoutConstraint.width(
            view:label)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(step:MLinearEquationsSolutionStep)
    {
        label.attributedText = step.title
        layoutLabelLeft.constant = step.kTitleLeft
        layoutLabelWidth.constant = step.kTitleWidth
    }
}
