import UIKit

class VLinearEquationsSolution:VView, UICollectionViewDelegate, UICollectionViewDataSource
{
    private weak var controller:CLinearEquationsSolution!
    private weak var collectionView:VCollection!
    private weak var viewBar:VLinearEquationsSolutionBar!
    private weak var spinner:VSpinner?
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 90
    
    override init(controller:CController)
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
            barHeight:kBarHeight)
        let collectionView:VCollection = VCollection(flow:flow)
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeader(
            header:VLinearEquationsSolutionHeaderStart.self)
        collectionView.registerHeader(
            header:VLinearEquationsSolutionHeaderProcess.self)
        collectionView.registerHeader(
            header:VLinearEquationsSolutionHeaderDone.self)
        collectionView.registerHeader(
            header:VLinearEquationsSolutionHeaderError.self)
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
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        
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
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        collectionView.reloadData()
        viewBar.refresh()
    }
    
    //MARK: collectionView delegate
    
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
        let header:VLinearEquationsSolutionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            step.reusableIdentifier,
            for:indexPath) as! VLinearEquationsSolutionHeader
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLinearEquationsSolutionEquationItem = modelAtIndex(index:indexPath)
        let cell:VLinearEquationsSolutionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VLinearEquationsSolutionCell
        
        return cell
    }
}
