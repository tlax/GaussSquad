import UIKit

class CLinearEquationsPlot:CController
{
    let model:MPlot
    weak var viewPlot:VLinearEquationsPlot!
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        model = MPlot(stepDone:stepDone)
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPlot:VLinearEquationsPlot = VLinearEquationsPlot(controller:self)
        self.viewPlot = viewPlot
        view = viewPlot
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
            
            let device:MTLDevice = viewPlot.viewMetal?.device
            
        else
        {
            return
        }
        
        if model.modelRender == nil
        {
            model.makeRender(device:device)
            viewPlot.viewMenu.refresh()
        }
    }
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        model.modelRender?.updateProjection(
            width:size.width,
            height:size.height)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func share()
    {
        guard
        
            let texture:UIImage = viewPlot.viewMetal?.currentDrawable?.texture.exportImage()
        
        else
        {
            return
        }
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[texture],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.viewPlot
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    func updateZoom(zoom:Double)
    {
        let increase:Double = model.updateZoom(zoom:zoom)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPlot.increaseAndRefresh(delta:increase)
        }
    }
}
