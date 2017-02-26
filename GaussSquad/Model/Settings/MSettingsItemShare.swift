import UIKit

class MSettingsItemShare:MSettingsItem
{
    private let kCellHeight:CGFloat = 80
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellShare.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
