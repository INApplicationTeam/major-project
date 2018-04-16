package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.BlogDao;
import dao.NotificationDao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.AllBlogModel;
import model.BlogModel;
import model.FacultyModel;
import model.NotificationModel;
import model.StudentModel;


/**
 * Servlet implementation class PostBlog
 */
public class PostBlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostBlog() {
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

            HttpSession session=request.getSession();
            ServletContext context=getServletContext();
            
            FacultyModel fm;
            StudentModel sm;
            String utype=(String)session.getAttribute("utype");
            String id = null;
            String name="";
            
            if(utype.equals("faculty"))
            {
              fm=(FacultyModel)session.getAttribute("userModel");
              id=fm.getFid();
              name=fm.getName();
            }
            else if(utype.equals("student"))
            {
              sm=(StudentModel)session.getAttribute("userModel");
              id=sm.getSid();
              name=sm.getName();
            }
            
            int did=Integer.parseInt(request.getParameter("did"));
            String title=request.getParameter("title");
            String json=null;
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            
            if(br != null)
            {
            json = br.readLine();
            }
            System.out.println("-------------"+json+"-----------------");
            BlogModel bm=new BlogModel();
            bm.setUid(id);
            bm.setBlogContent(json);
            bm.setDid(did);
            bm.setTitle(title);
            bm.setTimestamp(new Date().getTime());
            bm.setUname(name);
            
            NotificationDao nd=new NotificationDao();
            NotificationModel nm=new NotificationModel();
            String returnJSON="";
            ArrayList<NotificationModel> alnm=null;
            
            BlogDao bd=new BlogDao();
            bd.insertBlog(bm,context);
            
            nm.setUid(id);
            nm.setMessage(bm.getUname()+" wrote a blog : "+bm.getTitle());
            nm.setTimestamp(new Date().getTime());
            
            alnm=nd.notifyBlog(nm,context);
            
            System.out.println(alnm.toString());
            
            Gson gsonObj = new Gson();
            returnJSON=gsonObj.toJson(alnm);
            
            System.out.println(bm.getUname());
            
            AllBlogModel abm=(AllBlogModel)session.getAttribute("myblogs");
            
            if(abm!=null)
            {
                abm.getAbm().add(bm);
            }
            else
            {
                ArrayList<BlogModel> albm=new ArrayList<>();
                albm.add(bm);
                abm=new AllBlogModel();
                abm.setAbm(albm);
            }
            session.setAttribute("myblogs",abm);
            session.setAttribute("blogsNotifier", returnJSON);
            
            response.getWriter().write(json);
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
