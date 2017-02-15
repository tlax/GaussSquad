import UIKit

class VLinearEquationsSolutionCellPolynomialDivision:VLinearEquationsSolutionCell
{
    private weak var labelDividend:UILabel!
    private weak var labelDivisor:UILabel!
    private weak var imageView:UIImageView!
    private weak var layoutImageWidth:NSLayoutConstraint!
    private weak var layoutBorderTop:NSLayoutConstraint!
    private weak var layoutBorderHeight:NSLayoutConstraint!
    private weak var layoutDividendHeight:NSLayoutConstraint!
    private weak var layoutDivisorHeight:NSLayoutConstraint!
    
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
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.3))
        
        addSubview(border)
        addSubview(labelDividend)
        addSubview(labelDivisor)
        addSubview(imageView)
        
        layoutBorderTop = NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        layoutBorderHeight = NSLayoutConstraint.height(
            view:border)
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
        
        NSLayoutConstraint.bottomToBottom(
            view:labelDividend,
            toView:border)
        layoutDividendHeight = NSLayoutConstraint.height(
            view:labelDividend)
        NSLayoutConstraint.leftToRight(
            view:labelDividend,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:labelDividend,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelDivisor,
            toView:border)
        layoutDivisorHeight = NSLayoutConstraint.height(
            view:labelDivisor)
        NSLayoutConstraint.leftToRight(
            view:labelDivisor,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:labelDivisor,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY - 1
        let marginTop:CGFloat = height / 2.0
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
        imageView.image = model.imageSign
        layoutImageWidth.constant = model.signWidth
        layoutBorderHeight.constant = model.kBorderHeight
        layoutDividendHeight.constant = model.kLabelHeight
        layoutDivisorHeight.constant = model.kLabelHeight
    }
}
