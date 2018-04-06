/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import model.AllBlogModel;
import model.BlogCommentModel;
import model.BlogModel;
import model.BlogReplyModel;

/**
 *
 * @author rohan
 */
public class BlogDao {
    Connection con;
    PreparedStatement ps;
    String qr;
    ResultSet rs;
    
    public boolean insertBlog(BlogModel bm,ServletContext context)
    {
        try {
            con=(Connection)context.getAttribute("datacon");
            ArrayList<String> dlist=(ArrayList<String>)context.getAttribute("dlist");
            bm.setDname(dlist.get(bm.getDid()-1));
            
            qr="insert into blogs(uid,blogcontent,timestamp,upvote,did,blogtitle) values(?,?,?,?,?,?)";
            ps=con.prepareStatement(qr);
            ps.setString(1,bm.getUid());
            ps.setString(2,bm.getBlogContent());
            ps.setString(3,bm.getTimestamp());
            ps.setInt(4,bm.getUpvotes());
            ps.setInt(5,bm.getDid());
            ps.setString(6,bm.getTitle());
            
            return (ps.executeUpdate()>0);
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public void getMyBlogs(AllBlogModel abm,String id,ServletContext context)
    {
        qr="select blogid,blogs.uid,blogcontent,timestamp,upvote,did,blogtitle,allusers.uname from blogs natural join allusers where uid=? order by blogid desc";
        con=(Connection)context.getAttribute("datacon");
        ArrayList<String>dlist=(ArrayList<String>)context.getAttribute("dlist");
        BlogModel bm;
        ArrayList<BlogModel> albm=new ArrayList<>();
        
        try {
            ps=con.prepareStatement(qr);
            ps.setString(1,id);
            rs=ps.executeQuery();
            
            while(rs.next())
            {
             bm=new BlogModel();
             bm.setBlogId(rs.getInt(1));
             bm.setUid(rs.getString(2));
             bm.setBlogContent(rs.getString(3));
             bm.setTimestamp(rs.getString(4));
             bm.setUpvotes(rs.getInt(5));
             bm.setDid(rs.getInt(6));
             bm.setTitle(rs.getString(7));
             bm.setUname(rs.getString(8));
             bm.setDname(dlist.get(rs.getInt(6)-1));
             
             albm.add(bm);
            }
            abm.setAbm(albm);
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }
    
    public void updateBlog(BlogModel bm,ServletContext context)
    {
        
        try {
            con=(Connection)context.getAttribute("datacon");
            qr="update blogs set blogcontent=? where blogid=?";
            ps=con.prepareStatement(qr);
            ps.setString(1,bm.getBlogContent());
            ps.setInt(2,bm.getBlogId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getBlogContent(int did,AllBlogModel abm,ServletContext context)
    {
        try {
            con=(Connection)context.getAttribute("datacon");
            String qr="select blogid,blogs.uid,blogcontent,timestamp,upvote,did,blogtitle,uname from blogs inner join allusers on blogs.uid=allusers.uid where did=? order by blogid desc";
            ps=con.prepareStatement(qr);
            ps.setInt(1, did);
            rs=ps.executeQuery();
            
            BlogModel bm;
            ArrayList<BlogModel> albm=new ArrayList<>();
            ArrayList<String> dlist=(ArrayList<String>)context.getAttribute("dlist");
            String dname=dlist.get(did-1);
            
            while(rs.next())
            {
            bm=new BlogModel();
            bm.setBlogId(rs.getInt(1));
            bm.setUid(rs.getString(2));
            bm.setBlogContent(rs.getString(3));
            bm.setTimestamp(rs.getString(4));
            bm.setUpvotes(rs.getInt(5));
            bm.setDid(rs.getInt(6));
            bm.setTitle(rs.getString(7));
            bm.setUname(rs.getString(8));
            bm.setDname(dname);
            
            albm.add(bm);
            }
            
            abm.setAbm(albm);
            return dname;
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
    }
    
    public BlogModel getBlogById(int bid,ServletContext context)
    {
    	con=(Connection)context.getAttribute("datacon");
    	String qr="select blogid,blogs.uid,blogcontent,timestamp,upvote,did,blogtitle,uname from blogs inner join allusers on blogs.uid=allusers.uid where blogid=?";
    	try {
			ps=con.prepareStatement(qr);
			ps.setInt(1, bid);
			
			rs=ps.executeQuery();
			
			BlogModel bm=new BlogModel();
			ArrayList<String> dlist=(ArrayList<String>)context.getAttribute("dlist");
            //String dname=dlist.get(did-1);
			
			if(rs.next())
			{
				bm.setBlogId(rs.getInt(1));
	            bm.setUid(rs.getString(2));
	            bm.setBlogContent(rs.getString(3));
	            bm.setTimestamp1(rs.getLong(4));
	            bm.setUpvotes(rs.getInt(5));
	            bm.setDid(rs.getInt(6));
	            bm.setTitle(rs.getString(7));
	            bm.setUname(rs.getString(8));
	            bm.setDname(dlist.get(rs.getInt(6)-1));
			}
			
			String qr1="select bid,cid,comment,timestamp,allusers.uid,likes,flag,uname from blogcomments inner join allusers on blogcomments.uid=allusers.uid where bid=?";
			ps=con.prepareStatement(qr1);
			ps.setInt(1, bid);
			
			rs=ps.executeQuery();
			BlogCommentModel bcm;
			ArrayList<BlogCommentModel> arbcm=new ArrayList<>();
			
			PreparedStatement ps1=null;
			ResultSet rs1=null;
			
			while(rs.next())
			{
				bcm=new BlogCommentModel();
				bcm.setBid(bid);
				bcm.setCid(rs.getInt(2));
				bcm.setComment(rs.getString(3));
				bcm.setTimestamp(rs.getLong(4));
				bcm.setUid(rs.getString(5));
				bcm.setLikes(rs.getInt(6));
				bcm.setFlags(rs.getInt(7));
				bcm.setUname(rs.getString(8));
				
				String qr2="select rid,cid,reply,timestamp,likes,flag,allusers.uid,uname from blog_comment_replies inner join allusers on blog_comment_replies.uid=allusers.uid where cid=?";
				ps1=con.prepareStatement(qr2);
				ps1.setInt(1, rs.getInt(2));
				
				rs1=ps1.executeQuery();
				BlogReplyModel brm;
				ArrayList<BlogReplyModel> arbrm=new ArrayList<>();
				
				while(rs1.next())
				{
					brm=new BlogReplyModel();
					brm.setRid(rs.getInt(1));
					brm.setCid(rs.getInt(2));
					brm.setReply(rs.getString(3));
					brm.setTimestamp(rs.getLong(4));
					brm.setLikes(rs.getInt(5));
					brm.setFlags(rs.getInt(6));
					brm.setUid(rs.getString(7));
					brm.setUname(rs.getString(8));
					
					arbrm.add(brm);
				}
				bcm.setArbrm(arbrm);
				
				arbcm.add(bcm);
				
			}
			bm.setArbcm(arbcm);
			
			return bm;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		return null;
    	
    }
    
    public int incVote(BlogModel bm,ServletContext context)
    {
        try {
            con=(Connection)context.getAttribute("datacon");
            String qr0="select status from voterblogdetail where bid=? and voterid=?";
            ps=con.prepareStatement(qr0);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            
            rs=ps.executeQuery();
            boolean flag=rs.next();
            if(!flag) //
            {
            String qr="update blogs set upvote=upvote+1 where blogid=?";
            
            ps=con.prepareStatement(qr);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr1="insert into voterblogdetail values(?,?,?)";
            ps=con.prepareStatement(qr1);
            
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.setString(3,"up");
            ps.executeUpdate();
            }
            else 
            {
            if(rs.getString(1).equals("down"))
            {
            String qr3="update blogs set upvote=upvote+2 where blogid=?";
            
            ps=con.prepareStatement(qr3);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr4="update voterblogdetail set status='up' where bid=? and voterid=?";
            ps=con.prepareStatement(qr4);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.executeUpdate();
            }
            else if(rs.getString(1).equals("up"))
            {
            String qr5="update blogs set upvote=upvote-1 where blogid=?";
            
            ps=con.prepareStatement(qr5);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr6="delete from voterblogdetail where bid=? and voterid=?";
            ps=con.prepareStatement(qr6);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.executeUpdate();
            }
            }
            
            String qr2="select upvote from blogs where blogid=?";
            ps=con.prepareStatement(qr2);
            ps.setInt(1,bm.getBlogId());
            rs=ps.executeQuery();
            
            int voteCount=0;
            if(rs.next())
            {
                voteCount=rs.getInt(1);
            }
            return voteCount;
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    return 0;
    }
    
    
    
    
    public int decVote(BlogModel bm,ServletContext context)
    {
        try {
            con=(Connection)context.getAttribute("datacon");
            String qr0="select status from voterblogdetail where bid=? and voterid=?";
            ps=con.prepareStatement(qr0);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            
            rs=ps.executeQuery();
            boolean flag=rs.next();
            if(!flag) //
            {
            String qr="update blogs set upvote=upvote-1 where blogid=?";
            
            ps=con.prepareStatement(qr);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr1="insert into voterblogdetail values(?,?,?)";
            ps=con.prepareStatement(qr1);
            
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.setString(3,"down");
            ps.executeUpdate();
            }
            else 
            {
            if(rs.getString(1).equals("up"))
            {
            String qr3="update blogs set upvote=upvote-2 where blogid=?";
            
            ps=con.prepareStatement(qr3);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr4="update voterblogdetail set status='down' where bid=? and voterid=?";
            ps=con.prepareStatement(qr4);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.executeUpdate();
            }
            else if(rs.getString(1).equals("down"))
            {
            String qr5="update blogs set upvote=upvote+1 where blogid=?";
            
            ps=con.prepareStatement(qr5);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr6="delete from voterblogdetail where bid=? and voterid=?";
            ps=con.prepareStatement(qr6);
            ps.setInt(1,bm.getBlogId());
            ps.setString(2,bm.getUid());
            ps.executeUpdate();
            }
            }
            
            String qr2="select upvote from blogs where blogid=?";
            ps=con.prepareStatement(qr2);
            ps.setInt(1,bm.getBlogId());
            rs=ps.executeQuery();
            
            int voteCount=0;
            if(rs.next())
            {
                voteCount=rs.getInt(1);
            }
            return voteCount;
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    return 0;
    }
    
    public void deleteBlog(BlogModel bm,ServletContext context)
    {
        try {
            con=(Connection)context.getAttribute("datacon");
            String qr="delete from voterblogdetail where bid=?";
            ps=con.prepareStatement(qr);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
            String qr1="delete from blogs where blogid=?";
            ps=con.prepareStatement(qr1);
            ps.setInt(1,bm.getBlogId());
            ps.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
     public long getBlogCount(ServletContext context) {
        try {
            long count=0;
            con=(Connection)context.getAttribute("datacon");
            String qr="select count(blogid) from blogs";
            ps=con.prepareStatement(qr);
            rs=ps.executeQuery();
            
            if(rs.next())
            {
                count=rs.getLong(1);
            }
            
              
            return count;
        } catch (SQLException ex) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    
}
