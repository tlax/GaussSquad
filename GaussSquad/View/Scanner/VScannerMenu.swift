import UIKit

class VScannerMenu:UIView
{
    private weak var controller:CScanner!
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CScanner)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blur:VBlur = VBlur.dark()
        let border:VBorder = VBorder(color:UIColor(white:1, alpha:0.2))
        
        addSubview(blur)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.topToTop(
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
