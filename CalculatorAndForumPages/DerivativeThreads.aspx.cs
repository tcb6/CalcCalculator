using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class Forum : System.Web.UI.Page
{
    // Connection string for RDS instance.
    // Actual information for DB omitted for security reasons.
    MySqlConnection sqlConn = new MySqlConnection("Server=**************************************************;" +
                                                                                                  "Port=3306;" +
                                                                                                  "Database=*******;" +
                                                                                                  "Uid=*****;" +
                                                                                                  "Pwd=**********;");


    System.Int64 idTracker = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        ListThreads();

        if (Session["user"] != null)
        {
            helloLbl.Text = "Hello " + Session["user"];
            helloLbl.Visible = true;
            signInLink.InnerHtml = "Sign Out";
        }
        else
        {
            CreateYourOwnPostLbl.Visible = false;
            newTitleLbl.Visible = false;
            forumTitleTxt.Visible = false;
            messageLbl.Visible = false;
            forumPostTxt.Visible = false;
            postButton.Visible = false;
        }
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
        Button viewButton;
        Button deleteButton;
        string posterName;
        string postTitle;
        string message;
        System.Int64 rowReturned;
        bool rowFound = false;

        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        // Command to search for the start of thread derivative posts.
        // Forum board = 1 denotes derivative boards.
        cmd.CommandText = "SELECT COUNT(*) FROM posts WHERE forum_board = 1 AND is_start_of_thread = 0";

        cmd.Connection = sqlConn;

        // Open connection and check amount of posts in the table.
        sqlConn.Open();
        System.Int64 postCount = (System.Int64)cmd.ExecuteScalar();
        sqlConn.Close();

        for (int i = 0; i < postCount; i++)
        {
            while (!rowFound)
            {
                idTracker++;
                // Command to check for each post.
                cmd.CommandText = "SELECT COUNT(*) FROM posts WHERE post_id = " + idTracker + " AND forum_board = 1 AND is_start_of_thread = 0";

                cmd.Connection = sqlConn;

                // Open connection and check amount of posts in the table.
                sqlConn.Open();
                rowReturned = (System.Int64)cmd.ExecuteScalar();
                sqlConn.Close();

                if (rowReturned == 1)
                    rowFound = true;
            }

            rowFound = false;

            posterLbl = new Label();
            postLbl = new Label();
            titleLbl = new Label();
            viewButton = new Button();
            viewButton.Click += View_Post_Click;
            deleteButton = new Button();
            deleteButton.Click += Delete_Post_Click;
            MySqlCommand postNameCommand = new MySqlCommand();
            postNameCommand.CommandType = System.Data.CommandType.Text;
            MySqlCommand postMessage = new MySqlCommand();
            postMessage.CommandType = System.Data.CommandType.Text;

            // Gather information for each div
            cmd.CommandText = "SELECT users.username FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + idTracker;
            postNameCommand.CommandText = "SELECT posts.post_title FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + idTracker;
            postMessage.CommandText = "SELECT posts.post_message FROM users INNER JOIN posts ON posts.user_id=users.user_id AND post_id = " + idTracker;

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
            viewButton.Text = "Reply";
            deleteButton.Text = "Delete";

            // Create div and elements.
            newDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("DIV");

            newDiv.Controls.Add(titleLbl);
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(posterLbl);
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(postLbl);
            newDiv.Controls.Add(new LiteralControl("<br />"));
            newDiv.Controls.Add(viewButton);
            if (posterName == (string)Session["user"])
            {
                newDiv.Controls.Add(new LiteralControl("<br />"));
                newDiv.Controls.Add(deleteButton);
            }

            // Style the div and elements.
            newDiv.Style.Value = "border-top-style: dotted; border-color: fixed; border-width: medium; margin-bottom: 60px";
            titleLbl.Style.Value = "Font-Size:32px";
            titleLbl.Text = Server.HtmlEncode(titleLbl.Text);
            posterLbl.Style.Value = "margin-top:40px;";
            postLbl.Style.Value = "margin-top:80px;";
            postLbl.Text = Server.HtmlEncode(postLbl.Text);
            postLbl.Text = postLbl.Text.Replace(Environment.NewLine, "<br/>");
            viewButton.Style.Value = "margin-top:120px;";
            viewButton.ID = idTracker.ToString();
            deleteButton.ID = "del" + idTracker.ToString();

            // Add the div to the holder.
            forumsPlaceholder.Controls.Add(newDiv);

        }
    }

    public void View_Post_Click(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        Session["Reply"] = button.ID;

        Response.Redirect("DerivativeReply.aspx", true);
    }

    protected void postButton_Click(object sender, EventArgs e)
    {
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        cmd.Connection = sqlConn;

        // Prepare parameterized statement.
        cmd.CommandText = "INSERT INTO posts (forum_board, post_title, post_message, is_start_of_thread, user_id) VALUES (1, @title, @message, " + 0 +
            ", " + Session["userID"] + ")";

        cmd.Parameters.Clear();
        cmd.Parameters.AddWithValue("@message", forumPostTxt.Text);
        cmd.Parameters.AddWithValue("@title", forumTitleTxt.Text);


        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        Response.Redirect("DerivativeThreads.aspx", true);
    }

    protected void Delete_Post_Click(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

        cmd.Connection = sqlConn;

        // Prepare parameterized statement.
        cmd.CommandText = "DELETE FROM posts WHERE post_id = " + button.ID.ToString().Substring(3);
        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        // Check to see if there are any replies and delete them.
        cmd.CommandText = cmd.CommandText = "DELETE FROM posts WHERE forum_board = 1 AND is_start_of_thread = " + button.ID.ToString().Substring(3);

        sqlConn.Open();
        cmd.ExecuteNonQuery();
        sqlConn.Close();

        Response.Redirect("DerivativeThreads.aspx", true);
    }
}