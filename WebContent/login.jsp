<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.sql.*,java.util.Random,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%!
ResultSet rs1,rs;
PreparedStatement ps;

String s="STEVE SQUAD ENTERPRISES...";
String email;
String errror="";
String att1="hidden";
String att2="hidden";
String wo="";
%>

<%
try
{   System.out.println(session.getAttribute("email"));
	Class.forName("com.mysql.jdbc.Driver");
    String jdbcurl="jdbc:mysql://localhost/mysj";
    String user="root";
	String password="ohnax";
	Connection c=DriverManager.getConnection(jdbcurl,user,password);
	String otps= request.getParameter("otps");  
	if ((request.getMethod()=="POST"))
	 System.out.println("request is post");
	 {if (session.getAttribute("email")==null){
	    email=request.getParameter("email");
		String pass=request.getParameter("pass");
		System.out.println("parameter are "+email+" "+pass);
	    ps=c.prepareStatement("select * from usd where email=? and password=?");
	    ps.setString(1, email);
	    ps.setString(2, pass);
	    rs=ps.executeQuery();
	    
	    if(rs.next()) 
	    {	    
	    	System.out.println("User Exist");
	    	session.setAttribute( "email", email );
	    	final String from = "stevesquads1857@gmail.com";
			final String passk ="!@#$%^&*()1234567890";
			String to =email;
			String subject = "otp from steve squad";
		    final  String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890qwertyuioplkjhgfdsazxcvbnm";
		    StringBuilder salt = new StringBuilder();
		    Random rnd = new Random();
		    while (salt.length() < 8) { 
		            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
		            salt.append(SALTCHARS.charAt(index));}
		    String k=salt.toString();
			String Body="Your One Time Password is : "+k+". ";

			
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
			ps=c.prepareStatement("update usd set otp=? where email=?");
		    ps.setString(1,k);
		    ps.setString(2, email);
		    ps.executeUpdate();
		    System.out.println("otp send and updated in sql db");
		    att1="password";
			att2="submit";
}
	    else 
	    	{if(email!=null&&email!="") errror="User Name doesn't exist"; }  
	 }
	else{ 
		if(session.getAttribute("email")==email)
		{
		ps=c.prepareStatement("select otp from usd where email=?");
	    ps.setString(1, email);
	    rs=ps.executeQuery();
	    rs.next();
	    String tmp1,tmp2;
	    tmp1=request.getParameter("otps");
	    tmp2=rs.getString(1);
	    if(tmp1.equals(tmp2)){
	    	session.setAttribute("email",null);
	    	c.close();
	    	response.setStatus(response.SC_MOVED_TEMPORARILY);
	    	response.setHeader("Location","ThankYou.html" );
		}
	    else
	    {	
	    	wo="WRONG OTP";
		    att1="hidden";
			att2="hidden";
		   
	    }
		}}
	}
}
	catch(Exception e)
		{e.printStackTrace();} 
   
	%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Steve Squad</title>
<style>
form {
    border: 3px solid #f1f1f1;
}

input[type=email], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

button:hover {
    opacity: 0.8;
}


.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
}

img.avatar {
    width: 40%;
    border-radius: 50%;
}

.container {
    padding: 16px;
}


</style>
</head>
<body>

<h2>Login Form</h2>

<form action="#" method="POST">
  <div class="imgcontainer">
    <img src="thumb-1920-702248.jpg" alt="Avatar" class="avatar">
  </div>
 
  <div class="container">
    <p style="color:red;"><%= errror%></p>
  
    <label><b>Username</b></label>
	
    <input type="Email" placeholder="Enter Username" name="email" required>

    <label><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="pass" required>        
    <button type="submit">Login</button>

  </div>

</form >
<p>
<form  action="#" method="POST">
<input name="otps" type=<%= att1%> placeholder="Enter Otp"><p style="color:red;"><%= wo%></p>
<input type=<%= att2%> value="auth">
</p>
</form>

</body>
</html>