import UIKit

class VCalculatorText:UITextView, UITextViewDelegate
{
    private weak var controller:CCalculator!
    private let drawingOptions:NSStringDrawingOptions
    private let insetsHorizontal3:CGFloat
    private let kFontSize:CGFloat = 50
    private let kInsetsHorizontal:CGFloat = 5
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CCalculator)
    {
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        insetsHorizontal3 = kInsetsHorizontal + kInsetsHorizontal + kInsetsHorizontal
        
        super.init(frame:CGRect.zero, textContainer:nil)
        delegate = self
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.clear
        bounces = false
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.none
        keyboardType = UIKeyboardType.numbersAndPunctuation
        contentInset = UIEdgeInsets.zero
        textAlignment = NSTextAlignment.right
        font = UIFont.numeric(size:kFontSize)
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        restart()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        updateInsets()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func restart()
    {
        text = NSLocalizedString("VCalculatorText_initial", comment:"")
        updateInsets()
    }
    
    private func updateInsets()
    {
        let width:CGFloat = contentSize.width
        let height:CGFloat = contentSize.height
        let usableWidth:CGFloat = width - insetsHorizontal3
        let usableHeight:CGFloat = height - kInsetsHorizontal
        let usableSize:CGSize = CGSize(width:usableWidth, height:usableHeight)
        let boundingRect:CGRect = attributedText.boundingRect(
            with:usableSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(boundingRect.maxY)
        var insetsTop:CGFloat = usableHeight - textHeight
        
        if insetsTop < 0
        {
            insetsTop = 0
        }
        
        textContainerInset = UIEdgeInsets(
            top:insetsTop,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
    }
    
    //MARK: textView delegate
    
    func textViewDidChange(_ textView:UITextView)
    {
        updateInsets()
    }
}
