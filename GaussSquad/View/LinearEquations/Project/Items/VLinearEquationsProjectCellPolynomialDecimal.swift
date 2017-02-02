import UIKit

class VLinearEquationsProjectCellPolynomialDecimal:VLinearEquationsProjectCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelLeft:CGFloat = 5
    private let kLabelRight:CGFloat = -5
    private let kImageWidth:CGFloat = 20
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.right
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
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelRight)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(
        model:MLinearEquationsProjectRowItem,
        indexPath:IndexPath)
    {
        super.config(
            model:model,
            indexPath:indexPath)
        
        guard
            
            let model:MLinearEquationsProjectRowItemPolynomialDecimal = model as? MLinearEquationsProjectRowItemPolynomialDecimal
            
        else
        {
            return
        }
        
        label.attributedText = model.attributedString
        
        if model.positive
        {
            imageView.image = #imageLiteral(resourceName: "assetGenericColAdd")
        }
        else
        {
            imageView.image = #imageLiteral(resourceName: "assetGenericColSubstract")
        }
    }
}
