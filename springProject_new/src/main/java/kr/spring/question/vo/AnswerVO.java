package kr.spring.question.vo;

import javax.validation.constraints.NotEmpty;

public class AnswerVO { //문의답변 테이블
	private int a_num; //답변번호
	private int q_num;	//질문번호
	private int m_num;	//답변자 회원번호
	@NotEmpty
	private String a_content;	//답변내용
	private String answer_date;	//답변 날짜
	private String nickname;	//답변 닉네임
	
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
	
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	
	
	public String getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Override
	public String toString() {
		return "AnswerVO [a_num=" + a_num + ", q_num=" + q_num + ", m_num=" + m_num + ", a_content=" + a_content
				+ ", answer_date=" + answer_date + ", nickname=" + nickname + "]";
	}
	
	
	
	
	
}
