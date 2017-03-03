import UIKit

class MScannerMenuItemCalculator:MScannerMenuItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericImportCalculator")
        let title:String = NSLocalizedString("MScannerMenuItemCalculator_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override func selected(controller:CScannerOCR)
    {
        controller.calculator()
    }
}
