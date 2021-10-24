package kr.spring.project.vo;

import java.sql.Clob;
import java.sql.Date;
import java.text.DecimalFormat;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class ProjectVO {
	//프로젝트 정보 테이블
	private int num; //프로젝트 번호
	private int m_num; //프로젝트 창작자 회원번호
	@NotEmpty
	private String name; //프로젝트명
	@NotNull
	private int category; //프로젝트 카테고리
	@NotNull
	private Date start_date; //프로젝트 후원시작 날짜
	@NotNull
	private Date finish_date; //프로젝트 후원종료 날짜
	private int goal_amount; //프로젝트 목표 후원금액
	private int approval; //프로젝트 					==승인상태 -1 반려, 0 심사대기, 1 승인, 2 반려
	private String reason; //프로젝트 반려 사유
	@NotEmpty
	private String summary; //프로젝트 요약설명
	private String photo; //프로젝트 대표 사진
	private int ship; //후원선물 배송 여부
	@NotNull
	private String intro; //프로젝트 소개
	private String policy; //프로젝트 후원 정책
	
	private String nickname; //닉네임
	private int progress; //현황 퍼센티지
	private String goal_amount_str; //프로젝트 총 후원액-스트링
	private String amount; //프로젝트 총 후원액
	private int during; //현재 날찌 기준 진행 기간
	private int deadline; //프로젝트 남은 기간
	
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
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getFinish_date() {
		return finish_date;
	}
	public void setFinish_date(Date finish_date) {
		this.finish_date = finish_date;
	}
	public int getGoal_amount() {
		return goal_amount;
	}
	public void setGoal_amount(int goal_amount) {
		this.goal_amount = goal_amount;
		DecimalFormat df = new DecimalFormat("###,###");
		String money = df.format(goal_amount);
		this.setGoal_amount_str(money);
	}
	public int getApproval() {
		return approval;
	}
	public void setApproval(int approval) {
		this.approval = approval;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
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
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getPolicy() {
		return policy;
	}
	public void setPolicy(String policy) {
		this.policy = policy;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		DecimalFormat df = new DecimalFormat("###,###");
		String money = df.format(amount);
		this.amount = money;
	}
	public int getDuring() {
		return during;
	}
	public void setDuring(int during) {
		this.during = during;
	}
	public int getDeadline() {
		return deadline;
	}
	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}
	public String getGoal_amount_str() {
		return goal_amount_str;
	}
	public void setGoal_amount_str(String goal_amount_str) {
		this.goal_amount_str = goal_amount_str;
	}
	@Override
	public String toString() {
		return "ProjectVO [num=" + num + ", m_num=" + m_num + ", name=" + name + ", category=" + category
				+ ", start_date=" + start_date + ", finish_date=" + finish_date + ", goal_amount=" + goal_amount
				+ ", approval=" + approval + ", reason=" + reason + ", summary=" + summary + ", photo=" + photo
				+ ", ship=" + ship + ", intro=" + intro + ", policy=" + policy + ", nickname=" + nickname
				+ ", progress=" + progress + ", amount=" + amount+ ", deadline=" + deadline +"]";
	}
	
	
}
