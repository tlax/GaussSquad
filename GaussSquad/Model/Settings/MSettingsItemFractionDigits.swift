import UIKit

class MSettingsItemFractionDigits:MSettingsItem
{
    private let kCellHeight:CGFloat = 100
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellFractionDigits.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
