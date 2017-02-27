import UIKit

class VHelpCell:UICollectionViewCell
{
    weak var imageView:UIImageView!
    private let kImageTop:CGFloat = 100
    private let kImageHeight:CGFloat = 160
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MHelpItem)
    {
        imageView.image = model.image
    }
}
