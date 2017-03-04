import UIKit

class VCalculatorText:UITextView, UITextViewDelegate
{
    private weak var controller:CCalculator!
    private let drawingOptions:NSStringDrawingOptions
    private let insetsHorizontal3:CGFloat
    private let kFontSize:CGFloat = 50
    private let kInsetsHorizontal:CGFloat = 5
    
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
    
    override func becomeFirstResponder() -> Bool
    {
        let states:[MKeyboardState]?
        
        if let inputView:VKeyboard = self.inputView as? VKeyboard
        {
            states = inputView.model.states
        }
        else
        {
            states = nil
        }
        
        let textInput:VKeyboard = VKeyboard(textView:self, states:states)
        inputView = textInput
        
        return super.becomeFirstResponder()
    }
    
    //MARK: private
    
    private func updateInsets()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
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
