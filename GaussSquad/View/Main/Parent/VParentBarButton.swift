import UIKit

class VParentBarButton:UIButton
{
    init(image:UIImage)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.selected)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
        imageView!.tintColor = UIColor(white:0.9, alpha:1)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
