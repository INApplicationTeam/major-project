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

/**
 * Servlet implementation class MyBlogFeed
 */
public class MyBlogFeed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBlogFeed() {
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
           
           String uid="s14cs105";
           
           ArrayList<BlogModel> arbm;
           
           BlogDao bd=new BlogDao();
           arbm=bd.getBlogFeed(uid, context);
           for(BlogModel bm : arbm)
           {
        	   System.out.println(bm.toString());
           }
           session.setAttribute("feedBlogs",arbm);
           //response.sendRedirect("Blogs_Page.jsp?dname="+dname+"&did="+did);
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
