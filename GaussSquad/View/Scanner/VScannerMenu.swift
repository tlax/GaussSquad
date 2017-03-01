import UIKit

class VScannerMenu:UIView
{
    private weak var controller:CScanner!
    private weak var layoutShootLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kButtonsWidth:CGFloat = 50
    
    init(controller:CScanner)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.dark()
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.2))
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBackWhite").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonShoot:UIButton = UIButton()
        buttonShoot.translatesAutoresizingMaskIntoConstraints = false
        buttonShoot.setImage(
            #imageLiteral(resourceName: "assetGenericShoot").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShoot.setImage(
            #imageLiteral(resourceName: "assetGenericShoot").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShoot.imageView!.contentMode = UIViewContentMode.center
        buttonShoot.imageView!.clipsToBounds = true
        buttonShoot.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        
        addSubview(blur)
        addSubview(border)
        addSubview(buttonBack)
        addSubview(buttonShoot)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonShoot,
            toView:self)
        layoutShootLeft = NSLayoutConstraint.leftToLeft(
            view:buttonShoot,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonShoot,
            constant:kButtonsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainWidth:CGFloat = width - kButtonsWidth
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutShootLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: public
    
    func activateButtons()
    {
        
    }
}
