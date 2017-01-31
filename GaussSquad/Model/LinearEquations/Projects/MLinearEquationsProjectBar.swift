import Foundation

class MLinearEquationsProjectBar
{
    let items:[MLinearEquationsProjectBarItem]
    
    init(project:DProject)
    {
        let itemBack:MLinearEquationsProjectBarItemButtonBack = MLinearEquationsProjectBarItemButtonBack()
        let itemOptions:MLinearEquationsProjectBarItemButtonOptions = MLinearEquationsProjectBarItemButtonOptions()
        let itemRows:MLinearEquationsProjectBarItemReportRows = MLinearEquationsProjectBarItemReportRows()
        let itemIndeterminates:MLinearEquationsProjectBarItemReportIndeterminates = MLinearEquationsProjectBarItemReportIndeterminates()
        
        items = [
            itemBack,
            itemOptions,
            itemRows,
            itemIndeterminates]
    }
}
