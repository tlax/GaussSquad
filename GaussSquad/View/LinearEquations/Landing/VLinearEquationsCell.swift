import UIKit

class VLinearEquationsCell:UICollectionViewCell
{
    private weak var model:DProject?
    
    //MARK: public
    
    func config(model:DProject)
    {
        self.model = model
    }
}
