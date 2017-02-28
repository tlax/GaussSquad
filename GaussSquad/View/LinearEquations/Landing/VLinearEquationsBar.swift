import UIKit

class VLinearEquationsBar:UIView
{
    weak var border:VBorder!
    private weak var controller:CLinearEquations!
    private let kContentTop:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    private let kBorderTop:CGFloat = 65
    private let kTitleHeight:CGFloat = 44
    
    init(controller:CLinearEquations)
    {
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let labelTitle:UILabel = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:17)
        labelTitle.textColor = UIColor.black
        labelTitle.text = NSLocalizedString("VLinearEquationsBar_labelTitle", comment:"")
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        self.border = border
        
        addSubview(labelTitle)
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:labelTitle,
            constant:kBorderTop)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
