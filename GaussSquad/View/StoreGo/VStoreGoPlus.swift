import UIKit

class VStoreGoPlus:VView
{
    private weak var controller:CStoreGoPlus!
    private weak var layoutBaseViewLeft:NSLayoutConstraint!
    private weak var layoutBaseViewTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 299
    private let kBaseHeight:CGFloat = 180
    private let kButtonHeight:CGFloat = 54
    private let kCornerRadius:CGFloat = 20
    private let kLabelTitleHeight:CGFloat = 25
    private let kLabelDescrHeight:CGFloat = 20
    private let kImageTop:CGFloat = -55
    private let kImageHeight:CGFloat = 110
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CStoreGoPlus
        
        let blur:VBlur = VBlur.dark()
        
        let baseButton:UIButton = UIButton()
        baseButton.clipsToBounds = true
        baseButton.backgroundColor = UIColor.clear
        baseButton.translatesAutoresizingMaskIntoConstraints = false
        baseButton.addTarget(
            self,
            action:#selector(self.actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.cornerRadius = kCornerRadius
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = NSLocalizedString("VStoreGoPlus_title", comment:"")
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.font = UIFont.regular(size:15)
        labelDescr.textColor = UIColor.black
        labelDescr.textAlignment = NSTextAlignment.center
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.numberOfLines = 0
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.text = NSLocalizedString("VStoreGoPlus_descr", comment:"")
        
        let buttons:VStoreGoPlusButtons = VStoreGoPlusButtons(
            controller:self.controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericGoPlus")
        
        baseView.addSubview(labelTitle)
        baseView.addSubview(labelDescr)
        baseView.addSubview(buttons)
        addSubview(blur)
        addSubview(baseButton)
        addSubview(baseView)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:baseButton,
            toView:self)
        
        layoutBaseViewTop = NSLayoutConstraint.topToTop(
            view:baseView,
            toView:self)
        layoutBaseViewLeft = NSLayoutConstraint.leftToLeft(
            view:baseView,
            toView:self)
        NSLayoutConstraint.width(
            view:baseView,
            constant:kBaseWidth)
        NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        
        NSLayoutConstraint.topToBottom(
            view:labelTitle,
            toView:imageView)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kLabelTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:baseView)
        
        NSLayoutConstraint.topToBottom(
            view:labelDescr,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:labelDescr,
            constant:kLabelDescrHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelDescr,
            toView:baseView)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:baseView,
            constant:kImageTop)
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:baseView)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttons,
            toView:baseView)
        NSLayoutConstraint.height(
            view:buttons,
            constant:kButtonHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:buttons,
            toView:baseView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainLeft:CGFloat = width - kBaseWidth
        let remainTop:CGFloat = height - kBaseHeight
        let marginLeft:CGFloat = remainLeft / 2.0
        let marginTop:CGFloat = remainTop / 2.0
        layoutBaseViewLeft.constant = marginLeft
        layoutBaseViewTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
