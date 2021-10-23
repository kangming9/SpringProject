package kr.spring.delivery.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class DeliveryVO {	//배송지 테이블
	@NotEmpty
	private int num; //배송번호
	@NotEmpty
	private int m_num;	//회원번호
	@NotEmpty
	private String name; //배송지명
	@Size(min=5,max=5)
	private int zipcode; //우편번호
	@NotEmpty
	private String address;	//배송지주소
	@NotEmpty
	private String address_detail;	//배송지 상세주소
	@NotEmpty
	private int address_check; //기본 배송지 여부(1:기본배송지 0:일반배송지(디폴트값)
	@NotEmpty
	private String phone; //받을사람 폰번호
	private int s_num; //프로젝트 번호
	
	public int getS_num() {
		return s_num;
	}
	public void setS_num(int s_num) {
		this.s_num = s_num;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getZipcode() {
		return zipcode;
	}
	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public int getAddress_check() {
		return address_check;
	}
	public void setAddress_check(int address_check) {
		this.address_check = address_check;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Override
	public String toString() {
		return "DeliveryVO [num=" + num + ", m_num=" + m_num + ", name=" + name + ", zipcode=" + zipcode + ", address="
				+ address + ", address_detail=" + address_detail + ", address_check=" + address_check + ", phone="
				+ phone + "]";
	}
	
	
}
