package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class QuestionVO {
	private int num; //질문번호
	private int m_num; //질문한 회원번호
	private int p_num; //질문과 관련된 프로젝트 번호
	@NotEmpty
	private String title; //질문 제목
	@NotEmpty
	private String content; //질문 내용
	private String password; //질문글의 비번
	private Date question_date; //질문 작성 날짜
	private String id;	//회원 아이디
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getQuestion_date() {
		return question_date;
	}
	public void setQuestion_date(Date question_date) {
		this.question_date = question_date;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "QuestionVO [num=" + num + ", m_num=" + m_num + ", p_num=" + p_num + ", title=" + title + ", content="
				+ content + ", password=" + password + ", question_date=" + question_date + ", id=" + id + "]";
	}
	
	
	
	
	
}
