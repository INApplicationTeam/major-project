package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BlogDao;
import model.AllBlogModel;
import model.BlogModel;

/**
 * Servlet implementation class BlogContentSingle
 */
public class BlogContentSingle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlogContentSingle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           ServletContext context=getServletContext();
           HttpSession session=request.getSession();
           
           //int bid=Integer.parseInt(request.getParameter("bid"));
           int bid=2;
           
           BlogDao bd=new BlogDao();
           System.out.println("innnnnnnnn servlet ");
           BlogModel bm=bd.getBlogById(bid, context);
           System.out.println("innnnnnnnn servlet ");
           session.setAttribute("blogmodel",bm);
           response.sendRedirect("Blog_Page.jsp");
    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
