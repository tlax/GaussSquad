import UIKit

class CLinearEquationsPolynomialIndeterminate:CController
{
    private weak var viewList:VLinearEquationsIndeterminateList!
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
        let viewList:VLinearEquationsIndeterminateList = VLinearEquationsIndeterminateList(
            controller:self)
        self.viewList = viewList
        view = viewList
    }
}
