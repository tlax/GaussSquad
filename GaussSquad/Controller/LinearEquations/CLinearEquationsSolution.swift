import UIKit

class CLinearEquationsSolution:CController
{
    let model:MLinearEquationsSolution
    private weak var viewSolution:VLinearEquationsSolution!
    private let kBarHeight:CGFloat = 81
    private let kFooterHeight:CGFloat = 50
    private let kCellHeight:CGFloat = 25
    
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
            controller:self,
            barHeight:kBarHeight,
            footerHeight:kFooterHeight,
            cellHeight:kCellHeight)
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
    
    private func shareStepsImage(steps:[MLinearEquationsSolutionStep])
    {
        let totalWidth:CGFloat = viewSolution.collectionView.contentSize.width
        var totalHeight:CGFloat = 0
        
        for step:MLinearEquationsSolutionStep in steps
        {
            let countEquations:CGFloat = CGFloat(step.equations.count)
            totalHeight += step.headerHeight
            totalHeight += countEquations * kCellHeight
        }
        
        let size:CGSize = CGSize(width:totalWidth, height:totalHeight)
        let frame:CGRect = CGRect(origin:CGPoint.zero, size:size)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(frame)
        
        var stepIndex:Int = 0
        var removeTop:CGFloat = kBarHeight
        
        for step:MLinearEquationsSolutionStep in model.steps
        {
            
        }
        
        guard
            
            let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return
        }
        
        UIGraphicsEndImageContext()
        let sharingItems:[Any] = [image]
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.share(items:sharingItems)
            self?.viewSolution.endExporting()
        }
    }
    
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
            
            self?.viewSolution.startExporting()
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.viewSolution.startExporting()
                
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                { [weak self] in
                        
                    guard
                        
                        let steps:[MLinearEquationsSolutionStep] = self?.model.steps
                        
                    else
                    {
                        return
                    }
                    
                    self?.shareStepsImage(steps:steps)
                }
            }
        }
        
        let actionText:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareText", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewSolution.startExporting()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                    
                    let string:String = self?.model.shareText()
                    
                else
                {
                    return
                }
                
                let sharingItems:[Any] = [string]
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.share(items:sharingItems)
                    self?.viewSolution.endExporting()
                }
            }
        }
        
        alert.addAction(actionImage)
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
    
    func share(stepIndex:Int)
    {
        let title:String = String(
            format:NSLocalizedString("CLinearEquationsSolution_shareStepTitle", comment:""),
            "\((stepIndex + 1))")
        
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
         
            self?.viewSolution.startExporting()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                
                    let step:MLinearEquationsSolutionStep = self?.model.steps[stepIndex]
                
                else
                {
                    return
                }
                
                let steps:[MLinearEquationsSolutionStep] = [step]
                self?.shareStepsImage(steps:steps)
            }
        }
        
        let actionText:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLinearEquationsSolution_shareStepText", comment:""),
            style:
            UIAlertActionStyle.default)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewSolution.startExporting()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                    
                    let modelStep:MLinearEquationsSolutionStep = self?.model.steps[stepIndex]
                    
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
                    self?.viewSolution.endExporting()
                }
            }
        }
        
        alert.addAction(actionImage)
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
}
