import UIKit

class CLinearEquationsPolynomial:CController
{
    weak var polynomial:DPolynomial?
    weak var viewPolynomial:VLinearEquationsPolynomial!
    
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
        
        polynomial.deleteFromEquation()
        trashDone()
    }
    
    private func trashDone()
    {
        DManager.sharedInstance?.save
        {
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
        
        DManager.sharedInstance?.save
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.parentController.dismissAnimateOver(completion:nil)
            }
        }
        
        viewPolynomial.endEdition()
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
            
            self?.viewPolynomial.endEdition()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmTrash()
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = viewPolynomial
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    func changeIndeterminate()
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        guard
        
            let polynomial:DPolynomial = self.polynomial
        
        else
        {
            return
        }
        
        let controllerIndeterminate:CLinearEquationsPolynomialIndeterminate = CLinearEquationsPolynomialIndeterminate(
            polynomial:polynomial)
        parentController.animateOver(controller:controllerIndeterminate)
    }
}
