import UIKit

class VCalculatorText:UITextView, UITextViewDelegate
{
    private weak var controller:CCalculator!
    private let attributes:[String:AnyObject]
    private let drawingOptions:NSStringDrawingOptions
    private let insetsHorizontal2:CGFloat
    private let kFontSize:CGFloat = 50
    private let kInsetsHorizontal:CGFloat = 5
    private let kMaxInsetsTop:CGFloat = 170
    
    init(controller:CCalculator)
    {
        let font:UIFont = UIFont.numeric(size:kFontSize)
        
        attributes = [
            NSFontAttributeName:font]
        drawingOptions = NSStringDrawingOptions([
            NSStringDrawingOptions.usesLineFragmentOrigin,
            NSStringDrawingOptions.usesFontLeading])
        insetsHorizontal2 = kInsetsHorizontal + kInsetsHorizontal
        
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
        self.font = font
        self.controller = controller
        
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
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let usableWidth:CGFloat = width - insetsHorizontal2
        let usableSize:CGSize = CGSize(width:usableWidth, height:height)
        let attributed:NSAttributedString = NSAttributedString(
            string:text,
            attributes:attributes)
        let boundingRect:CGRect = attributed.boundingRect(
            with:usableSize,
            options:drawingOptions,
            context:nil)
        let textHeight:CGFloat = ceil(boundingRect.size.height)
        var insetsTop:CGFloat = height - textHeight
        
        if insetsTop > kMaxInsetsTop
        {
            insetsTop = kMaxInsetsTop
        }
        else
        {
            insetsTop -= 10
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
