import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemVersion:MSettingsItemVersion = MSettingsItemVersion()
        let itemFractionDigits:MSettingsItemFractionDigits = MSettingsItemFractionDigits()
        let itemSupport:MSettingsItemSupport = MSettingsItemSupport()
        let itemReview:MSettingsItemReview = MSettingsItemReview()
        let itemShare:MSettingsItemShare = MSettingsItemShare()
        
        items = [
            itemVersion,
            itemFractionDigits,
            itemSupport,
            itemReview,
            itemShare
        ]
    }
}
