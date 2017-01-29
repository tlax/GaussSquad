import UIKit

class VLinearEquations:VView
{
    private weak var controller:CLinearEquations!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquations
        
        let spinner:VSpinner = VSpinner()
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
