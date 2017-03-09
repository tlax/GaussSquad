import UIKit

class CLinearEquationsPlot:CController
{
    let model:MLinearEquationsPlot
    weak var viewPlot:VLinearEquationsPlot!
    private let kIndeterminatesWidth:CGFloat = 350
    private let kEquationsMargin:CGFloat = 20
    private let kTextTop:CGFloat = 9
    
    init(stepDone:MLinearEquationsSolutionStepDone)
    {
        model = MLinearEquationsPlot(stepDone:stepDone)
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
        
        parentController.viewParent.panRecognizer.isEnabled = false
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
            
            let texture:UIImage = viewPlot.viewMetal?.currentDrawable?.texture.exportImage(),
            let modelMenu:MLinearEquationsPlotMenu = model.modelMenu
            
        else
        {
            finishLoading()
            
            return
        }
        
        let textureWidth:CGFloat = texture.size.width
        let textureHeight:CGFloat = texture.size.height
        let totalWidth:CGFloat = textureWidth + kIndeterminatesWidth
        let totalSize:CGSize = CGSize(width:totalWidth, height:textureHeight)
        let totalFrame:CGRect = CGRect(origin:CGPoint.zero, size:totalSize)
        let textureFrame:CGRect = CGRect(origin:CGPoint.zero, size:texture.size)
        
        UIGraphicsBeginImageContextWithOptions(totalSize, true, 1)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            UIGraphicsEndImageContext()
            finishLoading()
            
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(totalFrame)
        texture.draw(in:textureFrame)
        
        let textAttributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.numericBold(size:30),
            NSForegroundColorAttributeName:UIColor.black]
        let equationIcon:UIImage = #imageLiteral(resourceName: "assetTexturePoint")
        let iconWidth:CGFloat = equationIcon.size.width
        let iconHeight:CGFloat = equationIcon.size.height
        let textWidth:CGFloat = kIndeterminatesWidth - (iconWidth + kEquationsMargin + kEquationsMargin)
        let currentX:CGFloat = textureWidth + kEquationsMargin
        var currentY:CGFloat = kEquationsMargin
        
        for menuItem:MLinearEquationsPlotMenuItem in modelMenu.items
        {
            guard
                
                let menuItem:MLinearEquationsPlotMenuItemEquation = menuItem as? MLinearEquationsPlotMenuItemEquation
            
            else
            {
                continue
            }
            
            let iconRect:CGRect = CGRect(
                x:currentX,
                y:currentY,
                width:iconWidth,
                height:iconHeight)
            let textRect:CGRect = CGRect(
                x:currentX + iconWidth + kEquationsMargin,
                y:currentY + kTextTop,
                width:textWidth,
                height:iconHeight)
            let rawString:String = menuItem.title.string
            let attributedString:NSAttributedString = NSAttributedString(
                string:rawString,
                attributes:textAttributes)
            
            context.setBlendMode(CGBlendMode.normal)
            equationIcon.draw(in:iconRect)
            context.setBlendMode(CGBlendMode.color)
            context.setFillColor(menuItem.color.cgColor)
            context.fill(iconRect)
            context.setBlendMode(CGBlendMode.normal)
            
            attributedString.draw(in:textRect)
            
            currentY += iconHeight
            currentY += kEquationsMargin
        }
        
        guard
            
            let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            finishLoading()
            
            return
        }
        
        UIGraphicsEndImageContext()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.finishSharing(image:image)
        }
    }
    
    private func finishSharing(image:UIImage)
    {
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if let popover:UIPopoverPresentationController = activity.popoverPresentationController
        {
            popover.sourceView = viewPlot
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        finishLoading()
        present(activity, animated:true)
        
        AnalyticsManager.sharedInstance?.trackShare(action:AnalyticsManager.ShareAction.plot)
    }
    
    private func finishLoading()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPlot.stopLoading()
        }
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
    
    func help()
    {
        
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
