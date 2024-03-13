namespace FinnPedersenFrance.BasicSubscriptionManagement;

enum 50140 "Subscription Enum"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Recurring)
    {
        Caption = 'Recurring';
    }
    value(2; Stop)
    {
        Caption = 'Stop';
    }
}
