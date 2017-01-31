import UIKit

class VLinearEquationsProjectCellIndex:VLinearEquationsProjectCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        imageView.image = #imageLiteral(resourceName: "assetGenericColIndex")
        
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
            
            let model:MLinearEquationsProjectRowItemIndex = model as? MLinearEquationsProjectRowItemIndex
            
        else
        {
            return
        }
        
        
    }
}
