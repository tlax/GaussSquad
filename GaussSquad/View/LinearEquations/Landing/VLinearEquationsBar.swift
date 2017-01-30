import UIKit

class VLinearEquationsBar:UIView
{
    weak var border:VBorder!
    private weak var controller:CLinearEquations!
    private weak var labelDescr:UILabel!
    private weak var layoutImageGaussLeft:NSLayoutConstraint!
    private weak var layoutLabelDescrHeight:NSLayoutConstraint!
    private let drawingOptions:NSStringDrawingOptions
    private let gaussWidth:CGFloat
    private let labelDescrMargin2:CGFloat
    private let kContentTop:CGFloat = 20
    private let kImageGaussMargin:CGFloat = 20
    private let kImageGaussSize:CGFloat = 100
    private let kLabelGaussWidth:CGFloat = 140
    private let kLabelDescrMargin:CGFloat = 10
    private let kMaxLabelDescrHeight:CGFloat = 500
    private let kBorderHeight:CGFloat = 1
    private let kBorderTop:CGFloat = 90
    private let kTitleHeight:CGFloat = 44
    
    init(controller:CLinearEquations)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        gaussWidth = kImageGaussSize + kLabelGaussWidth
        labelDescrMargin2 = kLabelDescrMargin + kLabelDescrMargin
        
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let stringGaussName:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsBar_labelGaussName", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.bold(size:14),
                NSForegroundColorAttributeName:UIColor.squadBlue])
        let stringGaussDate:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsBar_labelGaussDate", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.regular(size:11),
                NSForegroundColorAttributeName:UIColor.black])
        let stringGauss:NSMutableAttributedString = NSMutableAttributedString()
        stringGauss.append(stringGaussName)
        stringGauss.append(stringGaussDate)
        
        let stringDescr:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsBar_labelDescr", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.regular(size:15)])
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:17)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsBar_labelTitle", comment:"")
        
        let imageGauss:UIImageView = UIImageView()
        imageGauss.isUserInteractionEnabled = false
        imageGauss.translatesAutoresizingMaskIntoConstraints = false
        imageGauss.clipsToBounds = true
        imageGauss.contentMode = UIViewContentMode.center
        imageGauss.image = #imageLiteral(resourceName: "assetGenericGauss")
        
        let labelGauss:UILabel = UILabel()
        labelGauss.isUserInteractionEnabled = false
        labelGauss.translatesAutoresizingMaskIntoConstraints = false
        labelGauss.backgroundColor = UIColor.clear
        labelGauss.numberOfLines = 0
        labelGauss.attributedText = stringGauss
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.numberOfLines = 0
        labelDescr.textColor = UIColor.black
        labelDescr.attributedText = stringDescr
        self.labelDescr = labelDescr
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        self.border = border
        
        addSubview(labelTitle)
        addSubview(labelGauss)
        addSubview(labelDescr)
        addSubview(imageGauss)
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:imageGauss,
            toView:labelTitle,
            constant:kImageGaussMargin)
        NSLayoutConstraint.size(
            view:imageGauss,
            constant:kImageGaussSize)
        layoutImageGaussLeft = NSLayoutConstraint.leftToLeft(
            view:imageGauss,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:labelGauss,
            toView:imageGauss)
        NSLayoutConstraint.leftToRight(
            view:labelGauss,
            toView:imageGauss)
        NSLayoutConstraint.width(
            view:labelGauss,
            constant:kLabelGaussWidth)
        
        NSLayoutConstraint.topToBottom(
            view:labelDescr,
            toView:imageGauss,
            constant:kImageGaussMargin)
        layoutLabelDescrHeight = NSLayoutConstraint.height(
            view:labelDescr)
        NSLayoutConstraint.equalsHorizontal(
            view:labelDescr,
            toView:self,
            margin:kLabelDescrMargin)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:labelDescr,
            constant:kBorderTop)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        guard
            
            let descrString:NSAttributedString = labelDescr.attributedText
        
        else
        {
            return
        }
        
        let width:CGFloat = bounds.maxX
        let gaussRemain:CGFloat = width - gaussWidth
        let gaussMargin:CGFloat = gaussRemain / 2.0
        let labelDescrRemain:CGFloat = width - labelDescrMargin2
        let labelDescrMaxSize:CGSize = CGSize(
            width:labelDescrRemain,
            height:kMaxLabelDescrHeight)
        let descrSize:CGRect = descrString.boundingRect(
            with:labelDescrMaxSize,
            options:drawingOptions,
            context:nil)
        let descrHeight:CGFloat = ceil(descrSize.size.height)
        
        layoutImageGaussLeft.constant = gaussMargin
        layoutLabelDescrHeight.constant = descrHeight
        
        super.layoutSubviews()
    }
}
