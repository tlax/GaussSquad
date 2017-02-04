import UIKit

class VLinearEquationsIndeterminateList:VView
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomialIndeterminate
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
