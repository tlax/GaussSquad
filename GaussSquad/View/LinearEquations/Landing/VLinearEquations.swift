import UIKit

class VLinearEquations:VView
{
    private weak var controller:CLinearEquations!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquations
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
