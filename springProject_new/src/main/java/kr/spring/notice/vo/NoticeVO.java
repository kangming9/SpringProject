package kr.spring.notice.vo;

import java.sql.Clob;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class NoticeVO {
	private int num;//공지사항 번호
	private int p_num; //프로젝트 번호(0:전체공지)
	private int m_num; //작성자 번호
	@NotEmpty
	private String title; //공지사항 제목
	@NotEmpty
	private String content; //공지사항 내용
	private Date not_date; //공지 날짜
	private Date mod_date; //수정 날짜
	private String nickname; //작성자 닉네임
	private String p_name; //프로젝트 이름
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
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	@Override
	public String toString() {
		return "NoticeVO [num=" + num + ", p_num=" + p_num + ", m_num=" + m_num + ", title=" + title + ", content=" + content + ", not_date="
				+ not_date + ", mod_date=" + mod_date + "]";
	}
	
	
	
	
}
