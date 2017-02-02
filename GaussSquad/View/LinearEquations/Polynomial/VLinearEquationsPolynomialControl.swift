import UIKit

class VLinearEquationsPolynomialControl:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private let kButtonDoneWidth:CGFloat = 80
    private let kButtonDoneMargin:CGFloat = 10
    private let kButtonDoneCornerRadius:CGFloat = 6
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
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
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDone,
            toView:self,
            margin:kButtonDoneMargin)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonDoneWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonDone,
            toView:self,
            constant:-kButtonDoneMargin)
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
