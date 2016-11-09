package ec.rel;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
	
	/*Product-Discount*/
	public int insertPdDisRel(int pd_id, int dis_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into product_discount_rel values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setInt(2, dis_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	/*Product-Delivery*/
	public int insertPdDeRel(int pd_id, int de_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into product_delivery_rel values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setInt(2, de_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	

}
