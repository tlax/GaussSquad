import UIKit

class VLinearEquationsPolynomialIndeterminate:UIButton
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var labelIndeterminate:UILabel!
    private weak var layoutIndeterminateLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kTitleRight:CGFloat = -5
    private let kTitleWidth:CGFloat = 150
    private let kIndeterminateWidth:CGFloat = 140
    private let kIndeterminateMarginVertical:CGFloat = 10
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
        
        let blur:VBlur = VBlur.light()
        
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
        labelIndeterminate.backgroundColor = UIColor.squadBlue
        labelIndeterminate.font = UIFont.numeric(size:20)
        labelIndeterminate.textColor = UIColor.white
        labelIndeterminate.clipsToBounds = true
        labelIndeterminate.layer.cornerRadius = kCornerRadius
        self.labelIndeterminate = labelIndeterminate
        
        addSubview(blur)
        addSubview(labelTitle)
        addSubview(labelIndeterminate)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
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
        layoutIndeterminateLeft = NSLayoutConstraint.leftToLeft(
            view:labelIndeterminate,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kIndeterminateWidth
        let margin:CGFloat = remain / 2.0
        layoutIndeterminateLeft.constant = margin
        
        super.layoutSubviews()
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
