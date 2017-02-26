import UIKit

class MSettingsItemSupport:MSettingsItem
{
    private let kCellHeight:CGFloat = 70
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellSupport.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
