package ec.product_discount;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;
public class discountDao {

	public int insertDiscount(discountVo vo, int pd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 6°³
			String sql = "insert into product_discount values(null,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setInt(2, vo.getDis());
			ps.setInt(3,vo.getDis_method());
			
			ps.setInt(4,vo.getDis_rate());
			ps.setInt(5,vo.getDis_value());
			
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public discountVo selectDiscount(int pd_id) {
		discountVo vo = new discountVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from product_discount where dis_pd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setDis_id(rs.getInt("dis_id"));
				vo.setDis_pd_id(rs.getInt("dis_pd_id"));
				vo.setDis(rs.getInt("dis"));
				vo.setDis_method(rs.getInt("dis_method"));
				vo.setDis_rate(rs.getInt("dis_rate"));
				vo.setDis_value(rs.getInt("dis_value"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
