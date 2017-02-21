import UIKit

class VLinearEquationsPolynomial:VView, UITextViewDelegate
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var viewControl:VLinearEquationsPolynomialControl!
    private weak var viewIndeterminate:VLinearEquationsPolynomialIndeterminate!
    private weak var viewShowAs:VLinearEquationsPolynomialShowAs!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private weak var viewText:VLinearEquationsPolynomialText?
    private weak var viewDivision:VLinearEquationsPolynomialDivision?
    private let kDot:String = "."
    private let kComma:String = ","
    private let kEmpty:String = ""
    private let kNewline:String = "\n"
    private let kControlHeight:CGFloat = 50
    private let kIndeterminateHeight:CGFloat = 50
    private let kIndeterminateWidth:CGFloat = 210
    private let kShowAsWidth:CGFloat = 100
    private let kShowAsHeight:CGFloat = 32
    private let kShowAsLeft:CGFloat = 10
    private let kShowAsBottom:CGFloat = -9
    private let kAnimationDuration:TimeInterval = 0.35
    private let kNumbersMin:UInt32 = 48
    private let kNumbersMax:UInt32 = 57
    private let kDecimalPoint:UInt32 = 46
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomial
        
        let blur:VBlur = VBlur.light()
        
        let viewControl:VLinearEquationsPolynomialControl = VLinearEquationsPolynomialControl(
            controller:self.controller)
        self.viewControl = viewControl
        
        let viewIndeterminate:VLinearEquationsPolynomialIndeterminate = VLinearEquationsPolynomialIndeterminate(
            controller:self.controller)
        self.viewIndeterminate = viewIndeterminate
        
        let viewShowAs:VLinearEquationsPolynomialShowAs = VLinearEquationsPolynomialShowAs(
            controller:self.controller)
        self.viewShowAs = viewShowAs
        
        addSubview(blur)
        addSubview(viewIndeterminate)
        addSubview(viewShowAs)
        addSubview(viewControl)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewControl,
            constant:kControlHeight)
        layoutControlBottom = NSLayoutConstraint.bottomToBottom(
            view:viewControl,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewControl,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:viewIndeterminate,
            toView:viewControl)
        NSLayoutConstraint.height(
            view:viewIndeterminate,
            constant:kIndeterminateHeight)
        NSLayoutConstraint.width(
            view:viewIndeterminate,
            constant:kIndeterminateWidth)
        NSLayoutConstraint.rightToRight(
            view:viewIndeterminate,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:viewShowAs,
            toView:viewControl,
            constant:kShowAsBottom)
        NSLayoutConstraint.height(
            view:viewShowAs,
            constant:kShowAsHeight)
        NSLayoutConstraint.leftToLeft(
            view:viewShowAs,
            toView:self,
            constant:kShowAsLeft)
        NSLayoutConstraint.width(
            view:viewShowAs,
            constant:kShowAsWidth)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedKeyboardChanged(sender:)),
            name:NSNotification.Name.UIKeyboardWillChangeFrame,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: notifications
    
    func notifiedKeyboardChanged(sender notification:Notification)
    {
        guard
            
            let userInfo:[AnyHashable:Any] = notification.userInfo,
            let keyboardFrameValue:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            
        else
        {
            return
        }
        
        let keyRect:CGRect = keyboardFrameValue.cgRectValue
        let yOrigin = keyRect.origin.y
        let height:CGFloat = bounds.maxY
        let keyboardHeight:CGFloat
        
        if yOrigin < height
        {
            keyboardHeight = height - yOrigin
        }
        else
        {
            keyboardHeight = 0
        }
        
        layoutControlBottom.constant = -keyboardHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: private
    
    private func asDecimal()
    {
        self.viewText?.removeFromSuperview()
        self.viewDivision?.removeFromSuperview()
        
        let viewText:VLinearEquationsPolynomialText = VLinearEquationsPolynomialText()
        viewText.delegate = self
        self.viewText = viewText
        
        insertSubview(viewText, belowSubview:viewIndeterminate)
        
        NSLayoutConstraint.equals(
            view:viewText,
            toView:self)
    }
    
    private func asDivision()
    {
        self.viewText?.removeFromSuperview()
        self.viewDivision?.removeFromSuperview()
        
        let viewDivision:VLinearEquationsPolynomialDivision = VLinearEquationsPolynomialDivision()
        viewDivision.fieldDividend.delegate = self
        viewDivision.fieldDivisor.delegate = self
        self.viewDivision = viewDivision
        
        insertSubview(viewDivision, belowSubview:viewIndeterminate)
        
        NSLayoutConstraint.equals(
            view:viewDivision,
            toView:self)
    }
    
    private func curatedNumber(number:String) -> String
    {
        let curatedString:String = number.replacingOccurrences(
            of:kComma,
            with:kEmpty)
        
        return curatedString
    }
    
    private func textToPolynomial()
    {
        guard
            
            let polynomial:DPolynomial = controller.polynomial
            
        else
        {
            return
        }
        
        if polynomial.showAsDivision
        {
            guard
            
                let textDividend:String = viewDivision?.fieldDividend.text,
                let textDivisor:String = viewDivision?.fieldDivisor.text
            
            else
            {
                return
            }
            
            let dividend:Double = MSession.sharedInstance.numberFrom(
                string:textDividend)
            var divisor:Double = MSession.sharedInstance.numberFrom(
                string:textDivisor)
            
            if divisor <= 0
            {
                divisor = 1
            }
            
            polynomial.coefficientDividend = dividend
            polynomial.coefficientDivisor = divisor
            
        }
        else
        {
            guard
                
                let text:String = viewText?.text
                
            else
            {
                return
            }
            
            let coefficient:Double = MSession.sharedInstance.numberFrom(
                string:text)
            
            polynomial.coefficientDividend = coefficient
            polynomial.coefficientDivisor = 1
        }
    }
    
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
        
        if polynomial.showAsDivision
        {
            guard
            
                let viewDivision:VLinearEquationsPolynomialDivision = self.viewDivision
            
            else
            {
                return
            }
            
            let dividendString:String = MSession.sharedInstance.stringFrom(
                number:dividend)
            let divisorString:String = MSession.sharedInstance.stringFrom(
                number:divisor)
            
            let curatedDividend:String = curatedNumber(number:dividendString)
            let curatedDivisor:String = curatedNumber(number:divisorString)
            
            viewDivision.fieldDividend.text = curatedDividend
            viewDivision.fieldDivisor.text = curatedDivisor
            viewDivision.fieldDividend.becomeFirstResponder()
        }
        else
        {
            let coefficient:Double = dividend / divisor
            
            guard
                
                let viewText:VLinearEquationsPolynomialText = self.viewText
                
            else
            {
                return
            }
            
            let coefficientString:String = MSession.sharedInstance.stringFrom(
                number:coefficient)
            let curatedCoefficient:String = curatedNumber(number:coefficientString)
            viewText.text = curatedCoefficient
            viewText.becomeFirstResponder()
        }
    }
    
    //MARK: public
    
    func startEdition()
    {
        viewIndeterminate.refresh()
        checkMode()
    }
    
    func endEdition()
    {
        viewText?.isHidden = true
        viewDivision?.isHidden = true
    }
    
    func checkMode()
    {
        guard
            
            let polynomial:DPolynomial = self.controller.polynomial
            
        else
        {
            return
        }
        
        if polynomial.showAsDivision
        {
            asDivision()
        }
        else
        {
            asDecimal()
        }
        
        readPolynomial()
    }
    
    //MARK: textView delegate
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        if text == kNewline
        {
            if textView === viewDivision?.fieldDivisor
            {
                viewDivision?.fieldDividend.becomeFirstResponder()
            }
            else if textView === viewDivision?.fieldDividend
            {
                viewDivision?.fieldDivisor.becomeFirstResponder()
            }
            else
            {
                textView.resignFirstResponder()
            }
        }
        
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
                if textView.text.contains(kDot)
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
        let text:String = textView.text
        
        if text.characters.count == 2
        {
            let firstCharacter:Character = text[text.startIndex]
            let secondCharacter:Character = text[
                text.index(
                    text.startIndex,
                    offsetBy:1)]
            let firstString:String = "\(firstCharacter)"
            let secondString:String = "\(secondCharacter)"
            
            guard
                
                let firstScalar:UnicodeScalar = UnicodeScalar(firstString),
                let secondScalar:UnicodeScalar = UnicodeScalar(secondString)
                
            else
            {
                return
            }
            
            let firstUnicode:UInt32 = firstScalar.value
            let secondUnicode:UInt32 = secondScalar.value
            
            if firstUnicode == kNumbersMin
            {
                if secondUnicode != kDecimalPoint
                {
                    textView.text = secondString
                }
            }
        }
        
        textToPolynomial()
    }
}
