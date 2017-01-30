import UIKit

class VLinearEquationsProject:VView
{
    private weak var controller:CLinearEquationsProject!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsProject
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
