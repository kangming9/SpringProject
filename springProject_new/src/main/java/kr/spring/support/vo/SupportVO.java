
package kr.spring.support.vo;

import java.sql.Date;
import java.text.DecimalFormat;


import javax.validation.constraints.NotEmpty;

public class SupportVO {//후원 테이블
	@NotEmpty
	private int num; //후원 번호
	@NotEmpty
	private int m_num;//후원자 회원번호
	@NotEmpty
	private int p_num; //후원한 프로젝트번호
	@NotEmpty
	private Date payment_date; //후원 결제 신청 날짜(결제진행날짜x)
	@NotEmpty
	private int payment; //후원금 결제 여부
	@NotEmpty
	private int g_num; //선택한 선물 번호
	@NotEmpty
	private int d_num; //선물 배송지 번호
	@NotEmpty
	private int support_amount; //전체 후원금액
	private String gift_option;//후원의 추가적인 옵션 사항
	private int donation; //추가후원금액
	private String donation_str; //추가후원금액 스트링
	private String support_amount_str; //전체 후원금액 스트링 
	
	private String name; //프로젝트 명
	private int category;	//프로젝트 카테고리
	private Date finish_date;	//프로젝트 마감일자
	private String photo;	//프로젝트 사진
	private int ship;	//프로젝트 배송여부
	private int approval;	//프로젝트 진행상태
	private int goal_amount; //후원목표 금액
	private String summary; //프로젝트 요약
	
	private String md_name; //후원자 이름
	private String phone; //후원자 폰번호
	private String email; //후원자 메일
	
	public String getMd_name() {
		return md_name;
	}


	public void setMd_name(String md_name) {
		this.md_name = md_name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getSummary() {
		return summary;
	}


	public void setSummary(String summary) {
		this.summary = summary;
	}

	private String name_1;	//선물 명
	private int price;	//선물 가격
	private int due_ship;	//선물 배송여부 체크
	private int num_component;	//선물 한정수량
	
	
	public int getGoal_amount() {
		return goal_amount;
	}


	public void setGoal_amount(int goal_amount) {
		this.goal_amount = goal_amount;
	}


	public String getname_1() {
		return name_1;
	}


	public void setname_1(String name_1) {
		this.name_1 = name_1;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getDue_ship() {
		return due_ship;
	}


	public void setDue_ship(int due_ship) {
		this.due_ship = due_ship;
	}


	public int getNum_component() {
		return num_component;
	}


	public void setNum_component(int num_component) {
		this.num_component = num_component;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getCategory() {
		return category;
	}


	public void setCategory(int category) {
		this.category = category;
	}


	public Date getFinish_date() {
		return finish_date;
	}


	public void setFinish_date(Date finish_date) {
		this.finish_date = finish_date;
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public int getShip() {
		return ship;
	}


	public void setShip(int ship) {
		this.ship = ship;
	}


	public int getApproval() {
		return approval;
	}


	public void setApproval(int approval) {
		this.approval = approval;
	}
	
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
	public int getD_num() {
		return d_num;
	}
	public void setD_num(int d_num) {
		this.d_num = d_num;
	}
	public Date getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
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
		DecimalFormat df = new DecimalFormat("###,###");
		String money = df.format(support_amount);
		this.setSupport_amount_str(money);
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
		DecimalFormat df = new DecimalFormat("###,###");
		String money = df.format(donation);
		this.setDonation_str(money);
	}
	public String getDonation_str() {
		return donation_str;
	}
	public void setDonation_str(String donation_str) {
		this.donation_str = donation_str;
	}
	public String getSupport_amount_str() {
		return support_amount_str;
	}
	public void setSupport_amount_str(String support_amount_str) {
		this.support_amount_str = support_amount_str;
	}

	@Override
	public String toString() {
		return "SupportVO [num=" + num + ", m_num=" + m_num + ", p_num=" + p_num + ", d_num=" + d_num +", payment_date=" + payment_date
				+ ", payment=" + payment + ", g_num=" + g_num + ", support_amount=" + support_amount + ", gift_option="
				+ gift_option + ", donation=" + donation + ", donation_str=" + donation_str + ", support_amount_str="
				+ support_amount_str + ", name=" + name + ", category=" + category + ", finish_date=" + finish_date
				+ ", photo=" + photo + ", ship=" + ship + ", approval=" + approval + ", goal_amount=" + goal_amount
				+ ", name_1=" + name_1 + ", price=" + price + ", due_ship=" + due_ship + ", num_component="
				+ num_component + "]";
	}	
}
