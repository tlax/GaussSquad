import UIKit

class VLinearEquationsPlotBarZoom:UIView
{
    private weak var controller:CLinearEquationsPlot!
    private weak var stepper:UIStepper!
    private let kStepperWidth:CGFloat = 110
    private let kStepperHeight:CGFloat = 70
    
    init(controller:CLinearEquationsPlot)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let stepper:UIStepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.tintColor = UIColor.black
        self.stepper = stepper
        
        addSubview(stepper)
        
        NSLayoutConstraint.bottomToBottom(
            view:stepper,
            toView:self)
        NSLayoutConstraint.height(
            view:stepper,
            constant:kStepperHeight)
        NSLayoutConstraint.rightToRight(
            view:stepper,
            toView:self)
        NSLayoutConstraint.width(
            view:stepper,
            constant:kStepperWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
