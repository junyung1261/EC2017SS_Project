package ec.product_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;
public class product_detailDao {

	public int insertProductDetail(int pd_id, String col_id, String sz_id, int stk_count) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 5°³ Áß 1°³ Auto_inrement pdd_id
			String sql = "insert into product_detail values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, pd_id);
			ps.setString(2, col_id);
			ps.setString(3, sz_id);
			ps.setInt(4,stk_count);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
