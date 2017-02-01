import UIKit

class VLinearEquationsProjectCellIndex:VLinearEquationsProjectCell
{
    private weak var label:UILabel!
    private let kIndexDelta:Int = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.image = #imageLiteral(resourceName: "assetGenericColIndex")
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:12)
        label.textColor = UIColor.squadBlue
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
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
            
            let model:MLinearEquationsProjectRowItemIndex = model as? MLinearEquationsProjectRowItemIndex
            
        else
        {
            return
        }
        
        let index:Int = model.index + kIndexDelta
        let indexString:String = "\(index)"
        label.text = indexString
    }
}