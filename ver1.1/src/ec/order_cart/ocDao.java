package ec.order_cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class ocDao {
	public int insertCart(int oc_mem_id, String oc_co_id, int oc_pdd_id, int oc_opt_count, String oc_reg) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into order_cart values(?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, oc_mem_id);
			ps.setString(2, oc_co_id);
			ps.setInt(3, oc_pdd_id);
			ps.setInt(4, oc_opt_count);
			ps.setString(5, oc_reg);

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	public int deleteCart(int oc_mem_id, int oc_pdd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "delete from order_cart where oc_mem_id=? and oc_pdd_id=?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, oc_mem_id);
			ps.setInt(2, oc_pdd_id);

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	public int existCartCount(int oc_mem_id, int oc_pdd_id) {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select count(*) from order_cart where oc_mem_id = ? and oc_pdd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, oc_mem_id);
			ps.setInt(2, oc_pdd_id);
			
			rs = ps.executeQuery();
			rs.next();
			cnt = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}
	
	public int updateCart(int oc_mem_id, int oc_pdd_id, int oc_count, String oc_reg) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "update order_cart set oc_count = oc_count + ? , oc_reg = ? where oc_mem_id= ? and oc_pdd_id = ?";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, oc_count);
			ps.setString(2, oc_reg);
			ps.setInt(3, oc_mem_id);
			ps.setInt(4, oc_pdd_id);

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<ocVo> getCartList(int oc_mem_id, String oc_co_id) {
		ArrayList<ocVo> list = new ArrayList<ocVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from order_cart where oc_mem_id = ? and oc_co_id = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, oc_mem_id);
			ps.setString(2, oc_co_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				ocVo vo = new ocVo();

				vo.setOc_mem_id(rs.getInt("oc_mem_id"));
				vo.setOc_co_id(rs.getString("oc_co_id"));
				vo.setOc_pdd_id(rs.getInt("oc_pdd_id"));
				vo.setOc_opt_count(rs.getInt("oc_opt_count"));
				vo.setOc_reg(rs.getString("oc_reg"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<ocVo> getCartCompany(int oc_mem_id) {
		ArrayList<ocVo> list = new ArrayList<ocVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select oc_co_id from order_cart where oc_mem_id = ? group by oc_co_id ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, oc_mem_id);

			rs = ps.executeQuery();
			while (rs.next()) {
				ocVo vo = new ocVo();
				vo.setOc_co_id(rs.getString("oc_co_id"));

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
