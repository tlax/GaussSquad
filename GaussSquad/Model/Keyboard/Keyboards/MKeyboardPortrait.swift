import Foundation

class MKeyboardPortrait:MKeyboard
{
    init()
    {
        let item0:MKeyboardRowItem0 = MKeyboardRowItem0()
        let item1:MKeyboardRowItem1 = MKeyboardRowItem1()
        let item2:MKeyboardRowItem2 = MKeyboardRowItem2()
        
        let itemsFirstRow:[MKeyboardRowItem] = [
            item0,
            item1,
            item2]
        let itemsSecondRow:[MKeyboardRowItem] = [
            item1]
        
        let firstRow:MKeyboardRow = MKeyboardRow(
            items:itemsFirstRow)
        let secondRow:MKeyboardRow = MKeyboardRow(
            items:itemsSecondRow)
        
        let rows:[MKeyboardRow] = [
            firstRow,
            secondRow]
        
        super.init(rows:rows)
    }
}
