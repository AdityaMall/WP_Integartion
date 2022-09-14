pageextension 50012 MyExtension extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here
        modify(Name)
        {
            Editable = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}