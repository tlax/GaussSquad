import UIKit

class VLinearEquationsPolynomialDivision:UIView
{
    weak var fieldDividend:UITextView!
    weak var fieldDivisor:UITextView!
    private let kBorderHeight:CGFloat = 2
    private let kBorderMargin:CGFloat = 10
    private let kFontSize:CGFloat = 45
    private let kInsetsHorizontal:CGFloat = 5
    private let kFieldsTop:CGFloat = 30
    private let kFieldsHeight:CGFloat = 55
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let color:UIColor = UIColor.black
        let contentSize:UIEdgeInsets = UIEdgeInsets.zero
        let font:UIFont = UIFont.numeric(size:kFontSize)
        let containerInset:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        
        let fieldDividend:UITextView = UITextView()
        fieldDividend.clipsToBounds = true
        fieldDividend.translatesAutoresizingMaskIntoConstraints = false
        fieldDividend.backgroundColor = UIColor.clear
        fieldDividend.textColor = color
        fieldDividend.tintColor = color
        fieldDividend.bounces = false
        fieldDividend.isScrollEnabled = false
        fieldDividend.showsVerticalScrollIndicator = false
        fieldDividend.showsHorizontalScrollIndicator = false
        fieldDividend.returnKeyType = UIReturnKeyType.next
        fieldDividend.keyboardAppearance = UIKeyboardAppearance.light
        fieldDividend.autocorrectionType = UITextAutocorrectionType.no
        fieldDividend.spellCheckingType = UITextSpellCheckingType.no
        fieldDividend.autocapitalizationType = UITextAutocapitalizationType.none
        fieldDividend.keyboardType = UIKeyboardType.numbersAndPunctuation
        fieldDividend.contentInset = contentSize
        fieldDividend.font = font
        fieldDividend.textContainerInset = containerInset
        fieldDividend.textAlignment = NSTextAlignment.center
        self.fieldDividend = fieldDividend
        
        let fieldDivisor:UITextView = UITextView()
        fieldDivisor.clipsToBounds = true
        fieldDivisor.translatesAutoresizingMaskIntoConstraints = false
        fieldDivisor.backgroundColor = UIColor.clear
        fieldDivisor.textColor = color
        fieldDivisor.tintColor = color
        fieldDivisor.bounces = false
        fieldDivisor.isScrollEnabled = false
        fieldDivisor.showsVerticalScrollIndicator = false
        fieldDivisor.showsHorizontalScrollIndicator = false
        fieldDivisor.returnKeyType = UIReturnKeyType.next
        fieldDivisor.keyboardAppearance = UIKeyboardAppearance.light
        fieldDivisor.autocorrectionType = UITextAutocorrectionType.no
        fieldDivisor.spellCheckingType = UITextSpellCheckingType.no
        fieldDivisor.autocapitalizationType = UITextAutocapitalizationType.none
        fieldDivisor.keyboardType = UIKeyboardType.numbersAndPunctuation
        fieldDivisor.contentInset = contentSize
        fieldDivisor.font = font
        fieldDivisor.textContainerInset = containerInset
        fieldDivisor.textAlignment = NSTextAlignment.center
        self.fieldDivisor = fieldDivisor
        
        let border:VBorder = VBorder(color:color)
        border.layer.cornerRadius = kBorderHeight / 2.0
        
        addSubview(border)
        addSubview(fieldDividend)
        addSubview(fieldDivisor)
        
        NSLayoutConstraint.topToTop(
            view:fieldDividend,
            toView:self,
            constant:kFieldsTop)
        NSLayoutConstraint.height(
            view:fieldDividend,
            constant:kFieldsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:fieldDividend,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:fieldDividend,
            constant:kBorderMargin)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self,
            margin:kBorderMargin)
        
        NSLayoutConstraint.topToBottom(
            view:fieldDivisor,
            toView:border,
            constant:kBorderMargin)
        NSLayoutConstraint.height(
            view:fieldDivisor,
            constant:kFieldsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:fieldDivisor,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
