import UIKit

class VLinearEquationsPlot:VView
{
    private weak var controller:CLinearEquationsPlot!
    private weak var viewBar:VLinearEquationsPlotBar!
    private let kBarHeight:CGFloat = 80
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsPlot
        
        let viewBar:VLinearEquationsPlotBar = VLinearEquationsPlotBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        
        NSLayoutConstraint.topToTop(
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
