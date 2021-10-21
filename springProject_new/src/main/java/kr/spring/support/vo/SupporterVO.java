package kr.spring.support.vo;

import java.util.Date;

public class SupporterVO {
	private int num;
	private String nickname;
	private String name;
	private int price;
	private int donation;
	private int support_amount;
	private Date payment_date;
	private String payment_date_str;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDonation() {
		return donation;
	}
	public void setDonation(int donation) {
		this.donation = donation;
	}
	public int getSupport_amount() {
		return support_amount;
	}
	public void setSupport_amount(int support_amount) {
		this.support_amount = support_amount;
	}
	public Date getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
	}
	public String getPayment_date_str() {
		return payment_date_str;
	}
	public void setPayment_date_str(String payment_date_str) {
		this.payment_date_str = payment_date_str;
	}
	
	@Override
	public String toString() {
		return "SupporterVO [num=" + num + ", nickname=" + nickname + ", name=" + name + ", price=" + price
				+ ", donation=" + donation + ", support_amount=" + support_amount + ", payment_date=" + payment_date
				+ "]";
	}
}
