pageextension 50011 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addbefore("Sell-to Phone No.")
        {
            field(dial; rec.dial)
            {
                ApplicationArea = all;
            }
        }
        
    }

    actions
    {
        addafter("&Order Confirmation")
        {
            action(Send)
            {
                Image = Calls;
                Caption = 'Send Message';
                ApplicationArea = All;

                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send Whatsapp message';

                trigger OnAction()
                var
                    Whatsapp: Codeunit whatsupp_conformation;
                    salesHeader: Record "Sales Header";
                    so: Code[50];
                    name: text[50];
                    CustNo: Text;
                    template: text;
                begin
                    salesHeader.SetRange("No.", rec."No.");
                    salesHeader.SetRange("Sell-to Customer No.", rec."Sell-to Customer No.");
                    if salesHeader.FindFirst() then begin
                        //CustNo := salesHeader."Sell-to Phone No.";
                        CustNo := salesHeader.Dial + salesHeader."Sell-to Phone No.";
                        Message('Dear' + SalesHeader."Sell-to Customer Name" + ' ,Your Order with us is Registerd as  ' + SalesHeader."No." + 'and we will deliver you of your promising date' + Format(SalesHeader."Promised Delivery Date"));
                        template := 'Dear' + SalesHeader."Sell-to Customer Name" + ' ,Your Order with us is Registerd as  ' + SalesHeader."No." + 'and we will deliver you of your promising date' + Format(SalesHeader."Promised Delivery Date");
                        Whatsapp.sendMessage(salesHeader, CustNo, template);

                    end;
                end;

            }
        }
    }





}