import UIKit

class VLinearEquationsPlotBar:UIView
{
    private weak var controller:CLinearEquationsPlot!
    private weak var viewZoom:VLinearEquationsPlotBarZoom!
    private let kBorderHeight:CGFloat = 1
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 50
    private let kShareWidth:CGFloat = 50
    private let kZoomWidth:CGFloat = 170
    
    init(controller:CLinearEquationsPlot)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
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
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericSolutionShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericSolutionShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShare.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.addTarget(
            self,
            action:#selector(actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewZoom:VLinearEquationsPlotBarZoom = VLinearEquationsPlotBarZoom(
            controller:controller)
        self.viewZoom = viewZoom
        
        addSubview(blur)
        addSubview(border)
        addSubview(buttonBack)
        addSubview(buttonShare)
        addSubview(viewZoom)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToTop(
            view:buttonBack,
            toView:border)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:viewZoom,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:viewZoom,
            toView:self)
        NSLayoutConstraint.width(
            view:viewZoom,
            constant:kZoomWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonShare,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonShare,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:buttonShare,
            toView:buttonBack)
        NSLayoutConstraint.width(
            view:buttonShare,
            constant:kShareWidth)
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
    
    func actionShare(sender button:UIButton)
    {
        controller.share()
    }
}
