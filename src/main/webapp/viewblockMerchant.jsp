<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Block Merchant</title>
<style type="text/css">
body{
color:silver;
background-color: black;
}

b{
margin-left:430px;
 color: red;
 font-size: 50px;

}
a{
font-size: 35px;
margin-left: 50px;
}

#head{
color: yellow;
}
</style>
</head>
<body>
<%
   EntityManagerFactory emf=Persistence.createEntityManagerFactory("shopping");
   EntityManager em=emf.createEntityManager();
   
   Query query = em.createQuery("select a from Merchant a where status!='blocked'");
   List<Merchant> merchants=query.getResultList();
   
   if(merchants.size()>0)
   {
	   %>
	   <b>Merchant List</b>
	   <table  cellpadding="10" align="center" border="20">
	      <tr id="head">
	          <th>id</th>
              <th>Name</th>
              <th>Email</th>
              <th>Password</th>
              <th>Mobile Number</th>
              <th>status</th>
              <th>status</th>
	      </tr>
	   <%
	      for(Merchant m:merchants){  %>
	    	  
	    	 <tr>
	    	    <th><%=m.getId() %></th>
	    	    <th><%=m.getName() %></th>
	    	    <th><%=m.getEmail() %></th>
	    	    <th><%=m.getPassword() %></th>
	    	    <th><%=m.getMobileNumber() %></th>
	    	    <th><%=m.getStatus() %></th>
	    	    <th><a href="Block_Merchant.jsp?id=<%=m.getId()%>">Block</a></th>
	    	 </tr> 
	    	 <% 
	    	 } 
	    	 %>
	      
	  
	   </table>
	   <a href="adminoptions.html">Back</a>
	   <% 
	   
	   
   }
   else{
	   
	   PrintWriter pw=response.getWriter();
	   pw.write("Merchant not available");
	   
	   RequestDispatcher rd=request.getRequestDispatcher("adminoptions.html");
	   rd.include(request, response);
   }
   
   

%>
</body>
</html>