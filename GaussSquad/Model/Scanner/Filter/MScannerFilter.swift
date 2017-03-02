import Foundation
import MetalKit

class MScannerFilter
{
    private let items:[MScannerFilterItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func filter(device:MTLDevice, image:UIImage) -> UIImage?
    {
        return nil
    }
}
