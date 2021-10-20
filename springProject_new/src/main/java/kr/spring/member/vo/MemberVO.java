package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private int num; //회원번호
	@NotEmpty
	private String id; //아이디
	private int grade; //회원레벨
	@NotEmpty
	private String name; //이름
	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String pass; //비밀번호
	private Date reg_date; //가입일
	private Date modify_date; //정보 수정일
	@NotEmpty
	private String phone; //전화번호
	private String phone_confirm; //전화번호 컨펌
	@Email
	@NotEmpty
	private String email; //이메일
	private byte[] photo; //사진파일
	private String photo_name;//사진 파일명
	@Size(min=5,max=5)
	private String zipcode; //우편번호
	@NotEmpty
	private String address; //주소
	@NotEmpty
	private String address_detail; //나머지 주소
	private String nickname;

	@Pattern(regexp="^[A-Za-z0-9]{4,12}$")
	private String now_password;
	
	//=========비밀번호 일치 여부 체크 ==========//
	public boolean isCheckedPassword(String userPasswd) {
		if(pass.equals(userPasswd)) {
			return true;
		}
		return false;
	}
	//===============이미지 BLOB 처리 ====================//
	public void setUpload(MultipartFile upload)throws IOException{
		//MultipartFile -> byte[] : byte로 바꿔서 myBatis가 넘길 수 있도록 함
		setPhoto(upload.getBytes());
		//파일 이름
		setPhoto_name(upload.getOriginalFilename());
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone_confirm() {
		return phone_confirm;
	}

	public void setPhone_confirm(String phone_confirm) {
		this.phone_confirm = phone_confirm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getNow_password() {
		return now_password;
	}

	public void setNow_password(String now_password) {
		this.now_password = now_password;
	}

	@Override
	public String toString() {
		return "MemberVO [num=" + num + ", id=" + id + ", grade=" + grade + ", name=" + name + ", pass=" + pass
				+ ", reg_date=" + reg_date + ", modify_date=" + modify_date + ", phone=" + phone + ", phone_confirm="
				+ phone_confirm + ", email=" + email + ", photo_name=" + photo_name + ", zipcode=" + zipcode
				+ ", address=" + address + ", address_detail=" + address_detail + ", nickname=" + nickname
				+ ", now_password=" + now_password + "]";
	}
	
	

	
	
	
}
