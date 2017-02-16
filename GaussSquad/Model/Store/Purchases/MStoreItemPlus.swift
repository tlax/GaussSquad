import UIKit

class MStoreItemPlus:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.GaussSquad.plus"
    
    init()
    {
        let title:String = NSLocalizedString("MStoreItemPlus_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemPlus_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetGenericPurchasePlus")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.purchasePlus()
    }
    
    override func validatePurchase() -> Bool
    {
        var isPurchased:Bool = false
        
        guard
            
            let plus:Bool = MSession.sharedInstance.settings?.plus
            
        else
        {
            return isPurchased
        }
        
        isPurchased = plus
        
        return isPurchased
    }
}
