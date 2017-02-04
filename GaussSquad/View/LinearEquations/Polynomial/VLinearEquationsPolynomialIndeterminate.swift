import UIKit

class VLinearEquationsPolynomialIndeterminate:UIButton
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var labelIndeterminate:UILabel!
    private let kTitleLeft:CGFloat = 10
    private let kTitleWidth:CGFloat = 140
    private let kBorderHeight:CGFloat = 1
    private let kIndeterminateLeft:CGFloat = -40
    private let kIndeterminateBottom:CGFloat = -3
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        
        let borderColor:UIColor = UIColor(white:0, alpha:0.1)
        let borderTop:VBorder = VBorder(color:borderColor)
        let borderBottom:VBorder = VBorder(color:borderColor)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:12)
        labelTitle.textColor = UIColor(white:0, alpha:0.8)
        labelTitle.text = NSLocalizedString("VLinearEquationsPolynomialIndeterminate_labelTitle", comment:"")
        
        let labelIndeterminate:UILabel = UILabel()
        labelIndeterminate.isUserInteractionEnabled = false
        labelIndeterminate.translatesAutoresizingMaskIntoConstraints = false
        labelIndeterminate.backgroundColor = UIColor.clear
        labelIndeterminate.font = UIFont.numeric(size:28)
        labelIndeterminate.textColor = UIColor.black
        self.labelIndeterminate = labelIndeterminate
        
        addSubview(blur)
        addSubview(borderTop)
        addSubview(borderBottom)
        addSubview(labelTitle)
        addSubview(labelIndeterminate)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
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
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        isUserInteractionEnabled = false
        controller.changeIndeterminate()
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            backgroundColor = UIColor(white:0, alpha:0.2)
        }
        else
        {
            backgroundColor = UIColor.clear
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        isUserInteractionEnabled = true
        labelIndeterminate.text = controller.polynomial?.indeterminate?.symbol
    }
}
