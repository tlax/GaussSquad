import UIKit

class VLinearEquationsProjectControls:UIView
{
    private weak var controller:CLinearEquationsProject!
    
    init(controller:CLinearEquationsProject)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.squadBlue
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
