import UIKit

class CLinearEquationsProject:CController
{
    let model:MLinearEquationsProject
    private weak var viewProject:VLinearEquationsProject!
    
    init(project:DProject?)
    {
        model = MLinearEquationsProject(project:project)
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        model.load(controller:self)
    }
    
    override func loadView()
    {
        let viewProject:VLinearEquationsProject = VLinearEquationsProject(controller:self)
        self.viewProject = viewProject
        view = viewProject
    }
    
    //MARK: private
    
    private func confirmRemoveIndeterminate(indeterminate:DIndeterminate)
    {
        model.removeIndeterminate(indeterminate:indeterminate)
    }
    
    //MARK: public
    
    func next()
    {
        
    }
    
    func save()
    {
        DManager.sharedInstance?.save()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func delete()
    {
        
    }
    
    func modelLoaded()
    {
        viewProject.refresh()
    }
    
    func editPolynomial(polynomial:DPolynomial)
    {
        let controllerPolynomial:CLinearEquationsPolynomial = CLinearEquationsPolynomial(
            polynomial:polynomial)
        parentController.animateOver(
            controller:controllerPolynomial)
    }
    
    func addIndeterminate()
    {
        let controllerIndeterminate:CLinearEquationsIndeterminate = CLinearEquationsIndeterminate(
            model:model)
        parentController.animateOver(
            controller:controllerIndeterminate)
    }
    
    func removeIndeterminate(indeterminate:DIndeterminate)
    {
        guard
            
            let symbol:String = indeterminate.symbol
        
        else
        {
            return
        }
        
        let alertTitle:String = String(
            format:NSLocalizedString("CLinearEquationsProject_alertTitle", comment:""),
            symbol)
        
        let alert:UIAlertController = UIAlertController(
            title:alertTitle,
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmRemoveIndeterminate(
                indeterminate:indeterminate)
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
