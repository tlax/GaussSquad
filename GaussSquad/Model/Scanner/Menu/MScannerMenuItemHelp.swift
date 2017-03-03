import UIKit

class MScannerMenuItemHelp:MScannerMenuItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericHelp")
        let title:String = NSLocalizedString("MScannerMenuItemHelp_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
