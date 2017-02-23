import UIKit

class VCalculatorHistory:UIView
{
    private weak var controller:CCalculator!
    
    init(controller:CCalculator)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
