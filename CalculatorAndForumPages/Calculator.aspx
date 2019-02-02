<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calculator.aspx.cs" Inherits="Calculator" validateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    

</head>
<body>

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
    <div style="margin-left: auto; margin-right: auto; text-align: center;">

        <asp:Label ID="problemLbl" runat="server" Text="Please enter a problem: " Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />

        <link rel="stylesheet" href="/Content/mathquill.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="\Scripts\mathquill.js"></script>
        <script>
            var MQ = MathQuill.getInterface(2);
        </script>

        <meta charset="utf-8" />

        <span id="problemBox">\MathQuillMathField{}</span>
            

        <button runat="server" id="solveButton" onclick="solveButton()">Solve</button>

        <br />
        <br />
        
        <label id="answerLbl" style="font-weight:bold; font-size:32px"></label>

        <br />
        
        <label id="latexLbl" style="font-size:24px""></label>

        <br />
        <br />

        <button id="derivativeButton" onclick="derivativeButton()">d/dx</button>
        <button id="limitButton" style="margin-left:4%" onclick="limitButton()">Limit</button>
        <button id="fractionButton" style="margin-left:4%" onclick="fractionButton()">Fraction</button>
        <button id="sqrtButton" style="margin-left:4%;" onclick="sqrtButton()">Squareroot</button>
        <button id="expButton" style="margin-left:4%;" onclick="expButton()">Exponent</button>

        <br />
        <br />

        <asp:Label ID="instructionLbl" runat="server" Text="Enter a polynomial following the form Ax^n for each term. Use d/dx for a derivative, the limit button for a limit, or neither for an anitderivative." Font-Bold="true" Font-Size="X-Large" CssClass="StrongText"></asp:Label>

        <br />
        <br />

        <asp:Label ID="postLbl" runat="server" Text="Sign in to post to the forums!" Font-Bold="true" Font-Size="X-Large" CssClass="StrongText" Visible="true"></asp:Label>


        <script>
                // Elements must be loaded before javascript.
                var problem = MQ.MathField(document.getElementById('problemBox'));
                var latex = document.getElementById('latexLbl');
                var answer = document.getElementById('answerLbl');
                var term, pos, coeff, exp, limitPos, limitNumber, equation, arraySplit, newArray, skipFlag, limit;
                var i, j;
                problem.latex('');

                // Latex Fraction.
                function fractionButton() {
                    problem.cmd('\\frac');
                    problem.focus();
                }
            // Latex Limit.
                function limitButton() {
                    problem.latex('\lim_{x\\to }');
                    problem.keystroke('Left');
                    problem.focus();
                }
            // Latex Squareroot.
                function sqrtButton() {
                    problem.cmd('\\sqrt');
                    problem.focus();
                }
            // Latex d/dx.
                function derivativeButton() {
                    problem.latex('');
                    problem.typedText('d/dx');
                    problem.keystroke('Right');
                    problem.focus();
                }
            // Latex Exponent.
                function expButton() {
                    problem.typedText('^');
                    problem.focus();
                }
            // Display Latex and solve.
                function solveButton() {
                    // Check that it is a derivative.
                    // Add functionality for no coefficient.
                    if (problem.latex().startsWith('\\frac{d}{dx}'))
                        derivative();
                    else if (problem.latex().startsWith('\\lim_')) {
                        limitFunc();
                    }
                    else {
                        antiderivative();
                    }
                }

            // Derivative
            // One term setup, next is a polynomial.
            // Setup answer in label, mathquill's interface is allowing only one editable field.
                function derivative() {
                    latex.innerHTML = "Latex of what you entered: " + problem.latex();
                    skipFlag = false;

                    // Solve problem. For now, only take in terms that follow the format 5x^2.
                    equation = problem.latex().substring(12);

                    // Split terms based on +.
                    term = equation.split("+");
                    newArray = new Array;

                    // Split on minus but keep minus.
                    for (i = 0; i < term.length; i++) {
                        arraySplit = term[i].split(/(?=-)/g);

                        for (j = 0; j < arraySplit.length; j++)
                            newArray.push(arraySplit[j]);
                    }

                    term = newArray;


                    for (i = 0; i < term.length; i++) {


                        if (!skipFlag) {
                            pos = term[i].toString().search(/x/i);

                            // Derivative of number is 0.
                            if (pos == -1) {
                                coeff = 0;
                                exp = null;
                            }
                                // No coefficient.
                            else if (pos == 0) {
                                coeff = 1;
                                // Check exponent.
                                // No exponent
                                if (pos == term[i].length - 1)
                                    exp = 1;
                                else
                                    exp = term[i].toString().substring(pos + 3);

                                if (isNaN(exp))
                                    exp = exp.toString().substring(0, exp.length - 1);

                                exp = parseFloat(exp);


                                coeff = Math.round(coeff * exp * 100) / 100;
                                exp = exp - 1;
                            }
                                // Derivative with x but no exponent.
                            else if (pos + 1 == term[i].toString().length) {
                                coeff = parseFloat(term[i].toString().substring(0, pos));
                                exp = null;
                            }
                                // Take exponential derivative.
                            else {
                                coeff = term[i].toString().substring(0, pos);
                                exp = term[i].toString().substring(pos + 2);

                                // Check if exponent is more than one number.
                                if (exp.length > 1) {
                                    // Trim away the braces.
                                    exp = exp.substring(1, exp.length - 1);
                                }


                                coeff = parseFloat(coeff);
                                // Check for negative exponent
                                if (isNaN(parseFloat(exp)) && term.length != i + 1) {
                                    exp = term[i + 1].toString().substring(0, term[i + 1].toString().length - 1);
                                    skipFlag = true;
                                }

                                exp = parseFloat(exp);

                                coeff = Math.round(coeff * exp * 100) / 100;
                                exp = exp - 1;

                            }

                            term[i] = { coefficient: coeff, exponent: exp };

                        }

                        skipFlag = false;
                        
                    }

                    newArray = new Array;

                    // Combine like terms.
                    for (i = 0; i < term.length; i++) {
                        for (j = i + 1; j < term.length; j++) {
                            if (term[i].exponent == term[j].exponent) {

                                term[i].coefficient += term[j].coefficient;
                                term[i].coefficient = Math.round(term[i].coefficient * 100) / 100
                                term.splice(j, 1);
                                j--;
                            }
                        }
                        newArray.push(term[i]);
                    }

                    term = newArray;

                    // Build answer.
                    answer.innerHTML = "Answer:  ";
                    for (i = 0; i < term.length; i++) {
                        if (term[i].coefficient == 0) {
                            if (answer.innerHTML.toString() == "Answer:  " && i == term.length - 1)
                                answer.innerHTML = answer.innerHTML + term[i].coefficient + " + ";
                        }
                        else if (term[i].exponent == null)
                            if (term[i].coefficient < 0)
                                answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + " + ";
                            else
                                answer.innerHTML = answer.innerHTML + term[i].coefficient + " + ";
                        else if (term[i].exponent == 1)
                            if (term[i].coefficient < 0)
                                answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + "x + ";
                            else if (term[i].coefficient == 1)
                                answer.innerHTML = answer.innerHTML + "x + ";
                            else
                                answer.innerHTML = answer.innerHTML + term[i].coefficient + "x + ";
                        else if (term[i].exponent == 0)
                            answer.innerHTML = answer.innerHTML + term[i].coefficient + " + ";
                        else
                            if (term[i].coefficient < 0)
                                answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + "x<sup>" + term[i].exponent + "</sup> + ";
                            else if (term[i].coefficient == 1)
                                answer.innerHTML = answer.innerHTML + "x<sup>" + term[i].exponent + "</sup> + ";
                            else
                                answer.innerHTML = answer.innerHTML + term[i].coefficient + "x<sup>" + term[i].exponent + "</sup> + ";

                    }

                    answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2);
                }

                // Antiderivative
                // One term setup, next is a polynomial.
                // Setup answer in label, mathquill's interface is allowing only one editable field.
                function antiderivative() {
                    latex.innerHTML = "Latex of what you entered: " + problem.latex();
                    skipFlag = false;

                    equation = problem.latex();

                    // Split terms based on +.
                    term = equation.split("+");
                    newArray = new Array;

                    // Split on minus but keep minus.
                    for (i = 0; i < term.length; i++) {
                        arraySplit = term[i].split(/(?=-)/g);

                        for (j = 0; j < arraySplit.length; j++)
                            newArray.push(arraySplit[j]);
                    }

                    term = newArray;

                    for (i = 0; i < term.length; i++) {


                        if (!skipFlag) {
                            pos = term[i].toString().search(/x/i);

                            // Antiderivative of number is just number with x.
                            if (pos == -1) {
                                coeff = parseFloat(term[i].toString());
                                exp = null;
                            }
                                // No coefficient.
                            else if (pos == 0) {
                                coeff = 1;
                                // Check exponent.
                                // No exponent
                                if (pos == term[i].length - 1)
                                    exp = 1;
                                else
                                    exp = term[i].toString().substring(pos + 3);

                                exp = parseFloat(exp);

                                if (isNaN(exp))
                                    exp = exp.toString().substring(0, exp.length - 1);

                                exp = parseFloat(exp);

                                exp = exp + 1;
                                coeff = Math.round(coeff / exp * 100) / 100;
                            }
                                // Antiderivative with x but no exponent.
                            else if (pos + 1 == term[i].toString().length) {
                                coeff = term[i].substring(0, pos);
                                coeff = Math.round((parseFloat(coeff) / 2) * 100) / 100;
                                exp = 2;
                            }
                                // Take exponential antiderivative.
                            else {
                                coeff = term[i].substring(0, pos);
                                exp = term[i].substring(pos + 2);

                                // Check if exponent is more than one number.
                                if (exp.length > 1) {
                                    // Trim away the braces.
                                    exp = exp.substring(1, exp.length - 1);
                                }

                                coeff = parseFloat(coeff);

                                // Check for negative exponent
                                if (isNaN(parseFloat(exp)) && term.length != i + 1) {
                                    exp = term[i + 1].toString().substring(0, term[i + 1].toString().length - 1);
                                    skipFlag = true;
                                }

                                exp = parseFloat(exp);

                                exp = exp + 1;
                                coeff = Math.round((coeff / exp) * 100) / 100;

                            }

                            term[i] = { coefficient: coeff, exponent: exp };
                        }

                        skipFlag = false;
                    }

                    newArray = new Array;

                    // Combine like terms.
                    for (i = 0; i < term.length; i++) {
                        for (j = i + 1; j < term.length; j++) {
                            if (term[i].exponent == term[j].exponent) {

                                term[i].coefficient += term[j].coefficient;
                                term[i].coefficient = Math.round(term[i].coefficient * 100) / 100
                                term.splice(j, 1);
                                j--;
                            }
                        }
                        newArray.push(term[i]);
                    }

                    term = newArray;

                        // Build answer.
                        answer.innerHTML = "Answer:  ";
                        for (i = 0; i < term.length; i++) {
                            if (!term[i].coefficient.toString().includes("}"))
                                if (term[i].coefficient == 0) {
                                    if (answer.innerHTML.toString() == "Answer:  " && i == term.length - 1)
                                        answer.innerHTML = answer.innerHTML + term[i].coefficient + " + ";
                                }
                                else if (term[i].exponent == null)
                                    if (term[i].coefficient < 0)
                                        answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + "x + ";
                                    else if (term[i].coefficient == 1)
                                        answer.innerHTML = answer.innerHTML + "x + ";
                                    else
                                        answer.innerHTML = answer.innerHTML + term[i].coefficient + "x + ";
                                else if (term[i].exponent == 1)
                                    if (term[i].coefficient < 0)
                                        answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + "x + ";
                                    else if (term[i].coefficient == 1)
                                        answer.innerHTML = answer.innerHTML + "x + ";
                                    else
                                        answer.innerHTML = answer.innerHTML + term[i].coefficient + "x + ";
                                else
                                    if (term[i].coefficient < 0)
                                        answer.innerHTML = answer.innerHTML.substring(0, answer.innerHTML.length - 2) + " - " + term[i].coefficient.toString().substring(1) + "x<sup>" + term[i].exponent + "</sup> + ";
                                    else if (term[i].coefficient == 1)
                                        answer.innerHTML = answer.innerHTML + "x<sup>" + term[i].exponent + "</sup> + ";
                                    else
                                        answer.innerHTML = answer.innerHTML + term[i].coefficient + "x<sup>^" + term[i].exponent + "</sup> + ";

                        }

                        answer.innerHTML = answer.innerHTML + "C";
                }

                // Limit
                // One term setup, next is a polynomial.
                // Setup answer in label, mathquill's interface is allowing only one editable field.
                function limitFunc() {
                    latex.innerHTML = "Latex of what you entered: " + problem.latex();
                    limit = 0;
                    skipFlag = false;

                    coeff = 0;

                    term = problem.latex();

                    // Strip limit from problem, we already know that this is a limit.
                    limitPos = term.search(/o/i);
                    pos = term.search(/}/i);
                    limitNumber = term.substring(limitPos + 1, pos);
                    term = term.substring(pos + 1);

                    // Split terms based on +.
                    term = term.split("+");
                    newArray = new Array;

                    // Split on minus but keep minus.
                    for (i = 0; i < term.length; i++) {
                        arraySplit = term[i].split(/(?=-)/g);

                        for (j = 0; j < arraySplit.length; j++)
                            newArray.push(arraySplit[j]);
                    }

                    term = newArray;

                    for (i = 0; i < term.length; i++) {

                        if (!skipFlag) {
                            // Search for x.
                            pos = term[i].search(/x/i);

                            // Limit of number is just number.
                            if (pos == -1) {
                                limit = limit + parseFloat(term[i]);
                            }
                            // There is an x but no exponent.
                            else if (pos == term[i].length - 1) {

                                if (pos == 0)
                                    coeff = 1;
                                else
                                    coeff = term[i].substring(0, pos);


                                coeff = parseFloat(coeff);
                                limitNumber = parseFloat(limitNumber);

                                limit += parseFloat(Math.round(coeff * limitNumber * 100) / 100);
                            }
                                // Take limit with exponent.
                            else {
                                if (pos == 0)
                                    coeff = 1;
                                else
                                    coeff = term[i].substring(0, pos);
                                exp = term[i].substring(pos + 2);

                                // Check if exponent is more than one number.
                                if (exp.length > 1) {
                                    // Trim away the braces.
                                    exp = exp.substring(1, exp.length - 1);
                                }

                                // Check for negative exponent
                                if (isNaN(parseFloat(exp)) && term.length != i + 1) {
                                    exp = term[i + 1].toString().substring(0, term[i + 1].toString().length - 1);
                                    skipFlag = true;
                                }

                                coeff = parseFloat(coeff);
                                exp = parseFloat(exp);
                                limitNumber = parseFloat(limitNumber);

                                limit += parseFloat(Math.round((Math.pow(limitNumber, exp) * coeff) * 100) / 100);

                            }
                        }

                        skipFlag = false;
                    }

                    answer.innerHTML = "Answer " + limit;
                }
            </script>
    </div>
    
    <form id="form1" runat="server">

        <br />
    <asp:Label ID="topicLbl" runat="server" Text="Topic: " Font-Bold="true" Font-Size="X-Large" CssClass="StrongText" Visible="false"></asp:Label>
    <asp:DropDownList ID="topicList" runat="server" Visible="false">
        <asp:ListItem Enabled="true" Text="Derivative" Value="1"></asp:ListItem>
        <asp:ListItem Text="Antiderivative" Value="2"></asp:ListItem>
        <asp:ListItem Text="Limit" Value="3"></asp:ListItem>
    </asp:DropDownList>
    <br />
    <asp:Label ID="newTitleLbl" runat="server" Visible="false">Title:</asp:Label>
        <br />
        <asp:TextBox ID="forumTitleTxt" runat="server" Width="100%"  Visible="false"></asp:TextBox>
        <br />
        <asp:Label ID="messageLbl" runat="server" Visible="false">Post:</asp:Label>
        <br />
        <asp:TextBox ID="forumPostTxt" runat="server" Height="200px" Width="100%"  Visible="false" TextMode="MultiLine"></asp:TextBox>
        <br />
        <asp:Button ID="postButton" runat="server" Text="Post" OnClick="postButton_Click" Visible="false" UseSubmitBehavior="false"></asp:Button>

        </form>

        
</body>
</html>
