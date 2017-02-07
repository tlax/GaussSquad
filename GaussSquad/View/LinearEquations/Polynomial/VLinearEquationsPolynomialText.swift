import UIKit

class VLinearEquationsPolynomialText:UITextView
{
    private weak var controller:CLinearEquationsPolynomial!
    private let kFontSize:CGFloat = 70
    private let kInsetsHorizontal:CGFloat = 5
    private let kInsetsTop:CGFloat = 25
    private let kMaxFontSize:CGFloat = 32
    
    init(controller:CLinearEquationsPolynomial)
    {
        super.init(frame:CGRect.zero, textContainer:nil)
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
