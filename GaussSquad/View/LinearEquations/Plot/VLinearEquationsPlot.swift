import UIKit

class VLinearEquationsPlot:VView
{
    weak var viewMetal:VLinearEquationsPlotMetal?
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
        
        guard
            
            let viewMetal:VLinearEquationsPlotMetal = VLinearEquationsPlotMetal(
                controller:self.controller)
            
        else
        {
            return
        }
        
        self.viewMetal = viewMetal
        
        addSubview(viewMetal)
        
        NSLayoutConstraint.equals(
            view:viewMetal,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
