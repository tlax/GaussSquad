import UIKit

class VScannerCropper:UIView
{
    weak var thumbTopLeft:VScannerCropperThumb!
    weak var thumbTopRight:VScannerCropperThumb!
    weak var thumbBottomLeft:VScannerCropperThumb!
    weak var thumbBottomRight:VScannerCropperThumb!
    private weak var viewMover:VCameraCropImageMover!
    private weak var controller:CScanner!
    private var hadLayout:Bool
    private var shadesCreated:Bool
    private let thumbSize_2:CGFloat
    private let kMinMargin:CGFloat = 40
    private let kThumbSize:CGFloat = 48
    
    init(controller:CScanner)
    {
        hadLayout = false
        shadesCreated = false
        thumbSize_2 = kThumbSize / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let thumbTopLeft:VCameraCropImageThumb = VCameraCropImageThumb.topLeft()
        self.thumbTopLeft = thumbTopLeft
        
        let thumbTopRight:VCameraCropImageThumb = VCameraCropImageThumb.topRight()
        self.thumbTopRight = thumbTopRight
        
        let thumbBottomLeft:VCameraCropImageThumb = VCameraCropImageThumb.bottomLeft()
        self.thumbBottomLeft = thumbBottomLeft
        
        let thumbBottomRight:VCameraCropImageThumb = VCameraCropImageThumb.bottomRight()
        self.thumbBottomRight = thumbBottomRight
        
        let viewMover:VCameraCropImageMover = VCameraCropImageMover()
        self.viewMover = viewMover
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
