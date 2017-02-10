import UIKit

class VLinearEquationsSolutionCellIndex:VLinearEquationsSolutionCell
{
    private weak var label:UILabel!
    private let kMarginTop:CGFloat = 3
    private let kMarginRight:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.squadBlue
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.bold(size:13)
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kMarginTop)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kMarginRight)
        NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(model:MLinearEquationsSolutionEquationItem, index:IndexPath)
    {
        guard
            
            let model:MLinearEquationsSolutionEquationItemIndex = model as? MLinearEquationsSolutionEquationItemIndex
        
        else
        {
            return
        }
        
        label.text = "\(model.index + 1)"
    }
}
