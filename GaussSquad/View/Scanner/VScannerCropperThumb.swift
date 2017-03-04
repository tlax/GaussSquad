import UIKit

class VScannerCropperThumb:UIImageView
{
    enum Location
    {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    var positionX:CGFloat
    var positionY:CGFloat
    var originalX:CGFloat!
    var originalY:CGFloat!
    let location:Location
    private weak var layoutTop:NSLayoutConstraint!
    private weak var layoutLeft:NSLayoutConstraint!
    private var size_2:CGFloat
    
    class func topLeft() -> VScannerCropperThumb
    {
        let thumb:VScannerCropperThumb = VScannerCropperThumb(
            location:Location.topLeft)
        
        return thumb
    }
    
    class func topRight() -> VScannerCropperThumb
    {
        let thumb:VScannerCropperThumb = VScannerCropperThumb(
            location:Location.topRight)
        
        return thumb
    }
    
    class func bottomLeft() -> VScannerCropperThumb
    {
        let thumb:VScannerCropperThumb = VScannerCropperThumb(
            location:Location.bottomLeft)
        
        return thumb
    }
    
    class func bottomRight() -> VScannerCropperThumb
    {
        let thumb:VScannerCropperThumb = VScannerCropperThumb(
            location:Location.bottomRight)
        
        return thumb
    }
    
    private init(location:Location)
    {
        self.location = location
        positionX = 0
        positionY = 0
        size_2 = 0
        
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = true
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        
        state(selected:false)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func position(positionX:CGFloat, positionY:CGFloat)
    {
        self.positionX = positionX
        self.positionY = positionY
        layoutTop.constant = positionY - size_2
        layoutLeft.constant = positionX - size_2
        
        if originalX == nil
        {
            originalX = positionX
            originalY = positionY
        }
    }
    
    func initConstraints(size:CGFloat)
    {
        guard
            
            let superview:UIView = self.superview
            
        else
        {
            return
        }
        
        size_2 = size / 2.0
        layoutTop = NSLayoutConstraint.topToTop(
            view:self,
            toView:superview)
        layoutLeft = NSLayoutConstraint.leftToLeft(
            view:self,
            toView:superview)
        NSLayoutConstraint.size(
            view:self,
            constant:size)
    }
    
    func state(selected:Bool)
    {
        if selected
        {
            image = #imageLiteral(resourceName: "assetGenericThumbSelected")
        }
        else
        {
            image = #imageLiteral(resourceName: "assetGenericThumb")
        }
    }
    
    func reset()
    {
        position(
            positionX:originalX,
            positionY:originalY)
    }
}
