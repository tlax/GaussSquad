import UIKit

class MScannerMenuItemClean:MScannerMenuItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericCompress")
        let title:String = NSLocalizedString("MScannerMenuItemClean_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
    
    override func selected(controller:CScannerOCR)
    {
        controller.clean()
    }
}
