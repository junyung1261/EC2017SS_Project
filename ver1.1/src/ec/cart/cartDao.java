package ec.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;
import ec.product_detail.product_detailVo;


public class cartDao {
	
	public int insertCart(product_detailVo pdvo, int mem_id, int count){
		  int rst = 0;
		  Connection conn = null;
		  PreparedStatement ps = null;
		  try{
		   conn = ConnUtil.getConnection();
		   String sql = "insert into cart values(?,?,?,sysdate())";
		   ps = conn.prepareStatement(sql);
		   ps.setInt(1, mem_id);
		   ps.setInt(2, pdvo.getPdd_id());
		   ps.setInt(3, count);
		 
		 
		rst = ps.executeUpdate();
		  }catch(Exception e){
		   e.printStackTrace();
		  }finally{
		   ConnUtil.close(ps, conn);
		  }
		  return rst;
		 }
	
	public int deleteCart_List(int mem_id, int pdd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  
			String sql = "delete from cart where mem_id=? and pdd_id=?";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, mem_id);
			ps.setInt(2, pdd_id);
		
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public int updateCart_List(int mem_id, int pdd_id, int count) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  
			String sql = "update cart set cart_count= cart_count + ? where mem_id=? and pdd_id=?";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, count);
			ps.setInt(2, mem_id);
			ps.setInt(3, pdd_id);
		
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<cartVo> getCart_List(int mem_id) {
		ArrayList<cartVo> list = new ArrayList<cartVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from cart where mem_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
		
			rs = ps.executeQuery();
			while (rs.next()) {
				cartVo vo = new cartVo();
				
				vo.setMem_id(rs.getInt("mem_id"));
				vo.setPdd_id(rs.getInt("pdd_id"));
				vo.setCart_count(rs.getInt("cart_count"));
				vo.setCart_datetime(rs.getString("cart_datetime"));
				
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
