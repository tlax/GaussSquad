import UIKit

class VLinearEquationsPolynomialDivision:UIView
{
    weak var fieldDividend:UITextField!
    weak var fieldDivisor:UITextField!
    private weak var controller:CLinearEquationsPolynomial!
    
    init(controller:CLinearEquationsPolynomial)
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
