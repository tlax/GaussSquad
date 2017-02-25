import UIKit

class VCalculatorOptionsHeader:UICollectionReusableView
{
    private weak var controller:CCalculatorOptions?
    private weak var layoutNoneTop:NSLayoutConstraint!
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 200
    private let kButtonRight:CGFloat = -10
    private let kButtonWidth:CGFloat = 120
    private let kButtonHeight:CGFloat = 34
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:17)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VCalculatorOptionsHeader_title", comment:"")
        
        let buttonNone:UIButton = UIButton()
        buttonNone.translatesAutoresizingMaskIntoConstraints = false
        buttonNone.clipsToBounds = true
        buttonNone.backgroundColor = UIColor.squadRed
        buttonNone.layer.cornerRadius = kButtonHeight / 2.0
        buttonNone.setTitle(
            NSLocalizedString("VCalculatorOptionsHeader_buttonNone", comment:""),
            for:UIControlState.normal)
        buttonNone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonNone.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonNone.titleLabel?.font = UIFont.bold(size:14)
        buttonNone.addTarget(
            self,
            action:#selector(actionNone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(labelTitle)
        addSubview(buttonNone)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kLabelWidth)
        
        layoutNoneTop = NSLayoutConstraint.topToTop(
            view:buttonNone,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonNone,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonNone,
            constant:kButtonWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonNone,
            toView:self,
            constant:kButtonRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = height - kButtonHeight
        let marginTop:CGFloat = remain / 2.0
        layoutNoneTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionNone(sender button:UIButton)
    {
        controller?.selectOption(item:nil)
    }
    
    //MARK: public
    
    func config(controller:CCalculatorOptions)
    {
        self.controller = controller
    }
}
