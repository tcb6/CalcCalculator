using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forum : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            helloLbl.Text = "Hello " + Session["user"];
            helloLbl.Visible = true;
            signInLink.InnerHtml = "Sign Out";
        }
    }

    protected void Derivative_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("DerivativeThreads.aspx", true);
    }

    protected void Integral_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("IntegralThreads.aspx", true);
    }

    protected void Limit_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("LimitThreads.aspx", true);
    }

    protected void Miscellaneous_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("MiscellaneousThreads.aspx", true);
    }
}