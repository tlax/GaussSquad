import UIKit

class VLinearEquationsPolynomialIndeterminate:UIButton
{
    private weak var controller:CLinearEquationsPolynomial!
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 140
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.05)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:12)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsPolynomialIndeterminate_labelTitle", comment:"")
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kTitleLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
