import UIKit

class VCalculator:VView
{
    private weak var controller:CCalculator!
    private weak var viewText:VCalculatorText!
    private weak var viewBar:VCalculatorBar!
    private weak var layoutBarBottom:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 50
    private let kTextHeight:CGFloat = 125
    private let kTextBorderHeight:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.35
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCalculator
        
        let viewBar:VCalculatorBar = VCalculatorBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewText:VCalculatorText = VCalculatorText(
            controller:self.controller)
        self.viewText = viewText
        
        let textBorder:VBorder = VBorder(color:UIColor(white:0, alpha:0.2))
        
        addSubview(textBorder)
        addSubview(viewText)
        addSubview(viewBar)
        
        layoutBarBottom = NSLayoutConstraint.bottomToBottom(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewText,
            toView:self)
        NSLayoutConstraint.height(
            view:viewText,
            constant:kTextHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewText,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:textBorder,
            toView:viewText)
        NSLayoutConstraint.height(
            view:textBorder,
            constant:kTextBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:textBorder,
            toView:self)
        
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
        
        layoutBarBottom.constant = -keyboardHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        viewText.becomeFirstResponder()
    }
}
