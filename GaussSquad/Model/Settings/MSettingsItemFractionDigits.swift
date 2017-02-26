import UIKit

class MSettingsItemFractionDigits:MSettingsItem
{
    let kMaxDigits:Double = 15
    let kMinDigits:Double = 0
    private let kCellHeight:CGFloat = 100
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellFractionDigits.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
