import UIKit

class VScannerOCRText:UITextView
{
    private weak var controller:CScannerOCR!
    private let kFontSize:CGFloat = 30
    private let kInsetsTop:CGFloat = 30
    private let kInsetsHorizontal:CGFloat = 5
    
    init(controller:CScannerOCR)
    {
        super.init(frame:CGRect.zero, textContainer:nil)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        bounces = true
        isScrollEnabled = true
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = true
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.none
        keyboardType = UIKeyboardType.numbersAndPunctuation
        contentInset = UIEdgeInsets.zero
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
