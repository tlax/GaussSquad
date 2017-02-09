import UIKit

class VLinearEquationsSolution:VView
{
    private weak var controller:CLinearEquationsSolution!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsSolution
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
