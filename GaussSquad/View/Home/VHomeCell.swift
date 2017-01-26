import UIKit

class VHomeCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelSymbol:UILabel!
    private weak var labelTitle:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
