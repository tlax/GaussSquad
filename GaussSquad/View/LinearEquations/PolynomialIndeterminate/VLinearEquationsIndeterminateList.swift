import UIKit

class VLinearEquationsIndeterminateList:VView
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kBaseHeight:CGFloat = 200
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CLinearEquationsPolynomialIndeterminate
        
        let blur:VBlur = VBlur.dark()
        let borderTop:VBorder = VBorder(color:UIColor.black)
        
        let baseView:UIView = UIView()
        baseView.backgroundColor = UIColor.white
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        
        let dismissButton:UIButton = UIButton()
        dismissButton.backgroundColor = UIColor.clear
        dismissButton.clipsToBounds = true
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(
            self,
            action:#selector(actionDimiss(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(blur)
        addSubview(dismissButton)
        addSubview(borderTop)
        addSubview(baseView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:dismissButton,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self)
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:baseView,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:baseView,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:borderTop,
            toView:baseView)
        NSLayoutConstraint.height(
            view:borderTop,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:borderTop,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionDimiss(sender button:UIButton)
    {
        controller.close()
    }
    
    //MARK: public
    
    func animateShow()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
