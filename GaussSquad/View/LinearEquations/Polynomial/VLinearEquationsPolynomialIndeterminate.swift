import UIKit

class VLinearEquationsPolynomialIndeterminate:UIButton
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var labelIndeterminate:UILabel!
    private let kBorderHeight:CGFloat = 1
    private let kTitleRight:CGFloat = -4
    private let kTitleWidth:CGFloat = 150
    private let kIndeterminateWidth:CGFloat = 80
    private let kIndeterminateMarginVertical:CGFloat = 10
    private let kIndeterminateRight:CGFloat = -10
    private let kCornerRadius:CGFloat = 6
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:13)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.right
        labelTitle.text = NSLocalizedString("VLinearEquationsPolynomialIndeterminate_labelTitle", comment:"")
        
        let labelIndeterminate:UILabel = UILabel()
        labelIndeterminate.isUserInteractionEnabled = false
        labelIndeterminate.translatesAutoresizingMaskIntoConstraints = false
        labelIndeterminate.font = UIFont.numeric(size:20)
        labelIndeterminate.textColor = UIColor.black
        labelIndeterminate.clipsToBounds = true
        labelIndeterminate.layer.cornerRadius = kCornerRadius
        labelIndeterminate.textAlignment = NSTextAlignment.center
        self.labelIndeterminate = labelIndeterminate
        
        addSubview(labelTitle)
        addSubview(labelIndeterminate)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelTitle,
            toView:labelIndeterminate,
            constant:kTitleRight)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelIndeterminate,
            toView:self,
            margin:kIndeterminateMarginVertical)
        NSLayoutConstraint.width(
            view:labelIndeterminate,
            constant:kIndeterminateWidth)
        NSLayoutConstraint.rightToRight(
            view:labelIndeterminate,
            toView:self,
            constant:kIndeterminateRight)
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
            labelIndeterminate.backgroundColor = UIColor.squadRed
        }
        else
        {
            labelIndeterminate.backgroundColor = UIColor.squadGreen
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        isUserInteractionEnabled = true
        labelIndeterminate.text = controller.polynomial?.indeterminate?.symbol
        hover()
    }
}
