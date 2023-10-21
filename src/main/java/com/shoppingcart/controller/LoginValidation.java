package com.shoppingcart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shoppingcart.dto.Admin;
import com.shoppingcart.dto.Customer;
import com.shoppingcart.dto.Merchant;

@WebServlet("/Loginvalidate")
public class LoginValidation extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String choice = req.getParameter("choice");

		if (choice.equals("Customer")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
			EntityManager em = emf.createEntityManager();

			Query query = em.createQuery("select a from Customer a where a.email=?1 and a.password=?2");
			query.setParameter(1, email);
			query.setParameter(2, password);

			List<Customer> customers = query.getResultList();

			if (customers.size() > 0) {

				HttpSession httpSession = req.getSession();
				httpSession.setAttribute("customer", customers.get(0));
				RequestDispatcher rd = req.getRequestDispatcher("customeroption.html");
				rd.forward(req, resp);

			} else {
				PrintWriter pw = resp.getWriter();
				pw.print("invalid Credential");
				RequestDispatcher rd = req.getRequestDispatcher("login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");
			}

		} else if (choice.equals("Merchant")) {

			EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
			EntityManager em = emf.createEntityManager();

			Query query = em.createQuery("select a from Merchant a where a.email=?1 and a.password=?2");
			query.setParameter(1, email);
			query.setParameter(2, password);
			List<Merchant> merchants = query.getResultList();

			if (merchants.size() > 0) {
				Merchant m = merchants.get(0);
				if (m.getStatus().equals("active")) {
					HttpSession httpSession = req.getSession();
					httpSession.setAttribute("merchant", merchants.get(0));

					RequestDispatcher rd = req.getRequestDispatcher("merchantoption.html");
					rd.forward(req, resp);
				} else if (m.getStatus().equals("inactive")) {
					PrintWriter pw = resp.getWriter();
					pw.print("Your Account is not Active");
					RequestDispatcher rd = req.getRequestDispatcher("login.html");
					rd.include(req, resp);
					resp.setContentType("text/html");
				} else if (m.getStatus().equals("blocked")) {
					PrintWriter pw = resp.getWriter();
					pw.print("Your Account is Blocked");
					RequestDispatcher rd = req.getRequestDispatcher("login.html");
					rd.include(req, resp);
					resp.setContentType("text/html");
				}

			} else {
				PrintWriter pw = resp.getWriter();
				pw.print("invalid Credientials");
				RequestDispatcher rd = req.getRequestDispatcher("login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");

			}

		} else if (choice.equals("Admin")) {
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("shopping");
			EntityManager em = emf.createEntityManager();

			Query query = em.createQuery("select a from Admin a where a.email=?1 and a.password=?2");
			query.setParameter(1, email);
			query.setParameter(2, password);
			List<Admin> admins = query.getResultList();

			if (admins.size() > 0) {

				Admin admin = admins.get(0);

				HttpSession hs = req.getSession();
				hs.setAttribute("admin", admin);
				RequestDispatcher rd = req.getRequestDispatcher("adminoption.html");
				rd.forward(req, resp);

			} else {
				PrintWriter pw = resp.getWriter();
				pw.print("invalid Credientials");
				RequestDispatcher rd = req.getRequestDispatcher("login.html");
				rd.include(req, resp);
				resp.setContentType("text/html");

			}

		}

	}
}
