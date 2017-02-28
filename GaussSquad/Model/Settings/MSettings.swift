import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemFractionDigits:MSettingsItemFractionDigits = MSettingsItemFractionDigits()
        let itemSupport:MSettingsItemSupport = MSettingsItemSupport()
        let itemReview:MSettingsItemReview = MSettingsItemReview()
        let itemShare:MSettingsItemShare = MSettingsItemShare()
        
        items = [
            itemFractionDigits,
            itemSupport,
            itemReview,
            itemShare
        ]
    }
}
