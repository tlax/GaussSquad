import UIKit

class VLinearEquationsSolutionHeader:UICollectionReusableView
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
        clipsToBounds = true
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
