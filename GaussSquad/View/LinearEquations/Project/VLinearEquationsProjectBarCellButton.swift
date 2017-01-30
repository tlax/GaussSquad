import UIKit

class VLinearEquationsBarCellButton:VLinearEquationsBarCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
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
    
    override func config(model:MLinearEquationsProjectBarItem)
    {
        super.config(model:model)
        
        guard
        
            let model:MLinearEquationsProjectBarItemButton = model as? MLinearEquationsProjectBarItemButton
        
        else
        {
            return
        }
        
        imageView.image = model.image
    }
}
