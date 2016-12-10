package ec.category_product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class categoryDao {


	
	public ArrayList<categoryVo> category_List(int start, int end) {
		ArrayList<categoryVo> list = new ArrayList<categoryVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from category where cg_id >= ? and cg_id <= ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				categoryVo vo = new categoryVo();	
				vo.setCg_id(rs.getInt("cg_id"));
				vo.setCg_name(rs.getString("cg_name"));
			
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<String> cg_Name_List(int depth) {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from category where cg_depth = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, depth);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				list.add(rs.getString("cg_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	
}
