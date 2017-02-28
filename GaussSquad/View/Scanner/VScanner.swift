import UIKit

class VScanner:VView
{
    private weak var controller:CScanner!
    private weak var viewCropper:VScannerCropper!
    private weak var previewLayer:CALayer?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CScanner
        
        let viewCropper:VScannerCropper = VScannerCropper(
            controller:self.controller)
        self.viewCropper = viewCropper
        
        addSubview(viewCropper)
        
        NSLayoutConstraint.equals(
            view:viewCropper,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        if let previewLayer:CALayer = self.previewLayer
        {
            previewLayer.frame = bounds
        }
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
