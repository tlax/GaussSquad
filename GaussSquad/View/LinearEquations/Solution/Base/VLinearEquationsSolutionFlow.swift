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
    private let kCellHeight:CGFloat = 30
    private let kFooterHeight:CGFloat = 20
    
    init(
        model:MLinearEquationsSolution,
        barHeight:CGFloat)
    {
        self.model = model
        self.barHeight = barHeight
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
            print("shit")
            
            return
        }
        
        headerLayoutAttributes = []
        footerLayoutAttributes = []
        cellLayoutAttributes = []
        
        let collectionWidth:CGFloat = collectionView.bounds.maxX
        let collectionHeight:CGFloat = collectionView.bounds.maxY
        var maxPositionX:CGFloat = max(collectionWidth, collectionHeight)
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
            
            for equation:MLinearEquationsSolutionEquation in step.equations
            {
                var index:Int = 0
                var positionX:CGFloat = 0
                var equationItems:[MLinearEquationsSolutionEquationItem] = []
                equationItems.append(contentsOf:equation.items)
                equationItems.append(equation.equals)
                equationItems.append(equation.result)
                
                for item:MLinearEquationsSolutionEquationItem in equationItems
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
            
            let footerAttribute:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
                with:sectionIndexPath)
            footerAttribute.frame = CGRect(
                x:0,
                y:positionY,
                width:0,
                height:kFooterHeight)
            footerLayoutAttributes.append(footerAttribute)
            
            positionY += headerHeight
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
