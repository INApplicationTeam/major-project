/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author rohan
 */
public class DomainModel {
	
	private int did;
	private String dname;
    public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	private ArrayList<String> domainList;
    private ArrayList<Integer> domainIdList;
    private ArrayList<String> domainImg;
    private ArrayList<String> keyList;
    
    public ArrayList<String> getKeyList() {
        return keyList;
    }

    public void setKeyList(ArrayList<String> keyList) {
        this.keyList = keyList;
    }
    

    public ArrayList<String> getDomainImg() {
        return domainImg;
    }

    public void setDomainImg(ArrayList<String> domainImg) {
        this.domainImg = domainImg;
    }

    public ArrayList<Integer> getDomainIdList() {
        return domainIdList;
    }

    public void setDomainIdList(ArrayList<Integer> domainIdList) {
        this.domainIdList = domainIdList;
    }
    
    public ArrayList<String> getDomainList() {
        return domainList;
    }

    public void setDomainList(ArrayList<String> domainList) {
        this.domainList = domainList;
    }

    

    
    
}
