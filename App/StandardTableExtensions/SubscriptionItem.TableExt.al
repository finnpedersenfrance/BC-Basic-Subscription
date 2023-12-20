namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Inventory.Item;

tableextension 50140 "Subscription Item" extends Item
{
    fields
    {
        field(50000; "Subscription Type"; Enum "Subscription Enum")
        {
            Caption = 'Subscription Type';

            trigger OnValidate()
            begin
                if "Subscription Type" = "Subscription Type"::" " then
                    Clear("Subscription Periodicity");
            end;
        }

        field(50001; "Subscription Periodicity"; DateFormula)
        {
            trigger OnValidate()
            var
                DateFormulaErr: TextConst ENU = 'The Date Formula %1 will not calculate a date in the future. Please enter a correct Date Formula.';
            begin
                if not (CalcDate("Subscription Periodicity", WorkDate()) > WorkDate()) then
                    Error(DateFormulaErr, "Subscription Periodicity");
            end;
        }

    }
}
