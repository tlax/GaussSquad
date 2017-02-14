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
    
    private func shareSolutionImage()
    {
        viewSolution.startExporting()
        let collectionView:VCollection = viewSolution.collectionView
        let size:CGSize = collectionView.contentSize
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
        
        for step:MLinearEquationsSolutionStep in model.steps
        {
            var itemIndex:Int = 0
            
            let sectionPath:IndexPath = IndexPath(
                item:0,
                section:stepIndex)
            let header:VLinearEquationsSolutionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:UICollectionElementKindSectionHeader,
                withReuseIdentifier:
                step.reusableIdentifier,
                for:sectionPath) as! VLinearEquationsSolutionHeader
            header.config(
                step:step,
                indexPath:sectionPath)
            let headerFrame:CGRect = header.frame
            header.drawHierarchy(
                in:headerFrame,
                afterScreenUpdates:true)
            
            for item:MLinearEquationsSolutionEquationItem in step.plainItems
            {
                let indexPath:IndexPath = IndexPath(
                    item:itemIndex,
                    section:stepIndex)
                let cell:VLinearEquationsSolutionCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier:
                    item.reusableIdentifier,
                    for:indexPath) as! VLinearEquationsSolutionCell
                cell.config(
                    model:item,
                    index:indexPath)
                let cellFrame:CGRect = cell.frame
                cell.drawHierarchy(
                    in:cellFrame,
                    afterScreenUpdates:true)
                
                itemIndex += 1
            }
            
            stepIndex += 1
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
        
        share(items:sharingItems)
        viewSolution.endExporting()
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
            
            self?.shareSolutionImage()
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
                    
                    let string:String = self?.model.shareText()
                    
                else
                {
                    return
                }
                
                let sharingItems:[Any] = [string]
                
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
