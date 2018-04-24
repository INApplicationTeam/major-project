package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;

import java.sql.Connection;
import model.AnswerModel;
import model.NotificationModel;
import model.QuestionModel;
import model.pollmodel.CreateNewPollModel;
import model.springmodel.ClassSubjectFaculty;

public class NotificationDao {
	
	Connection con;
    PreparedStatement ps;
    String qr,qr1,qr2,qr3;
    ResultSet rs,rs1;
    
	public ArrayList<NotificationModel> notifyWhenAnswered(NotificationModel nm,QuestionModel qm,ServletContext context)
	{
		 con=(Connection)context.getAttribute("datacon");
		 qr="insert into notifications(message,timestamp) values(?,?)";
		 qr1="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		 qr2="select followerId from questionfollowers where qid=?";
		 
		 ArrayList<NotificationModel> alnm=new ArrayList<>();
		 NotificationModel nm1;
		 try {
			
			 ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			 ps.setString(1,nm.getMessage());
			 ps.setLong(2,nm.getTimestamp());
			 ps.executeUpdate();
			 rs = ps.getGeneratedKeys();
			 
			 if(rs.next())
			 {
				 nm.setNid(rs.getInt(1));
			 }
			
			 QuestionModel qm1=new QuestionModel();
			 qm1.setQid(qm.getQid());
			 new QuestionDao().isFollowed(qm1,qm.getUid(),context);
			 
			 if(!qm1.isFollowed())
			{
				ps=con.prepareStatement(qr1);
				ps.setInt(1,nm.getNid());
				ps.setString(2,nm.getUid());
				ps.setBoolean(3,nm.isViewed());
				ps.executeUpdate();
				alnm.add(nm);
			}
			
			ps=con.prepareStatement(qr2);
			ps.setInt(1,qm.getQid());
			rs=ps.executeQuery();
			
			String followerId=null;
			
			while(rs.next())
			{
				followerId=rs.getString(1);
				
				nm1=new NotificationModel();
				nm1.setMessage(nm.getMessage());
				nm1.setUid(followerId);
				nm1.setNid(nm.getNid());
				nm1.setViewed(false);
				nm1.setTimestamp(nm.getTimestamp());
				
				ps=con.prepareStatement(qr1);
				ps.setInt(1,nm1.getNid());
				ps.setString(2,nm1.getUid());
				ps.setBoolean(3,nm1.isViewed());
				ps.executeUpdate();
				
				alnm.add(nm1);
				
			}
			
			return alnm;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
	}
	
	public ArrayList<NotificationModel> notifyPollsForYou(CreateNewPollModel cnpm,ServletContext context)
	{
		 con=(Connection)context.getAttribute("datacon");
		 qr1="select question from pollquedetails where queid=?";
		 qr2="insert into notifications(message,timestamp) values(?,?)";
		 qr3="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		 String que="";
		 
		 
		 
		 try {
			ps=con.prepareStatement(qr1);
			ps.setInt(1,cnpm.getPollqueid());
			rs=ps.executeQuery();
			
			if(rs.next())
			{
				que=rs.getString(1);
			}
			
			ArrayList<NotificationModel> alnm=new ArrayList<>();
			NotificationModel nm=new NotificationModel();
			NotificationModel nm1;
			nm.setMessage(cnpm.getCreatorName()+" created Poll :"+que+" for you.");
			nm.setTimestamp(new Date().getTime());
			 
			ps=con.prepareStatement(qr2,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,nm.getMessage());
			ps.setLong(2,nm.getTimestamp()); 
			 
			if(ps.executeUpdate()>0)
			{
				rs = ps.getGeneratedKeys();
				 
				if(rs.next())
				{
					nm.setNid(rs.getInt(1));
					
					if(cnpm.getBranch().equalsIgnoreCase("ALL") && cnpm.getSem().equalsIgnoreCase("0") && cnpm.getSec().equalsIgnoreCase("0"))
					{
						if(cnpm.getPollviewer().equalsIgnoreCase("ALL"))
						{
							qr="select uid from allusers";
							ps=con.prepareStatement(qr);
						}
						
						else if(cnpm.getPollviewer().equalsIgnoreCase("STUDENT"))
						{
							qr="select EnrollmentNo from student";
							ps=con.prepareStatement(qr);
						}
						
						else if(cnpm.getPollviewer().equalsIgnoreCase("FACULTY"))
						{
							qr="select FacultyId from faculty";
							ps=con.prepareStatement(qr);
						}
					}
					
					else if(!cnpm.getBranch().equalsIgnoreCase("ALL") && cnpm.getSem().equalsIgnoreCase("0") && cnpm.getSec().equalsIgnoreCase("0"))
					{
						if(cnpm.getPollviewer().equalsIgnoreCase("ALL"))
						{
							qr="select EnrollmentNo from student where branch=? union select FacultyId from faculty where department=?";
							ps=con.prepareStatement(qr);
							ps.setString(1,cnpm.getBranch());
						}
							
						else if(cnpm.getPollviewer().equalsIgnoreCase("STUDENT"))
						{
							qr="select EnrollmentNo from student where branch=?";
							ps=con.prepareStatement(qr);
							ps.setString(1,cnpm.getBranch());
						}
							
						else if(cnpm.getPollviewer().equalsIgnoreCase("FACULTY"))
						{
							qr="select FacultyId from faculty where department=?";
							ps=con.prepareStatement(qr);
							ps.setString(1,cnpm.getBranch());
						}
					}
					
					else if(cnpm.getPollviewer().equalsIgnoreCase("student"))
					{
						if(cnpm.getBranch().equalsIgnoreCase("ALL"))
						{
							if(cnpm.getSem().equalsIgnoreCase("0"))
							{
								if(!cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where section=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getSec());
								}
							}
							else if(!cnpm.getSem().equalsIgnoreCase("0"))
							{
								if(cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where sem=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getSem());
								}
								else if(!cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where sem=? and section=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getSem());
									ps.setString(2,cnpm.getSec());
								}
							}
						}
						else if(!cnpm.getBranch().equalsIgnoreCase("ALL"))
						{
							if(cnpm.getSem().equalsIgnoreCase("0"))
							{
								if(!cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where branch=? and section=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getBranch());
									ps.setString(2,cnpm.getSec());
								}
							}
							else if(!cnpm.getSem().equalsIgnoreCase("0"))
							{
								if(cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where sem=? and branch=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getSem());
									ps.setString(2,cnpm.getBranch());
								}
								else if(!cnpm.getSec().equalsIgnoreCase("0"))
								{
									qr="select EnrollmentNo from student where sem=? and branch=? and section=?";
									ps=con.prepareStatement(qr);
									ps.setString(1,cnpm.getSem());
									ps.setString(2,cnpm.getBranch());
									ps.setString(3,cnpm.getSec());
								}
							}
						}
					}
					
