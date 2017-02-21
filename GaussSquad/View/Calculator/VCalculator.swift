import UIKit

class VCalculator:VView
{
    private weak var controller:CCalculator!
    private weak var viewBar:VCalculatorBar!
    private weak var layoutBarBottom:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCalculator
        
        let viewBar:VCalculatorBar = VCalculatorBar(
            controller:self.controller)
        self.viewBar = viewBar
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
