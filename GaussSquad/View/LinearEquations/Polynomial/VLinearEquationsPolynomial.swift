import UIKit

class VLinearEquationsPolynomial:VView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var viewControl:VLinearEquationsPolynomialControl!
    private weak var viewText:VLinearEquationsPolynomialText!
    private weak var viewIndeterminate:VLinearEquationsPolynomialIndeterminate!
    private weak var viewShowAs:VLinearEquationsPolynomialShowAs!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private let kControlHeight:CGFloat = 50
    private let kIndeterminateHeight:CGFloat = 50
    private let kIndeterminateWidth:CGFloat = 210
    private let kShowAsWidth:CGFloat = 100
    private let kShowAsHeight:CGFloat = 32
    private let kShowAsLeft:CGFloat = 10
    private let kShowAsBottom:CGFloat = -9
    private let kAnimationDuration:TimeInterval = 2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomial
        
        let blur:VBlur = VBlur.light()
        
        let viewText:VLinearEquationsPolynomialText = VLinearEquationsPolynomialText(
            controller:self.controller)
        self.viewText = viewText
        
        let viewControl:VLinearEquationsPolynomialControl = VLinearEquationsPolynomialControl(
            controller:self.controller)
        self.viewControl = viewControl
        
        let viewIndeterminate:VLinearEquationsPolynomialIndeterminate = VLinearEquationsPolynomialIndeterminate(
            controller:self.controller)
        self.viewIndeterminate = viewIndeterminate
        
        let viewShowAs:VLinearEquationsPolynomialShowAs = VLinearEquationsPolynomialShowAs(
            controller:self.controller)
        self.viewShowAs = viewShowAs
        
        addSubview(blur)
        addSubview(viewText)
        addSubview(viewIndeterminate)
        addSubview(viewControl)
        addSubview(viewShowAs)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewText,
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
        
        NSLayoutConstraint.bottomToTop(
            view:viewIndeterminate,
            toView:viewControl)
        NSLayoutConstraint.height(
            view:viewIndeterminate,
            constant:kIndeterminateHeight)
        NSLayoutConstraint.width(
            view:viewIndeterminate,
            constant:kIndeterminateWidth)
        NSLayoutConstraint.rightToRight(
            view:viewIndeterminate,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:viewShowAs,
            toView:viewControl,
            constant:kShowAsBottom)
        NSLayoutConstraint.height(
            view:viewShowAs,
            constant:kShowAsHeight)
        NSLayoutConstraint.leftToLeft(
            view:viewShowAs,
            toView:self,
            constant:kShowAsLeft)
        NSLayoutConstraint.width(
            view:viewShowAs,
            constant:kShowAsWidth)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
    
    //MARK: public
    
    func startEdition()
    {   
        viewText.readPolynomial()
        viewIndeterminate.refresh()
    }
    
    func endEdition()
    {
        viewText.isHidden = true
    }
}
