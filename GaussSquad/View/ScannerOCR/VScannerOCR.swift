import UIKit

class VScannerOCR:VView
{
    private weak var controller:CScannerOCR!
    private weak var viewText:VScannerOCRText!
    private weak var border:VBorder!
    private weak var spinner:VSpinner!
    private let kTextHeight:CGFloat = 240
    private let kBorderHeight:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CScannerOCR
        
        let viewText:VScannerOCRText = VScannerOCRText(
            controller:self.controller)
        viewText.isHidden = true
        self.viewText = viewText
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        border.isHidden = true
        self.border = border
        
        addSubview(viewText)
        addSubview(spinner)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewText,
            toView:self)
        NSLayoutConstraint.height(
            view:viewText,
            constant:kTextHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewText,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self,
            constant:kTextHeight)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func textRecognized(text:String)
    {
        spinner.stopAnimating()
        border.isHidden = false
        viewText.isHidden = false
        viewText.text = text
    }
}
