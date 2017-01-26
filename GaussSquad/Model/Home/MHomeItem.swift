import UIKit

class MHomeItem
{
    let symbol:String
    let title:String
    let image:UIImage
    
    init(
        symbol:String,
        title:String,
        image:UIImage)
    {
        self.symbol = symbol
        self.title = title
        self.image = image
    }
    
    //MARK: public
    
    func selected() -> CController?
    {
        return nil
    }
}
