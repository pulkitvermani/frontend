<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.sql.*,java.util.Random,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%!ResultSet rs1,rs;
PreparedStatement ps; 
String email;
String pass;
String x="";
%>
<%
if (request.getMethod().equals("POST")){
	System.out.println("Request is post");
	try{
	email=request.getParameter("email");
	pass=request.getParameter("psw");
	System.out.println(email+"	"+pass);
	Class.forName("com.mysql.jdbc.Driver");
	String jdbcurl="jdbc:mysql://localhost/mysj";
	String user="root";
	String password="ohnax";
	Connection c=DriverManager.getConnection(jdbcurl,user,password);
	ps=c.prepareStatement("select email from usd where email=? ");
    ps.setString(1, email);
    rs=ps.executeQuery();
    if(!rs.next()) 
   {System.out.println("New Email");
    x="";
    	ps=c.prepareStatement("insert into usd values( ?, ?, null)");
     ps.setString(1, email);
     ps.setString(2, pass);
     ps.execute();
     
     session.setAttribute( "email", email );
 		final String from = "stevesquads1857@gmail.com";
		final String passk ="!@#$%^&*()1234567890";
		String to ="rupam.singh.cs.2015@miet.ac.in";//email;
		String subject = "Congo from steve squad";
		String Body="congratulations You Have Sucessfully.Signed Up for Steve Squad \n Start Using Services By Logining in and conforming Your Self with OTP";

		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");			

		Session msession = Session.getInstance(props,
		new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(from,passk);
		}
		});

		// Create a default MimeMessage object.
		Message message = new MimeMessage(msession);
	
		// Set From: header field of the header.
		message.setFrom(new InternetAddress(from));
	
		// Set To: header field of the header.
		message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
	
		// Set Subject: header field
		message.setSubject(subject);
	
		// Now set the actual message
		message.setText(Body);
		
		Transport.send(message);
		System.out.println("message send....");
		msession=null;

     
     System.out.println("Email has been Sent");
     response.setStatus(response.SC_MOVED_TEMPORARILY);
 	 response.setHeader("Location","login.jsp" );
    }
    	
    else
    	{if(email!=""&&email!=null) 
    		x="Email id already in use try Diffrent one";}
    }
	catch(Exception e)
	{
		}
}
%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn,.signupbtn {
    float: left;
    width: 50%;
}

/* Add padding to container elements */
.container {
    padding: 16px;
}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
}
</style>
</head>
<body>

<h2>Signup Form</h2>


<form action='#' method="POST" style="border:1px solid #ccc;" >
  <div class="container">
    <label><b>Email</b></label>
    <input type="text" placeholder="Enter Email" name="email" required><p style="color:red;"><%= x %></p>
    <label><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>
    <div class="clearfix">
      <button type="submit" class="signupbtn" >Sign Up</button>
    </div>
  </div>
</form>

</body>
</html>