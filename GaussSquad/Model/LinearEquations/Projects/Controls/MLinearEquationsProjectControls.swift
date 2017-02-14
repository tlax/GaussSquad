import Foundation

class MLinearEquationsProjectControls
{
    let items:[[MLinearEquationsProjectControlsItem]]
    
    init(project:MLinearEquationsProject)
    {
        var items:[[MLinearEquationsProjectControlsItem]] = []
        let countRows:Int = project.rows.count - 1
        
        for indexRow:Int in 0 ..< countRows
        {
            let row:MLinearEquationsProjectRow = project.rows[indexRow]
            var rowItems:[MLinearEquationsProjectControlsItem] = []
            
            if indexRow > 0
            {
                let itemMoveUp:MLinearEquationsProjectControlsItemMoveUp = MLinearEquationsProjectControlsItemMoveUp(
                    row:row)
                rowItems.append(itemMoveUp)
            }
            
            if indexRow < countRows - 1
            {
                let itemMoveDown:MLinearEquationsProjectControlsItemMoveDown = MLinearEquationsProjectControlsItemMoveDown(
                    row:row)
                rowItems.append(itemMoveDown)
            }
            
            let itemDelete:MLinearEquationsProjectControlsItemDelete = MLinearEquationsProjectControlsItemDelete(
                row:row)
            rowItems.append(itemDelete)
            
            items.append(rowItems)
        }
        
        self.items = items
    }
}
