import UIKit

class VScannerPreview:UIView
{
    private weak var previewLayer:CALayer?
    private weak var controller:CScanner!
    
    init(controller:CScanner)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
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
