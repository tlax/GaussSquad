import UIKit

class VKeyboard:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var textView:UITextView?
    private let model:MKeyboard
    private let keyboardHeight:CGFloat
    private let kBorderHeight:CGFloat = 1
    private let kRowHeight:CGFloat = 30
    
    init(textView:UITextView)
    {
        let screenSize:CGSize = UIScreen.main.bounds.size
        let width:CGFloat = screenSize.width
        let height:CGFloat = screenSize.height
        
        if height >= width
        {
            model = MKeyboardPortrait()
        }
        else
        {
            model = MKeyboardLandscape()
        }
        
        keyboardHeight = CGFloat(model.rows.count) * kRowHeight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        self.textView = textView
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
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
    
    //MARK: collectionView delegate
    
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
        let cell:VKeyboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VKeyboardCell.reusableIdentifier,
            for:indexPath) as! VKeyboardCell
        
        return cell
    }
}
