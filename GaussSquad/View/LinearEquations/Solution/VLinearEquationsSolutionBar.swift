import UIKit

class VLinearEquationsSolutionBar:UIView
{
    private weak var controller:CLinearEquationsSolution!
    
    init(controller:CLinearEquationsSolution)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
