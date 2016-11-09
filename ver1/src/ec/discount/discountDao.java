package ec.discount;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class discountDao {
	
	public int discountIdMax() {
		System.out.println("진입");
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select MAX(dis_id) from discount";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next(); 
			cnt = rs.getInt("MAX(dis_id)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}
	
	public int insertDiscount(discountVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 5개 중 1개 Auto_inrement(dis_id)
			String sql = "insert into product values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getDis());
			ps.setInt(2,vo.getDis_method());
			
			ps.setInt(3,vo.getDis_rate());
			ps.setInt(4,vo.getDis_value());
			
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
