import UIKit

class VScannerCropperMover:UIView
{
    var deltaTop:CGFloat?
    var deltaBottom:CGFloat?
    var deltaLeft:CGFloat?
    var deltaRight:CGFloat?
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func start(
        deltaTop:CGFloat,
        deltaBottom:CGFloat,
        deltaLeft:CGFloat,
        deltaRight:CGFloat)
    {
        self.deltaTop = deltaTop
        self.deltaBottom = deltaBottom
        self.deltaLeft = deltaLeft
        self.deltaRight = deltaRight
    }
    
    func clear()
    {
        deltaTop = nil
        deltaBottom = nil
        deltaLeft = nil
        deltaRight = nil
    }
}
