import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonHome:VParentBarButton!
    private weak var buttonStore:VParentBarButton!
    private weak var layoutHomeLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kButtonsTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 60
    
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
        buttonHome.addTarget(
            self,
            action:#selector(actionHome(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonHome = buttonHome
        
        let buttonStore:VParentBarButton = VParentBarButton(
            image:#imageLiteral(resourceName: "assetGenericStore"))
        self.buttonStore = buttonStore
        
        addSubview(border)
        addSubview(buttonStore)
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
        
        NSLayoutConstraint.topToTop(
            view:buttonStore,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonStore,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonStore,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonStore,
            constant:kButtonsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainHome:CGFloat = width - kButtonsWidth
        let marginHome:CGFloat = remainHome / 2.0
        layoutHomeLeft.constant = marginHome
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionHome(sender button:UIButton)
    {
        
    }
    
    func actionStore(sender button:UIButton)
    {
        
    }
}
