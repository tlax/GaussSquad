import UIKit

class VScanner:VView
{
    weak var viewCropper:VScannerCropper!
    weak var viewPreview:VScannerPreview!
    private weak var controller:CScanner!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CScanner
        
        let viewPreview:VScannerPreview = VScannerPreview(
            controller:self.controller)
        self.viewPreview = viewPreview
        
        let viewCropper:VScannerCropper = VScannerCropper(
            controller:self.controller)
        self.viewCropper = viewCropper
        
        addSubview(viewPreview)
        addSubview(viewCropper)
        
        NSLayoutConstraint.equals(
            view:viewPreview,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewCropper,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
