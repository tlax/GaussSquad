import UIKit

class VLinearEquationsProjectCellOperator:VLinearEquationsProjectCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(imageView)
        
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
        
            let model:MLinearEquationsProjectRowItemOperator = model as? MLinearEquationsProjectRowItemOperator
        
        else
        {
            return
        }
        
        imageView.image = model.image
    }
}
