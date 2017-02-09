import UIKit

class VLinearEquationsSolution:VView
{
    private weak var controller:CLinearEquationsSolution!
    private weak var viewBar:VLinearEquationsSolutionBar!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 80
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsSolution
        
        let viewBar:VLinearEquationsSolutionBar = VLinearEquationsSolutionBar(
            controller:self.controller)
        self.viewBar = viewBar
        
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
        return nil
    }
    
    //MARK: public
    
    func refresh()
    {
        
    }
}