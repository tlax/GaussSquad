import UIKit

class VParent:UIView
{
    weak var viewBar:VParentBar!
    private weak var controller:CParent!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.4
    private let kBarHeight:CGFloat = 70
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let viewBar:VParentBar = VParentBar(controller:controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.width(
            view:viewBar,
            toView:self)
    }
    
    //MARK: public
    
    func scrollDidScroll(offsetY:CGFloat)
    {
        let barTopConstant:CGFloat
        
        if offsetY > 0
        {
            barTopConstant = offsetY
        }
        else
        {
            barTopConstant = 0
        }
        
        layoutBarTop.constant = -barTopConstant
    }
    
    func mainView(view:VView)
    {
        insertSubview(view, belowSubview:viewBar)
        
        view.layoutTop = NSLayoutConstraint.topToTop(
            view:view,
            toView:self)
        view.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:view,
            toView:self)
        view.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:view,
            toView:self)
        view.layoutRight = NSLayoutConstraint.rightToRight(
            view:view,
            toView:self)
    }
    
    func slide(
        currentView:VView,
        newView:VView,
        left:CGFloat,
        completion:@escaping(() -> ()))
    {
        insertSubview(newView, belowSubview:viewBar)
        
        newView.layoutTop = NSLayoutConstraint.topToTop(
            view:newView,
            toView:self)
        newView.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:newView,
            toView:self)
        newView.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:newView,
            toView:self,
            constant:-left)
        newView.layoutRight = NSLayoutConstraint.rightToRight(
            view:newView,
            toView:self,
            constant:-left)
        
        layoutIfNeeded()
        
        currentView.layoutRight.constant = left
        currentView.layoutLeft.constant = left
        newView.layoutRight.constant = 0
        newView.layoutLeft.constant = 0
        
        UIView.animate(
        withDuration:kAnimationDuration,
        animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            currentView.removeFromSuperview()
            completion()
        }
    }
    
    func push(
        newView:VView,
        left:CGFloat,
        top:CGFloat,
        completion:@escaping(() -> ()))
    {
        addSubview(newView)
        
        newView.layoutTop = NSLayoutConstraint.topToTop(
            view:newView,
            toView:self,
            constant:top)
        newView.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:newView,
            toView:self,
            constant:top)
        newView.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:newView,
            toView:self,
            constant:left)
        newView.layoutRight = NSLayoutConstraint.rightToRight(
            view:newView,
            toView:self,
            constant:left)
        
        layoutIfNeeded()
        
        if top >= 0
        {
            newView.layoutTop.constant = 0
            newView.layoutBottom.constant = 0
        }
        else
        {
            newView.layoutBottom.constant = 0
            newView.layoutTop.constant = 0
        }
        
        if left >= 0
        {
            newView.layoutLeft.constant = 0
            newView.layoutRight.constant = 0
        }
        else
        {
            newView.layoutRight.constant = 0
            newView.layoutLeft.constant = 0
        }
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func animateOver(
        newView:VView,
        completion:@escaping(() -> ()))
    {
        newView.alpha = 0
        addSubview(newView)
        
        newView.layoutTop = NSLayoutConstraint.topToTop(
            view:newView,
            toView:self)
        newView.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:newView,
            toView:self)
        newView.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:newView,
            toView:self)
        newView.layoutRight = NSLayoutConstraint.rightToRight(
            view:newView,
            toView:self)
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak newView] in
                
                newView?.alpha = 1
            })
        { (done:Bool) in
            
            completion()
        }
    }
    
    func pop(
        currentView:VView,
        left:CGFloat,
        top:CGFloat,
        completion:@escaping(() -> ()))
    {
        currentView.layoutTop.constant = top
        currentView.layoutBottom.constant = top
        currentView.layoutRight.constant = left
        currentView.layoutLeft.constant = left
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            currentView.removeFromSuperview()
            completion()
        }
    }
    
    func dismissAnimateOver(
        currentView:VView,
        completion:@escaping(() -> ()))
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak currentView] in
                
                currentView?.alpha = 0
            })
        { [weak currentView] (done:Bool) in
            
            currentView?.removeFromSuperview()
            completion()
        }
    }
}
