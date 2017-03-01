import UIKit

class VCalculatorBar:UIView
{
    private weak var controller:CCalculator!
    private let kHelpLeft:CGFloat = 8
    private let kButtonWidth:CGFloat = 50
    
    init(controller:CCalculator)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
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
        buttonOptions.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonOptions.imageView!.clipsToBounds = true
        buttonOptions.imageView!.contentMode = UIViewContentMode.center
        buttonOptions.addTarget(
            self,
            action:#selector(actionOptions(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonUndo:UIButton = UIButton()
        buttonUndo.translatesAutoresizingMaskIntoConstraints = false
        buttonUndo.setImage(
            #imageLiteral(resourceName: "assetGenericUndo").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonUndo.setImage(
            #imageLiteral(resourceName: "assetGenericUndo").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonUndo.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonUndo.imageView!.clipsToBounds = true
        buttonUndo.imageView!.contentMode = UIViewContentMode.center
        buttonUndo.addTarget(
            self,
            action:#selector(actionUndo(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonHelp:UIButton = UIButton()
        buttonHelp.translatesAutoresizingMaskIntoConstraints = false
        buttonHelp.setImage(
            #imageLiteral(resourceName: "assetGenericHelpBlack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonHelp.setImage(
            #imageLiteral(resourceName: "assetGenericHelpBlack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonHelp.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonHelp.imageView!.clipsToBounds = true
        buttonHelp.imageView!.contentMode = UIViewContentMode.center
        buttonHelp.addTarget(
            self,
            action:#selector(actionHelp(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonHelp)
        addSubview(buttonBack)
        addSubview(buttonOptions)
        addSubview(buttonUndo)
        
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
            view:buttonHelp,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:buttonHelp,
            toView:buttonOptions,
            constant:kHelpLeft)
        NSLayoutConstraint.width(
            view:buttonHelp,
            constant:kButtonWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonUndo,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonUndo,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonUndo,
            constant:kButtonWidth)
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
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.showOptions()
    }
    
    func actionUndo(sender button:UIButton)
    {
        controller.undo()
    }
    
    func actionHelp(sender button:UIButton)
    {
        controller.help()
    }
}
