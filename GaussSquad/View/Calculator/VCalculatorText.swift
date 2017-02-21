import UIKit

class VCalculatorText:UITextView, UITextViewDelegate
{
    private weak var controller:CCalculator!
    private let kFontSize:CGFloat = 60
    private let kInsetsHorizontal:CGFloat = 5
    private let kInsetsTop:CGFloat = 10
    
    init(controller:CCalculator)
    {
        super.init(frame:CGRect.zero, textContainer:nil)
        delegate = self
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
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
        textContainerInset = UIEdgeInsets(
            top:kInsetsTop,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
