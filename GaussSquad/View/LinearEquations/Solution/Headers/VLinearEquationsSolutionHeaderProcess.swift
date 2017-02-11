import UIKit

class VLinearEquationsSolutionHeaderProcess:VLinearEquationsSolutionHeader
{
    private weak var label:UILabel!
    private let kLabelLeft:CGFloat = 10
    private let kLabelWidth:CGFloat = 280
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:17)
        label.textColor = UIColor(white:0, alpha:0.5)
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(step:MLinearEquationsSolutionStep, indexPath:IndexPath)
    {
        guard
        
            let stepProcess:MLinearEquationsSolutionStepProcess = step as? MLinearEquationsSolutionStepProcess
        
        else
        {
            return
        }
        
        label.text = stepProcess.descr
    }
}
