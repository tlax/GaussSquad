import UIKit

class VCalculatorOptions:VView
{
    private weak var controller:CCalculatorOptions!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 280
    private let kAnimationDuration:TimeInterval = 0.25
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCalculatorOptions
        
        let blur:VBlur = VBlur.dark()
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewBase:UIView = UIView()
        viewBase.backgroundColor = UIColor.white
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blur)
        addSubview(closeButton)
        addSubview(viewBase)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseHeight)
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:viewBase,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
