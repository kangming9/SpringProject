package kr.spring.question.vo;

import java.sql.Clob;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class AnswerVO { //문의답변 테이블
	@NotEmpty
	private int num; //답변번호
	@NotEmpty
	private int q_num;	//질문번호
	@NotEmpty
	private int m_num;	//답변자 회원번호
	@NotEmpty
	private Clob content;	//답변내용
	@NotEmpty
	private Date answer_date;	//답변 날짜
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
	}
	public Clob getContent() {
		return content;
	}
	public void setContent(Clob content) {
		this.content = content;
	}
	public Date getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}
	@Override
	public String toString() {
		return "AnswerVO [num=" + num + ", q_num=" + q_num + ", m_num=" + m_num + ", content=" + content
				+ ", answer_date=" + answer_date + "]";
	}
	
	
	
}
