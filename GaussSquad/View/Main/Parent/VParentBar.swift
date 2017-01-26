import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CParent)
    {
        super.init(frame:CGRect.zero)
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(border)
        
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
