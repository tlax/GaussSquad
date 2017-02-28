import UIKit

class VLinearEquationsPlotMenuCellOrigin:VLinearEquationsPlotMenuCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.text = NSLocalizedString("VLinearEquationsPlotMenuCellOrigin_title", comment:"")
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
