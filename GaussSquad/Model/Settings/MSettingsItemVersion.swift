import UIKit

class MSettingsItemVersion:MSettingsItem
{
    private let kCellHeight:CGFloat = 150
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellShare.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
