package ec.size;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class sizeDao {
	public ArrayList<sizeVo> sizeList() {
		ArrayList<sizeVo> list = new ArrayList<sizeVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from size order by sz_size asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				sizeVo vo = new sizeVo();				
				vo.setSz_size(rs.getString("sz_size"));
				vo.setSz_cat(rs.getString("sz_cat"));
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
