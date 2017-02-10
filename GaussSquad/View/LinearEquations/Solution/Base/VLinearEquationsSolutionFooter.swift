import UIKit

class VLinearEquationsSolutionFooter:UICollectionReusableView
{
    private let kMarginTop:CGFloat = 5
    private let kMarginBottom:CGFloat = -30
    private let kMarginLeft:CGFloat = 10
    private let kButtonWidth:CGFloat = 50
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetGenericShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.addTarget(
            self,
            action:#selector(actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonShare)
        
        NSLayoutConstraint.topToTop(
            view:buttonShare,
            toView:self,
            constant:kMarginTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonShare,
            toView:self,
            constant:kMarginBottom)
        NSLayoutConstraint.leftToLeft(
            view:buttonShare,
            toView:self,
            constant:kMarginLeft)
        NSLayoutConstraint.width(
            view:buttonShare,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        print("share")
    }
}
