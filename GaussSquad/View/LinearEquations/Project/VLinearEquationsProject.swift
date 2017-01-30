import UIKit

class VLinearEquationsProject:VView
{
    private weak var controller:CLinearEquationsProject!
    private weak var viewBar:VLinearEquationsProjectBar!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 70
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsProject
        
        let viewBar:VLinearEquationsProjectBar = VLinearEquationsProjectBar(
            controller:self.controller)
        
        addSubview(viewBar)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
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
        fatalError()
    }
}
