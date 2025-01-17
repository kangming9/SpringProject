package kr.spring.project.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.project.vo.ProjectVO;

public interface ProjectMapper {
	@Select("SELECT * FROM project WHERE num=#{num}")
	public ProjectVO selectCheckNumProject(int num);
	@Select("SELECT * FROM project WHERE name=#{name}")
	public ProjectVO selectCheckProject(String name);
	@Select("SELECT project_seq.nextval FROM dual")
	public int selectNum();
	@Insert("INSERT INTO project (num, name, category, start_date, finish_date, goal_amount, m_num, intro, ship, summary, policy, approval) VALUES (#{num}, #{name}, #{category}, #{start_date}, #{finish_date}, #{goal_amount}, #{m_num}, #{intro}, #{ship}, #{summary}, #{policy}, -1)")
	public void insertProject(ProjectVO project);
	public ProjectVO updateProject(ProjectVO project);
	@Update("UPDATE project SET name=#{name}, category=#{category}, start_date=#{start_date}, finish_date=#{finish_date}, goal_amount=#{goal_amount}, summary=#{summary}, ship=#{ship}, intro=#{intro}, policy=#{policy} WHERE num=#{num}")
	public void updateAllProject(ProjectVO project);
	
	@Update("UPDATE project SET photo=#{photo} WHERE num=#{num}")
	public void updatePhoto(ProjectVO project);
	@Update("UPDATE project SET photo=default WHERE num=#{num}")
	public void deletePhoto(ProjectVO project);
	
	@Select("SELECT finish_date FROM project WHERE num = #{pnum}")
	public Date selectFinish(int pnum);
	
	@Update("UPDATE project SET approval=0 WHERE num = #{pnum}")
	public void updateApproval(int pnum);
	
	public List<ProjectVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public ProjectVO selectProject(Integer num);
	public int selectProjectSupporter(Integer num);
	
	//관리자가 컨펌할 프로젝트(parameter = p_num)
	@Select("SELECT * FROM project p WHERE p.num = #{num}")
	public ProjectVO selectConfirmProject(Integer num);
	//관리자 프로젝트 컨펌 결과
	@Update("UPDATE project SET approval=#{approval} WHERE num=#{num}")
	public void confirmApproveResult(@Param("approval")int approval,@Param("num")int num);
	@Update("UPDATE project SET approval=#{approval}, reason=#{reason} WHERE num=#{num}")
	public void confirmReturnResult(@Param("approval")int approval,@Param("reason") String reason,@Param("num") int num);
	
	
}
