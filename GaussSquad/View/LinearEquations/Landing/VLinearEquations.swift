import UIKit

class VLinearEquations:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquations!
    private weak var collectionView:VCollection!
    private weak var viewBar:VLinearEquationsBar!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutBarHeight:NSLayoutConstraint!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquations
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLinearEquationsBar = VLinearEquationsBar(
            controller:self.controller)
        viewBar.isHidden = true
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
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        viewBar.layoutIfNeeded()
        let barMaxHeight:CGFloat = viewBar.border.frame.maxY
        layoutBarHeight.constant = barMaxHeight
        
        super.layoutSubviews()
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
        viewBar.isUserInteractionEnabled = true
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        
    }
}
