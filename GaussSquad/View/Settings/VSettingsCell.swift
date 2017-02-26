import UIKit

class VSettingsCell:UICollectionViewCell
{
    weak var controller:CSettings?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(controller:CSettings, model:MSettingsItem)
    {
        self.controller = controller
    }
}
