import UIKit

class MSettingsItemSupport:MSettingsItem
{
    private let kCellHeight:CGFloat = 80
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellSupport.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
