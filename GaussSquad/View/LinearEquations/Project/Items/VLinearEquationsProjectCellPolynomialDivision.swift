import UIKit

class VLinearEquationsProjectCellPolynomialDivision:VLinearEquationsProjectCell
{
    private weak var labelDividend:UILabel!
    private weak var labelDivisor:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelLeft:CGFloat = 5
    private let kLabelRight:CGFloat = -5
    private let kLabelHeight:CGFloat = 23
    private let kLabelMarginVertical:CGFloat = 2
    private let kImageWidth:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelDividend:UILabel = UILabel()
        labelDividend.isUserInteractionEnabled = false
        labelDividend.translatesAutoresizingMaskIntoConstraints = false
        labelDividend.backgroundColor = UIColor.clear
        labelDividend.textAlignment = NSTextAlignment.center
        labelDividend.textColor = UIColor.black
        self.labelDividend = labelDividend
        
        let labelDivisor:UILabel = UILabel()
        labelDivisor.isUserInteractionEnabled = false
        labelDivisor.translatesAutoresizingMaskIntoConstraints = false
        labelDivisor.backgroundColor = UIColor.clear
        labelDivisor.textAlignment = NSTextAlignment.center
        labelDivisor.textColor = UIColor.black
        self.labelDivisor = labelDivisor
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        let border:VBorder = VBorder(color:UIColor.black)
        
        addSubview(labelDividend)
        addSubview(labelDivisor)
        addSubview(border)
        addSubview(imageView)
        
        NSLayoutConstraint.topToTop(
            view:labelDividend,
            toView:self,
            constant:kLabelMarginVertical)
        NSLayoutConstraint.height(
            view:labelDividend,
            constant:kLabelHeight)
        NSLayoutConstraint.leftToRight(
            view:labelDividend,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:labelDividend,
            toView:self,
            constant:kLabelRight)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:labelDividend)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.leftToRight(
            view:border,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:border,
            toView:self,
            constant:kLabelRight)
        
        NSLayoutConstraint.topToBottom(
            view:labelDivisor,
            toView:border)
        NSLayoutConstraint.height(
            view:labelDivisor,
            constant:kLabelHeight)
        NSLayoutConstraint.leftToRight(
            view:labelDivisor,
            toView:imageView,
            constant:kLabelLeft)
        NSLayoutConstraint.rightToRight(
            view:labelDivisor,
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
            
            let model:MLinearEquationsProjectRowItemPolynomialDivision = model as? MLinearEquationsProjectRowItemPolynomialDivision
            
        else
        {
            return
        }
        
        labelDividend.attributedText = model.attributedDividend
        labelDivisor.attributedText = model.attributedDivisor
        
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
