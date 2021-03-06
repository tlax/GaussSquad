import UIKit

class VSettingsCellFractionDigits:VSettingsCell
{
    private weak var labelNumber:UILabel!
    private weak var stepper:UIStepper!
    private let kLabelTitleLeft:CGFloat = 10
    private let kLabelNumberWidth:CGFloat = 60
    private let kLabelNumberRight:CGFloat = -10
    private let kStepperWidth:CGFloat = 110
    private let kStepperHeight:CGFloat = 70
    private let kStepperTop:CGFloat = 34
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.medium(size:15)
        labelTitle.numberOfLines = 0
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VSettingsCellFractionDigits_labelTitle", comment:"")
        
        let stepper:UIStepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.tintColor = UIColor.black
        stepper.addTarget(
            self,
            action:#selector(actionStepper(sender:)),
            for:UIControlEvents.valueChanged)
        self.stepper = stepper
        
        let labelNumber:UILabel = UILabel()
        labelNumber.isUserInteractionEnabled = false
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.textAlignment = NSTextAlignment.right
        labelNumber.font = UIFont.numericBold(size:26)
        labelNumber.textColor = UIColor.squadBlue
        self.labelNumber = labelNumber
        
        addSubview(labelTitle)
        addSubview(labelNumber)
        addSubview(stepper)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:self,
            constant:kLabelTitleLeft)
        NSLayoutConstraint.rightToLeft(
            view:labelTitle,
            toView:labelNumber)
        
        NSLayoutConstraint.equalsVertical(
            view:labelNumber,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:labelNumber,
            toView:stepper,
            constant:kLabelNumberRight)
        NSLayoutConstraint.width(
            view:labelNumber,
            constant:kLabelNumberWidth)
        
        NSLayoutConstraint.topToTop(
            view:stepper,
            toView:self,
            constant:kStepperTop)
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
    
    override func config(controller:CSettings, model:MSettingsItem)
    {
        super.config(controller:controller, model:model)
        
        guard
        
            let model:MSettingsItemFractionDigits = model as? MSettingsItemFractionDigits
        
        else
        {
            return
        }

        stepper.isContinuous = true
        stepper.maximumValue = model.kMaxDigits
        stepper.minimumValue = model.kMinDigits
        
        guard
        
            let maxFractionDigits:Double = MSession.sharedInstance.settings?.maxFractionDigits
        
        else
        {
            return
        }
        
        stepper.value = maxFractionDigits
        displayValue()
    }
    
    //MARK: actions
    
    func actionStepper(sender stepper:UIStepper)
    {
        let current:Double = stepper.value
        MSession.sharedInstance.settings?.newMaxFractionDigits(maxFractionDigits:current)
        
        displayValue()
    }
    
    //MARK: private
    
    private func displayValue()
    {
        let current:Int = Int(stepper.value)
        let stringCurrent:String = "\(current)"
        labelNumber.text = stringCurrent
    }
}
