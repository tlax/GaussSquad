import UIKit

class VLinearEquationsIndeterminateListCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.numeric(size:24)
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
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
            backgroundColor = UIColor.squadBlue
            label.textColor = UIColor.white
        }
        else
        {
            backgroundColor = UIColor.clear
            label.textColor = UIColor.black
        }
    }
    
    //MARK: public
    
    func config(model:MLinearEquationsIndeterminatesItem)
    {
        hover()
        label.text = model.symbol
    }
}
