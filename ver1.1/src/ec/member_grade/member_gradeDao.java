package ec.member_grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;


public class member_gradeDao {
	public int memberGradeInitial(int mg_mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_grade values(null,?,0,0,0,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mg_mem_id);
			ps.setString(2, time);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public member_gradeVo getMemberGradeInfo(String mg_mem_id) {
		member_gradeVo vo = new member_gradeVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from member_grade where mg_mem_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mg_mem_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setMg_id(rs.getInt("mg_id"));
				vo.setMg_mem_id(rs.getString("mg_mem_id"));
				vo.setMg_before_buy(rs.getInt("mg_before_buy"));
				vo.setMg_before_order(rs.getInt("mg_before_order"));
				vo.setMg_before_confirm(rs.getInt("mg_before_confirm"));
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
			String sql = "select * from member_grade order by mg_id asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				member_gradeVo vo = new member_gradeVo();
				vo.setMg_id(rs.getInt("mg_id"));
				vo.setMg_mem_id(rs.getString("mg_mem_id"));
				vo.setMg_before_buy(rs.getInt("mg_before_buy"));
				vo.setMg_before_order(rs.getInt("mg_before_order"));
				vo.setMg_before_confirm(rs.getInt("mg_before_confirm"));
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
