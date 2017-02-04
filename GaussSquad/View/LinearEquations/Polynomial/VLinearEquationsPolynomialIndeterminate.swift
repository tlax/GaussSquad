import UIKit

class VLinearEquationsPolynomialIndeterminate:UIButton
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var labelIndeterminate:UILabel!
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 140
    private let kBorderHeight:CGFloat = 1
    private let kIndeterminateLeft:CGFloat = -20
    private let kIndeterminateBottom:CGFloat = 3
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let borderColor:UIColor = UIColor(white:0, alpha:0.2)
        let borderTop:VBorder = VBorder(color:borderColor)
        let borderBottom:VBorder = VBorder(color:borderColor)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:12)
        labelTitle.textColor = UIColor(white:0, alpha:0.6)
        labelTitle.text = NSLocalizedString("VLinearEquationsPolynomialIndeterminate_labelTitle", comment:"")
        
        let labelIndeterminate:UILabel = UILabel()
        labelIndeterminate.isUserInteractionEnabled = false
        labelIndeterminate.translatesAutoresizingMaskIntoConstraints = false
        labelIndeterminate.backgroundColor = UIColor.clear
        labelIndeterminate.font = UIFont.bold(size:20)
        labelIndeterminate.textColor = UIColor.black
        self.labelIndeterminate = labelIndeterminate
        
        addSubview(borderTop)
        addSubview(borderBottom)
        addSubview(labelTitle)
        addSubview(labelIndeterminate)
        
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
        
        NSLayoutConstraint.topToTop(
            view:borderTop,
            toView:self)
        NSLayoutConstraint.height(
            view:borderTop,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderTop,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:borderBottom,
            toView:self)
        NSLayoutConstraint.height(
            view:borderBottom,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderBottom,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelIndeterminate,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:labelIndeterminate,
            toView:self,
            constant:kIndeterminateBottom)
        NSLayoutConstraint.leftToRight(
            view:labelIndeterminate,
            toView:labelTitle,
            constant:kIndeterminateLeft)
        NSLayoutConstraint.rightToRight(
            view:labelIndeterminate,
            toView:self,
            constant:-kTitleLeft)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func refresh()
    {
        labelIndeterminate.text = controller.polynomial?.indeterminate?.symbol
    }
}
