import UIKit

class VScanner:VView
{
    private weak var controller:CScanner!
    private weak var previewLayer:CALayer?
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CScanner
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func addPreviewLayer(previewLayer:CALayer)
    {
        self.previewLayer = previewLayer
        layer.addSublayer(previewLayer)
    }
}
