import UIKit

class VLinearEquationsPolynomialShowAs:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var buttonDivision:UIButton!
    private weak var buttonDecimal:UIButton!
    private let kButtonWidth:CGFloat = 60
    
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
