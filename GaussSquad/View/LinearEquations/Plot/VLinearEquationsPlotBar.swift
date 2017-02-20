import UIKit

class VLinearEquationsPlotBar:UIView
{
    private weak var controller:CLinearEquationsPlot!
    private weak var viewZoom:VLinearEquationsPlotBarZoom!
    private let kBorderHeight:CGFloat = 1
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 50
    private let kZoomWidth:CGFloat = 120
    
    init(controller:CLinearEquationsPlot)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.light()
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.2))
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
        
        let viewZoom:VLinearEquationsPlotBarZoom = VLinearEquationsPlotBarZoom(
            controller:controller)
        self.viewZoom = viewZoom
        
        addSubview(blur)
        addSubview(border)
        addSubview(buttonBack)
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
        NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:self)
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
