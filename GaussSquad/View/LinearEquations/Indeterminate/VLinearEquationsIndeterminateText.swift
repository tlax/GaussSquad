import UIKit

class VlinearEquationsIndeterminateText:UITextField, UITextFieldDelegate
{
    private weak var controller:CLinearEquationsIndeterminate!
    private let kFontSize:CGFloat = 70
    
    init(controller:CLinearEquationsIndeterminate)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.none
        keyboardType = UIKeyboardType.alphabet
        borderStyle = UITextBorderStyle.none
        clearButtonMode = UITextFieldViewMode.never
        font = UIFont.numeric(size:kFontSize)
        delegate = self
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: textField delegate
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
