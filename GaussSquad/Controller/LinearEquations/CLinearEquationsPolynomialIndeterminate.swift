import UIKit

class CLinearEquationsPolynomialIndeterminate:CController
{
    private weak var viewIndeterminate:VLinearEquationsIndeterminate!
    private weak var polynomial:DPolynomial?
    
    init(polynomial:DPolynomial)
    {
        self.polynomial = polynomial
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewIndeterminate:VLinearEquationsIndeterminate = VLinearEquationsIndeterminate(
            controller:self)
        self.viewIndeterminate = viewIndeterminate
        view = viewIndeterminate
    }
}
