<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MiscellaneousReply.aspx.cs" Inherits="MiscellaneousReply" validateRequest="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Label ID="helloLbl" runat="server" Text="Hello" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText" Visible="false" style="padding-left:100px"></asp:Label>

        <br />

        <div><nav style="text-align: center; height:75px;">
            <ul style="text-align: center; height:35px; background-color:navy;"> <!-- Horizontally -->
                <li style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;
                        list-style-type: none; display:inline; width:20%; padding-left: 8%; padding-right: 8%; height:50px;">
                    <a href="Calculator.aspx" style="
                        text-decoration: none;
                        font-size: 24px;
                        color: white;
                        top: 10px; height:50px;">Calculator</a></li>

                <li  style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;
                        list-style-type: none; display:inline; width:20%; padding-left: 8%; padding-right: 8%; height:50px;">
                    <a href="Forum.aspx" style="
                        text-decoration: none;
                        font-size: 24px;
                        color: white;
                        top: 10px;">Forums</a></li>

                <li style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;
                        list-style-type: none; display:inline; width:20%; padding-left: 8%; padding-right: 8%; height:50px;">
                    <a href="help.aspx" style="
                        text-decoration: none;
                        font-size: 24px;
                        color: white;
                        top: 10px;">Help</a></li>

                <li style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;
                        list-style-type: none; display:inline; width:20%; padding-left: 8%; padding-right: 8%; height:50px;">
                    <a class="contact" href="Default.aspx" style="
                        text-decoration: none;
                        font-size: 24px;
                        color: white;
                        top: 10px;" id="signInLink" runat="server">Sign In</a></li>
            </ul>
    </nav></div>

    <div>
    
        <%--
            Building a placeholder for what forums should look like.

            Placeholder object at bottom will be container which database will use to generate forum entries.

            More pages need to be added, such as handling replies or entries under different subjects, but that should be handled as
            the database is created so as not to waste too much time back-tracking on work already completed.
        --%>

        <asp:Label ID="forumLbl" runat="server" Text="Forums" Font-Bold="True" Font-Size="52px"></asp:Label>

        <br />

        <asp:Label ID="subjectLbl" runat="server" Text="Miscellaneous" Font-Bold="True" Font-Size="32px"></asp:Label>

        <br />
        <br />

        <asp:Label Visible="false" ID="titleLbl" style="position:fixed" runat="server" Font-Size="32px"> Title:</asp:Label>
        <asp:Label Visible="false" ID="posterLbl" style="position:fixed; margin-top:40px;" runat="server"> User:</asp:Label>
        <asp:Label Visible="false" ID="postTxt" style="margin-top:80px; position:fixed" runat="server"> Post:</asp:Label>
        <asp:Button Visible="false" ID="deleteButton" style="margin-top:150px; width:50%" runat="server" Text="Delete" UseSubmitBehavior="false"></asp:Button>

        <asp:PlaceHolder runat="server" ID="forumsPlaceholder" />
        <br />

        <asp:Label ID="CreateYourOwnReplyLbl" style="margin-top:80px;" runat="server">Write a Reply:</asp:Label>
        <br />
        <asp:TextBox ID="forumCommentTxt" runat="server" Height="200px" Width="100%"  TextMode="MultiLine"></asp:TextBox>
        <br />
        <asp:Button ID="postButton" runat="server" Text="Post" OnClick="postButton_Click" UseSubmitBehavior="false"></asp:Button>
    </div>
    </form>
</body>
</html>
