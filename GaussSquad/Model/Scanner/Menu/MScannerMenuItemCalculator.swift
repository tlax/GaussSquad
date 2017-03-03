import UIKit

class MScannerMenuItemCalculator:MScannerMenuItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetGenericBack")
        let title:String = NSLocalizedString("MScannerMenuItemCalculator_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
