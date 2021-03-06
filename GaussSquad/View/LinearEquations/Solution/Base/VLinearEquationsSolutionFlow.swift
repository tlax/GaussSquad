import UIKit

class VLinearEquationsSolutionFlow:UICollectionViewLayout
{
    private weak var model:MLinearEquationsSolution!
    private var headerLayoutAttributes:[UICollectionViewLayoutAttributes]
    private var footerLayoutAttributes:[UICollectionViewLayoutAttributes]
    private var cellLayoutAttributes:[UICollectionViewLayoutAttributes]
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    private let barHeight:CGFloat
    private let footerHeight:CGFloat
    private let cellHeight:CGFloat
    private let kMarginRight:CGFloat = 20
    
    init(
        model:MLinearEquationsSolution,
        barHeight:CGFloat,
        footerHeight:CGFloat,
        cellHeight:CGFloat)
    {
        self.model = model
        self.barHeight = barHeight
        self.footerHeight = footerHeight
        self.cellHeight = cellHeight
        contentWidth = 0
        contentHeight = 0
        headerLayoutAttributes = []
        footerLayoutAttributes = []
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
        
        guard
            
            let collectionView:UICollectionView = self.collectionView
        
        else
        {
            return
        }
        
        headerLayoutAttributes = []
        footerLayoutAttributes = []
        cellLayoutAttributes = []
        
        let collectionWidth:CGFloat = collectionView.bounds.maxX
        let collectionHeight:CGFloat = collectionView.bounds.maxY
        var maxPositionX:CGFloat = min(collectionWidth, collectionHeight)
        var section:Int = 0
        var positionY:CGFloat = barHeight
        
        for step:MLinearEquationsSolutionStep in model.steps
        {
            let headerHeight:CGFloat = step.headerHeight
            let sectionIndexPath:IndexPath = IndexPath(
                item:0,
                section:section)

            let headerAttribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
                with:sectionIndexPath)
            headerAttribute.frame = CGRect(
                x:0,
                y:positionY,
                width:0,
                height:headerHeight)
            headerLayoutAttributes.append(headerAttribute)
            
            positionY += headerHeight
            var index:Int = 0
            
            for equation:MLinearEquationsSolutionEquation in step.equations
            {
                var positionX:CGFloat = 0
                
                for item:MLinearEquationsSolutionEquationItem in equation.plainItems
                {
                    let indexPath:IndexPath = IndexPath(
                        item:index,
                        section:section)
                    let cellWidth:CGFloat = item.cellWidth
                    let frame:CGRect = CGRect(
                        x:positionX,
                        y:positionY,
                        width:cellWidth,
                        height:cellHeight)
                    
                    index += 1
                    positionX += cellWidth
                    
                    let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                        forCellWith:indexPath)
                    attributes.frame = frame
                    cellLayoutAttributes.append(attributes)
                }
                
                let positionMargin:CGFloat = positionX + kMarginRight
                
                if positionMargin > maxPositionX
                {
                    maxPositionX = positionMargin
                }
                
                positionY += cellHeight
            }
            
            let footerAttribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
                with:sectionIndexPath)
            footerAttribute.frame = CGRect(
                x:0,
                y:positionY,
                width:0,
                height:footerHeight)
            footerLayoutAttributes.append(footerAttribute)
            
            positionY += footerHeight
            section += 1
        }
        
        contentWidth = maxPositionX
        contentHeight = positionY
        
        var listReusables:[UICollectionViewLayoutAttributes] = []
        listReusables.append(contentsOf:headerLayoutAttributes)
        listReusables.append(contentsOf:footerLayoutAttributes)
        
        for attributesReusable:UICollectionViewLayoutAttributes in listReusables
        {
            let origin:CGPoint = attributesReusable.frame.origin
            let height:CGFloat = attributesReusable.frame.size.height
            let newSize:CGSize = CGSize(width:contentWidth, height:height)
            let newFrame:CGRect = CGRect(origin:origin, size:newSize)
            
            attributesReusable.frame = newFrame
        }
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
        allAttributes.append(contentsOf:footerLayoutAttributes)
        
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
        let listAttributes:[UICollectionViewLayoutAttributes]
        
        if elementKind == UICollectionElementKindSectionHeader
        {
            listAttributes = headerLayoutAttributes
        }
        else
        {
            listAttributes = footerLayoutAttributes
        }
        
        for layoutAttribute:UICollectionViewLayoutAttributes in listAttributes
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
