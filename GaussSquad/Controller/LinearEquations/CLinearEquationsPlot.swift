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
    
    //MARK: private
    
    private func shareTexture()
    {
        guard
            
            let texture:UIImage = viewPlot.viewMetal?.currentDrawable?.texture.exportImage()
            
            else
        {
            return
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.finishSharing(image:texture)
        }
    }
    
    private func finishSharing(image:UIImage)
    {
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.viewPlot
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        viewPlot.stopLoading()
        present(activity, animated:true)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func share()
    {
        viewPlot.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.shareTexture()
        }
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
