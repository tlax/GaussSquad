import UIKit

class VLinearEquationsSolutionCellIndex:VLinearEquationsSolutionCell
{
    private weak var label:UILabel!
    private let kMarginRight:CGFloat = -5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.squadRed
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.medium(size:12)
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
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
}
