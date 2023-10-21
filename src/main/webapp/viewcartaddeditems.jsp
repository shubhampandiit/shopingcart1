<%@page import="java.io.PrintWriter"%>
<%@page import="com.shoppingcart.dto.Item"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Cart"%>
<%@page import="com.shoppingcart.dto.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	Customer customers=(Customer)session.getAttribute("customer");
	Cart cart=customers.getCart();
	List<Item>items=cart.getItems();
	if(items.size()>0)
	{
%>
	<table border="0px" align="center" cellpadding="20px" >
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>Category</th>
				<th>quantity</th>
				<th>price</th>
				<th>Remove</th>
			</tr>
			
			<%
				for(Item i:items)
				{
			%>
				<tr>
				<td><%=i.getId()%></td>
				<td><%=i.getName() %></td>
				<td><%=i.getCategory() %></td>
				<td><%=i.getQuantity() %></td>
				<td><%=i.getQuantity()%> X <%=i.getPrice()%></td>
				<td><a href="removeitemfromcart.jsp?id=<%=i.getId()%>">Remove</a></td>
				</tr>
				<%} %>
			
			<tr>
			<td></td>
			<td></td>
			<td>Total price</td>
			<td></td>
			<td><%=cart.getTotalPrice()%></td>
			</tr>			 
			
		</table>
		
		<%}else
			{
				PrintWriter pw=response.getWriter();
				pw.write("No items added to cart!");
				RequestDispatcher rd=request.getRequestDispatcher("searchproduct.jsp");
				rd.include(request, response);
			}%>

</body>
</html>