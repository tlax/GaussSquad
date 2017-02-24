import UIKit

class VCalculatorOptions:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCalculatorOptions!
    private weak var collectionView:VCollection!
    private weak var layoutBaseBottom:NSLayoutConstraint!
    private let kBaseHeight:CGFloat = 280
    private let kAnimationDuration:TimeInterval = 0.25
    private let kCellHeight:CGFloat = 50
    private let kHeaderHeight:CGFloat = 62
    private let kCollectionBottom:CGFloat = 20
    private let kInterItem:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCalculatorOptions
        
        let blur:VBlur = VBlur.dark()
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewBase:UIView = UIView()
        viewBase.backgroundColor = UIColor(white:0.95, alpha:1)
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCalculatorOptionsCell.self)
        collectionView.registerHeader(header:VCalculatorOptionsHeader.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
            flow.minimumInteritemSpacing = kInterItem
            flow.minimumLineSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:kInterItem,
                left:0,
                bottom:kCollectionBottom,
                right:0)
        }
        
        viewBase.addSubview(collectionView)
        addSubview(blur)
        addSubview(closeButton)
        addSubview(viewBase)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseHeight)
        layoutBaseBottom = NSLayoutConstraint.bottomToBottom(
            view:viewBase,
            toView:self,
            constant:kBaseHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:viewBase)
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
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCalculatorFunctions
    {
        let item:MCalculatorFunctions = controller.model.functions[index.item]
        
        return item
    }
    
    //MARK: public
    
    func viewAppeared()
    {
        layoutBaseBottom.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration,
        animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
            
            guard
            
                let functionList:[MCalculatorFunctions] = self?.controller.model.functions,
                let selectedFunction:MCalculatorFunctions = self?.controller.model.currentFunction
            
            else
            {
                return
            }
            
            var indexFunction:Int = 0
            
            for function:MCalculatorFunctions in functionList
            {
                if function === selectedFunction
                {
                    break
                }
                
                indexFunction += 1
            }
            
            let indexPath:IndexPath = IndexPath(
                item:indexFunction,
                section:0)
            self?.collectionView.selectItem(
                at:indexPath,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition.centeredVertically)
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
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
        let count:Int = controller.model.functions.count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let header:VCalculatorOptionsHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VCalculatorOptionsHeader.reusableIdentifier,
            for:indexPath) as! VCalculatorOptionsHeader
        header.config(controller:controller)
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCalculatorFunctions = modelAtIndex(index:indexPath)
        let cell:VCalculatorOptionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCalculatorOptionsCell.reusableIdentifier,
            for:indexPath) as! VCalculatorOptionsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        let item:MCalculatorFunctions = modelAtIndex(index:indexPath)
        controller.selectOption(item:item)
    }
}
