import UIKit

class VHelpCellLong:VHelpCell
{
    private weak var label:UILabel!
    private weak var layoutLabelHeight:NSLayoutConstraint!
    private let drawingOptions:NSStringDrawingOptions
    private let labelMargin2:CGFloat
    private let kLabelMargin:CGFloat = 20
    private let kLabelMaxHeight:CGFloat = 900
    
    override init(frame:CGRect)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        labelMargin2 = kLabelMargin + kLabelMargin
        
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView,
            constant:kLabelMargin)
        layoutLabelHeight = NSLayoutConstraint.height(
            view:label)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        guard
            
            let attributedText:NSAttributedString = label.attributedText
        
        else
        {
            super.layoutSubviews()
            
            return
        }
        
        let width:CGFloat = bounds.maxX
        let usableWidth:CGFloat = width - labelMargin2
        let usableSize:CGSize = CGSize(
            width:usableWidth,
            height:kLabelMaxHeight)
        let textRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(textRect.size.height)
        layoutLabelHeight.constant = textHeight
        
        super.layoutSubviews()
    }
    
    override func config(model:MHelpItem)
    {
        super.config(model:model)
        
        guard
            
            let model:MHelpItemLong = model as? MHelpItemLong
            
        else
        {
            return
        }
        
        label.attributedText = model.title
    }
}
