import UIKit

class VHelpCellShort:VHelpCell
{
    private weak var label:UILabel!
    private let kLabelHeight:CGFloat = 110
    private let kLabelMargin:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:20)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MHelpItem)
    {
        super.config(model:model)
        
        guard
        
            let model:MHelpItemShort = model as? MHelpItemShort
        
        else
        {
            return
        }
        
        label.text = model.title
    }
}
