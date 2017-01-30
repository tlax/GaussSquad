import UIKit

class VLinearEquationsCell:UICollectionViewCell
{
    private weak var model:MLinearEquationsItem?
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.blue
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MLinearEquationsItem)
    {
        self.model = model
        hover()
    }
}
