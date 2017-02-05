import UIKit

class VLinearEquationsIndeterminateListHeader:UICollectionReusableView
{
    private weak var controller:CLinearEquationsPolynomialIndeterminate?
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.regular(size:14)
        labelTitle.textColor = UIColor.black
        
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
    
    //MARK: public
    
    func config(controller:CLinearEquationsPolynomialIndeterminate)
    {
        self.controller = controller
    }
}
