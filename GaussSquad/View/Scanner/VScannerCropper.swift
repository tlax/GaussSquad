import UIKit

class VScannerCropper:UIView
{
    weak var thumbTopLeft:VScannerCropperThumb!
    weak var thumbTopRight:VScannerCropperThumb!
    weak var thumbBottomLeft:VScannerCropperThumb!
    weak var thumbBottomRight:VScannerCropperThumb!
    private weak var viewMover:VScannerCropperMover!
    private weak var controller:CScanner!
    private weak var draggingThumb:VScannerCropperThumb?
    private weak var draggingMover:VScannerCropperMover?
    private let thumbSize_2:CGFloat
    private let kMinMargin:CGFloat = 10
    private let kThumbSize:CGFloat = 60
    
    init(controller:CScanner)
    {
        thumbSize_2 = kThumbSize / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let thumbTopLeft:VScannerCropperThumb = VScannerCropperThumb.topLeft()
        self.thumbTopLeft = thumbTopLeft
        
        let thumbTopRight:VScannerCropperThumb = VScannerCropperThumb.topRight()
        self.thumbTopRight = thumbTopRight
        
        let thumbBottomLeft:VScannerCropperThumb = VScannerCropperThumb.bottomLeft()
        self.thumbBottomLeft = thumbBottomLeft
        
        let thumbBottomRight:VScannerCropperThumb = VScannerCropperThumb.bottomRight()
        self.thumbBottomRight = thumbBottomRight
        
        let viewMover:VScannerCropperMover = VScannerCropperMover()
        self.viewMover = viewMover
        
        addSubview(viewMover)
        addSubview(thumbTopLeft)
        addSubview(thumbTopRight)
        addSubview(thumbBottomLeft)
        addSubview(thumbBottomRight)
        
        thumbTopLeft.initConstraints(size:kThumbSize)
        thumbTopRight.initConstraints(size:kThumbSize)
        thumbBottomLeft.initConstraints(size:kThumbSize)
        thumbBottomRight.initConstraints(size:kThumbSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        if draggingThumb == nil
        {
            guard
                
                let touch:UITouch = touches.first
                
            else
            {
                return
            }
            
            if let draggingMover:VScannerCropperMover = touch.view as? VScannerCropperMover
            {
                self.draggingMover = draggingMover
                
                let point:CGPoint = touch.location(in:self)
                let pointX:CGFloat = point.x
                let pointY:CGFloat = point.y
                let posTop:CGFloat = thumbTopLeft.positionY
                let posBottom:CGFloat = thumbBottomLeft.positionY
                let posLeft:CGFloat = thumbTopLeft.positionX
                let posRight:CGFloat = thumbTopRight.positionX
                let deltaTop:CGFloat = pointY - posTop
                let deltaBottom:CGFloat = posBottom - pointY
                let deltaLeft:CGFloat = pointX - posLeft
                let deltaRight:CGFloat = posRight - pointX
                
                draggingMover.start(
                    deltaTop:deltaTop,
                    deltaBottom:deltaBottom,
                    deltaLeft:deltaLeft,
                    deltaRight:deltaRight)
            }
            else if let draggingThumb:VScannerCropperThumb = touch.view as? VScannerCropperThumb
            {
                bringSubview(toFront:draggingThumb)
                draggingThumb.state(selected:true)
                self.draggingThumb = draggingThumb
            }
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let touch:UITouch = touches.first
            
            else
        {
            return
        }
        
        let point:CGPoint = touch.location(in:self)
        
        if let _:VScannerCropperMover = self.draggingMover
        {
            movingMover(point:point)
        }
        else if let draggingThumb:VScannerCropperThumb = self.draggingThumb
        {
            switch draggingThumb.location
            {
            case VScannerCropperThumb.Location.topLeft:
                
                movingTopLeft(point:point)
                
                break
                
            case VScannerCropperThumb.Location.topRight:
                
                movingTopRight(point:point)
                
                break
                
            case VScannerCropperThumb.Location.bottomLeft:
                
                movingBottomLeft(point:point)
                
                break
                
            case VScannerCropperThumb.Location.bottomRight:
                
                movingBottomRight(point:point)
                
                break
            }
        }
    }

    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        draggingEnded()
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        draggingEnded()
    }
    
    //MARK: private
    
    private func draggingEnded()
    {
        viewMover.clear()
        draggingThumb?.state(selected:false)
        draggingThumb = nil
        draggingMover = nil
    }
    
    private func movingMover(point:CGPoint)
    {
        guard
            
            let deltaTop:CGFloat = viewMover.deltaTop,
            let deltaBottom:CGFloat = viewMover.deltaBottom,
            let deltaLeft:CGFloat = viewMover.deltaLeft,
            let deltaRight:CGFloat = viewMover.deltaRight
            
        else
        {
            return
        }
        
        let newPointX:CGFloat = point.x
        let newPointY:CGFloat = point.y
        let minTop:CGFloat = thumbTopLeft.originalY
        let maxBottom:CGFloat = thumbBottomLeft.originalY
        let minLeft:CGFloat = thumbTopLeft.originalX
        let maxRight:CGFloat = thumbTopRight.originalX
        var newTop:CGFloat = newPointY - deltaTop
        var newBottom:CGFloat = newPointY + deltaBottom
        var newLeft:CGFloat = newPointX - deltaLeft
        var newRight:CGFloat = newPointX + deltaRight
        
        if newTop < minTop
        {
            let delta:CGFloat = minTop - newTop
            newTop = minTop
            newBottom += delta
        }
        else if newBottom > maxBottom
        {
            let delta:CGFloat = newBottom - maxBottom
            newBottom = maxBottom
            newTop -= delta
        }
        
        if newLeft < minLeft
        {
            let delta:CGFloat = minLeft - newLeft
            newLeft = minLeft
            newRight += delta
        }
        else if newRight > maxRight
        {
            let delta:CGFloat = newRight - maxRight
            newRight = maxRight
            newLeft -= delta
        }
        
        thumbTopLeft.position(
            positionX:newLeft,
            positionY:newTop)
        thumbTopRight.position(
            positionX:newRight,
            positionY:newTop)
        thumbBottomLeft.position(
            positionX:newLeft,
            positionY:newBottom)
        thumbBottomRight.position(
            positionX:newRight,
            positionY:newBottom)
    }
    
    private func movingTopLeft(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbTopLeft.originalX
        let originalY:CGFloat = thumbTopLeft.originalY
        let rightX:CGFloat = thumbTopRight.positionX
        let bottomY:CGFloat = thumbBottomLeft.positionY
        
        if pointX < originalX
        {
            pointX = originalX
        }
        
        if pointY < originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = rightX - pointX
        var deltaY:CGFloat = bottomY - pointY
        
        if deltaX < kMinMargin
        {
            deltaX = kMinMargin
        }
        
        if deltaY < kMinMargin
        {
            deltaY = kMinMargin
        }
        
        pointX = rightX - deltaX
        pointY = bottomY - deltaY
        
        thumbTopLeft.position(
            positionX:pointX,
            positionY:pointY)
        thumbTopRight.position(
            positionX:rightX,
            positionY:pointY)
        thumbBottomLeft.position(
            positionX:pointX,
            positionY:bottomY)
    }
    
    private func movingTopRight(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbTopRight.originalX
        let originalY:CGFloat = thumbTopRight.originalY
        let leftX:CGFloat = thumbTopLeft.positionX
        let bottomY:CGFloat = thumbBottomRight.positionY
        
        if pointX > originalX
        {
            pointX = originalX
        }
        
        if pointY < originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = pointX - leftX
        var deltaY:CGFloat = bottomY - pointY
        
        if deltaX < kMinMargin
        {
            deltaX = kMinMargin
        }
        
        if deltaY < kMinMargin
        {
            deltaY = kMinMargin
        }
        
        pointX = leftX + deltaX
        pointY = bottomY - deltaY
        
        thumbTopRight.position(
            positionX:pointX,
            positionY:pointY)
        thumbTopLeft.position(
            positionX:leftX,
            positionY:pointY)
        thumbBottomRight.position(
            positionX:pointX,
            positionY:bottomY)
    }
    
    private func movingBottomLeft(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbBottomLeft.originalX
        let originalY:CGFloat = thumbBottomLeft.originalY
        let rightX:CGFloat = thumbBottomRight.positionX
        let topY:CGFloat = thumbTopLeft.positionY
        
        if pointX < originalX
        {
            pointX = originalX
        }
        
        if pointY > originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = rightX - pointX
        var deltaY:CGFloat = pointY - topY
        
        if deltaX < kMinMargin
        {
            deltaX = kMinMargin
        }
        
        if deltaY < kMinMargin
        {
            deltaY = kMinMargin
        }
        
        pointX = rightX - deltaX
        pointY = topY + deltaY
        
        thumbBottomLeft.position(
            positionX:pointX,
            positionY:pointY)
        thumbBottomRight.position(
            positionX:rightX,
            positionY:pointY)
        thumbTopLeft.position(
            positionX:pointX,
            positionY:topY)
    }
    
    private func movingBottomRight(point:CGPoint)
    {
        var pointX:CGFloat = point.x
        var pointY:CGFloat = point.y
        let originalX:CGFloat = thumbBottomRight.originalX
        let originalY:CGFloat = thumbBottomRight.originalY
        let leftX:CGFloat = thumbBottomLeft.positionX
        let topY:CGFloat = thumbTopRight.positionY
        
        if pointX > originalX
        {
            pointX = originalX
        }
        
        if pointY > originalY
        {
            pointY = originalY
        }
        
        var deltaX:CGFloat = pointX - leftX
        var deltaY:CGFloat = pointY - topY
        
        if deltaX < kMinMargin
        {
            deltaX = kMinMargin
        }
        
        if deltaY < kMinMargin
        {
            deltaY = kMinMargin
        }
        
        pointX = leftX + deltaX
        pointY = topY + deltaY
        
        thumbBottomRight.position(
            positionX:pointX,
            positionY:pointY)
        thumbBottomLeft.position(
            positionX:leftX,
            positionY:pointY)
        thumbTopRight.position(
            positionX:pointX,
            positionY:topY)
    }
    
    //MARK: public
    
    private func createShades()
    {
        let shadeTop:VScannerCropperShade = VScannerCropperShade.borderBottom()
        let shadeBottom:VScannerCropperShade = VScannerCropperShade.borderTop()
        let shadeLeft:VScannerCropperShade = VScannerCropperShade.borderRight()
        let shadeRight:VScannerCropperShade = VScannerCropperShade.borderLeft()
        let shadeCornerTopLeft:VScannerCropperShade = VScannerCropperShade.noBorder()
        let shadeCornerTopRight:VScannerCropperShade = VScannerCropperShade.noBorder()
        let shadeCornerBottomLeft:VScannerCropperShade = VScannerCropperShade.noBorder()
        let shadeCornerBottomRight:VScannerCropperShade = VScannerCropperShade.noBorder()
        
        insertSubview(shadeTop, belowSubview:viewMover)
        insertSubview(shadeBottom, belowSubview:viewMover)
        insertSubview(shadeLeft, belowSubview:viewMover)
        insertSubview(shadeRight, belowSubview:viewMover)
        insertSubview(shadeCornerTopLeft, belowSubview:viewMover)
        insertSubview(shadeCornerTopRight, belowSubview:viewMover)
        insertSubview(shadeCornerBottomLeft, belowSubview:viewMover)
        insertSubview(shadeCornerBottomRight, belowSubview:viewMover)
        
        NSLayoutConstraint.topToTop(
            view:shadeTop,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:shadeTop,
            toView:thumbTopLeft,
            constant:thumbSize_2)
        NSLayoutConstraint.leftToLeft(
            view:shadeTop,
            toView:thumbTopLeft,
            constant:thumbSize_2)
        NSLayoutConstraint.rightToRight(
            view:shadeTop,
            toView:thumbTopRight,
            constant:-thumbSize_2)
        
        NSLayoutConstraint.topToBottom(
            view:shadeBottom,
            toView:thumbBottomLeft,
            constant:-thumbSize_2)
        NSLayoutConstraint.bottomToBottom(
            view:shadeBottom,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:shadeBottom,
            toView:thumbBottomLeft,
            constant:thumbSize_2)
        NSLayoutConstraint.rightToRight(
            view:shadeBottom,
            toView:thumbBottomRight,
            constant:-thumbSize_2)
        
        NSLayoutConstraint.topToTop(
            view:shadeLeft,
            toView:thumbTopLeft,
            constant:thumbSize_2)
        NSLayoutConstraint.bottomToBottom(
            view:shadeLeft,
            toView:thumbBottomLeft,
            constant:-thumbSize_2)
        NSLayoutConstraint.leftToLeft(
            view:shadeLeft,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:shadeLeft,
            toView:thumbTopLeft,
            constant:thumbSize_2)
        
        NSLayoutConstraint.topToTop(
            view:shadeRight,
            toView:thumbTopRight,
            constant:thumbSize_2)
        NSLayoutConstraint.bottomToBottom(
            view:shadeRight,
            toView:thumbBottomRight,
            constant:-thumbSize_2)
        NSLayoutConstraint.leftToRight(
            view:shadeRight,
            toView:thumbTopRight,
            constant:-thumbSize_2)
        NSLayoutConstraint.rightToRight(
            view:shadeRight,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:shadeCornerTopLeft,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:shadeCornerTopLeft,
            toView:shadeLeft)
        NSLayoutConstraint.leftToLeft(
            view:shadeCornerTopLeft,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:shadeCornerTopLeft,
            toView:shadeTop)
        
        NSLayoutConstraint.topToTop(
            view:shadeCornerTopRight,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:shadeCornerTopRight,
            toView:shadeRight)
        NSLayoutConstraint.leftToRight(
            view:shadeCornerTopRight,
            toView:shadeTop)
        NSLayoutConstraint.rightToRight(
            view:shadeCornerTopRight,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:shadeCornerBottomLeft,
            toView:shadeLeft)
        NSLayoutConstraint.bottomToBottom(
            view:shadeCornerBottomLeft,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:shadeCornerBottomLeft,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:shadeCornerBottomLeft,
            toView:shadeBottom)
        
        NSLayoutConstraint.topToBottom(
            view:shadeCornerBottomRight,
            toView:shadeRight)
        NSLayoutConstraint.bottomToBottom(
            view:shadeCornerBottomRight,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:shadeCornerBottomRight,
            toView:shadeBottom)
        NSLayoutConstraint.rightToRight(
            view:shadeCornerBottomRight,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewMover,
            toView:shadeTop)
        NSLayoutConstraint.bottomToTop(
            view:viewMover,
            toView:shadeBottom)
        NSLayoutConstraint.leftToRight(
            view:viewMover,
            toView:shadeLeft)
        NSLayoutConstraint.rightToLeft(
            view:viewMover,
            toView:shadeRight)
    }
    
    private func positionThumbs()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let width_margin:CGFloat = width - kMinMargin
        let height_margin:CGFloat = height - kMinMargin
        
        thumbTopLeft.position(
            positionX:kMinMargin,
            positionY:kMinMargin)
        thumbTopRight.position(
            positionX:width_margin,
            positionY:kMinMargin)
        thumbBottomLeft.position(
            positionX:kMinMargin,
            positionY:height_margin)
        thumbBottomRight.position(
            positionX:width_margin,
            positionY:height_margin)
    }
    
    //MARK: public
    
    func viewDidAppeared()
    {
        positionThumbs()
        createShades()
    }
}
