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

import com.google.gson.Gson;

import dao.BlogDao;
import dao.KeyWordDao;
import dao.NotificationDao;
import dao.QuestionDao;
import dao.UserDao;
import model.BlogModel;
import model.DomainModel;
import model.FacultyModel;
import model.NotificationModel;
import model.RelatedQuestionModel;
import model.StudentModel;
import model.UserModel;

/**
 * Servlet implementation class LoadBlogFeed
 */
public class LoadBlogFeed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadBlogFeed() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try (PrintWriter out = response.getWriter()) {
	          
	          HttpSession session=request.getSession();
	          ServletContext context=getServletContext();
	          
	          
	          
	         
		          String utype=(String)session.getAttribute("utype");
		          StudentModel sm;
		          FacultyModel fm;
		          String uid="",name;
		          
		          if(utype.equals("student"))
		          {
		              sm=(StudentModel)session.getAttribute("userModel");
		              uid=sm.getSid();
		              
		          }
		          else if(utype.equals("faculty"))
		          {
		              fm=(FacultyModel)session.getAttribute("userModel");
		              uid=fm.getFid();
		          }
	          
	          

	          
	          
	          
	          BlogDao bd=new BlogDao();
	          
	          ArrayList<BlogModel> albm=bd.getBlogFeed(uid, context);
	          ArrayList<DomainModel> dm=bd.getActiveWorkspaces(context);
	          long blogsCount=bd.getBlogCount(context);
	          ArrayList<UserModel> um=bd.getTopWriters(context);
	          ArrayList<BlogModel> albm1=bd.getTopBlogs(context);
	          
	          session.setAttribute("bloglist", albm);
	          session.setAttribute("activedomainmodel",dm);
	          session.setAttribute("blogcount",blogsCount);
	          session.setAttribute("usermodel",um);
	          session.setAttribute("topbloglist",albm1);
	          
	          response.sendRedirect("Blog_Feed.jsp");
	          
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
