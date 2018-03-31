/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author rohan
 */

@Entity
@Table(name="student")
public class StudentModel {
	
	@Column(name="Name")
    private String name;
	
	@Id
	
	@Column(name="EnrollmentNo")
    private String sid;
    
	@Column(name="Email")
    private String email;
    
	@Column(name="Branch")
    private String branch;
    
	@Column(name="Sem")
    private String semester;
    
	@Column(name="Section")
    private String section;
   
	@Column(name="Password")
    private String password;
    
	@Column(name="SecurityQuestion")
    private String securityque;
    
	@Column(name="SecurityAnswer")
    private String securityans;
    
	@Column(name="aboutme")
    private String aboutme;
	
	@Column(name="batch")
    private int batch;

	@Transient
	String classId;
	
	
    public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public void setClassId()
	{
		classId=branch+"-"+semester+"-"+section+"-"+batch;
	}
	
	public void setClassAttributes(String classid)
	{
		this.classId=classid;
		String temp[]=classid.split("-");
		this.branch=temp[0];
		this.semester=temp[1];
		this.section=temp[2];
		this.batch=Integer.parseInt(temp[3]);
		
	}
	public int getBatch() {
		return batch;
	}

	public void setBatch(int batch) {
		this.batch = batch;
	}

	public String getAboutme() {
        return aboutme;
    }

    public void setAboutme(String aboutme) {
        this.aboutme = aboutme;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSecurityque() {
        return securityque;
    }

    public void setSecurityque(String securityque) {
        this.securityque = securityque;
    }

    public String getSecurityans() {
        return securityans;
    }

    public void setSecurityans(String securityans) {
        this.securityans = securityans;
    }

	@Override
	public String toString() {
		return "StudentModel [name=" + name + ", sid=" + sid + ", email=" + email + ", branch=" + branch + ", semester="
				+ semester + ", section=" + section + ", password=" + password + ", securityque=" + securityque
				+ ", securityans=" + securityans + ", aboutme=" + aboutme + ", batch=" + batch + "]";
	}
	
	@Override
    public boolean equals(Object o)
    {
    	StudentModel sm=null;
    	if(o instanceof StudentModel)
        	{
    		sm=(StudentModel)o;
    	
    	if(this.getSid().equals(sm.getSid()))
		return true;
    	}   	
    	return false;
   	
   }

	
    
}
