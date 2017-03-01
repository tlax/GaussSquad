import UIKit

class VScanner:VView
{
    weak var viewCropper:VScannerCropper?
    weak var viewPreview:VScannerPreview!
    weak var viewMenu:VScannerMenu!
    private weak var controller:CScanner!
    private let kMenuHeight:CGFloat = 65
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CScanner
        
        let viewPreview:VScannerPreview = VScannerPreview(
            controller:self.controller)
        self.viewPreview = viewPreview
        
        let viewMenu:VScannerMenu = VScannerMenu(
            controller:self.controller)
        self.viewMenu = viewMenu
        
        addSubview(viewPreview)
        addSubview(viewMenu)
        
        NSLayoutConstraint.equals(
            view:viewPreview,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func reloadCropper()
    {
        self.viewCropper?.removeFromSuperview()
        
        let viewCropper:VScannerCropper = VScannerCropper(
            controller:self.controller)
        self.viewCropper = viewCropper
        
        addSubview(viewCropper)
        
        NSLayoutConstraint.topToTop(
            view:viewCropper,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:viewCropper,
            toView:viewMenu)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCropper,
            toView:self)
        
        layoutIfNeeded()
        viewCropper.viewAppeared()
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        reloadCropper()
    }
    
    func prepareForRotation()
    {
        viewCropper?.removeFromSuperview()
    }
    
    func viewRotated()
    {
        reloadCropper()
    }
}
