import UIKit

class VScanner:VView
{
    private weak var controller:CScanner!
    private weak var previewLayer:CALayer?
    private let kMaxWidth:CGFloat = 720
    private let kMaxHeight:CGFloat = 1280
    
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
    
    override func layoutSubviews()
    {
        if let previewLayer:CALayer = self.previewLayer
        {
            let width:CGFloat = bounds.maxX
            let height:CGFloat = bounds.maxY
            let remainX:CGFloat = width - kMaxWidth
            let remainY:CGFloat = height - kMaxHeight
            let marginX:CGFloat = remainX / 2.0
            let marginY:CGFloat = remainY / 2.0
            let previewSize:CGRect = CGRect(
                x:marginX,
                y:marginY,
                width:kMaxWidth,
                height:kMaxHeight)
            
            previewLayer.frame = previewSize
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
