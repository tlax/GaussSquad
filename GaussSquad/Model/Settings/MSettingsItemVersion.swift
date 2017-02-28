import UIKit

class MSettingsItemVersion:MSettingsItem
{
    private let kCellHeight:CGFloat = 200
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellVersion.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
