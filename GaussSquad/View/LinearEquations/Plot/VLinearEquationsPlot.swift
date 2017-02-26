import UIKit

class VLinearEquationsPlot:VView
{
    weak var viewMetal:VLinearEquationsPlotMetal?
    weak var viewMenu:VLinearEquationsPlotMenu!
    private weak var controller:CLinearEquationsPlot!
    private weak var viewBar:VLinearEquationsPlotBar!
    private weak var spinner:VSpinner?
    private var startingPoint:CGPoint?
    private let kBarHeight:CGFloat = 64
    private let kMenuHeight:CGFloat = 52
    private var positionX:CGFloat = 0
    private var positionY:CGFloat = 0
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsPlot
        
        let viewBar:VLinearEquationsPlotBar = VLinearEquationsPlotBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let viewMenu:VLinearEquationsPlotMenu = VLinearEquationsPlotMenu(
            controller:self.controller)
        self.viewMenu = viewMenu
        
        addSubview(viewBar)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
        
        guard
            
            let viewMetal:VLinearEquationsPlotMetal = VLinearEquationsPlotMetal(
                controller:self.controller)
            
        else
        {
            let error:String = NSLocalizedString("VLinearEquationsPlot_notSupported", comment:"")
            VAlert.message(message:error)
            
            return
        }
        
        self.viewMetal = viewMetal
        insertSubview(viewMetal, belowSubview:viewBar)

        NSLayoutConstraint.equals(
            view:viewMetal,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let touch:UITouch = touches.first,
            let view:UIView = touch.view
        
        else
        {
            return
        }
        
        if view !== viewBar
        {
            startingPoint = touch.location(in:self)
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
        
            let startingPoint:CGPoint = self.startingPoint,
            let newPoint:CGPoint = touches.first?.location(in:self)
        
        else
        {
            return
        }
        
        self.startingPoint = newPoint
        let deltaX:CGFloat = startingPoint.x - newPoint.x
        let deltaY:CGFloat = startingPoint.y - newPoint.y
        positionX -= deltaX
        positionY += deltaY
        
        viewMetal?.newPosition(
            positionX:positionX,
            positionY:positionY)
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        startingPoint = nil
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        startingPoint = nil
    }
    
    //MARK: public
    
    func centerItem(item:MLinearEquationsPlotMenuItem)
    {
        positionX = -item.positionX
        positionY = -item.positionY
        
        viewMetal?.newPosition(
            positionX:positionX,
            positionY:positionY)
    }
    
    func increaseAndRefresh(delta:Double)
    {
        let floatDelta:CGFloat = CGFloat(delta)
        
        if positionX >= 0
        {
            positionX += floatDelta
        }
        else
        {
            positionX -= floatDelta
        }
        
        if positionY >= 0
        {
            positionY += floatDelta
        }
        else
        {
            positionY -= floatDelta
        }
        
        viewMetal?.newPosition(
            positionX:positionX,
            positionY:positionY)
        
        viewMenu.refresh()
    }
    
    func startLoading()
    {
        isUserInteractionEnabled = false
        self.spinner?.stopAnimating()
        self.spinner?.removeFromSuperview()
        viewMetal?.isPaused = true
        viewMetal?.isHidden = true
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    func stopLoading()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        isUserInteractionEnabled = true
        viewMetal?.isHidden = false
        viewMetal?.isPaused = false
    }
}
