import UIKit

class VCalculatorBar:UIView
{
    private weak var controller:CCalculator!
    private let kButtonWidth:CGFloat = 50
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CCalculator)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonBack.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonOptions:UIButton = UIButton()
        buttonOptions.translatesAutoresizingMaskIntoConstraints = false
        buttonOptions.setImage(
            #imageLiteral(resourceName: "assetGenericOptions").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonOptions.setImage(
            #imageLiteral(resourceName: "assetGenericOptions").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonOptions.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonOptions.imageView!.clipsToBounds = true
        buttonOptions.imageView!.contentMode = UIViewContentMode.center
        buttonOptions.addTarget(
            self,
            action:#selector(actionOptions(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonClear:UIButton = UIButton()
        buttonClear.translatesAutoresizingMaskIntoConstraints = false
        buttonClear.setImage(
            #imageLiteral(resourceName: "assetGenericClear").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonClear.setImage(
            #imageLiteral(resourceName: "assetGenericClear").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonClear.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonClear.imageView!.clipsToBounds = true
        buttonClear.imageView!.contentMode = UIViewContentMode.center
        buttonClear.addTarget(
            self,
            action:#selector(actionClear(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(buttonBack)
        addSubview(buttonOptions)
        addSubview(buttonClear)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonOptions,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:buttonOptions,
            toView:buttonBack)
        NSLayoutConstraint.width(
            view:buttonOptions,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonClear,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonClear,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonClear,
            constant:kButtonWidth)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
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
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionOptions(sender button:UIButton)
    {
        
    }
    
    func actionClear(sender button:UIButton)
    {
        
    }
}
