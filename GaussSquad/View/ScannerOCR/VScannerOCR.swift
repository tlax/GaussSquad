import UIKit

class VScannerOCR:VView
{
    private weak var controller:CScannerOCR!
    private weak var viewText:VScannerOCRText!
    private weak var spinner:VSpinner!
    private let kTextHeight:CGFloat = 200
    
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
        
        addSubview(viewText)
        addSubview(spinner)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func textRecognized(text:String)
    {
        spinner.stopAnimating()
        viewText.isHidden = false
        viewText.text = text
    }
}
