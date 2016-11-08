package ec.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class productDao {
	
	public int insertProduct(productVo vo, String co_id, int cgp_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 19개 중 1개 Auto_inrement
			String sql = "insert into product values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, vo.getPd_id());
			ps.setString(2, co_id);
			ps.setInt(3, cgp_id);
			ps.setString(4,vo.getPd_name());
			
			ps.setInt(5,vo.getPd_status());
			ps.setString(6,vo.getPd_summary());
			ps.setString(7, vo.getPd_main_img());
			ps.setString(8, vo.getPd_detail_img());
			
			ps.setString(9, vo.getPd_reg_date());
			ps.setString(10, vo.getPd_modify_date());	
			
			ps.setInt(11,vo.getPd_sell_count());
			ps.setInt(12,vo.getPd_wish_count());
			ps.setInt(13,vo.getPd_review_count());
			ps.setFloat(14,vo.getPd_avg_rate());
			
			ps.setString(15, vo.getPd_keyword());
			
			ps.setInt(16,vo.getPd_price());
			ps.setInt(17, vo.getPd_sale());
			ps.setInt(18, vo.getPd_sale_type());
			ps.setInt(19, vo.getPd_sale_value());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	public int productCount() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select count(*) from product";
			ps = conn.prepareStatement(sql);
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

	public ArrayList<productVo> productList(int req, String co_id) {
		ArrayList<productVo> list = new ArrayList<productVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			
			String sql = null;
			switch(req){
			case 1:
				//전체리스트
				sql = "select * from product order by pd_id asc";
				break;
			case 2:
				sql = "select * from product_detail where co_id = order by pd_id asc";
			}
			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				productVo vo = new productVo();
				/*
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPd_name(rs.getString("pd_name"));
				vo.setPd_cat1(rs.getInt("pd_cat1"));
				vo.setPd_cat2(rs.getInt("pd_cat2"));
				vo.setPd_cat3(rs.getInt("pd_cat3"));
				vo.setPd_status(rs.getInt("pd_status"));
				vo.setPd_summary(rs.getString("pd_summary"));
				vo.setPd_content(rs.getString("pd_content"));
				vo.setPd_price(rs.getInt("pd_price"));
				vo.setPd_datetime(rs.getString("pd_datetime"));
				vo.setPd_updated_datetime(rs.getString("pd_updated_datetime"));
				vo.setPd_sell_count(rs.getInt("pd_sell_count"));
				vo.setPd_review_count(rs.getInt("pd_review_count"));
				vo.setPd_avg_rate(rs.getInt("pd_avg_rate"));
				vo.setPd_prom(rs.getInt("pd_prom"));
				vo.setPd_sale(rs.getInt("pd_sale"));
				vo.setPd_sale_type(rs.getInt("pd_sale_type"));
				vo.setPd_sale_value(rs.getInt("pd_sale_value"));
				
				list.add(vo);
				*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	
}
