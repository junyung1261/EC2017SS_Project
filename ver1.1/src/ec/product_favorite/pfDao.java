package ec.product_favorite;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;

public class pfDao {
	public int insertProductFavorite(String fa_user_id, int fa_pd_id, String fa_reg) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 4°³ Áß 1°³ Auto_inrement
			String sql = "insert into product_favorite values(null,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, fa_user_id);
			ps.setInt(2, fa_pd_id);
			ps.setString(3, fa_reg);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
