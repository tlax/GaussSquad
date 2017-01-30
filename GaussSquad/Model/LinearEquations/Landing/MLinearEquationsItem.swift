import Foundation

class MLinearEquationsItem
{
    let name:String
    private(set) weak var project:DProject!
    
    init(project:DProject)
    {
        self.project = project
        name = "hello word"
    }
}
