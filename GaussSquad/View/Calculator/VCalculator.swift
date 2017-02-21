import UIKit

class VCalculator:VView
{
    private weak var controller:CCalculator!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCalculator
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
