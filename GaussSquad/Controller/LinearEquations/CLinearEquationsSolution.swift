import UIKit

class CLinearEquationsSolution:CController
{
    let model:MLinearEquationsSolution
    private weak var viewSolution:VLinearEquationsSolution!
    private weak var stepDone:MLinearEquationsSolutionStepDone?
    private let kBarHeight:CGFloat = 81
    private let kFooterHeight:CGFloat = 50
    private let kCellHeight:CGFloat = 25
    private let kSmallFooterHeight:CGFloat = 25
    
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
        var totalHeight:CGFloat = kSmallFooterHeight
        
        for step:MLinearEquationsSolutionStep in steps
        {
            let countEquations:CGFloat = CGFloat(step.equations.count)
            totalHeight += step.headerHeight
            totalHeight += kSmallFooterHeight
            totalHeight += countEquations * kCellHeight
        }
        
        let size:CGSize = CGSize(width:totalWidth, height:totalHeight)
        let frame:CGRect = CGRect(origin:CGPoint.zero, size:size)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(frame)
        
        var positionY:CGFloat = kSmallFooterHeight
        
        for step:MLinearEquationsSolutionStep in steps
        {
            let headerHeight:CGFloat = step.headerHeight
            let rect:CGRect = CGRect(
                x:0,
                y:positionY,
                width:totalWidth,
                height:headerHeight)
            
            step.drawInRect(rect:rect)
            positionY += headerHeight
            
            for equation:MLinearEquationsSolutionEquation in step.equations
            {
                let itemIndex:MLinearEquationsSolutionEquationItem = equation.index
                let itemResult:MLinearEquationsSolutionEquationItem = equation.result
                let itemEquals:MLinearEquationsSolutionEquationItem = equation.equals
                let items:[MLinearEquationsSolutionEquationItem] = equation.items
                
                var positionX:CGFloat = 0
                
                let itemIndexWidth:CGFloat = itemIndex.cellWidth
                let itemIndexRect:CGRect = CGRect(
                    x:positionX,
                    y:positionY,
                    width:itemIndexWidth,
                    height:kCellHeight)
                
                itemIndex.drawInRect(rect:itemIndexRect)
                positionX += itemIndexWidth
                
                for item:MLinearEquationsSolutionEquationItem in items
                {
                    let itemWidth:CGFloat = item.cellWidth
                    let itemRect:CGRect = CGRect(
                        x:positionX,
                        y:positionY,
                        width:itemWidth,
                        height:kCellHeight)
                    
                    item.drawInRect(rect:itemRect)
                    positionX += itemWidth
                }
                
                let itemEqualsWidth:CGFloat = itemEquals.cellWidth
                let itemEqualsRect:CGRect = CGRect(
                    x:positionX,
                    y:positionY,
                    width:itemEqualsWidth,
                    height:kCellHeight)
                
                itemEquals.drawInRect(rect:itemEqualsRect)
                positionX += itemEqualsWidth
                
                let itemResultWidth:CGFloat = itemResult.cellWidth
                let itemResultRect:CGRect = CGRect(
                    x:positionX,
                    y:positionY,
                    width:itemResultWidth,
                    height:kCellHeight)
                
                itemResult.drawInRect(rect:itemResultRect)
                positionX += itemResultWidth
                positionY += kCellHeight
            }
            
            positionY += kSmallFooterHeight
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
    
    func solutionComplete(stepDone:MLinearEquationsSolutionStepDone?)
    {
        self.stepDone = stepDone
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewSolution.refresh(stepDone:stepDone)
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
        guard
        
            let stepDone:MLinearEquationsSolutionStepDone = self.stepDone
        
        else
        {
            return
        }
        
        let controllerPlot:CLinearEquationsPlot = CLinearEquationsPlot(
            stepDone:stepDone)
        parentController.push(
            controller:controllerPlot,
            horizontal:CParent.TransitionHorizontal.fromRight)
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
