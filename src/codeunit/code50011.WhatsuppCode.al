/// <summary>
/// Codeunit whatsupp_conformation (ID 50011).
/// </summary>
codeunit 50011 whatsupp_conformation
{
    trigger OnRun()
    begin
        // GetRateForDate();

    end;

    /// <summary>
    /// GetRateForDate.
    /// </summary>
    procedure sendMessage(SalesHeader: Record "Sales Header"; phonenumber: text; template: text)
    var/// <param name="template">text.</param>
    
        //     var
        client: HttpClient;
        content: HttpContent;
        contentHeaders: HttpHeaders;
        response: HttpResponseMessage;
        request: HttpRequestMessage;
        token: Text;
        url: Text;
        payload: Text;
        custmer: Record Customer;

        phoneno: text;
        countryCode: code[10];
        OrderNo: code[30];
        message: text;


        Jsonvalue: JsonValue;
        JsonObject: JsonObject;

    begin
        salesHeader.SetRange("Document Type", salesHeader."Document Type");
        salesHeader.SetRange("No.", salesHeader."No.");
        if salesHeader.FindFirst() then begin
            phoneno := salesHeader.Dial + salesHeader."Sell-to Phone No.";
            Message(phoneno);
            message := 'Dear' + SalesHeader."Sell-to Customer Name" + ' ,Your Order with us is Registerd as  ' + SalesHeader."No." + 'and we will deliver you of your promising date' + Format(SalesHeader."Promised Delivery Date");
            // payload := '{"messaging_product": "whatsapp","to": "917309504382","type": "template","template": {"name": "order_send","language": {"code": "en"}}}';
            payload := '{' + '"messaging_product": "whatsapp",' + '"to":' + phoneno + ',"type":"template",' + '"template":{' + '"name":"order",' + '"language": {' + '"code": "en"' + '}' + '}' + '}';


            url := 'https://graph.facebook.com/v14.0/111315575050744/messages';
            token := 'EAAUWdLdIhO8BAFxVxeeGWHmmE9aX14LZC3HLtVexS83Ke0pBkMuLf69ZApFMYynPb4UD1Yfkfy0nepBY6kD9SDVZBYhJsCJhFoABBICZB2tHS5ZBk7LD7FKzR69OOGZAYXcAbyGdhyoNEXmgzJpXIARJi54fhAinCAwpsrQJKrBCQf5DlsRZCXE56Q8FS0aSrymZCPLQnfdAbgZDZD';

            content.WriteFrom(payload);

            content.GetHeaders(contentHeaders);
            contentHeaders.Clear();

            contentHeaders.Add('Content-Type', 'application/json');
            request.GetHeaders(contentHeaders);
            contentHeaders.Add('Authorization', StrSubstNo('Bearer %1', Token));
            contentHeaders.Add('Accept', 'application/xml');

            request.Content := content;

            request.SetRequestUri(Url);
            request.Method := 'POST';

            if client.Send(request, response) then begin


                if Response.IsSuccessStatusCode() then
                    Message('message %1', Response.HttpStatusCode)
                else
                    Message('message not send %1,', Response.HttpStatusCode);
            end;
        end;
    end;
}