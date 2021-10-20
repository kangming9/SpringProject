package kr.spring.project.service;

import java.util.List;
import java.util.Map;

import kr.spring.project.vo.ProjectVO;

public interface ProjectService {
	public void insertProject(ProjectVO project);
	public ProjectVO selectCheckProject(String name);
	public int selectNum();
	
	public void updateProject(ProjectVO project);
	
	public List<ProjectVO> selectList(Map<String,Object>map);
	public int selectRowCount(Map<String,Object> map);
	
	public void updatePhoto(ProjectVO project);
	public void deletePhoto(ProjectVO project);
	
	public ProjectVO selectProject(Integer num);
	public int selectProjectSupporter(Integer num);

}
