import UIKit

class VLinearEquationsIndeterminateControl:UIView
{
    private weak var controller:CLinearEquationsIndeterminate!
    
    init(controller:CLinearEquationsIndeterminate)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle(
            NSLocalizedString("VLinearEquationsIndeterminateControl_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.squadRed,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.bold(
            size:17)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonSave:UIButton = UIButton()
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.setTitle(
            NSLocalizedString("VLinearEquationsIndeterminateControl_buttonSave", comment:""),
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor.squadBlue,
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonSave.titleLabel!.font = UIFont.bold(
            size:17)
        buttonSave.addTarget(
            self,
            action:#selector(actionSave(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonCancel)
        addSubview(buttonSave)
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
