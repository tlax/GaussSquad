import UIKit

class VLinearEquationsProjectFlow:UICollectionViewFlowLayout
{
    private weak var model:MLinearEquationsProject!
    private var layoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let kCellHeight:CGFloat = 80
    
    init(model:MLinearEquationsProject)
    {
        self.model = model
        contentWidth = 0
        contentHeight = 0
        layoutAttributes = []
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func prepare()
    {
        super.prepare()
        
        layoutAttributes = []
        
        var section:Int = 0
        var maxPositionX:CGFloat = 0
        var positionY:CGFloat = 0
        
        for row:MLinearEquationsProjectRow in model.rows
        {
            var item:Int = 0
            var positionX:CGFloat = 0
            
            for col:MLinearEquationsProjectRowItem in row.items
            {
                let indexPath:IndexPath = IndexPath(
                    item:item,
                    section:section)
                let colWidth:CGFloat = col.cellWidth
                let frame:CGRect = CGRect(
                    x:positionX,
                    y:positionY,
                    width:colWidth,
                    height:kCellHeight)
                
                item += 1
                positionX += colWidth
                
                guard
                    
                    let attributes:UICollectionViewLayoutAttributes = layoutAttributesForItem(
                        at:indexPath)
                
                else
                {
                    continue
                }
                
                attributes.frame = frame
            }
            
            if positionX > maxPositionX
            {
                maxPositionX = positionX
            }
            
            section += 1
            positionY += kCellHeight
        }
        
        contentWidth = maxPositionX
        contentHeight = positionY
    }
    
    override var collectionViewContentSize:CGSize
    {
        get
        {
            let size:CGSize = CGSize(
                width:contentWidth,
                height:contentHeight)
            
            return size
        }
    }
    
    override func layoutAttributesForElements(in rect:CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var attributes:[UICollectionViewLayoutAttributes]?
        
        for layoutAttribute:UICollectionViewLayoutAttributes in layoutAttributes
        {
            let frame:CGRect = layoutAttribute.frame
            
            if frame.intersects(rect)
            {
                if attributes == nil
                {
                    attributes = []
                }
                
                attributes!.append(layoutAttribute)
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds:CGRect) -> Bool
    {
        return false
    }
}
