import UIKit

class VCalculatorHistoryCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private let kLabelMargin:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.numeric(size:12)
        label.textColor = UIColor(white:0, alpha:0.6)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MCalculatorStepsItem)
    {
        
    }
}
