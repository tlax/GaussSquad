import UIKit

class VScannerOCR:VView
{
    weak var viewText:VScannerOCRText!
    private weak var controller:CScannerOCR!
    private weak var viewBar:VScannerOCRBar!
    private weak var viewMenu:VScannerOCRMenu!
    private weak var spinner:VSpinner!
    private let kBarHeight:CGFloat = 64
    private let kMenuHeight:CGFloat = 65
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CScannerOCR
        
        let viewText:VScannerOCRText = VScannerOCRText(
            controller:self.controller)
        viewText.isHidden = true
        self.viewText = viewText
        
        let viewBar:VScannerOCRBar = VScannerOCRBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let viewMenu:VScannerOCRMenu = VScannerOCRMenu(
            controller:self.controller)
        viewMenu.isHidden = true
        self.viewMenu = viewMenu
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(viewBar)
        addSubview(viewText)
        addSubview(viewMenu)
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewText,
            toView:viewBar)
        NSLayoutConstraint.bottomToTop(
            view:viewText,
            toView:viewMenu)
        NSLayoutConstraint.equalsHorizontal(
            view:viewText,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
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
        viewBar.isHidden = false
        viewMenu.isHidden = false
        viewText.isHidden = false
        viewText.text = text
    }
}
