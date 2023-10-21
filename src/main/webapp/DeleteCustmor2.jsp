<%@page import="com.shoppingcart.dto.Customer"%>
<%@page import="javax.persistence.EntityTransaction"%>
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
</head>
<body>
<%
int id =Integer.parseInt(request.getParameter("id"));

EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
EntityManager em = emf.createEntityManager();
EntityTransaction et = em.getTransaction();

Customer custmor = em.find(Customer.class, id);

et.begin();
em.remove(custmor);
et.commit();

RequestDispatcher rd = request.getRequestDispatcher("Delete_custmor.jsp");
rd.forward(request, response);

%>
</body>
</html>