import UIKit

class VLinearEquationsSolutionCellPolynomialDivision:VLinearEquationsSolutionCell
{
    private weak var labelDividend:UILabel!
    private weak var labelDivisor:UILabel!
    private weak var imageView:UIImageView!
    private weak var layoutImageWidth:NSLayoutConstraint!
    private weak var layoutBorderTop:NSLayoutConstraint!
    private let kImageWidth:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    private let kLabelHeight:CGFloat = 16
    
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
        
        addSubview(border)
        addSubview(labelDividend)
        addSubview(labelDivisor)
        addSubview(imageView)
        
        layoutBorderTop = NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.leftToRight(
            view:border,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        layoutImageWidth = NSLayoutConstraint.width(
            view:imageView)
        
        NSLayoutConstraint.bottomToTop(
            view:labelDividend,
            toView:border)
        NSLayoutConstraint.height(
            view:labelDividend,
            constant:kLabelHeight)
        NSLayoutConstraint.leftToRight(
            view:labelDividend,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:labelDividend,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelDivisor,
            toView:border)
        NSLayoutConstraint.height(
            view:labelDivisor,
            constant:kLabelHeight)
        NSLayoutConstraint.leftToRight(
            view:labelDivisor,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:labelDividend,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = height - kBorderHeight
        let marginTop:CGFloat = remain / 2.0
        layoutBorderTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    override func config(
        model:MLinearEquationsSolutionEquationItem,
        index:IndexPath)
    {
        guard
            
            let model:MLinearEquationsSolutionEquationItemPolynomialDivision = model as? MLinearEquationsSolutionEquationItemPolynomialDivision
            
        else
        {
            return
        }
        
        labelDividend.attributedText = model.stringDividend
        labelDivisor.attributedText = model.stringDivisor
        
        if model.showSign
        {
            layoutImageWidth.constant = kImageWidth
            
            if model.coefficientDividend >= 0
            {
                imageView.image = #imageLiteral(resourceName: "assetGenericColAddSmall")
            }
            else
            {
                imageView.image = #imageLiteral(resourceName: "assetGenericColSubstractSmall")
            }
        }
        else
        {
            layoutImageWidth.constant = 0
            imageView.image = nil
        }
    }
}
