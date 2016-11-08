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
			String sql = "insert into product values(null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, co_id);
			ps.setInt(2, cgp_id);
			ps.setString(3,vo.getPd_name());
			
			ps.setInt(4,vo.getPd_status());
			ps.setString(5,vo.getPd_summary());
			ps.setString(6, vo.getPd_main_img());
			ps.setString(7, vo.getPd_detail_img());
			
			ps.setString(8, vo.getPd_reg_date());
			ps.setString(9, vo.getPd_modify_date());	
			
			ps.setInt(10,vo.getPd_sell_count());
			ps.setInt(11,vo.getPd_wish_count());
			ps.setInt(12,vo.getPd_review_count());
			ps.setFloat(13,vo.getPd_avg_rate());
			
			ps.setString(14, vo.getPd_keyword());
			
			ps.setInt(15,vo.getPd_price());
			ps.setInt(16, vo.getPd_sale());
			ps.setInt(17, vo.getPd_sale_type());
			ps.setInt(18, vo.getPd_sale_value());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	//product insert 과정에서, jsp로부터 pd_id를 가져오지 못함(auto_increment)니까.
	//따라서 가장 최근에 들어간 id값(max)로 id를 가져와서, product_detail_insert의 pd_id로 써야함//
	
	public int getProductIdMax() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select MAX(pd_id) from product";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next(); 
			cnt = rs.getInt("MAX(pd_id)");
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
