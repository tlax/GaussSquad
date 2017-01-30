import UIKit

class VLinearEquationsProjectBar:UIView
{
    private weak var controller:CLinearEquationsProject!
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
