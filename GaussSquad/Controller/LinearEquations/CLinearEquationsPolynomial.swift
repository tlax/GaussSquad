import UIKit

class CLinearEquationsPolynomial:CController
{
    weak var polynomial:DPolynomial?
    private weak var viewPolynomial:VLinearEquationsPolynomial!
    private let kCleanDividend:Double = 0
    private let kCleanDivisor:Double = 1
    private let kIsPositive:Bool = true
    private let kShowAsDivision:Bool = false
    
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
    
    //MARK: private
    
    private func confirmTrash()
    {
        guard
        
            let polynomial:DPolynomial = self.polynomial
        
        else
        {
            return
        }
     
        viewPolynomial.endEdition()
        
        if let otherPolynomials:Int = polynomial.equationResult?.polynomials?.count
        {
            if otherPolynomials > 0
            {
                cleanPolynomialInstead(polynomial:polynomial)
                
                return
            }
        }
        
        DManager.sharedInstance?.delete(object:polynomial)
        { [weak self] in
            
            self?.trashDone()
        }
    }
    
    private func cleanPolynomialInstead(polynomial:DPolynomial)
    {
        polynomial.indeterminate = nil
        polynomial.coefficientDividend = kCleanDividend
        polynomial.coefficientDivisor = kCleanDivisor
        polynomial.isPositive = kIsPositive
        polynomial.showAsDivision = kShowAsDivision
        
        trashDone()
    }
    
    private func trashDone()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            DManager.sharedInstance?.save()
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.parentController.dismissAnimateOver(completion:nil)
            }
        }
    }
    
    //MARK: public
    
    func save()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        DManager.sharedInstance?.save()
        
        viewPolynomial.endEdition()
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func trash()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("CLinearEquationsPolynomial_alertTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsPolynomial_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsPolynomial_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmTrash()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
    
    func changeIndeterminate()
    {
        
    }
}
