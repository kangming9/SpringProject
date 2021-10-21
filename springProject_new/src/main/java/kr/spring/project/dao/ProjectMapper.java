package kr.spring.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.project.vo.ProjectVO;

public interface ProjectMapper {
	@Select("SELECT * FROM project WHERE name=#{name}")
	public ProjectVO selectCheckProject(String name);
	@Select("SELECT project_seq.nextval FROM dual")
	public int selectNum();
	@Insert("INSERT INTO project (num, name, category, start_date, finish_date, goal_amount, m_num, intro, ship, summary, policy, approval) VALUES (#{num}, #{name}, #{category}, #{start_date}, #{finish_date}, #{goal_amount}, #{m_num}, #{intro}, #{ship}, #{summary}, #{policy}, -1)")
	public void insertProject(ProjectVO project);
	public ProjectVO updateProject(ProjectVO project);
	
	@Update("UPDATE project SET photo=#{photo} WHERE num=#{num}")
	public void updatePhoto(ProjectVO project);
	@Update("UPDATE project SET photo=default WHERE num=#{num}")
	public void deletePhoto(ProjectVO project);
	
	public List<ProjectVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public ProjectVO selectProject(Integer num);
	public int selectProjectSupporter(Integer num);
}
