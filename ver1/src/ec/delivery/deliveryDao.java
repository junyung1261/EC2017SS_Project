package ec.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import ec.connUtil.ConnUtil;

public class deliveryDao {
	
	public int deliveryMax() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select MAX(de_id) from delivery";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next(); 
			cnt = rs.getInt("MAX(de_id)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}
	
	public int insertDelivery(deliveryVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into delivery values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getDe_method());
			ps.setInt(2, vo.getDe_price());
			ps.setInt(3, vo.getDe_price_exception());
			ps.setInt(4, vo.getDe_price_condition());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
