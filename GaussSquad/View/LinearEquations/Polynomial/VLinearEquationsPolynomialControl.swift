import UIKit

class VLinearEquationsPolynomialControl:UIView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var viewSign:VLinearEquationsPolynomialControlSign!
    private let kButtonDoneWidth:CGFloat = 80
    private let kButtonTrashWidth:CGFloat = 45
    private let kContentMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 6
    private let kSignsWidth:CGFloat = 120
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        
        let viewSign:VLinearEquationsPolynomialControlSign = VLinearEquationsPolynomialControlSign(
            controller:controller)
        viewSign.layer.cornerRadius = kCornerRadius
        self.viewSign = viewSign
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.squadBlue
        buttonDone.setTitle(
            NSLocalizedString("VLinearEquationsPolynomialControl_buttonDone", comment:""),
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonDone.titleLabel!.font = UIFont.bold(size:14)
        buttonDone.layer.cornerRadius = kCornerRadius
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonTrash:UIButton = UIButton()
        buttonTrash.translatesAutoresizingMaskIntoConstraints = false
        buttonTrash.clipsToBounds = true
        buttonTrash.backgroundColor = UIColor.squadRed
        buttonTrash.layer.cornerRadius = kCornerRadius
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetGenericTrashWhite").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetGenericTrashWhite").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonTrash.imageView!.clipsToBounds = true
        buttonTrash.imageView!.contentMode = UIViewContentMode.center
        buttonTrash.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonTrash.addTarget(
            self,
            action:#selector(actionTrash(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(buttonTrash)
        addSubview(buttonDone)
        addSubview(viewSign)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDone,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonDoneWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonDone,
            toView:self,
            constant:-kContentMargin)
        
        NSLayoutConstraint.equalsVertical(
            view:viewSign,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.leftToLeft(
            view:viewSign,
            toView:self,
            constant:kContentMargin)
        NSLayoutConstraint.width(
            view:viewSign,
            constant:kSignsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonTrash,
            toView:self,
            margin:kContentMargin)
        NSLayoutConstraint.width(
            view:buttonTrash,
            constant:kButtonTrashWidth)
        NSLayoutConstraint.rightToLeft(
            view:buttonTrash,
            toView:buttonDone,
            constant:-kContentMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        controller.save()
    }
    
    func actionTrash(sender button:UIButton)
    {
        controller.trash()
    }
}
