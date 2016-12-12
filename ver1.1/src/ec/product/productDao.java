package ec.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.*;
import ec.connUtil.ConnUtil;

public class productDao {

	public int nextInsertProductId() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name = 'product' AND table_schema =database( );";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next(); 
			cnt = rs.getInt("AUTO_INCREMENT");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}

	public int insertProduct(productVo vo, int cat1) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 19개 중 1개 Auto_inrement
			String sql = "insert into product values(null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getPd_co_id());
			ps.setInt(2, cat1);
			ps.setString(3,vo.getPd_name());
			ps.setInt(4,vo.getPd_status());
			ps.setString(5,vo.getPd_summary());
			ps.setString(6, vo.getPd_main_img());
			ps.setString(9, vo.getPd_detail_main_img());
			ps.setString(8, vo.getPd_detail_img());
			ps.setString(9, vo.getPd_reg_date());
			ps.setString(10, vo.getPd_modify_date());	
			ps.setInt(11,vo.getPd_sell_count());
			ps.setInt(12,vo.getPd_wish_count());
			ps.setInt(13,vo.getPd_review_count());
			ps.setFloat(14,vo.getPd_avg_rate());
			ps.setString(15, vo.getPd_keyword());
			ps.setInt(16,vo.getPd_price());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	//*업체 별 제품 수*//
	public int productCountByCom(int req, String co_id) {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		try {
			conn = ConnUtil.getConnection();
			String sql = null;
			switch(req){
				case 0:   // 업체 별 전체
					sql = "select count(*) from product where pd_co_id = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					break;
				case 1:   // 판매중
					sql = "select count(*) from product where  pd_co_id = ? and pd_status= ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 1);
					break;
					
				case 2:   // 판매대기
					sql = "select count(*) from product where pd_co_id = ? and pd_status= ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 0);
					break;
				case 3:   // 당월등록상품
					sql = "select count(*) from product where pd_co_id = ? and pd_reg_date regexp ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setString(2, month+"/[0-9]*/"+year);
					break;
				case 10:	// 남성카테고리
					sql = "select count(*) from product where pd_co_id = ? and pd_cgp_id = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 10);
					break;
				case 20:	// 남성카테고리
					sql = "select count(*) from product where pd_co_id = ? and pd_cgp_id = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 20);
					break;
				case 30:	// 남성카테고리
					sql = "select count(*) from product where pd_co_id = ? and pd_cgp_id = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 30);
					break;	
			}
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
				/*전체 리스트*/
			case 1:
				sql = "select * from product order by pd_id asc";
				ps = conn.prepareStatement(sql);
				break;
			case 2:
				/*업체별 리스트*/
				sql = "select * from product where pd_co_id = ? order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			case 10:
				/*남성 리스트*/
				sql = "select * from product where pd_co_id = ? and pd_cgp_id = ? order by pd_id asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setInt(2,10);
				break;
			case 20:
				/*여성 리스트*/
				sql = "select * from product where pd_co_id = ? and pd_cgp_id = ? order by pd_id asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setInt(2,20);
				break;	
			case 30:
				/*공용 리스트*/
				sql = "select * from product where pd_co_id = ? and pd_cgp_id = ? order by pd_id asc";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setInt(2,30);
				break;	
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				productVo vo = new productVo();
				
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPd_co_id(rs.getString("pd_co_id"));
				vo.setPd_cgp_id(rs.getInt("pd_cgp_id"));
				vo.setPd_name(rs.getString("pd_name"));
				vo.setPd_status(rs.getInt("pd_status"));
				vo.setPd_summary(rs.getString("pd_summary"));
				vo.setPd_main_img(rs.getString("pd_main_img"));
				vo.setPd_detail_main_img(rs.getString("pd_detail_main_img"));
				vo.setPd_detail_img(rs.getString("pd_detail_img"));
				vo.setPd_reg_date(rs.getString("pd_reg_date"));
				vo.setPd_modify_date(rs.getString("pd_modify_date"));
				vo.setPd_sell_count(rs.getInt("pd_sell_count"));
				vo.setPd_wish_count(rs.getInt("pd_wish_count"));
				vo.setPd_review_count(rs.getInt("pd_review_count"));
				vo.setPd_avg_rate(rs.getInt("pd_avg_rate"));
				vo.setPd_keyword(rs.getString("pd_keyword"));
				vo.setPd_price(rs.getInt("pd_price"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public productVo getProductInfo(int pd_id) {
		productVo vo = new productVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from product where pd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPd_co_id(rs.getString("pd_co_id"));
				vo.setPd_cgp_id(rs.getInt("pd_cgp_id"));
				vo.setPd_name(rs.getString("pd_name"));
				vo.setPd_status(rs.getInt("pd_status"));
				vo.setPd_summary(rs.getString("pd_summary"));
				vo.setPd_main_img(rs.getString("pd_main_img"));
				vo.setPd_detail_main_img(rs.getString("pd_detail_main_img"));
				vo.setPd_detail_img(rs.getString("pd_detail_img"));
				vo.setPd_reg_date(rs.getString("pd_reg_date"));
				vo.setPd_modify_date(rs.getString("pd_modify_date"));
				vo.setPd_sell_count(rs.getInt("pd_sell_count"));
				vo.setPd_wish_count(rs.getInt("pd_wish_count"));
				vo.setPd_review_count(rs.getInt("pd_review_count"));
				vo.setPd_avg_rate(rs.getInt("pd_avg_rate"));
				vo.setPd_keyword(rs.getString("pd_keyword"));
				vo.setPd_price(rs.getInt("pd_price"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public String getProductName(int pd_id) {
		String pd_name = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from product where pd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			rs.next();
			pd_name = rs.getString("pd_name");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return pd_name;
	}
	
	
}
