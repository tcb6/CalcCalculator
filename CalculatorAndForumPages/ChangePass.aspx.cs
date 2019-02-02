using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;

public partial class Register : System.Web.UI.Page
{
    string user;
    string password;

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
        cmd.CommandType = System.Data.CommandType.Text;

        if (Session["user"] != null)
        {
            helloLbl.Text = "Hello " + Session["user"];
            helloLbl.Visible = true;
            signInLink.InnerHtml = "Sign Out";
        }
    }

    /*
     * Transfer the user back to the login page.
     * */
    protected void Back_Button_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx", true);
    }

    /*
     * Change the user's password.
     * */
    protected void Pass_Button_Click(object sender, EventArgs e)
    {
        // Check if the passwords are the same. If they aren't, notify the user.
        if (newPassTxt.Text != confirmPassTxt.Text)
        {
            passwordEnterLbl.Text = "The passwords do not match";
            passwordEnterLbl.Visible = true;
            usernameExistsLbl.Visible = false;
        }
        else
        {
            // Store the username and password.
            user = userTxt.Text;
            password = newPassTxt.Text;


            // Check if user exists.
            if (!CheckUserExists())
            {
                usernameExistsLbl.Visible = true;
                passwordEnterLbl.Visible = false;
            }

            // Check that the password matches for the current user
            else if (!PasswordMatch())
            {
                passwordEnterLbl.Text = "Incorrect username or password.";
                passwordEnterLbl.Visible = true;
                usernameExistsLbl.Visible = false;
            }
            else if (!CheckPass(password))
            {
                usernameExistsLbl.Visible = false;
                passwordEnterLbl.Visible = true;
            }

            // Change the password.
            else
            {
                cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.CommandText = "UPDATE users SET password = SHA1(@password) WHERE username = @username";

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@username", user);
                cmd.Parameters.AddWithValue("@password", password);

                cmd.Connection = sqlConn;

                sqlConn.Open();
                cmd.ExecuteNonQuery();
                sqlConn.Close();

                string message = "Password Changed";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                
            }

        }


    }

    

    /**
     * Check if the user exists.
     * */
    public bool CheckUserExists()
    {
        // Check if user exists. If so, change the password.
        cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;
        
        user = userTxt.Text;

        // Command to search for the user.
        cmd.CommandText = "SELECT COUNT(*) FROM users WHERE username like @username";

        cmd.Parameters.Clear();
        cmd.Parameters.AddWithValue("@username", user);

        cmd.Connection = sqlConn;

        // Open connection, check store the amount of matches in database, and close the connection.
        sqlConn.Open();
        System.Int64 userCount = (System.Int64)cmd.ExecuteScalar();
        sqlConn.Close();

        // If the search for the player returned a row, deny the user creation.
        if (userCount > 0)
            return true;
        else
            return false;
    }

    /**
     * Check if the user's password is correct.
     * */
    public bool PasswordMatch()
    {
        // Variables to store the user's credentials.
        string user = userTxt.Text;
        string password = passwordTxt.Text;

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
            return true;
        }
        return false;
    }

    /**
     * Check if the password is valid.
     * */
    protected bool CheckPass(string password)
    {
        // Prepare password error text.
        passwordEnterLbl.Text = "The password must be 8 to 16 characters long and should contain at least one lowercase letter, " +
                                "uppercase letter, and number.";

        // Check password length.
        if (password.Length < 8 || password.Length > 16)
        {
            passwordEnterLbl.Visible = true;
            usernameExistsLbl.Visible = false;
            return false;
        }

        // Create vaiables to check against password.
        bool isUpperCase = false;
        bool isLowerCase = false;
        bool isDigit = false;

        // Loop through each character and check what it is.
        foreach (char c in password)
        {
            if (char.IsUpper(c))
                isUpperCase = true;
            else if (char.IsLower(c))
                isLowerCase = true;
            else if (char.IsDigit(c))
                isDigit = true;
        }

        // Check if all requirements are met.
        if (isUpperCase && isLowerCase && isDigit)
        {
            return true;
        }
        else
        {
            passwordEnterLbl.Visible = true;
            usernameExistsLbl.Visible = false;
            return false;
        }

    }
}