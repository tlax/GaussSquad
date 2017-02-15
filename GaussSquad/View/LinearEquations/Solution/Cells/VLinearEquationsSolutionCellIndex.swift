import UIKit

class VLinearEquationsSolutionCellIndex:VLinearEquationsSolutionCell
{
    private weak var label:UILabel!
    private weak var layoutLabelTop:NSLayoutConstraint!
    private weak var layoutLabelLeft:NSLayoutConstraint!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        self.label = label
        
        addSubview(label)
        
        layoutLabelTop = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        layoutLabelLeft = NSLayoutConstraint.leftToLeft(
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
        
        label.attributedText = model.string
        layoutLabelTop.constant = model.kMarginTop
        layoutLabelLeft.constant = model.kMarginLeft
    }
}
