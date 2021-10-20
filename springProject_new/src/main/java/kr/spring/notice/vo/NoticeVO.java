package kr.spring.notice.vo;

import java.sql.Clob;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class NoticeVO {
	@NotEmpty
	private int num;//공지사항 번호
	@NotEmpty
	private int p_num; //프로젝트 번호(0:전체공지)
	@NotEmpty
	private String title; //공지사항 제목
	@NotEmpty
	private Clob content; //공지사항 내용
	@NotEmpty
	private Date not_date; //공지 날짜
	@NotEmpty
	private Date mod_date; //수정 날짜
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Clob getContent() {
		return content;
	}
	public void setContent(Clob content) {
		this.content = content;
	}
	public Date getNot_date() {
		return not_date;
	}
	public void setNot_date(Date not_date) {
		this.not_date = not_date;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	@Override
	public String toString() {
		return "NoticeVO [num=" + num + ", p_num=" + p_num + ", title=" + title + ", content=" + content + ", not_date="
				+ not_date + ", mod_date=" + mod_date + "]";
	}
	
	
	
	
}