					rs=ps.executeQuery();
					String uid=null;
					
					
					while(rs.next())
					{
						uid=rs.getString(1);
						nm1=new NotificationModel();
						nm1.setMessage(nm.getMessage());
						nm1.setNid(nm.getNid());
						nm1.setTimestamp(nm.getTimestamp());
						nm1.setUid(uid);
						nm1.setViewed(nm.isViewed());
						alnm.add(nm1);
						
						ps=con.prepareStatement(qr3);
						ps.setInt(1,nm1.getNid());
						ps.setString(2,nm1.getUid());
						ps.setBoolean(3,nm1.isViewed());
						ps.executeUpdate();
					}
					return alnm;
				}
				 
			}
			 
			
		 }
		catch (SQLException e1)
		{
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			 
		return null;	 
		 
	}
	
	public ArrayList<NotificationModel> notifyWhenFollowed(NotificationModel nm,ServletContext context)
	{
		 con=(Connection)context.getAttribute("datacon");
		 
		 qr="insert into notifications(message,timestamp) values(?,?)";
		 qr1="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		 
		 ArrayList<NotificationModel> alnm=new ArrayList<>();
		
		 try {
			ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,nm.getMessage());
			ps.setLong(2,nm.getTimestamp());
			
			if(ps.executeUpdate()>0)
			{
				rs = ps.getGeneratedKeys();
				if(rs.next())
				{
					nm.setNid(rs.getInt(1));
					
					ps=con.prepareStatement(qr1);
					ps.setInt(1,nm.getNid());
					ps.setString(2,nm.getUid());
					ps.setBoolean(3,false);
					ps.executeUpdate();
					
					alnm.add(nm);
					return alnm;
				}
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
		
	}
	
	public ArrayList<NotificationModel> showAllNotifications(String uid,ServletContext context)
	{
		 con=(Connection)context.getAttribute("datacon");
		 qr="select * from notifications where nid in (select nid from usernotifications where uid=? and isViewed= 'false')";
		 ArrayList<NotificationModel> alnm=new ArrayList<>();
		 NotificationModel nm=null;
		 
		 try{
			 ps=con.prepareStatement(qr);
			 ps.setString(1,uid);
			 rs=ps.executeQuery();
			 
			 while(rs.next())
			 {
				 nm=new NotificationModel();
				 nm.setNid(rs.getInt(1));
				 nm.setMessage(rs.getString(2));
				 nm.setTimestamp(rs.getLong(3));
				 nm.setUid(uid);
				 nm.setViewed(false);
				 alnm.add(nm);
			 }
			 
			 return alnm;
		 }
		 catch (SQLException e) 
		 {
			 e.printStackTrace();
		 }
		return null;
	}

	public boolean notificationViewed(String nid, String uid, ServletContext context) {
		
		con=(Connection)context.getAttribute("datacon");
		String qr="update usernotifications set isViewed=? where nid=? and uid=?";
		try{
			ps=con.prepareStatement(qr);
			ps.setBoolean(1,true);
			ps.setString(2,nid);
			ps.setString(3,uid);
			System.out.println(ps);
			return ps.executeUpdate()>0;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return false;
	}

	
	public boolean notifyA2A(NotificationModel nm,ServletContext context)
	{
		con=(Connection)context.getAttribute("datacon");
		 
		qr="insert into notifications(message,timestamp) values(?,?)";
		qr1="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		
		try {
			ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,nm.getMessage());
			ps.setLong(2,nm.getTimestamp());
			
			if(ps.executeUpdate()>0)
			{	
				rs = ps.getGeneratedKeys();
				if(rs.next())
				{
					nm.setNid(rs.getInt(1));
					ps=con.prepareStatement(qr1);
					ps.setInt(1,nm.getNid());
					ps.setString(2,nm.getUid());
					ps.setBoolean(3,false);
					
					return ps.executeUpdate()>0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public ArrayList<NotificationModel> notifyBlog(NotificationModel nm, ServletContext context) {
		
		con=(Connection)context.getAttribute("datacon");
		String qr="insert into notifications(message,timestamp) values(?,?)";
		String qr1="insert into usernotifications values(?,?,?)";
		String qr2="select otherUserId from userfollowers where myUserId=?";
		
		try {
			ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, nm.getMessage());
			ps.setLong(2, nm.getTimestamp());
			
			if(ps.executeUpdate()>0)
			{
				rs=ps.getGeneratedKeys();
				if(rs.next())
				{
          nm.setNid(rs.getInt(1));

          ps=con.prepareStatement(qr2);
          ps.setString(1, nm.getUid());
          rs=ps.executeQuery();

          NotificationModel nm1;
          ArrayList<NotificationModel> alnm=new ArrayList<>();

          while(rs.next())
          {
            nm1=new NotificationModel();
            ps=con.prepareStatement(qr1);
            ps.setInt(1, nm.getNid());
            ps.setString(2, rs.getString(1));
            ps.setBoolean(3, false);

            ps.executeUpdate();

            nm1.setNid(nm.getNid());
            nm1.setUid(rs.getString(1));
            nm1.setViewed(false);
            nm1.setMessage(nm.getMessage());
            nm1.setTimestamp(nm.getTimestamp());

            alnm.add(nm1);
          }
  				return alnm;
				}
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
  }
	public ArrayList<NotificationModel> addClassPostNotification(NotificationModel nm, String classId,ServletContext context) 
	{
		ClassSubjectFaculty classSubjectFaculty=new ClassSubjectFaculty();
		classSubjectFaculty.setClassAttributes(classId);
		
		con=(Connection)context.getAttribute("datacon");
		qr="insert into notifications(message,timestamp) values(?,?)";
		qr1="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		qr2="select EnrollmentNo from student where branch=? and sem=? and section=? and batch=? union select uid from class_subject_faculty where classid=? union select uid from class_coordinators where classid=?";
		
		ArrayList<NotificationModel> alnm=new ArrayList<>();
		NotificationModel nm1;
		 
		try {
			
			 ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			 ps.setString(1,nm.getMessage());
			 ps.setLong(2,nm.getTimestamp());
			 ps.executeUpdate();
			 rs = ps.getGeneratedKeys();
			 
			 if(rs.next())
			 {
				 nm.setNid(rs.getInt(1));
			 }
			
			 ps=con.prepareStatement(qr2);
			 ps.setString(1,classSubjectFaculty.getBranch());
			 ps.setInt(2,classSubjectFaculty.getSem());
			 ps.setString(3,classSubjectFaculty.getSec()+"");
			 ps.setInt(4,classSubjectFaculty.getBatch());
			 ps.setString(5,classSubjectFaculty.getClassid());
			 ps.setString(6,classSubjectFaculty.getClassid());
			 rs=ps.executeQuery();
			 
			 while(rs.next())
			 {
				 ps=con.prepareStatement(qr1);
				 ps.setInt(1,nm.getNid());
				 ps.setString(2,rs.getString(1));
				 ps.setBoolean(3,false);
				 ps.executeUpdate();
				 
				 nm1=new NotificationModel();
				 nm1.setMessage(nm.getMessage());
				 nm1.setNid(nm.getNid());
				 nm1.setTimestamp(nm.getTimestamp());
				 nm1.setViewed(false);
				 nm1.setUid(rs.getString(1));
				 
				 alnm.add(nm1);
			 }
			 
			return alnm;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void onMessageNotification(NotificationModel nm, ServletContext context) 
	{
		con=(Connection)context.getAttribute("datacon");
		qr="insert into notifications(message,timestamp) values(?,?)";
		qr1="insert into usernotifications(nid,uid,isViewed) values(?,?,?)";
		
		try {
			
			 ps=con.prepareStatement(qr,Statement.RETURN_GENERATED_KEYS);
			 ps.setString(1,nm.getMessage());
			 ps.setLong(2,nm.getTimestamp());
			 ps.executeUpdate();
			 rs = ps.getGeneratedKeys();
			 
			 if(rs.next())
			 {
				 nm.setNid(rs.getInt(1));
			 }
			
			 ps=con.prepareStatement(qr1);
			 ps.setInt(1,nm.getNid());
			 ps.setString(2,nm.getUid());
			 ps.setBoolean(3,false);
			 ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
