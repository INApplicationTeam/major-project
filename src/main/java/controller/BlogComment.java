package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BlogDao;
import model.BlogCommentModel;
import model.BlogModel;

/**
 * Servlet implementation class BlogComment
 */
public class BlogComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlogComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           ServletContext context=getServletContext();
           //HttpSession session=request.getSession();
           
           BlogCommentModel bcm=new BlogCommentModel();
           
           int bid=Integer.parseInt(request.getParameter("bid").trim());
           
           bcm.setBid(bid);
           bcm.setComment(request.getParameter("comment"));
           bcm.setUid(request.getParameter("uid").trim());
           bcm.setTimestamp(new Date().getTime());
           
           BlogDao bd=new BlogDao();
           System.out.println("innnnnnnnnC servlet ");
           bd.insertComment(bcm, context);
           System.out.println("innnnnnnnnC servlet ");
           response.sendRedirect("BlogContentSingle?bid="+bid);
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
