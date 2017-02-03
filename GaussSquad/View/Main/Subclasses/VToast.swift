import UIKit

class VToast:UIView
{
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let drawingOptions:NSStringDrawingOptions
    private let kFontSize:CGFloat = 16
    private let kTextMargin:CGFloat = 20
    private let kBackgroundMargin:CGFloat = -10
    private let kCornerRadius:CGFloat = 15
    private let kMaxHeight:CGFloat = 1000
    
    init(
        message:String,
        color:UIColor,
        textColor:UIColor = UIColor.white)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesFontLeading,
            NSStringDrawingOptions.usesLineFragmentOrigin])
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let attributes:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kFontSize)]
        let string:NSAttributedString = NSAttributedString(
            string:message,
            attributes:attributes)
        
        let background:UIView = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = color
        background.isUserInteractionEnabled = false
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.attributedText = string
        self.label = label
        
        addSubview(background)
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kTextMargin)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kTextMargin)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:label,
            margin:kBackgroundMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let labelWidth:CGFloat = label.bounds.maxX
        let maxSize:CGSize = CGSize(width:labelWidth, height:kMaxHeight)
        
        if let labelSize:CGRect = label.attributedText?.boundingRect(
            with:maxSize,
            options:drawingOptions,
            context:nil)
        {
            let labelHeight:CGFloat = ceil(labelSize.size.height)
            layoutLabelHeight.constant = labelHeight
        }
        
        super.layoutSubviews()
    }
}
