package ec.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class deliveryDao {
	
	public int insertDelivery(deliveryVo vo, int pd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into delivery values(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, pd_id);
			ps.setInt(2, vo.getDe_method());
			ps.setInt(3, vo.getDe_price());
			ps.setInt(4, vo.getDe_price_exception());
			ps.setInt(5, vo.getDe_price_condition());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public deliveryVo selectDelivery(int pd_id) {
		deliveryVo vo = new deliveryVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from delivery where de_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setDe_id(rs.getInt("de_id"));
				vo.setDe_method(rs.getInt("de_method"));
				vo.setDe_price(rs.getInt("de_price"));
				vo.setDe_price_exception(rs.getInt("de_price_exception"));
				vo.setDe_price_condition(rs.getInt("de_price_condition"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
