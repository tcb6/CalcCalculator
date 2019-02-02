<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forum.aspx.cs" Inherits="Forum" %>

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
        
        <asp:Label ID="forumLbl" runat="server" Text="Forums" Font-Bold="True" Font-Size="52px"></asp:Label>

        <br />

        <asp:Label ID="subjectLbl" runat="server" Text="Please Choose a Subject" Font-Bold="True" Font-Size="32px"></asp:Label>

        <br />
        <br />
        <br />

        <div style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;">
            <br />
                <asp:Button runat="server" Text="Derivatives" Font-Bold="True" Font-Size="32px" ForeColor="White" Font-Underline="True" BackColor="Navy" OnClick="Derivative_Button_Click" UseSubmitBehavior="false"/>
            <br />
            <br />
        </div>
        
        <br />

        <div style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;">
            <br />
                <asp:Button runat="server" Text="Antiderivatives" Font-Bold="True" Font-Size="32px" ForeColor="White" Font-Underline="True" BackColor="Navy" OnClick="Integral_Button_Click" UseSubmitBehavior="false"/>
            <br />
            <br />
        </div>
        
        <br />

        <div style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;">
            <br />
                <asp:Button runat="server" Text="Limits" Font-Bold="True" Font-Size="32px" ForeColor="White" Font-Underline="True" BackColor="Navy" OnClick="Limit_Button_Click" UseSubmitBehavior="false"/>
            <br />
            <br />
        </div>
        
        <br />

        <div style="background-color:navy; margin-left: auto; margin-right: auto; text-align: center;">
            <br />
                <asp:Button runat="server" Text="Miscellaneous" Font-Bold="True" Font-Size="32px" ForeColor="White" Font-Underline="True" BackColor="Navy" OnClick="Miscellaneous_Button_Click" UseSubmitBehavior="false"/>
            <br />
            <br />
        </div>

    </div>
    </form>
</body>
</html>
