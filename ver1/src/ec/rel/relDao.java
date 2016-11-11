package ec.rel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

//* rel insert*//
public class relDao {
	/*Product-Company*/
	public int insertPdCoRel(int pd_id, String co_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into product_company_rel values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setString(2, co_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public String getCoByPd(int pd_id) {
		String result = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select co_id from product_company_rel where pd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			rs.next(); 
			result = rs.getString("co_id");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return result;
	}
	/*Product-Category*/
	public int insertPdCgpRel(int pd_id, int cgp_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into product_category_rel values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setInt(2, cgp_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	
	
	/*Product-Mileage*/
	public int insertPdMilRel(int pd_id, int mil_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into product_mileage_rel values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setInt(2, mil_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	

}
