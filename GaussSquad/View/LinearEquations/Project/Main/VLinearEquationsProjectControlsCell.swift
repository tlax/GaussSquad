import UIKit

class VLinearEquationsProjectControlsCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    //MARK: public
    
    func config(model:MLinearEquationsProjectControlsItem)
    {
        imageView.image = model.image
    }
}
