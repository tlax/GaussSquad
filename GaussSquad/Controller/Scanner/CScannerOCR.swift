import UIKit

class CScannerOCR:CController
{
    private weak var viewOCR:VScannerOCR!
    private let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewOCR:VScannerOCR = VScannerOCR(controller:self)
        self.viewOCR = viewOCR
        view = viewOCR
    }
}
