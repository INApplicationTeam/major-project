package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BlogDao;
import model.AllBlogModel;
import model.BlogModel;
import model.DomainModel;
import model.FacultyModel;
import model.StudentModel;
import model.UserModel;

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
           
           int bid=Integer.parseInt(request.getParameter("bid"));
           //int bid=2;
           
           BlogDao bd=new BlogDao();
           System.out.println("innnnnnnnn servlet ");
           BlogModel bm=bd.getBlogById(bid, context);
           ArrayList<BlogModel> albm=bd.getRecentBlogs(bm.getDid(),context);
           
           String utype=(String)session.getAttribute("utype");
           StudentModel sm;
           FacultyModel fm;
           String id="";
           if(utype.equals("student"))
           { 
               sm=(StudentModel)session.getAttribute("userModel");
               id=sm.getSid();
           }
           
           else if(utype.equals("faculty"))
           { 
               fm=(FacultyModel)session.getAttribute("userModel");
               id=fm.getFid();
           }
           
           String status=bd.getBlogStatusForUser(id,bid,context);
           
           bm.setBlogId(bid);
           System.out.println("innnnnnnnn servlet ");
           session.setAttribute("blogmodel",bm);
           session.setAttribute("recentblogsmodel", albm);
           session.setAttribute("status", status);
           
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
