import UIKit

class VLinearEquationsSolutionCellPolynomialDecimal:VLinearEquationsSolutionCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(
        model:MLinearEquationsSolutionEquationItem,
        index:IndexPath)
    {
        guard
        
            let model:MLinearEquationsSolutionEquationItemPolynomialDecimal = model as? MLinearEquationsSolutionEquationItemPolynomialDecimal
        
        else
        {
            return
        }
        
        label.attributedText = model.string
    }
}
