
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*; 

public class EL implements Runnable 
{
    Thread t;
    String to="";
    String em;
    String mo;
    String RS;
    String nm;
    EL(String nm,String em,String mo,String RS)
     {  this.nm=nm;
		this.em=em;
         this.mo=mo;
         this.RS=RS;
    	  t=new Thread(this);
    	  t.start();
     }
	public void run()
	{
		
		   try{

		
				final String from = "stevesquads1857@gmail.com";
				final String pass ="!@#$%^&*()1234567890";
				to =em;
				String subject = "With Regard to Your Recent Purchase of "+mo+" :-)";
				String link="https://localhost:8080/survey/feedback.jsp?C0de="+RS+"&email="+em;
				String Body= "Sir/Madam, this is a survey regarding the experience you had with our company so far,so kindly help us to serve you better.\n\n"
				+link+"\n\n\nThanks for you Mr/Miss "+nm+"  for doing business with Us. ;-D";

				
				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", "465");

				// Get the Session object.
				Session msession = Session.getInstance(props,
				new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from,pass);
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
			}catch(Exception e)
			{e.printStackTrace();} 


			}
			
		}
