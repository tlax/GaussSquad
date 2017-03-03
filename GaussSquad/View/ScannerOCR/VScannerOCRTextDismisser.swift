import UIKit

class VScannerOCRTextDismisser:UIView
{
    private let size:CGSize
    private let kHeight:CGFloat = 40
    private let kMargin:CGFloat = 5
    private let kCornerRadius:CGFloat = 6
    private let kButtonWidth:CGFloat = 100
    
    init()
    {
        size = CGSize(width:UIViewNoIntrinsicMetric, height:kHeight)
        
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonDismiss:UIButton = UIButton()
        buttonDismiss.translatesAutoresizingMaskIntoConstraints = false
        buttonDismiss.backgroundColor = UIColor.squadBlue
        buttonDismiss.clipsToBounds = true
        buttonDismiss.layer.cornerRadius = kCornerRadius
        buttonDismiss.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDismiss.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonDismiss.setTitle(
            NSLocalizedString("VScannerOCRTextDismisser_buttonDismiss", comment:""),
            for:UIControlState.normal)
        buttonDismiss.titleLabel!.font = UIFont.bolder(size:14)
        buttonDismiss.addTarget(
            self,
            action:#selector(actionDismiss(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonDismiss)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonDismiss,
            toView:self,
            margin:kMargin)
        NSLayoutConstraint.rightToRight(
            view:buttonDismiss,
            toView:self,
            constant:-kMargin)
        NSLayoutConstraint.width(
            view:buttonDismiss,
            constant:kButtonWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var intrinsicContentSize:CGSize
    {
        get
        {
            return size
        }
    }
    
    //MARK: actions
    
    func actionDismiss(sender button:UIButton)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
