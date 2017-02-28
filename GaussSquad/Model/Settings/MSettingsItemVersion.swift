import UIKit

class MSettingsItemVersion:MSettingsItem
{
    private let kCellHeight:CGFloat = 150
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellFractionVersion.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
