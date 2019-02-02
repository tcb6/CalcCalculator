using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class DerivativeReply : System.Web.UI.Page
{
    // Connection string for RDS instance.
    // Actual information for DB omitted for security reasons.
    MySqlConnection sqlConn = new MySqlConnection("Server=**************************************************;" +
                                                                                                  "Port=3306;" +
                                                                                                  "Database=*******;" +
                                                                                                  "Uid=*****;" +
                                                                                                  "Pwd=**********;");


    System.Int64 idTracker = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        // If the user is trying to come to this page through link, kick them out
        if (Session["Reply"] == null)
            Response.Redirect("DerivativeThreads.aspx");

        if (Session["user"] != null)
        {
            helloLbl.Text = "Hello " + Session["user"];
            helloLbl.Visible = true;
            signInLink.InnerHtml = "Sign Out";
        }
        else
        {
            CreateYourOwnReplyLbl.Visible = false;
            forumCommentTxt.Visible = false;
            postButton.Visible = false;
        }

        ListThreads();
    }

    /*
    * Read in thread information from the database and display it.
    * */
    public void ListThreads()
    {
        System.Web.UI.HtmlControls.HtmlGenericControl newDiv;

        Label posterLbl;
        Label postLbl;
        Label titleLbl;
        string posterName;
        string postTitle;
        string message;
        // Need a value but still flag that we have never found a match. The post id will be nonnegative so we are gauranteed.
        System.Int64 reply = -1;
        int rowsChecked = 0;

        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        // Command to search for the start of thread derivative posts.
        // Forum board = 1 denotes derivative boards.
        cmd.CommandText = "SELECT COUNT(*) FROM posts";

        cmd.Connection = sqlConn;

        // Open connection and check amount of posts in the table.
        sqlConn.Open();
        System.Int64 rowCount = (System.Int64)cmd.ExecuteScalar();
        sqlConn.Close();
        
        
            posterLbl = new Label();
            postLbl = new Label();
            titleLbl = new Label();
            deleteButton = new Button();
            deleteButton.Click += Delete_Post_Click;
            MySqlCommand postNameCommand = new MySqlCommand();
            postNameCommand.CommandType = System.Data.CommandType.Text;
            MySqlCommand postMessage = new MySqlCommand();
            postMessage.CommandType = System.Data.CommandType.Text;

            // Gather information for each div
            cmd.CommandText = "SELECT users.username FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + Session["Reply"];
            postNameCommand.CommandText = "SELECT posts.post_title FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + Session["Reply"];
            postMessage.CommandText = "SELECT posts.post_message FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + Session["Reply"];

            cmd.Connection = sqlConn;
            postNameCommand.Connection = sqlConn;
            postMessage.Connection = sqlConn;

            // Open connection and check the row for owner.
            sqlConn.Open();
            posterName = (string)cmd.ExecuteScalar();
            postTitle = (string)postNameCommand.ExecuteScalar();
            message = (string)postMessage.ExecuteScalar();
            sqlConn.Close();

            // Print Info
            titleLbl.Text = postTitle;
            posterLbl.Text = posterName;
            postLbl.Text = message;

            // Create div and elements.
            newDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");

            newDiv.Controls.Add(titleLbl);
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(posterLbl);
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(postLbl);

            // Style the div and elements.
            newDiv.Style.Value = "border-top-style: dotted; border-color: fixed; border-width: medium; margin-bottom: 60px";
            titleLbl.Style.Value = "Font-Size:32px";
            titleLbl.Text = Server.HtmlEncode(titleLbl.Text);
            posterLbl.Style.Value = "margin-top:40px;";
            postLbl.Style.Value = "margin-top:80px;";
            postLbl.Text = Server.HtmlEncode(postLbl.Text);
            postLbl.Text = postLbl.Text.Replace(Environment.NewLine, "<br/>");

        // Add the div to the holder.
        forumsPlaceholder.Controls.Add(newDiv);

        // Loop through and get replies.
        while (rowsChecked < rowCount)
        {
            // Command to check for each reply.
            cmd.CommandText = "SELECT is_start_of_thread FROM posts WHERE post_id = " + idTracker;

            cmd.Connection = sqlConn;
            
            sqlConn.Open();
            // Check that the id is there for the row.
            if (cmd.ExecuteScalar() != null)
            {
                reply = (int)cmd.ExecuteScalar();
                rowsChecked++;
            }
            sqlConn.Close();
            
            if (reply.ToString() == Session["Reply"].ToString())
            {
                posterLbl = new Label();
                postLbl = new Label();

                // Gather information for each div
                cmd.CommandText = "SELECT users.username FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + idTracker + " AND is_start_of_thread = " + Session["Reply"];
                postMessage.CommandText = "SELECT posts.post_message FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + idTracker + " AND is_start_of_thread = " + Session["Reply"];

                cmd.Connection = sqlConn;
                postNameCommand.Connection = sqlConn;
                postMessage.Connection = sqlConn;

                // Open connection and check the row for owner.
                sqlConn.Open();
                posterName = (string)cmd.ExecuteScalar();
                if (postNameCommand.ExecuteScalar().GetType() != typeof(DBNull))
                    postTitle = (string)postNameCommand.ExecuteScalar();
                message = (string)postMessage.ExecuteScalar();
                sqlConn.Close();

                // Print Info
                titleLbl.Text = postTitle;
                posterLbl.Text = posterName;
                postLbl.Text = message;
                deleteButton.Text = "Delete";

                // Create div and elements.
                newDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");

                newDiv.Controls.Add(new LiteralControl("<br />"));
                newDiv.Controls.Add(new LiteralControl("<br />"));
                newDiv.Controls.Add(posterLbl);
                newDiv.Controls.Add(new LiteralControl("<br />"));
                newDiv.Controls.Add(new LiteralControl("<br />"));
                newDiv.Controls.Add(postLbl);
                if (posterName == (string)Session["user"])
                {
                    newDiv.Controls.Add(new LiteralControl("<br />"));
                    newDiv.Controls.Add(new LiteralControl("<br />"));
                    newDiv.Controls.Add(deleteButton);
                }

                // Style the div and elements.
                newDiv.Style.Value = "border-top-style: dotted; border-color: fixed; border-width: medium; margin-bottom: 60px";
                posterLbl.Style.Value = "margin-top:40px;";
                postLbl.Style.Value = "margin-top:80px;";
                postLbl.Text = Server.HtmlEncode(postLbl.Text);
                postLbl.Text = postLbl.Text.Replace(Environment.NewLine, "<br/>");
                deleteButton.ID = idTracker.ToString();

                // Add the div to the holder.
                forumsPlaceholder.Controls.Add(newDiv);
            }


            idTracker++;
        }
    }

    protected void postButton_Click(object sender, EventArgs e)
    {
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        cmd.Connection = sqlConn;

        // Prepare parameterized statement.
        cmd.CommandText = "INSERT INTO posts (forum_board, post_message, is_start_of_thread, user_id) VALUES (1, @message, " + Session["Reply"] + ", " + Session["userID"] + ")";

        cmd.Parameters.Clear();
        cmd.Parameters.AddWithValue("@message", forumCommentTxt.Text);

        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        Response.Redirect("DerivativeReply.aspx", true);
    }

    protected void Delete_Post_Click(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        cmd.Connection = sqlConn;

        // Prepare parameterized statement.
        cmd.CommandText = "DELETE FROM posts WHERE post_id = " + button.ID;
        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        Response.Redirect("DerivativeReply.aspx", true);
    }
}