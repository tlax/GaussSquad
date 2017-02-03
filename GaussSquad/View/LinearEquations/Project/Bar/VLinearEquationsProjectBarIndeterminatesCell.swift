import UIKit

class VLinearEquationsProjectBarIndeterminatesCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    
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
        imageView.image = #imageLiteral(resourceName: "assetGenericIndeterminate").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:13)
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
        let color:UIColor
        
        if isSelected || isHighlighted
        {
            color = UIColor.squadRed
        }
        else
        {
            color = UIColor.squadGreen
        }
        
        imageView.tintColor = color
        label.textColor = color
    }
    
    //MARK: public
    
    func config(indeterminate:DIndeterminate)
    {
        hover()
        label.text = indeterminate.symbol
    }
}
