<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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

    <br />
        <br />
        <br />
    
        <div style="margin-left: auto; margin-right: auto; text-align: center;">

            <asp:Label ID="loginLbl" runat="server" Text="Login" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

            <br />
            <br />

            <asp:Label ID="usernameLbl" runat="server" Text="Username: " Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>
            <asp:TextBox ID="userTxt" runat="server" Width="200"></asp:TextBox>
            
            <br />

            <asp:Label ID="passLbl" runat="server" Text="Password: " Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>
            <asp:TextBox ID="passTxt" runat="server" Width="200" TextMode="Password"></asp:TextBox>

            <br />

            <asp:Label ID="invalidLoginLbl" runat="server" Text="Incorrect username/password" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText" ForeColor="Red" Visible="false"></asp:Label>

            <br />
            
            <asp:Button ID="loginButton" runat="server" Text="Login" OnClick="Login_Button_Click" />

            <asp:Button ID="registerButton" runat="server" Text="Register" OnClick="Register_Button_Click"  Style="margin-left:4%;"/>
            <asp:Button ID="changePassButton" runat="server" Text="Change Password" OnClick="Pass_Button_Click"  Style="margin-left:4%;"/>

            <br />
            <br />


        </div>
    </form>
</body>
</html>
