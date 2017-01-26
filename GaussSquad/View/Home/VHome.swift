import UIKit

class VHome:VView
{
    private weak var controller:CHome!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CHome
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
