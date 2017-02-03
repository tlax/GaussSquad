import UIKit

class VLinearEquationsProjectBarIndeterminatesCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelBottom:CGFloat = -3
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericIndeterminate")
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:16)
        self.label = label
        
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self,
            constant:kLabelBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
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
            label.textColor = UIColor.white
        }
        else
        {
            label.textColor = UIColor.black
        }
    }
    
    //MARK: public
    
    func config(indeterminate:DIndeterminate)
    {
        hover()
        label.text = indeterminate.symbol
    }
}
