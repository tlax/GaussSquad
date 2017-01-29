import Foundation

class MLinearEquations
{
    private weak var controller:CLinearEquations?
    
    init(controller:CLinearEquations)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadFromDb()
        }
    }
    
    //MARK: private
    
    private func loadFromDb()
    {
        
    }
    
    private func finishLoading()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.modelLoaded()
        }
    }
}
