import UIKit

class VLinearEquationsProject:VView, UICollectionViewDelegate, UICollectionViewDataSource
{
    private enum Drag
    {
        case stand
        case restart
        case avoid
    }
    
    private weak var controller:CLinearEquationsProject!
    private weak var viewBar:VLinearEquationsProjectBar!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 210
    private let kDeselectTime:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsProject
        
        let viewBar:VLinearEquationsProjectBar = VLinearEquationsProjectBar(
            controller:self.controller)
        viewBar.isHidden = true
        self.viewBar = viewBar
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let flow:VLinearEquationsProjectFlow = VLinearEquationsProjectFlow(
            model:self.controller.model,
            barHeight:kBarHeight)
        let collectionView:VCollection = VCollection(flow:flow)
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellIndex.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellPolynomialDecimal.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellPolynomialDivision.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellEquals.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellNewPolynomial.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellNewRow.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewBar)
        addSubview(spinner)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsProjectRowItem
    {
        let item:MLinearEquationsProjectRowItem = controller.model.rows[index.section].items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        viewBar.isHidden = false
        viewBar.viewIndeterminates.refresh()
    }
    
    func startLoading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
        viewBar.isHidden = true
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        var offsetY:CGFloat = -scrollView.contentOffset.y
        
        if offsetY > 0
        {
            offsetY = 0
        }
        
        layoutBarTop.constant = offsetY
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = controller.model.rows.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.rows[section].items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsProjectRowItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsProjectCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectCell
        cell.config(model:item, indexPath:indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MLinearEquationsProjectRowItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
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
