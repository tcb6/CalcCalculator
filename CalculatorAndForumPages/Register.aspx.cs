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

    protected void Page_Load(object sender, EventArgs e)
    {
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
     * Create the user's account if the name hasn't already been taken.
     * */
    protected void Register_Button_Click(object sender, EventArgs e)
    {
        // Check if the passwords are the same. If they aren't, notify the user.
        if (passwordTxt.Text != confirmPassTxt.Text)
        {
            passwordEnterLbl.Text = "The passwords do not match.";
            passwordEnterLbl.Visible = true;
            usernameExistsLbl.Visible = false;
        }
        else
        {
            // Store the username and password.
            user = userTxt.Text;
            password = passwordTxt.Text;


            // Check if password meets requirements.
            if (CheckUserExists(user))
            {
                usernameExistsLbl.Text = "The username is taken.";
                usernameExistsLbl.Visible = true;
                passwordEnterLbl.Visible = false;
            }
            else if (!CheckPass(password))
            {
                usernameExistsLbl.Visible = false;
                passwordEnterLbl.Visible = true;
            }
            else if (!CheckUsername(user))
            {
                usernameExistsLbl.Visible = true;
                passwordEnterLbl.Visible = false;
            }

            // Create the user.
            else
            {
                // Check if user exists. If not, create the user.
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                cmd.CommandText = "INSERT INTO users (username, password) VALUES (@username, SHA1(@password))";

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@username", user);
                cmd.Parameters.AddWithValue("@password", password);

                cmd.Connection = sqlConn;

                sqlConn.Open();
                cmd.ExecuteNonQuery();
                sqlConn.Close();

                Response.Redirect("Default.aspx", true);
            }

        }


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

    /**
     * Check if the user exists.
     * */
    public bool CheckUserExists(string user)
    {
        // Check if user exists. If not, create the user.
        MySqlCommand cmd = new MySqlCommand();
        cmd.CommandType = System.Data.CommandType.Text;

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

    public bool CheckUsername(string user)
    {
        // Prepare username error.
        usernameExistsLbl.Text = "Username should be at most 16 characters long and should only contain letters " +
                                 "and numbers.";

        if (user.Length > 16)
        {
            return false;
        }

        foreach (char c in user)
        {
            if (!(char.IsUpper(c) || char.IsLower(c) || char.IsDigit(c)))
                return false;
        }
        return true;
    }
}