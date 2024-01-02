namespace FinnPedersenFrance.App.BasicSubscriptionManagement;

using Microsoft.Sales.Document;

tableextension 50141 "Subscription Sales Line" extends "Sales Line"
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
            Caption = 'Subscription Periodicity';
            trigger OnValidate()
            var
                DateFormulaErr: TextConst ENU = 'The Date Formula %1 will not calculate a date in the future. Please enter a correct Date Formula.';
            begin
                if not (CalcDate("Subscription Periodicity", WorkDate()) > WorkDate()) then
                    Error(DateFormulaErr, "Subscription Periodicity");
            end;
        }
        field(50002; OrderNumber; Code[20])
        {
            Caption = 'OrderNumber';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
