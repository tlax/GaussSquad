import UIKit

class VLinearEquationsIndeterminateControl:UIView
{
    private weak var controller:CLinearEquationsIndeterminate!
    private let kButtonsWidth:CGFloat = 100
    private let kButtonMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 18
    
    init(controller:CLinearEquationsIndeterminate)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.backgroundColor = UIColor.squadRed
        buttonCancel.setTitle(
            NSLocalizedString("VLinearEquationsIndeterminateControl_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.bold(
            size:15)
        buttonCancel.layer.cornerRadius = kCornerRadius
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonSave:UIButton = UIButton()
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.backgroundColor = UIColor.squadBlue
        buttonSave.setTitle(
            NSLocalizedString("VLinearEquationsIndeterminateControl_buttonSave", comment:""),
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonSave.titleLabel!.font = UIFont.bold(
            size:15)
        buttonSave.layer.cornerRadius = kCornerRadius
        buttonSave.addTarget(
            self,
            action:#selector(actionSave(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCancel)
        addSubview(buttonSave)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonCancel,
            toView:self,
            margin:kButtonMargin)
        NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self,
            constant:kButtonMargin)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonSave,
            toView:self,
            margin:kButtonMargin)
        NSLayoutConstraint.rightToRight(
            view:buttonSave,
            toView:self,
            constant:-kButtonMargin)
        NSLayoutConstraint.width(
            view:buttonSave,
            constant:kButtonsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
    
    func actionSave(sender button:UIButton)
    {
        controller.save()
    }
}
