import UIKit

class VLinearEquationsSolutionHeaderProcess:VLinearEquationsSolutionHeader
{
    private weak var labelDescr:UILabel!
    private weak var labelNumber:UILabel!
    private let kDescrWidth:CGFloat = 240
    private let kNumberLeft:CGFloat = 10
    private let kNumberWidth:CGFloat = 35
    
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
        labelNumber.font = UIFont.bold(size:16)
        labelNumber.textColor = UIColor.squadRed
        self.labelNumber = labelNumber
        
        addSubview(labelDescr)
        addSubview(labelNumber)
        
        NSLayoutConstraint.equalsVertical(
            view:labelDescr,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelDescr,
            toView:labelNumber)
        NSLayoutConstraint.width(
            view:labelDescr,
            constant:kDescrWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelNumber,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:labelNumber,
            toView:self,
            constant:kNumberLeft)
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
        labelNumber.text = "\(indexPath.section)"
    }
}
