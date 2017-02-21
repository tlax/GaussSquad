import UIKit

class MLinearEquationsSolutionBarItem
{
    let image:UIImage
    let active:Bool
    
    init(
        image:UIImage,
        active:Bool)
    {
        self.image = image
        self.active = active
    }
    
    //MARK: public
    
    func selected(controller:CLinearEquationsSolution)
    {
    }
}
