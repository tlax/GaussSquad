import UIKit

class VCalculator:VView
{
    private weak var controller:CCalculator!
    private weak var viewText:VCalculatorText!
    private weak var viewHistory:VCalculatorHistory!
    private weak var viewBar:VCalculatorBar!
    private weak var layoutTextHeight:NSLayoutConstraint!
    private weak var layoutBarBottom:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 45
    private let kTextMaxHeight:CGFloat = 125
    private let kTextMinHeight:CGFloat = 65
    private let kTextBorderHeight:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.35
    private let kAnimationFastDuration:TimeInterval = 0.1
    
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
        
        let viewHistory:VCalculatorHistory = VCalculatorHistory(
            controller:self.controller)
        self.viewHistory = viewHistory
        
        let textBorder:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(textBorder)
        addSubview(viewHistory)
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
        layoutTextHeight = NSLayoutConstraint.height(
            view:viewText)
        NSLayoutConstraint.equalsHorizontal(
            view:viewText,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewHistory,
            toView:viewText)
        NSLayoutConstraint.bottomToTop(
            view:viewHistory,
            toView:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewHistory,
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
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
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
    
    //MARK: private
    
    private func resizeField()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let textHeight:CGFloat
        
        if height >= width
        {
            textHeight = kTextMaxHeight
        }
        else
        {
            textHeight = kTextMinHeight
        }
        
        layoutTextHeight.constant = textHeight
        
        UIView.animate(
            withDuration:kAnimationFastDuration,
        animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
            
            let _:Bool? = self?.viewText.becomeFirstResponder()
        }
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        resizeField()
    }
    
    func orientationChange()
    {
        resizeField()
    }
}
