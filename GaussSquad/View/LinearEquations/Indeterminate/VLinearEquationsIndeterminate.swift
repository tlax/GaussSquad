import UIKit

class VLinearEquationsIndeterminate:VView
{
    private weak var controller:CLinearEquationsIndeterminate!
    private weak var viewControl:VLinearEquationsIndeterminateControl!
    private weak var viewText:VlinearEquationsIndeterminateText!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private let kControlHeight:CGFloat = 50
    private let kTextMargin:CGFloat = 10
    private let kTitleTop:CGFloat = 30
    private let kTitleHeight:CGFloat = 25
    private let kTextHeight:CGFloat = 100
    private let kToastHeight:CGFloat = 150
    private let kAnimationDuration:TimeInterval = 2
    
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
        
        let viewText:VlinearEquationsIndeterminateText = VlinearEquationsIndeterminateText(
            controller:self.controller)
        self.viewText = viewText
        
        addSubview(blur)
        addSubview(labelTitle)
        addSubview(viewText)
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
        
        NSLayoutConstraint.topToBottom(
            view:viewText,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:viewText,
            constant:kTextHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewText,
            toView:self,
            margin:kTextMargin)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    //MARK: notifications
    
    func notifiedKeyboardChanged(sender notification:Notification)
    {
        guard
            
            let userInfo:[AnyHashable:Any] = notification.userInfo,
            let keyboardFrameValue:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            
        else
        {
            return
        }
        
        let keyRect:CGRect = keyboardFrameValue.cgRectValue
        let yOrigin = keyRect.origin.y
        let height:CGFloat = bounds.maxY
        let keyboardHeight:CGFloat
        
        if yOrigin < height
        {
            keyboardHeight = height - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        layoutControlBottom.constant = -keyboardHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func startEdition()
    {
        viewText.becomeFirstResponder()
    }
    
    func endEdition()
    {
        viewText.isHidden = true
    }
    
    func toastMessage(message:String)
    {
        let viewToast:VToast = VToast(
            message:message,
            color:UIColor.squadRed)
        
        addSubview(viewToast)
        
        NSLayoutConstraint.topToTop(
            view:viewToast,
            toView:viewText)
        NSLayoutConstraint.height(
            view:viewToast,
            constant:kToastHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewToast,
            toView:self)
    }
}
