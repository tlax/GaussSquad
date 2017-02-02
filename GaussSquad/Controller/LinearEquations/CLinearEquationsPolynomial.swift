import UIKit

class CLinearEquationsPolynomial:CController
{
    weak var polynomial:DPolynomial?
    private weak var viewPolynomial:VLinearEquationsPolynomial!
    
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
        let viewPolynomial:VLinearEquationsPolynomial = VLinearEquationsPolynomial(
            controller:self)
        self.viewPolynomial = viewPolynomial
        view = viewPolynomial
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)

        viewPolynomial.startEdition()
    }
    
    //MARK: public
    
    func save()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        viewPolynomial.endEdition()
        DManager.sharedInstance?.save()
        parentController.dismissAnimateOver(completion:nil)
    }
}
