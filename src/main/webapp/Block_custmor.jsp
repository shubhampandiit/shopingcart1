
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Customer"%>
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
<title>Insert title here</title>
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
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
	EntityManager em = emf.createEntityManager();

	Query query = em.createQuery("select c from Custmor c where c.status!='blocked'");

	List<Customer> custmors = query.getResultList();
	
	if(custmors.size()>0)
	   {
		   %>
		   <b>Custmor List</b>
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
		      for(Customer c:custmors){  %>
		    	  
		    	 <tr>
		    	    <th><%=c.getId() %></th>
		    	    <th><%=c.getName() %></th>
		    	    <th><%=c.getEmail() %></th>
		    	    <th><%=c.getPassword() %></th>
		    	    <th><%=c.getMobileNumber() %></th>
		    	    <th><%=c.getStatus() %></th>

		    	    <th><a href="BlockCustmor.jsp?id=<%=c.getId()%>">Block</a></th>
		    	 </tr> 
		    	 <% 
		    	 } 
		    	 %>
		      
		  
		   </table>
		   <a href="adminoptions.html">Back</a>
		  <% }
	else{
		PrintWriter pw = response.getWriter();
		pw.print("No Custmors Available!!!");
		RequestDispatcher rd = request.getRequestDispatcher("adminoptions.html");
		rd.include(request, response);
		response.setContentType("text/html");
		
	}
		  %>  
	
</body>
</html>