import UIKit

class MSettingsItemReview:MSettingsItem
{
    private let kCellHeight:CGFloat = 85
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellReview.reusableIdentifier
        
        super.init(
            reusableIdentifier:reusableIdentifier,
            cellHeight:kCellHeight)
    }
}
