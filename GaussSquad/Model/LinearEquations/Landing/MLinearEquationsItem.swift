import Foundation

class MLinearEquationsItem
{
    let descr:NSAttributedString
    let age:String
    private(set) weak var project:DProject!
    
    init(project:DProject)
    {
        self.project = project
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        
        
        
        descr = mutableString
        age = "2 hours"
    }
}
