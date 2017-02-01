import UIKit

class VLinearEquationsPolynomial:VView
{
    private weak var controller:CLinearEquationsPolynomial!
    private weak var viewControl:VLinearEquationsPolynomialControl!
    private weak var layoutControlBottom:NSLayoutConstraint!
    private let kControlHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomial
        
        let blur:VBlur = VBlur.light()
        
        let viewControl:VLinearEquationsPolynomialControl = VLinearEquationsPolynomialControl(
            controller:self.controller)
        self.viewControl = viewControl
        
        addSubview(blur)
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
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func startEdition()
    {
        
    }
}
