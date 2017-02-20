import UIKit

class VLinearEquationsPlotBarZoom:UIView
{
    private weak var controller:CLinearEquationsPlot!
    private weak var stepper:UIStepper!
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let kMinInteger:Int = 1
    private let kMinFraction:Int = 0
    private let kLabelRight:CGFloat = -10
    private let kLabelWidth:CGFloat = 60
    private let kLabelBottom:CGFloat = -15
    private let kLabelHeight:CGFloat = 30
    private let kStepperWidth:CGFloat = 110
    private let kStepperHeight:CGFloat = 47
    private let kMinZoom:Double = -10
    private let kMaxZoom:Double = 10
    
    init(controller:CLinearEquationsPlot)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = kMinFraction
        numberFormatter.minimumIntegerDigits = kMinInteger
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.bold(size:18)
        label.textColor = UIColor.black
        self.label = label
        
        let stepper:UIStepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.tintColor = UIColor.black
        stepper.minimumValue = kMinZoom
        stepper.maximumValue = kMaxZoom
        self.stepper = stepper
        
        addSubview(label)
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
        
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self,
            constant:kLabelBottom)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.rightToLeft(
            view:label,
            toView:stepper,
            constant:kLabelRight)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        showZoom()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionStepper(sender stepper:UIStepper)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            var value:Double = stepper.value
            
            if value < 1
            {
                value = 1 / abs(value)
            }
            
            self?.controller.model.updateZoom(zoom:value)
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.showZoom()
            }
        }
    }
    
    //MARK: private
    
    private func showZoom()
    {
        let zoom:Double = controller.model.zoom
        let zoomNumber:NSNumber = zoom as NSNumber
        
        guard
        
            let zoomString:String = numberFormatter.string(from:zoomNumber)
        
        else
        {
            return
        }
        
        let zoomDescr:String = String(
            format:NSLocalizedString("VLinearEquationsPlotBarZoom_descr", comment:""),
            zoomString)
        label.text = zoomDescr
    }
}
