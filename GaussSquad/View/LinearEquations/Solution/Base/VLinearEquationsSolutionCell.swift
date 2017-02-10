import UIKit

class VLinearEquationsSolutionCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(
        model:MLinearEquationsSolutionEquationItem,
        index:IndexPath)
    {
    }
}
