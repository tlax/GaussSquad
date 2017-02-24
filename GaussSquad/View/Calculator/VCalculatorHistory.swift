import UIKit

class VCalculatorHistory:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCalculator!
    private weak var collectionView:VCollection!
    private let kCellHeight:CGFloat = 30
    private let kCollectionTop:CGFloat = 20
    private let kCollectionBottom:CGFloat = 20
    
    init(controller:CCalculator)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
        
        let collectionView:VCollection = VCollection()
        collectionView.isUserInteractionEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCalculatorHistoryCell.self)
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kCollectionTop)
            flow.footerReferenceSize = CGSize(width:0, height:kCollectionBottom)
        }
        
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
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
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCalculatorStepsItem
    {
        let item:MCalculatorStepsItem = controller.model.steps.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.steps.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCalculatorStepsItem = modelAtIndex(index:indexPath)
        let cell:VCalculatorHistoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCalculatorHistoryCell.reusableIdentifier,
            for:indexPath) as! VCalculatorHistoryCell
        cell.config(model:item)
        
        return cell
    }
}
