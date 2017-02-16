import Foundation

class MSettings
{
    let items:[MSettingsItem]
    
    init()
    {
        let itemFractionDigits:MSettingsItemFractionDigits = MSettingsItemFractionDigits()
        
        items = [
            itemFractionDigits
        ]
    }
}
