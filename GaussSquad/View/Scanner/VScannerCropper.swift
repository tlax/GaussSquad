import UIKit

class VScannerCropper:UIView
{
    weak var thumbTopLeft:VScannerCropperThumb!
    weak var thumbTopRight:VScannerCropperThumb!
    weak var thumbBottomLeft:VScannerCropperThumb!
    weak var thumbBottomRight:VScannerCropperThumb!
    private weak var viewMover:VScannerCropperMover!
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
