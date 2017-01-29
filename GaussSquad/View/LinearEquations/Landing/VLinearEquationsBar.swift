import UIKit

class VLinearEquationsBar:UIView
{
    private weak var controller:CLinearEquations!
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kBackHeight:CGFloat = 44
    private let kImageGaussSize:CGFloat = 130
    private let kLabelGaussRight:CGFloat = -10
    
    init(controller:CLinearEquations)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let stringGaussName:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsBar_labelGaussName", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.medium(size:15),
                NSForegroundColorAttributeName:UIColor.squadBlue])
        let stringGaussDate:NSAttributedString = NSAttributedString(
            string:NSLocalizedString("VLinearEquationsBar_labelGaussDate", comment:""),
            attributes:[
                NSFontAttributeName:UIFont.regular(size:15),
                NSForegroundColorAttributeName:UIColor.black])
        let stringGauss:NSMutableAttributedString = NSMutableAttributedString()
        stringGauss.append(stringGaussName)
        stringGauss.append(stringGaussDate)
        
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
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:16)
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
        
        addSubview(labelTitle)
        addSubview(labelGauss)
        addSubview(imageGauss)
        addSubview(buttonBack)
        
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
            toView:buttonBack)
        NSLayoutConstraint.size(
            view:imageGauss,
            constant:kImageGaussSize)
        NSLayoutConstraint.leftToLeft(
            view:imageGauss,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:labelGauss,
            toView:imageGauss)
        NSLayoutConstraint.leftToRight(
            view:labelGauss,
            toView:imageGauss)
        NSLayoutConstraint.rightToRight(
            view:labelGauss,
            toView:self,
            constant:kLabelGaussRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
