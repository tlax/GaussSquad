import UIKit

class MScannerMenuItem
{
    let image:UIImage
    let title:String
    
    init(image:UIImage, title:String)
    {
        self.image = image
        self.title = title
    }
    
    //MARK: public
    
    func selected(controller:CScannerOCR)
    {
    }
}
