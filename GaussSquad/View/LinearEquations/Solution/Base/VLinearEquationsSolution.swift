import UIKit

class VLinearEquationsSolution:VView, UICollectionViewDelegate, UICollectionViewDataSource
{
    weak var collectionView:VCollection!
    private weak var controller:CLinearEquationsSolution!
    private weak var viewBar:VLinearEquationsSolutionBar!
    private weak var spinner:VSpinner!
    private weak var layoutBarTop:NSLayoutConstraint!
    
    init(
        controller:CController,
        barHeight:CGFloat,
        footerHeight:CGFloat,
        cellHeight:CGFloat)
    {
        super.init(controller:controller)
        self.controller = controller as? CLinearEquationsSolution
        
        let viewBar:VLinearEquationsSolutionBar = VLinearEquationsSolutionBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let flow:VLinearEquationsSolutionFlow = VLinearEquationsSolutionFlow(
            model:self.controller.model,
            barHeight:barHeight,
            footerHeight:footerHeight,
            cellHeight:cellHeight)
        let collectionView:VCollection = VCollection(flow:flow)
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(
            header:VLinearEquationsSolutionHeader.self)
        collectionView.registerFooter(
            footer:VLinearEquationsSolutionFooter.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellPolynomialDecimal.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellPolynomialDivision.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellConstantDecimal.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellConstantDivision.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellEquals.self)
        collectionView.registerCell(
            cell:VLinearEquationsSolutionCellIndex.self)
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:barHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func stepAtIndex(index:IndexPath) -> MLinearEquationsSolutionStep
    {
        let step:MLinearEquationsSolutionStep = controller.model.steps[index.section]
        
        return step
    }
    
    private func modelAtIndex(index:IndexPath) -> MLinearEquationsSolutionEquationItem
    {
        let step:MLinearEquationsSolutionStep = stepAtIndex(index:index)
        let item:MLinearEquationsSolutionEquationItem = step.plainItems[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    func startExporting()
    {
        collectionView.isHidden = true
        viewBar.isHidden = true
        spinner.startAnimating()
    }
    
    func endExporting()
    {
        collectionView.isHidden = false
        viewBar.isHidden = false
        spinner.stopAnimating()
    }
    
    func bottom()
    {
        let section:Int = controller.model.steps.count - 1
        
        if section >= 0
        {
            let item:Int = controller.model.steps[section].plainItems.count - 1
            
            if item >= 0
            {
                let indexPath:IndexPath = IndexPath(item:item, section:section)
                collectionView.scrollToItem(
                    at:indexPath,
                    at:UICollectionViewScrollPosition.top,
                    animated:true)
            }
        }
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
        let count:Int = controller.model.steps.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.steps[section].plainItems.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let step:MLinearEquationsSolutionStep = stepAtIndex(index:indexPath)
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VLinearEquationsSolutionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VLinearEquationsSolutionHeader.reusableIdentifier,
                for:indexPath) as! VLinearEquationsSolutionHeader
            header.config(
                step:step,
                indexPath:indexPath)
            
            reusable = header
        }
        else
        {
            let footer:VLinearEquationsSolutionFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VLinearEquationsSolutionFooter.reusableIdentifier,
                for:indexPath) as! VLinearEquationsSolutionFooter
            footer.config(
                controller:controller,
                index:indexPath)
            
            reusable = footer
        }
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsSolutionEquationItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsSolutionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsSolutionCell
        cell.config(model:item, index:indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
