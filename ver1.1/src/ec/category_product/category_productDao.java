package ec.category_product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class category_productDao {
	
	public category_productVo getCategoryId(String cgp_cat1, String cgp_cat2, String cgp_cat3) {
		category_productVo vo = new category_productVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from category_product where cgp_cat1 = ? and cgp_cat2=? and cgp_cat3=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cgp_cat1);
			ps.setString(2, cgp_cat2);
			ps.setString(3, cgp_cat3);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setCgp_id(rs.getInt("cgp_id"));
				vo.setCgp_cat1(rs.getString("cgp_cat1"));
				vo.setCgp_cat2(rs.getString("cgp_cat2"));
				vo.setCgp_cat3(rs.getString("cgp_cat3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public ArrayList<category_productVo> cgpList() {
		ArrayList<category_productVo> list = new ArrayList<category_productVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from category_product where order by cgp_id asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				category_productVo vo = new category_productVo();	
				vo.setCgp_id(rs.getInt("cgp_id"));
				vo.setCgp_cat1(rs.getString("cgp_cat1"));
				vo.setCgp_cat2(rs.getString("cgp_cat2"));
				vo.setCgp_cat3(rs.getString("cgp_cat3"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<String> getCgpCat1() {
		ArrayList<String> list = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select cgp_cat1 from category_product group by cgp_cat1 ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int i=0;
			
			while (rs.next()) {
				String cat1 = new String();
				cat1 = rs.getString("cgp_cat1");
				list.add(cat1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<category_productVo> getCgpCat2_Cat3(String req) {
		ArrayList<category_productVo> list = new ArrayList<category_productVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from category_product where cgp_cat1 = ? order by cgp_id asc";
			ps = conn.prepareStatement(sql);
			ps.setString(1, req);
			rs = ps.executeQuery();
			while (rs.next()) {
				category_productVo vo = new category_productVo();	
				vo.setCgp_id(rs.getInt("cgp_id"));
				vo.setCgp_cat1(rs.getString("cgp_cat1"));
				vo.setCgp_cat2(rs.getString("cgp_cat2"));
				vo.setCgp_cat3(rs.getString("cgp_cat3"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<category_productVo> getCgpCat(String req1, String req2) {
		ArrayList<category_productVo> list = new ArrayList<category_productVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select cgp_cat3 from category_product where cgp_cat1 = ? and cgp_cat2 = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, req1);
			ps.setString(2, req2);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				category_productVo vo = new category_productVo();	
				vo.setCgp_cat3(rs.getString("cgp_cat3"));
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
