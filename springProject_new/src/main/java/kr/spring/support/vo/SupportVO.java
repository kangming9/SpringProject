package kr.spring.support.vo;

import javax.validation.constraints.NotEmpty;

public class SupportVO {//후원 테이블
	@NotEmpty
	private int num; //후원 번호
	@NotEmpty
	private int m_num;//후원자 회원번호
	@NotEmpty
	private int p_num; //후원한 프로젝트번호
	@NotEmpty
	private int payment; //후원금 결제 여부
	@NotEmpty
	private int g_num; //선택한 선물 번호
	@NotEmpty
	private int support_amount; //전체 후원금액
	private String gift_option;//후원의 추가적인 옵션 사항
	private int donation; //추가후원금액
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
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public int getG_num() {
		return g_num;
	}
	public void setG_num(int g_num) {
		this.g_num = g_num;
	}
	public int getSupport_amount() {
		return support_amount;
	}
	public void setSupport_amount(int support_amount) {
		this.support_amount = support_amount;
	}
	public String getGift_option() {
		return gift_option;
	}
	public void setGift_option(String gift_option) {
		this.gift_option = gift_option;
	}
	public int getDonation() {
		return donation;
	}
	public void setDonation(int donation) {
		this.donation = donation;
	}
	@Override
	public String toString() {
		return "SupportVO [num=" + num + ", m_num=" + m_num + ", p_num=" + p_num + ", payment=" + payment + ", g_num="
				+ g_num + ", support_amount=" + support_amount + ", gift_option=" + gift_option + ", donation="
				+ donation + "]";
	}
	
	
	
	
}
