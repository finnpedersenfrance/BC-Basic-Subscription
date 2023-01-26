TableExtension 50140 "FPFr Subscription Item" extends Item
{
    fields
    {
        field(50000; "Subscription Type"; Enum "FPFr Subscription Enum")
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
                DateFormularZero: DateFormula;
                DateFormulaErr: TextConst ENU = 'The Date Formula %1 will not calculate a date in the future. Please enter a correct Date Formula.';
            begin
                if not (CalcDate("Subscription Periodicity", WorkDate()) > WorkDate()) then
                    Error(DateFormulaErr, "Subscription Periodicity");
            end;
        }

    }
}
