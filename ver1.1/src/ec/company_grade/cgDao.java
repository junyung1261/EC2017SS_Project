package ec.company_grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class cgDao {
	public int insertGrade(cgVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into company_grade values(null,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getCg_name());
			ps.setString(2, vo.getCg_mil_rate());
			ps.setString(3, vo.getCg_reg());

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<cgVo> gradeList() {
		ArrayList<cgVo> list = new ArrayList<cgVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql =  "select * from company_grade order by cg_id asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				cgVo vo = new cgVo();
				vo.setCg_id(rs.getInt("cg_id"));
				vo.setCg_name(rs.getString("cg_name"));
				vo.setCg_mil_rate(rs.getString("cg_mil_rate"));
				vo.setCg_reg(rs.getString("cg_reg"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public cgVo getGradeInfo(String co_grade) {
		cgVo vo = new cgVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from company_grade where cg_name = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, co_grade);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setCg_id(rs.getInt("cg_id"));
				vo.setCg_name(rs.getString("cg_name"));
				vo.setCg_mil_rate(rs.getString("cg_mil_rate"));
				vo.setCg_reg(rs.getString("cg_reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
