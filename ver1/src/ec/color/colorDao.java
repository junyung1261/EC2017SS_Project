package ec.color;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class colorDao {
	public ArrayList<colorVo> colorList() {
		ArrayList<colorVo> list = new ArrayList<colorVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from color order by col_name asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				colorVo vo = new colorVo();				
				vo.setCol_name(rs.getString("col_name"));
				vo.setCol_eng(rs.getString("col_eng"));
				vo.setCol_eng_short(rs.getString("col_eng_short"));
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
