package kr.spring.gift.vo;

import java.text.DecimalFormat;

public class GiftVO {	
	//선물 테이블
	private int num;	//선물번호
	private int p_num;	//프로젝트번호
	private int price;	//선물 총 후원금액
	private String name;	//선물이름
	private int due_ship;	//배송여부
	private int num_component; //한정수량
	private int optional;
	//선물 구성품 테이블
	private int gd_num; //구성품 번호
	private String gd_name; //구성품 이름
	private int gd_count; //구성품 개수
	private int com_cnt; //선물당 구성품 개수
	private String price_str; //선물 총 후원금액 스트링
	private int rest_cnt; //선물 남은 개수
	
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
		DecimalFormat df = new DecimalFormat("###,###");
		String money = df.format(price);
		this.setPrice_str(money);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public int getOptional() {
		return optional;
	}
	public void setOptional(int optional) {
		this.optional = optional;
	}
	public int getGd_num() {
		return gd_num;
	}
	public void setGd_num(int gd_num) {
		this.gd_num = gd_num;
	}
	public String getGd_name() {
		return gd_name;
	}
	public void setGd_name(String gd_name) {
		this.gd_name = gd_name;
	}

	public int getGd_count() {
		return gd_count;
	}
	public void setGd_count(int gd_count) {
		this.gd_count = gd_count;
	}
	
	public int getCom_cnt() {
		return com_cnt;
	}
	public void setCom_cnt(int com_cnt) {
		this.com_cnt = com_cnt;
	}
	public String getPrice_str() {
		return price_str;
	}
	public void setPrice_str(String price_str) {
		this.price_str = price_str;
	}
	public int getRest_cnt() {
		return rest_cnt;
	}
	public void setRest_cnt(int rest_cnt) {
		this.rest_cnt = rest_cnt;
	}
	@Override
	public String toString() {
		return "GiftVO [num=" + num + ", p_num=" + p_num + ", price=" + price + ", name=" + name
				+ ", due_ship=" + due_ship + ", num_component=" + num_component + ", gd_num=" + gd_num + ", gd_name="
				+ gd_name + ", gd_count=" + gd_count + "]";
	}

}
