import UIKit

class VLinearEquationsPolynomialText:UITextView, UITextViewDelegate
{
    private weak var controller:CLinearEquationsPolynomial!
    private let kMaxHeight:CGFloat = 40
    private let kInsetsHorizontal:CGFloat = 5
    private let kMaxFontSize:CGFloat = 32
    
    convenience init(controller:CLinearEquationsPolynomial)
    {
        self.init()
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
        keyboardType = UIKeyboardType.alphabet
        contentInset = UIEdgeInsets.zero
        text = "asd"
        font = UIFont.medium(size:kMaxHeight)
        textContainerInset = UIEdgeInsets(
            top:0,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        delegate = self
        self.controller = controller
    }
    
    //MARK: textView delegate
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        let currentText:NSString = textView.text as NSString
        let editedText:String = currentText.replacingCharacters(
            in:range,
            with:text)
        
        return true
    }
}
