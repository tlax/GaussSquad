import UIKit

class VLinearEquations:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquations!
    private weak var collectionView:VCollection!
    private weak var viewBar:VLinearEquationsBar!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kCellHeight:CGFloat = 70
    private let kCollectionBottom:CGFloat = 20
    private let kInterline:CGFloat = 1
    private let kDeselectTime:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.98, alpha:1)
        self.controller = controller as? CLinearEquations
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VLinearEquationsBar = VLinearEquationsBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumLineSpacing = kInterline
        collectionView.alwaysBounceVertical = true
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
            CGRect(
                x:0,
                y:0,
                width:1,
                height:1),
            animated:false)
        collectionView.reloadData()
        spinner.stopAnimating()
        collectionView.isHidden = false
        viewBar.isHidden = false
        viewBar.isUserInteractionEnabled = true
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> DProject
    {
        let item:DProject = controller.model!.projects[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let collectionTop:CGFloat = layoutBarHeight.constant
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:collectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = bounds.width
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = controller.model?.projects.count
        
        else
        {
            return 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:DProject = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLinearEquationsCell.reusableIdentifier,
            for:indexPath) as! VLinearEquationsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:DProject = modelAtIndex(index:indexPath)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
