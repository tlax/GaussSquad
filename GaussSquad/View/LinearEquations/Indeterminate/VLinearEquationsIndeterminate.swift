import UIKit

class VLinearEquationsIndeterminate:VView
{
    private weak var controller:CLinearEquationsIndeterminate!
    private weak var viewControl:VLinearEquationsIndeterminateControl!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private let kControlHeight:CGFloat = 50
    private let kTextMargin:CGFloat = 10
    private let kTitleTop:CGFloat = 30
    private let kTitleHeight:CGFloat = 25
    private let kTextHeight:CGFloat = 90
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsIndeterminate
        
        let blur:VBlur = VBlur.light()
        
        let viewControl:VLinearEquationsIndeterminateControl = VLinearEquationsIndeterminateControl(
            controller:self.controller)
        self.viewControl = viewControl
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.regular(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsIndeterminate_labelTitle", comment:"")
        
        addSubview(blur)
        addSubview(labelTitle)
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
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self,
            margin:kTextMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
