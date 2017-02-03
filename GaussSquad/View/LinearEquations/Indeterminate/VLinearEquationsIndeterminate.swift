import UIKit

class VLinearEquationsIndeterminate:VView
{
    private weak var controller:CLinearEquationsIndeterminate!
    private weak var viewControl:VLinearEquationsIndeterminateControl!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private let kControlHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsIndeterminate
        
        let blur:VBlur = VBlur.light()
        
        let viewControl:VLinearEquationsIndeterminateControl = VLinearEquationsIndeterminateControl(
            controller:self.controller)
        self.viewControl = viewControl
        
        addSubview(blur)
        addSubview(viewControl)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewControl,
            constant:kControlHeight)
        layoutControlBottom = NSLayoutConstraint.bottomToBottom(
            view:viewControl,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewControl,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
