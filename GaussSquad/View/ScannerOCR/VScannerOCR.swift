import UIKit

class VScannerOCR:VView
{
    private weak var controller:CScannerOCR!
    private weak var spinner:VSpinner!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CScannerOCR
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
