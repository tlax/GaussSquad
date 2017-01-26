import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonHome:VParentBarButton!
    private weak var layoutHomeLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kButtonsTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 70
    
    init(controller:CParent)
    {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let buttonHome:VParentBarButton = VParentBarButton(
            image:#imageLiteral(resourceName: "assetGenericHome"))
        buttonHome.isSelected = true
        self.buttonHome = buttonHome
        
        addSubview(border)
        addSubview(buttonHome)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonHome,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonHome,
            toView:self)
        layoutHomeLeft = NSLayoutConstraint.leftToLeft(
            view:buttonHome,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonHome,
            constant:kButtonsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainHome:CGFloat = width - kButtonsWidth
        let marginHome:CGFloat = remainHome / 2.0
        layoutHomeLeft.constant = marginHome
        
        super.layoutSubviews()
    }
}
