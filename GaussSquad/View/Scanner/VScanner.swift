import UIKit

class VScanner:VView
{
    private weak var controller:CScanner!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CScanner
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
