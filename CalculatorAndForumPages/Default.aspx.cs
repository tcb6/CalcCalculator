using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class _Default : System.Web.UI.Page
{
    // Connection string for RDS instance.
    // Actual information for DB omitted for security reasons.
    MySqlConnection sqlConn = new MySqlConnection("Server=**************************************************;" +
                                                                                                  "Port=3306;" +
                                                                                                  "Database=*******;" +
                                                                                                  "Uid=*****;" +
                                                                                                  "Pwd=**********;");
    MySqlCommand cmd = new MySqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
    }

    /*
     * Transfer user to register page.
     * */
    public void Register_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx", true);
    }

    /*
    * Transfer user to change passsword page.
    */
    public void Pass_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("ChangePass.aspx", true);
    }

    /*
     * Attempt to sign the user in if their credentials exist in the database.
     * */
    protected void Login_Button_Click(object sender, EventArgs e)
    {

        // Variables to store the user's credentials.
        string user = userTxt.Text;
        string password = passTxt.Text;

        // Prepare command object.
        cmd.CommandType = System.Data.CommandType.Text;

        // Command to search for user credentials.
        cmd.CommandText = "SELECT COUNT(*) FROM users WHERE username like @username AND password = SHA1(@password)";

        cmd.Parameters.Clear();
        cmd.Parameters.AddWithValue("@username", user);
        cmd.Parameters.AddWithValue("@password", password);

        cmd.Connection = sqlConn;

        // Open connection, check store the amount of matches in database, and close the connection.
        sqlConn.Open();
        System.Int64 userCount = (System.Int64)cmd.ExecuteScalar();
        sqlConn.Close();

        // If the search for the player returned a row, remember the user's name and take them to the forum.
        if (userCount > 0)
        {
            Session["user"] = userTxt.Text;

            cmd.CommandText = "SELECT user_id FROM users WHERE username like @username AND password = SHA1(@password)";

            sqlConn.Open();
            Session["userID"] = cmd.ExecuteScalar().ToString();     // Store user's ID for later pages.
            sqlConn.Close();

            Response.Redirect("forum.aspx", true);
        }
        // Incorrect login; there is no record in the database. Display message.
        else
            invalidLoginLbl.Visible = true;
    }
}