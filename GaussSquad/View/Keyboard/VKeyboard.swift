import UIKit

class VKeyboard:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let model:MKeyboard
    private weak var textView:UITextView?
    private weak var collectionView:VCollection!
    private let keyboardHeight:CGFloat
    private let kRowHeight:CGFloat = 42
    private let kInterLine:CGFloat = 1
    private let kDeselectTime:TimeInterval = 0.07
    
    init(
        textView:UITextView,
        states:[MKeyboardState]?)
    {
        let screenSize:CGSize = UIScreen.main.bounds.size
        let width:CGFloat = screenSize.width
        let height:CGFloat = screenSize.height
        
        if height >= width
        {
            model = MKeyboardPortrait(states:states)
        }
        else
        {
            model = MKeyboardLandscape(states:states)
        }
        
        let countRows:CGFloat = CGFloat(model.rows.count)
        let interLines:CGFloat = kInterLine * (countRows + 1)
        let rowsHeight:CGFloat = kRowHeight * countRows
        keyboardHeight = interLines + rowsHeight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0.94, alpha:1)
        self.textView = textView
        
        let collectionView:VCollection = VCollection()
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VKeyboardCell.self)
        self.collectionView = collectionView
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            let cols:CGFloat = CGFloat(model.cols)
            let colsLines:CGFloat = (cols + 1) * kInterLine
            let usableWidth:CGFloat = width - colsLines
            let cellWidth:CGFloat = usableWidth / cols
            let cellSize:CGSize = CGSize(width:cellWidth, height:kRowHeight)
            flow.itemSize = cellSize
            flow.minimumInteritemSpacing = kInterLine
            flow.minimumLineSpacing = kInterLine
        }
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        if textView.text.isEmpty
        {
            let startingText:String = model.lastString()
            textView.insertText(startingText)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var intrinsicContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(
                width:UIViewNoIntrinsicMetric,
                height:keyboardHeight)
            
            return size
        }
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MKeyboardRowItem
    {
        let item:MKeyboardRowItem = model.rows[index.section].items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let bottom:CGFloat
        
        if section == model.rows.count - 1
        {
            bottom = kInterLine
        }
        else
        {
            bottom = 0
        }
        
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kInterLine,
            left:kInterLine,
            bottom:bottom,
            right:kInterLine)
        
        return insets
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int = model.rows.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.rows[section].items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MKeyboardRowItem = modelAtIndex(index:indexPath)
        let cell:VKeyboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VKeyboardCell.reusableIdentifier,
            for:indexPath) as! VKeyboardCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        guard
            
            let textView:UITextView = self.textView
        
        else
        {
            return
        }
        
        let item:MKeyboardRowItem = modelAtIndex(index:indexPath)
        item.selected(
            model:model,
            view:textView)
        
        collectionView.selectItem(
            at:nil,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition())
    }
}
