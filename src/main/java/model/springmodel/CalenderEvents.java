package model.springmodel;

import javax.persistence.Entity;
import javax.persistence.Table;

public class CalenderEvents {
	
	private String date;
	
	private boolean badge=true;
	
	private String title;
	
	private String body;
	
	private String footer;

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Boolean getBadge() {
		return badge;
	}

	public void setBadge(Boolean badge) {
		this.badge = badge;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getFooter() {
		return footer;
	}

	public void setFooter(String footer) {
		this.footer = footer;
	}

	@Override
	public String toString() {
		return "CalenderEvents [date=" + date + ", badge=" + badge + ", title=" + title + ", body=" + body + ", footer="
				+ footer + "]";
	}
	

}
