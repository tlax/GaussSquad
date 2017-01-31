import UIKit

class VLinearEquationsProjectCellIndeterminateSymbol:VLinearEquationsProjectCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
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
    
    override func config(model:MLinearEquationsProjectRowItem)
    {
        super.config(model:model)
        
        guard
        
            let model:MLinearEquationsProjectRowItemIndeterminateSymbol = model as? MLinearEquationsProjectRowItemIndeterminateSymbol
        
        else
        {
            return
        }
        
        label.attributedText = model.attributedString
    }
}
