import UIKit

class VScannerCropperShade:UIView
{
    private let kBorderSize:CGFloat = 1
    private let kAlpha:CGFloat = 0.8
    
    class func noBorder() -> VScannerCropperShade
    {
        let shade:VScannerCropperShade = VScannerCropperShade()
        
        return shade
    }
    
    class func borderTop() -> VScannerCropperShade
    {
        let shade:VScannerCropperShade = VScannerCropperShade(borderTop:true)
        
        return shade
    }
    
    class func borderBottom() -> VScannerCropperShade
    {
        let shade:VScannerCropperShade = VScannerCropperShade(borderBottom:true)
        
        return shade
    }
    
    class func borderLeft() -> VScannerCropperShade
    {
        let shade:VScannerCropperShade = VScannerCropperShade(borderLeft:true)
        
        return shade
    }
    
    class func borderRight() -> VScannerCropperShade
    {
        let shade:VScannerCropperShade = VScannerCropperShade(borderRight:true)
        
        return shade
    }
    
    private init(
        borderTop:Bool = false,
        borderBottom:Bool = false,
        borderLeft:Bool = false,
        borderRight:Bool = false)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0, alpha:kAlpha)
        
        if borderTop
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.topToTop(
                view:border,
                toView:self)
            NSLayoutConstraint.height(
                view:border,
                constant:kBorderSize)
            NSLayoutConstraint.equalsHorizontal(
                view:border,
                toView:self)
        }
        
        if borderBottom
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.bottomToBottom(
                view:border,
                toView:self)
            NSLayoutConstraint.height(
                view:border,
                constant:kBorderSize)
            NSLayoutConstraint.equalsHorizontal(
                view:border,
                toView:self)
        }
        
        if borderLeft
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.equalsVertical(
                view:border,
                toView:self)
            NSLayoutConstraint.leftToLeft(
                view:border,
                toView:self)
            NSLayoutConstraint.width(
                view:border,
                constant:kBorderSize)
        }
        
        if borderRight
        {
            let border:VBorder = VBorder(color:UIColor.white)
            
            addSubview(border)
            
            NSLayoutConstraint.equalsVertical(
                view:border,
                toView:self)
            NSLayoutConstraint.rightToRight(
                view:border,
                toView:self)
            NSLayoutConstraint.width(
                view:border,
                constant:kBorderSize)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
