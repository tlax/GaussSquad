import Foundation

class MKeyboardPortrait:MKeyboard
{
    init()
    {
        let item0:MKeyboardRowItem0 = MKeyboardRowItem0()
        let item1:MKeyboardRowItem1 = MKeyboardRowItem1()
        let item2:MKeyboardRowItem2 = MKeyboardRowItem2()
        let item3:MKeyboardRowItem3 = MKeyboardRowItem3()
        let item4:MKeyboardRowItem4 = MKeyboardRowItem4()
        let item5:MKeyboardRowItem5 = MKeyboardRowItem5()
        let item6:MKeyboardRowItem6 = MKeyboardRowItem6()
        let item7:MKeyboardRowItem7 = MKeyboardRowItem7()
        let item8:MKeyboardRowItem8 = MKeyboardRowItem8()
        let item9:MKeyboardRowItem9 = MKeyboardRowItem9()
        
        let itemDot:MKeyboardRowItemDot = MKeyboardRowItemDot()
        let itemSign:MKeyboardRowItemSign = MKeyboardRowItemSign()
        let itemClear:MKeyboardRowItemClear = MKeyboardRowItemClear()
        let itemBackspace:MKeyboardRowItemBackspace = MKeyboardRowItemBackspace()
        let itemPercent:MKeyboardRowItemPercent = MKeyboardRowItemPercent()
        
        let itemsFirstRow:[MKeyboardRowItem] = [
            itemClear,
            itemBackspace,
            itemSign]
        let itemsSecondRow:[MKeyboardRowItem] = [
            item7,
            item8,
            item9]
        let itemsThirdRow:[MKeyboardRowItem] = [
            item4,
            item5,
            item6]
        let itemsFourthRow:[MKeyboardRowItem] = [
            item1,
            item2,
            item3]
        let itemsFifthRow:[MKeyboardRowItem] = [
            item0,
            itemDot,
            itemPercent]
        
        let firstRow:MKeyboardRow = MKeyboardRow(
            items:itemsFirstRow)
        let secondRow:MKeyboardRow = MKeyboardRow(
            items:itemsSecondRow)
        let thirdRow:MKeyboardRow = MKeyboardRow(
            items:itemsThirdRow)
        let fourthRow:MKeyboardRow = MKeyboardRow(
            items:itemsFourthRow)
        let fifthRow:MKeyboardRow = MKeyboardRow(
            items:itemsFifthRow)
        
        let rows:[MKeyboardRow] = [
            firstRow,
            secondRow,
            thirdRow,
            fourthRow,
            fifthRow]
        
        super.init(rows:rows)
    }
}
