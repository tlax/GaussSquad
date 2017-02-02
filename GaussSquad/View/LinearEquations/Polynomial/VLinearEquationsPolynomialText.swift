import UIKit

class VLinearEquationsPolynomialText:UITextView, UITextViewDelegate
{
    private weak var controller:CLinearEquationsPolynomial!
    private let numberFormatter:NumberFormatter
    private let kNumberFormatterStyle:NumberFormatter.Style = NumberFormatter.Style.decimal
    private let kDot:String = "."
    private let kComma:String = ","
    private let kEmpty:String = ""
    private let kMaxHeight:CGFloat = 45
    private let kInsetsHorizontal:CGFloat = 5
    private let kInsetsTop:CGFloat = 25
    private let kMaxFontSize:CGFloat = 32
    private let kNumbersMin:UInt32 = 48
    private let kNumbersMax:UInt32 = 57
    private let kDecimalPoint:UInt32 = 46
    private let kMinIntegers:Int = 1
    private let kMaxIntegers:Int = 10
    private let kMinDecimals:Int = 0
    private let kMaxDecimals:Int = 10
    
    init(controller:CLinearEquationsPolynomial)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = kNumberFormatterStyle
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumIntegerDigits = kMaxIntegers
        numberFormatter.minimumFractionDigits = kMinDecimals
        numberFormatter.maximumFractionDigits = kMaxDecimals

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
        font = UIFont.medium(size:kMaxHeight)
        textContainerInset = UIEdgeInsets(
            top:kInsetsTop,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        delegate = self
        self.controller = controller
        
        readPolynomial()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func readPolynomial()
    {
        guard
        
            let polynomial:DPolynomial = controller.polynomial
        
        else
        {
            return
        }
        
        let dividend:Double = polynomial.coefficientDividend
        let divisor:Double = polynomial.coefficientDivisor
        let coefficient:Double = dividend / divisor
        let coefficentNumber:NSNumber = NSNumber(value:coefficient)
        
        guard
        
            let coefficientString:String = numberFormatter.string(
                from:coefficentNumber)
        
        else
        {
            return
        }
        
        let curatedCoefficient:String = coefficientString.replacingOccurrences(
            of:kComma,
            with:kEmpty)
        
        text = curatedCoefficient
    }
    
    private func textToPolynomial()
    {
        guard
        
            let number:NSNumber = numberFormatter.number(
                from:text)
        
        else
        {
            return
        }
        
        let numberDouble:Double = number as Double
        
        print("number \(number) as double \(numberDouble)")
        
        controller.polynomial?.coefficientDividend = numberDouble
        controller.polynomial?.coefficientDivisor = 1
    }
    
    //MARK: textView delegate
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        let newTextCount:Int = text.characters.count
        
        for newTextIndex:Int in 0 ..< newTextCount
        {
            let character:Character = text[
                text.index(
                    text.startIndex,
                    offsetBy:newTextIndex)]
            let characterString:String = "\(character)"
            
            guard
            
                let unicodeScalar:UnicodeScalar = UnicodeScalar(characterString)
            
            else
            {
                return false
            }
            
            let unicodeInt:UInt32 = unicodeScalar.value
            
            if unicodeInt == kDecimalPoint
            {
                if self.text.contains(kDot)
                {
                    return false
                }
            }
            else
            {
                if unicodeInt < kNumbersMin || unicodeInt > kNumbersMax
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func textViewDidChange(_ textView:UITextView)
    {
        textToPolynomial()
    }
}
