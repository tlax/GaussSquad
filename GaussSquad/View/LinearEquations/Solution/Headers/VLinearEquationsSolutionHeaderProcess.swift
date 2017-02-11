import UIKit

class VLinearEquationsSolutionHeaderProcess:VLinearEquationsSolutionHeader
{
    private weak var labelDescr:UILabel!
    private weak var labelNumber:UILabel!
    private let kDescrLeft:CGFloat = 5
    private let kDescrWidth:CGFloat = 280
    private let kNumberWidth:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let labelDescr:UILabel = UILabel()
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.numberOfLines = 0
        labelDescr.isUserInteractionEnabled = false
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.font = UIFont.regular(size:16)
        labelDescr.textColor = UIColor(white:0, alpha:0.5)
        self.labelDescr = labelDescr
        
        let labelNumber:UILabel = UILabel()
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.numberOfLines = 0
        labelNumber.isUserInteractionEnabled = false
        labelNumber.backgroundColor = UIColor.clear
        labelNumber.font = UIFont.regular(size:16)
        labelNumber.textColor = UIColor.squadBlue
        labelNumber.textAlignment = NSTextAlignment.right
        self.labelNumber = labelNumber
        
        addSubview(labelDescr)
        
        NSLayoutConstraint.equalsVertical(
            view:labelDescr,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelDescr,
            toView:labelNumber,
            constant:kDescrLeft)
        NSLayoutConstraint.width(
            view:labelDescr,
            constant:kDescrWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelNumber,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelNumber,
            toView:self)
        NSLayoutConstraint.width(
            view:labelNumber,
            constant:kNumberWidth)
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
        
        labelDescr.text = stepProcess.descr
        labelNumber.text = "\(indexPath.item)"
    }
}
