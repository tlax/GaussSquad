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
    
    private func confirmDelete()
    {
        guard
            
            let project:DProject = model.project
        
        else
        {
            return
        }
        
        DManager.sharedInstance?.delete(data:project)
        { [weak self] in
            
            self?.deleteDone()
        }
    }
    
    private func deleteDone()
    {
        DManager.sharedInstance?.save
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
            }
        }
    }
    
    //MARK: public
    
    func next()
    {
        
    }
    
    func compress()
    {
        viewProject.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model.compress()
        }
    }
    
    func save()
    {
        DManager.sharedInstance?.save()
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func delete()
    {
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("CLinearEquationsProject_alertProjectTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertProjectCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertProjectDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmDelete()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
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
            format:NSLocalizedString("CLinearEquationsProject_alertIndeterminateTitle", comment:""),
            symbol)
        
        let alert:UIAlertController = UIAlertController(
            title:alertTitle,
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertIndeterminateCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsProject_alertIndeterminateDelete", comment:""),
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
