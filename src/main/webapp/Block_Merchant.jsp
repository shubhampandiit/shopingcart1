<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.shoppingcart.dto.Admin"%>
<%@page import="com.shoppingcart.dto.Merchant"%>
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
<title>Block Merchant</title>
</head>
<body>
	<%
	int id =Integer.parseInt(request.getParameter("id"));

	EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	Merchant merchant = em.find(Merchant.class, id);
	merchant.setStatus("blocked");

	int id2 = (Integer) session.getAttribute("id");

	Admin admin = em.find(Admin.class, id2);

	merchant.setAdmin(admin);

	List<Merchant> merchants = new ArrayList<Merchant>();

	merchants.add(merchant);

	admin.setMerchants(merchants);

	et.begin();
	em.merge(merchant);
	em.merge(admin);
	et.commit();

	RequestDispatcher rd = request.getRequestDispatcher("viewblockMerchant.jsp");
	rd.forward(request, response);
	%>
</body>
</html>