import UIKit

class VLinearEquationsProjectFlow:UICollectionViewFlowLayout
{
    private weak var model:MLinearEquationsProject!
    private var layoutAttributes:[UICollectionViewLayoutAttributes]?
    private var contentWidth:CGFloat
    private var contentHeight:CGFloat
    
    init(model:MLinearEquationsProject)
    {
        self.model = model
        contentWidth = 0
        contentHeight = 0
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func prepare()
    {
        super.prepare()
        
        if layoutAttributes == nil
        {
            print("shit")
            layoutAttributes = []
        }
    }
    
    override func invalidateLayout()
    {
        super.invalidateLayout()
//        layoutAttributes = nil
    }
}
