/// <summary>
/// TableExtension Phone No. Dial (ID 50010) extends Record Country/Region.
/// </summary>
tableextension 50011 "Dial" extends "Sales Header"
{
    fields
    {
        field(50000; "Dial"; Code[10])
        {
            Caption = 'Dial';
            DataClassification = SystemMetadata;
            //  TableRelation = "Country/Region".Dial;

            trigger OnValidate()
            var
                C: Text[1];
                i: Integer;
                DialErr: Label 'Only allowed numbers and -';
            begin
                for i := 1 to StrLen("Dial") do begin
                    C := CopyStr("Dial", i, 1);
                    if not (C in ['-', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
                        Error(DialErr);
                end;
            end;
        }
    }
}