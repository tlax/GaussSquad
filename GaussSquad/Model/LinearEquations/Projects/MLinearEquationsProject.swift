import Foundation

class MLinearEquationsProject
{
    var rows:[MLinearEquationsProjectRow]
    private weak var controller:CLinearEquationsProject?
    private var project:DProject?
    
    init(project:DProject?)
    {
        rows = []
        self.project = project
    }
    
    //MARK: private
    
    private func loadFinished()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.modelLoaded()
        }
    }
    
    //MARK: public
    
    func load(controller:CLinearEquationsProject)
    {
        self.controller = controller
    }
}
