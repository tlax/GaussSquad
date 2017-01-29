import UIKit

class VLinearEquations:VView
{
    private weak var controller:CLinearEquations!
    private weak var collectionView:VCollection!
    private weak var viewBar:VLinearEquationsBar!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 160
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquations
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLinearEquationsBar = VLinearEquationsBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        layoutBarTop =  NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func modelLoading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
        viewBar.isHidden = true
    }
    
    func refresh()
    {
        collectionView.scrollRectToVisible(
            CGRect(x:0, y:0, width:1, height:1),
            animated:false)
        collectionView.reloadData()
        spinner.stopAnimating()
        collectionView.isHidden = false
        viewBar.isHidden = false
    }
}
