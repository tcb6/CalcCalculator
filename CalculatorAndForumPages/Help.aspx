<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Help.aspx.cs" Inherits="Help" %>

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

        <asp:Label ID="helpLbl" runat="server" Text="Help" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />
        <br />


    <div style="margin-left:5% ">

        <asp:Label ID="welcomeLbl" runat="server" Text="Welcome to my calculator!" Font-Bold="true" Font-Size="Large"></asp:Label>
        
        <br />
        <br />

        <asp:Label ID="calculatorHead" runat="server" Text="Calculator" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl1" runat="server" Text="The navigation bar above will take you to anywhere you will want to go on my website." Font-Bold="true" Font-Size="Large"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl2" runat="server" Text="The calculator tab will allow you use our calculus calculator. My calculator currently supports derivatives, antiderivatives, and limits." Font-Bold="true" Font-Size="Large"></asp:Label>
    
        <br />
        <br />

        <asp:Label ID="instructionLbl3" runat="server" Text="My calculator also utilizes a project called LaTeX (pronounced Lay-tech) which provides an interface to format mathematical and scientific equations.
            More information on the project may be found " Font-Bold="true" Font-Size="Large"></asp:Label><a href="https://www.latex-project.org/"> here.</a>

        <br />
        <br />
        <br />

        <asp:Label ID="forumHead" runat="server" Text="Forum" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl4" runat="server" Text="The forum tab will allow you to visit our forums. We have boards for derivatives, antiderivatives, limits, and miscellaneous." Font-Bold="true" Font-Size="Large"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl5" runat="server" Text="In order to post to the forums, you will need to create a username and password and sign in to the website. If you are signed in while using the calculator,
            there will be an option to post right to one of the boards from the calculator." Font-Bold="true" Font-Size="Large"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl6" runat="server" Text="Signing in also provides the ability to reply to threads and delete your own content, so sign in and join the discussion!" Font-Bold="true" Font-Size="Large"></asp:Label>
    
        <br />
        <br />
        <br />

        <asp:Label ID="signInHead" runat="server" Text="Sign In" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl7" runat="server" Text="Using the Sign In tab allows you to sign in with a username and password if you have one for the website. If not,
            you can register with us from that same tab as well as change a password." Font-Bold="true" Font-Size="Large"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl8" runat="server" Text="Registering a username on this site requires nothing more than a username and a password. However, the password must
             be between 8 and 16 characters and contain at least one lowercase letter, one uppercase letter, and a number." Font-Bold="true" Font-Size="Large"></asp:Label>

        <br />
        <br />

        <asp:Label ID="instructionLbl9" runat="server" Text="Upon signing in, your username will be displayed in the upper-left portion on all pages of the website. To sign out,
             simply click Sign Out where the Sign In tab used to be." Font-Bold="true" Font-Size="Large"></asp:Label>
    
    </div>

        <br />
        <br />
        <br />
        <br />

    </form>

    
    <div style="margin-left: auto; margin-right: auto; text-align: center;">

        <asp:Label ID="contactLbl" runat="server" Text="I hope you enjoy using my website! If you have any questions, please email me at tcb6@pct.edu." Font-Bold="true" Font-Size="Large"></asp:Label>

        </div>

</body>
</html>
