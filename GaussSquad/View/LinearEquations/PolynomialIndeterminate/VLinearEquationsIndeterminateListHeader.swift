import UIKit

class VLinearEquationsIndeterminateListHeader:UICollectionReusableView
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate?
    private let kBorderHeight:CGFloat = 1
    private let kContentMargin:CGFloat = 10
    private let kTitleWidth:CGFloat = 150
    private let kButtonWidth:CGFloat = 100
    private let kCornerRadius:CGFloat = 6
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.regular(size:14)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsIndeterminateListHeader_labelTitlte", comment:"")
        
        let buttonNone:UIButton = UIButton()
        buttonNone.translatesAutoresizingMaskIntoConstraints = false
        buttonNone.backgroundColor = UIColor.squadRed
        buttonNone.clipsToBounds = true
        buttonNone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonNone.setTitleColor(
            UIColor(white:1, alpha:0.1),
            for:UIControlState.highlighted)
        buttonNone.setTitle(
            NSLocalizedString("VLinearEquationsIndeterminateListHeader_buttonNone", comment:""),
            for:UIControlState.normal)
        buttonNone.layer.cornerRadius = kCornerRadius
        buttonNone.addTarget(
            self,
            action:#selector(actionNone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(labelTitle)
        addSubview(buttonNone)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kContentMargin)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonNone,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.rightToRight(
            view:buttonNone,
            toView:self,
            constant:-kContentMargin)
        NSLayoutConstraint.width(
            view:buttonNone,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionNone(sender button:UIButton)
    {
        
    }
    
    //MARK: public
    
    func config(controller:CLinearEquationsPolynomialIndeterminate)
    {
        self.controller = controller
    }
}
