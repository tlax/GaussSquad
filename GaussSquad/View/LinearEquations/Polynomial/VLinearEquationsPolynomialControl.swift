import UIKit

class VLinearEquationsPolynomialControl:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var viewSign:VLinearEquationsPolynomialControlSign!
    private let kButtonDoneWidth:CGFloat = 80
    private let kContentMargin:CGFloat = 10
    private let kButtonDoneCornerRadius:CGFloat = 6
    private let kSignsWidth:CGFloat = 100
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewSign:VLinearEquationsPolynomialControlSign = VLinearEquationsPolynomialControlSign(
            controller:controller)
        self.viewSign = viewSign
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.squadBlue
        buttonDone.setTitle(
            NSLocalizedString("VLinearEquationsPolynomialControl_buttonDone", comment:""),
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonDone.titleLabel!.font = UIFont.bold(size:14)
        buttonDone.layer.cornerRadius = kButtonDoneCornerRadius
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonDone)
        addSubview(viewSign)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDone,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonDoneWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonDone,
            toView:self,
            constant:-kContentMargin)
        
        NSLayoutConstraint.equalsVertical(
            view:viewSign,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.leftToLeft(
            view:viewSign,
            toView:self,
            constant:kContentMargin)
        NSLayoutConstraint.width(
            view:viewSign,
            constant:kSignsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        controller.save()
    }
}
