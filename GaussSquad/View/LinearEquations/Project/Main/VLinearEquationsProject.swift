import UIKit

class VLinearEquationsProject:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLinearEquationsProject!
    private weak var viewBar:VLinearEquationsProjectBar!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 100
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 60
    
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
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellIndeterminateSymbol.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellIndeterminateNone.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellCoefficientDivision.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellCoefficientWhole.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellEquals.self)
        collectionView.registerCell(
            cell:VLinearEquationsProjectCellOperator.self)
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
    
    override func layoutSubviews()
    {
        collectionView.flow.invalidateLayout()
        
        super.layoutSubviews()
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
        guard
            
            let project:DProject = controller.model.project
        
        else
        {
            return
        }
        
        spinner.stopAnimating()
        collectionView.reloadData()
        viewBar.isHidden = false
        viewBar.refresh(project:project)
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let insets:UIEdgeInsets
        
        if section == 0
        {
            insets = UIEdgeInsets(
                top:kBarHeight,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        else
        {
            insets = UIEdgeInsets.zero
        }
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let index:Int = indexPath.item
        let cellWidth:CGFloat = controller.model.cols[index]
        let size:CGSize = CGSize(width:cellWidth, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = controller.model.rows.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.cols.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsProjectRowItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsProjectCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsProjectCell
        
        return cell
    }
}
