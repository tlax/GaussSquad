import UIKit

class MScannerMenuItemClean:MScannerMenuItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericBack")
        let title:String = NSLocalizedString("MScannerMenuItemClean_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
