import UIKit

class VLinearEquationsBar:UIView
{
    private weak var controller:CLinearEquations!
    private weak var labelDescr:UILabel!
    private weak var layoutImageGaussLeft:NSLayoutConstraint!
    private weak var layoutLabelDescrHeight:NSLayoutConstraint!
    private weak var layoutButtonAddLeft:NSLayoutConstraint!
    private let drawingOptions:NSStringDrawingOptions
    private let gaussWidth:CGFloat
    private let labelDescrMargin2:CGFloat
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kBackHeight:CGFloat = 44
    private let kImageGaussMargin:CGFloat = 20
    private let kImageGaussSize:CGFloat = 100
    private let kLabelGaussWidth:CGFloat = 140
    private let kLabelDescrMargin:CGFloat = 10
    private let kMaxLabelDescrHeight:CGFloat = 500
    private let kButtonAddTop:CGFloat = 30
    private let kButtonAddSize:CGFloat = 50
    
    init(controller:CLinearEquations)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        gaussWidth = kImageGaussSize + kLabelGaussWidth
        labelDescrMargin2 = kLabelDescrMargin + kLabelDescrMargin
        
        super.init(frame:CGRect.zero)
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
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetGenericAdd"),
            for:UIControlState.normal)
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetGenericAddSelected"),
            for:UIControlState.highlighted)
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        
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
        
        addSubview(labelTitle)
        addSubview(labelGauss)
        addSubview(labelDescr)
        addSubview(imageGauss)
        addSubview(buttonBack)
        addSubview(buttonAdd)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kBackHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kBackHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:imageGauss,
            toView:buttonBack,
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
            view:buttonAdd,
            toView:labelDescr,
            constant:kButtonAddTop)
        NSLayoutConstraint.size(
            view:buttonAdd,
            constant:kButtonAddSize)
        layoutButtonAddLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
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
        let buttonAddRemain:CGFloat = width - kButtonAddSize
        let buttonAddMargin:CGFloat = buttonAddRemain / 2.0
        
        layoutImageGaussLeft.constant = gaussMargin
        layoutLabelDescrHeight.constant = descrHeight
        layoutButtonAddLeft.constant = buttonAddMargin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionAdd(sender button:UIButton)
    {
        isUserInteractionEnabled = false
        controller.add()
    }
}
