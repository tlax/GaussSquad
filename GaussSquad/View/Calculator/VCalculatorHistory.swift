import UIKit

class VCalculatorHistory:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCalculator!
    private weak var collectionView:VCollection!
    private let kCellHeight:CGFloat = 20
    private let kCollectionTop:CGFloat = 5
    private let kCollectionBottom:CGFloat = 130
    
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
            flow.sectionInset = UIEdgeInsets(
                top:kCollectionTop,
                left:0,
                bottom:kCollectionBottom,
                right:0)
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
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.scrollToBottom()
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCalculatorStepsItem
    {
        let item:MCalculatorStepsItem = controller.model.steps.items[index.item]
        
        return item
    }
    
    private func scrollToBottom()
    {
        let countItems:Int = controller.model.steps.items.count
        
        if countItems > 0
        {
            let indexPath:IndexPath = IndexPath(
                item:countItems - 1,
                section:0)
            collectionView.scrollToItem(
                at:indexPath,
                at:UICollectionViewScrollPosition.top,
                animated:true)
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
        scrollToBottom()
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
