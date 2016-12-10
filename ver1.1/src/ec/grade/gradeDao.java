package ec.grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class gradeDao {
	
	public ArrayList<gradeVo> gradeList() {
		ArrayList<gradeVo> list = new ArrayList<gradeVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from grade order by grd_id asc"; 
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				gradeVo vo = new gradeVo();
				vo.setGrd_id(rs.getInt("grd_id"));
				vo.setGrd_name(rs.getString("grd_name"));
				vo.setGrd_name_eng(rs.getString("grd_name_eng"));
				vo.setGrd_reg(rs.getString("grd_reg"));
				vo.setGrd_score(rs.getInt("grd_score"));
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
