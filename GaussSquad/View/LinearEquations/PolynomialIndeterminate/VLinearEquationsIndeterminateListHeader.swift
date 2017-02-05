import UIKit

class VLinearEquationsIndeterminateListHeader:UICollectionReusableView
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate?
    
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
    
    func config(controller:CLinearEquationsPolynomialIndeterminate)
    {
        self.controller = controller
    }
}
