import UIKit

class VLinearEquationsSolutionHeader:UICollectionReusableView
{
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(border)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
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
