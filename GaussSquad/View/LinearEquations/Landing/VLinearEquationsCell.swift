import UIKit

class VLinearEquationsCell:UICollectionViewCell
{
    private weak var model:MLinearEquationsItem?
    private weak var labelDescr:UILabel!
    private weak var labelAge:UILabel!
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    private let kLabelMargin:CGFloat = 10
    private let kAgeHeight:CGFloat = 20
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.textColor = UIColor.black
        self.labelDescr = labelDescr
        
        let labelAge:UILabel = UILabel()
        labelAge.isUserInteractionEnabled = false
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.backgroundColor = UIColor.clear
        labelAge.font = UIFont.bold(size:13)
        labelAge.textColor = UIColor.squadBlue
        self.labelAge = labelAge
        
        addSubview(labelDescr)
        addSubview(labelAge)
        
        NSLayoutConstraint.topToTop(
            view:labelDescr,
            toView:self,
            constant:kLabelMargin)
        NSLayoutConstraint.bottomToTop(
            view:labelDescr,
            toView:labelAge)
        NSLayoutConstraint.equalsHorizontal(
            view:labelDescr,
            toView:self,
            margin:kLabelMargin)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelAge,
            toView:self,
            constant:-kLabelMargin)
        NSLayoutConstraint.height(
            view:labelAge,
            constant:kAgeHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelAge,
            toView:self,
            margin:kLabelMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MLinearEquationsItem)
    {
        self.model = model
        labelDescr.attributedText = model.descr
        labelAge.text = model.age
        hover()
    }
}
