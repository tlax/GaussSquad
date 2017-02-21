import UIKit

class VCalculator:VView
{
    private weak var controller:CCalculator!
    private weak var viewText:VCalculatorText!
    private weak var viewBar:VCalculatorBar!
    private weak var layoutBarBottom:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 50
    private let kTextHeight:CGFloat = 200
    
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        viewText.becomeFirstResponder()
    }
}
