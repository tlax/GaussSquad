import UIKit

class VLinearEquationsSolutionFlow:UICollectionViewLayout
{
    private weak var model:MLinearEquationsSolution!
    private var headerLayoutAttributes:[UICollectionViewLayoutAttributes]
    private var cellLayoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let barHeight:CGFloat
    private let kCellHeight:CGFloat = 30
    
    init(
        model:MLinearEquationsSolution,
        barHeight:CGFloat)
    {
        self.model = model
        self.barHeight = barHeight
        contentWidth = 0
        contentHeight = 0
        headerLayoutAttributes = []
        cellLayoutAttributes = []
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func prepare()
    {
        super.prepare()
        
        headerLayoutAttributes = []
        cellLayoutAttributes = []
        
        var section:Int = 0
        var maxPositionX:CGFloat = 0
        var positionY:CGFloat = barHeight
        
        for step:MLinearEquationsSolutionStep in model.steps
        {
            let headerHeight:CGFloat = step.headerHeight
            let headerIndexPath:IndexPath = IndexPath(
                item:0,
                section:section)

            let headerAttribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
                with:headerIndexPath)
            headerAttribute.frame = CGRect(
                x:0,
                y:positionY,
                width:0,
                height:headerHeight)
            headerLayoutAttributes.append(headerAttribute)
            
            positionY += headerHeight
            
            for equation:MLinearEquationsSolutionEquation in step.equations
            {
                var index:Int = 0
                var positionX:CGFloat = 0
                
                for item:MLinearEquationsSolutionEquationItem in equation.items
                {
                    let indexPath:IndexPath = IndexPath(
                        item:index,
                        section:section)
                    let cellWidth:CGFloat = item.cellWidth
                    let frame:CGRect = CGRect(
                        x:positionX,
                        y:positionY,
                        width:cellWidth,
                        height:kCellHeight)
                    
                    index += 1
                    positionX += cellWidth
                    
                    let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                        forCellWith:indexPath)
                    attributes.frame = frame
                    cellLayoutAttributes.append(attributes)
                }
                
                if positionX > maxPositionX
                {
                    maxPositionX = positionX
                }
                
                positionY += kCellHeight
            }
            
            section += 1
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
        var allAttributes:[UICollectionViewLayoutAttributes] = []
        allAttributes.append(contentsOf:cellLayoutAttributes)
        allAttributes.append(contentsOf:headerLayoutAttributes)
        
        for layoutAttribute:UICollectionViewLayoutAttributes in allAttributes
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
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind:String, at indexPath:IndexPath) -> UICollectionViewLayoutAttributes?
    {
        for layoutAttribute:UICollectionViewLayoutAttributes in headerLayoutAttributes
        {
            if layoutAttribute.indexPath.section == indexPath.section
            {
                return layoutAttribute
            }
        }
        
        return nil
    }
    
    override func layoutAttributesForItem(at indexPath:IndexPath) -> UICollectionViewLayoutAttributes?
    {
        for layoutAttribute:UICollectionViewLayoutAttributes in cellLayoutAttributes
        {
            if layoutAttribute.indexPath == indexPath
            {
                return layoutAttribute
            }
        }
        
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds:CGRect) -> Bool
    {
        return false
    }
}
