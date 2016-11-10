package ec.member_grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class member_gradeDao {
	public member_gradeVo getMemberGradeInfo(int mg_id) {
		member_gradeVo vo = new member_gradeVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from member_grade where mg_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mg_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setMg_id(rs.getInt("mg_id"));
				vo.setMg_name_ko(rs.getString("mg_name_ko"));
				vo.setMg_name_eng(rs.getString("mg_name_eng"));
				vo.setMg_reg(rs.getString("mg_reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public ArrayList<member_gradeVo> member_gradeList() {
		ArrayList<member_gradeVo> list = new ArrayList<member_gradeVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from member_grade where mg_id = ? order by mg_id asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				member_gradeVo vo = new member_gradeVo();
				vo.setMg_id(rs.getInt("mg_id"));
				vo.setMg_name_ko(rs.getString("mg_name_ko"));
				vo.setMg_name_eng(rs.getString("mg_name_eng"));
				vo.setMg_reg(rs.getString("mg_reg"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
}
