import UIKit

class VLinearEquationsPolynomial:VView
{
    private weak var controller:CLinearEquationsPolynomial!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomial
        
        let blur:VBlur = VBlur.light()
        
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
