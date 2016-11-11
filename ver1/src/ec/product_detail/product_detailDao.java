package ec.product_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class product_detailDao {
	// 수정부분 안되면 다십변경  int pd_id, String col_id, String sz_id, int stk_count _//
	public int insertProductDetail(int pd_id, String col_id, String sz_id, int pd_stk_count) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 5개 중 1개 Auto_inrement pdd_id
			String sql = "insert into product_detail values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, pd_id);
			ps.setString(2, col_id);
			ps.setString(3, sz_id);
			ps.setInt(4, pd_stk_count);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<product_detailVo> getProductColor(int pd_id) {
		ArrayList<product_detailVo> list = new ArrayList<product_detailVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select col_id from product_detail where pd_id=? group by col_id order by col_id asc;";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				product_detailVo vo = new product_detailVo();
				vo.setCol_id(rs.getString("col_id"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	public ArrayList<product_detailVo> getProductSize(int pd_id) {
		ArrayList<product_detailVo> list = new ArrayList<product_detailVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select sz_id from product_detail where pd_id=? group by sz_id order by sz_id asc;";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
		
			rs = ps.executeQuery();
			while (rs.next()) {
				product_detailVo vo = new product_detailVo();
				vo.setSz_id(rs.getString("sz_id"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	public int getProductStock(int pd_id, String col_id, String sz_id) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int cnt = 0;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select pdd_stk_count from product_detail where pd_id = ? and col_id=? and sz_id = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			ps.setString(2, col_id);
			ps.setString(3, sz_id);
			rs = ps.executeQuery();
			rs.next();
			cnt = rs.getInt("pdd_stk_count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return cnt;
	}
	public int updateProductStock(int pd_id, String col_id, String sz_id){
		  int rst = 0;
		  Connection conn = null;
		  PreparedStatement ps = null;
		  try{
		   conn = ConnUtil.getConnection();
		   String sql = "update product_detail set pdd_stk_count = pdd_stk_count-1 where pd_id = ? and col_id = ? and sz_id = ?;";
		   ps = conn.prepareStatement(sql);
		   ps.setInt(1, pd_id);
		   ps.setString(2, col_id);
		   ps.setString(3, sz_id);
		rst = ps.executeUpdate();
		  }catch(Exception e){
		   e.printStackTrace();
		  }finally{
		   ConnUtil.close(ps, conn);
		  }
		  return rst;
		 }
}
