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
    
    func plot()
    {
        
    }
    
    func share(step:Int)
    {
        let alert:UIAlertController = UIAlertController(
            title:NSLocalizedString("CLinearEquationsSolution_shareStepTitle", comment:""),
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
        { [weak self] (action:UIAlertAction) in
            
        }
        
        alert.addAction(actionImage)
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
