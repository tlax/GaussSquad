import UIKit

class VLinearEquationsProjectCellPolynomialDecimal:VLinearEquationsProjectCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    
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
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
        NSLayoutConstraint.equals(
            view:imageView,
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
            
            let model:MLinearEquationsProjectRowItemPolynomialDecimal = model as? MLinearEquationsProjectRowItemPolynomialDecimal
            
        else
        {
            return
        }
        
        label.attributedText = model.attributedString
    }
}
