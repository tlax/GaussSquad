import UIKit

class VLinearEquationsSolutionCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.red
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
