import UIKit

class VCalculatorOptionsCell:UICollectionViewCell
{
    private weak var labelTitle:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.bold(size:15)
        labelTitle.textAlignment = NSTextAlignment.center
        self.labelTitle = labelTitle
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.equals(
            view:labelTitle,
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
            labelTitle.textColor = UIColor.white
        }
        else
        {
            backgroundColor = UIColor.white
            labelTitle.textColor = UIColor.black
        }
    }
    
    //MARK: public
    
    func config(model:MCalculatorFunctions)
    {
        labelTitle.text = model.title
        hover()
    }
}
