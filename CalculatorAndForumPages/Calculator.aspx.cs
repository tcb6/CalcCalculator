using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class Calculator : System.Web.UI.Page
{
    // Connection string for RDS instance.
    // Actual information for DB omitted for security reasons.
    MySqlConnection sqlConn = new MySqlConnection("Server=**************************************************;" +
                                                                                                  "Port=3306;" +
                                                                                                  "Database=*******;" +
                                                                                                  "Uid=*****;" +
                                                                                                  "Pwd=**********;");


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            helloLbl.Text = "Hello " + Session["user"];
            helloLbl.Visible = true;
            signInLink.InnerHtml = "Sign Out";
            postLbl.Visible = true;
            postLbl.Text = "Would you like to post a question to the forums?";
            topicLbl.Visible = true;
            topicList.Visible = true;
            newTitleLbl.Visible = true;
            forumTitleTxt.Visible = true;
            messageLbl.Visible = true;
            forumPostTxt.Visible = true;
            postButton.Visible = true;
        }
    }

    protected void postButton_Click(object sender, EventArgs e)
    {
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        cmd.Connection = sqlConn;

        // Prepare parameterized statement.
        cmd.CommandText = "INSERT INTO posts (forum_board, post_title, post_message, is_start_of_thread, user_id) VALUES (@board, @title, @message, " + 0 +
            ", " + Session["userID"] + ")";

        cmd.Parameters.Clear();
        cmd.Parameters.AddWithValue("@board", topicList.SelectedValue);
        cmd.Parameters.AddWithValue("@message", forumPostTxt.Text);
        cmd.Parameters.AddWithValue("@title", forumTitleTxt.Text);


        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        if (topicList.SelectedValue == "1")
            Response.Redirect("DerivativeThreads.aspx", true);
        else if (topicList.SelectedValue == "2")
            Response.Redirect("IntegralThreads.aspx", true);
        else
            Response.Redirect("LimitThreads.aspx", true);
    }
}