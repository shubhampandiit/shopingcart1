<%@page import="java.io.PrintWriter"%>
<%@page import="javax.swing.text.StyledEditorKit.ForegroundAction"%>
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
<title>Approve merchant</title>
<style type="text/css">
body{
color:yellow;
background-color: black;
}

b{
margin-left:390px;
 color: red;
 font-size: 50px;

}
#back{
font-size: 30px;
margin-left: 50px;
}

</style>
</head>
<body>
<% 
   EntityManagerFactory emf=Persistence.createEntityManagerFactory("shopping");
   EntityManager em= emf.createEntityManager();
   
   Query query = em.createQuery("select a from Merchant a where a.status='inactive'");
   List<Merchant>merchants = query.getResultList();
   
   if(merchants.size()>0){
	   %>
	   <b>Inactive Merchant </b>
	   <table  cellpadding="10" align="center" border="20">
           <tr>
            <th>id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Mobile Number</th>
            <th>status</th>
            <th>Approve</th>
         </tr>
         
         
         <%
              for(Merchant m:merchants){ %>
              
              <tr>
                <td><%=m.getId() %></td>
                <td><%=m.getName()%></td>
                <td><%=m.getEmail()%></td>
                <td><%=m.getPassword()%></td>
                <td><%=m.getMobileNumber()%></td>
                <td><%=m.getStatus()%></td>
                <td><a href="merchantstatusactive.jsp?id=<%=m.getId()%>">Approve</a></td>
         
         <% }  %> 
         
         </table>
         
          <a  id="back" href="adminoptions.html">Back</a>
         <% 
     }
   
              
   else{
    
	 PrintWriter pw=response.getWriter();
     pw.print("No Merchants To Be Approved");

     RequestDispatcher rd=request.getRequestDispatcher("adminoptions.html");
     rd.include(request, response);
     response.setContentType("text/html");

              }
    %>
	   
	   


</body>
</html>