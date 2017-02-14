import UIKit

class CLinearEquationsSolution:CController
{
    let model:MLinearEquationsSolution
    private weak var viewSolution:VLinearEquationsSolution!
    
    init(project:DProject)
    {
        model = MLinearEquationsSolution(project:project)
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewSolution:VLinearEquationsSolution = VLinearEquationsSolution(
            controller:self)
        self.viewSolution = viewSolution
        view = viewSolution
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
            
                let strongSelf:CLinearEquationsSolution = self
                
            else
            {
                return
            }
            
            strongSelf.model.solve(controller:strongSelf)
        }
    }
    
    //MARK: private
    
    private func share(items:[Any])
    {
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:items,
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.viewSolution
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    //MARK: public
    
    func solutionComplete()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSolution.refresh()
        }
    }
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func bottom()
    {
        viewSolution.bottom()
    }
    
    func plot()
    {
        
    }
    
    func share()
    {
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("CLinearEquationsSolution_shareTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionImage:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareImage", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
        }
        
        let actionText:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareText", comment:""),
            style:
            UIAlertActionStyle.default)
        { (action:UIAlertAction) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                    
                    let modelStep:MLinearEquationsSolutionStep = self?.model.steps[step]
                    
                else
                {
                    return
                }
                
                guard
                    
                    let stepText:String = modelStep.shareText()
                    
                else
                {
                    return
                }
                
                let sharingItems:[Any] = [stepText]
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.share(items:sharingItems)
                }
            }
        }
        
        alert.addAction(actionImage)
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
    
    func share(step:Int)
    {
        let title:String = String(
            format:NSLocalizedString("CLinearEquationsSolution_shareStepTitle", comment:""),
            "\((step + 1))")
        
        let alert:UIAlertController = UIAlertController(
            title:title,
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareStepCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionImage:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareStepImage", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
        }
        
        let actionText:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareStepText", comment:""),
            style:
            UIAlertActionStyle.default)
        { (action:UIAlertAction) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                    
                    let modelStep:MLinearEquationsSolutionStep = self?.model.steps[step]
                    
                else
                {
                    return
                }
                
                guard
                    
                    let stepText:String = modelStep.shareText()
                
                else
                {
                    return
                }
                
                let sharingItems:[Any] = [stepText]
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.share(items:sharingItems)
                }
            }
        }
        
        alert.addAction(actionImage)
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
