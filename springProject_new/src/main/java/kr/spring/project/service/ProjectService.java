package kr.spring.project.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.project.vo.ProjectVO;
import kr.spring.support.vo.SupportVO;

public interface ProjectService {
	public void insertProject(ProjectVO project);
	public ProjectVO selectCheckProject(String name);
	public int selectNum();
	
	public void updateProject(ProjectVO project);
	public void updateAllProject(ProjectVO project);
	
	public List<ProjectVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	
	public void updatePhoto(ProjectVO project);
	public void deletePhoto(ProjectVO project);
	
	public ProjectVO selectProject(Integer num);
	public int selectProjectSupporter(Integer num);
	public Date selectFinish(int pnum);
	
	public void updateApproval(int pnum);
	public ProjectVO selectCheckNumProject(int num);
	
	//관리자 프로젝트 확인
	public ProjectVO selectConfirmProject(int num);
	//관리자 프로젝트 컨펌 결과
	public void confirmApproveResult(@Param("approval")int approval,@Param("num")int num);
	public void confirmReturnResult(@Param("approval")int approval,@Param("reason") String reason,@Param("num") int num);
}
