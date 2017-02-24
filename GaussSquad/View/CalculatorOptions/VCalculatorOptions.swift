import UIKit

class VCalculatorOptions:VView
{
    private weak var controller:CCalculatorOptions!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCalculatorOptions
        
        let blur:VBlur = VBlur.dark()
        
        addSubview(blur)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
