import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemFractionDigits:MSettingsItemFractionDigits = MSettingsItemFractionDigits()
        let itemSupport:MSettingsItemSupport = MSettingsItemSupport()
        let itemReview:MSettingsItemReview = MSettingsItemReview()
        
        items = [
            itemFractionDigits,
            itemSupport,
            itemReview
        ]
    }
}
