package ec.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.*;
import ec.connUtil.ConnUtil;

public class productDao {

	public int nextInsertProductId() {
		System.out.println("진입");
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

	public int insertProduct(productVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 19개 중 1개 Auto_inrement
			String sql = "insert into product values(null,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,vo.getPd_name());
			ps.setInt(2,vo.getPd_status());
			ps.setString(3,vo.getPd_summary());
			ps.setString(4, vo.getPd_main_img());
			ps.setString(5, vo.getPd_detail_img());
			ps.setString(6, vo.getPd_reg_date());
			ps.setString(7, vo.getPd_modify_date());	
			ps.setInt(8,vo.getPd_sell_count());
			ps.setInt(9,vo.getPd_wish_count());
			ps.setInt(10,vo.getPd_review_count());
			ps.setFloat(11,vo.getPd_avg_rate());
			ps.setString(12, vo.getPd_keyword());
			ps.setInt(13,vo.getPd_price());
			
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
					sql = "select count(*) from product where pd_id in (select pd_id from product_company_rel where co_id = ?) order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					break;
				case 1:   // 판매중
					sql = "select count(*) from product where pd_id in (select pd_id from product_company_rel where co_id = ?) and pd_status= ? order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 1);
					break;
					
				case 2:   // 판매대기
					sql = "select count(*) from product where pd_id in (select pd_id from product_company_rel where co_id = ?) and pd_status= ? order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setInt(2, 0);
					break;
				case 3:   // 당월등록상품
					sql = "select count(*) from product where pd_id in (select pd_id from product_company_rel where co_id = ?) and pd_reg_date regexp ? order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setString(2, month+"/[0-9]*/"+year);
					break;
				case 100:	// 남성카테고리
					sql = "select count(*) from product "
							+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
							+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
							+ "order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setString(2, "1"+"%");
					break;
				case 200:	// 남성카테고리
					sql = "select count(*) from product "
							+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
							+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
							+ "order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setString(2, "2"+"%");
					break;
				case 300:	// 남성카테고리
					sql = "select count(*) from product "
							+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
							+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
							+ "order by pd_id asc;";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					ps.setString(2, "3"+"%");
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
				sql = "select * from product where pd_id in (select pd_id from product_company_rel where co_id = ?) order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			case 100:
				/*남성 리스트*/
				sql = "select * from product "
						+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
						+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
						+ "order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setString(2,"1"+"%");
				break;
			case 200:
				/*여성 리스트*/
				sql = "select * from product "
						+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
						+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
						+ "order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setString(2,"2"+"%");
				break;	
			case 300:
				/*공용 리스트*/
				sql = "select * from product "
						+ "where pd_id in (select pd_id from product_company_rel where co_id = ?) "
						+ "and pd_id in (select pd_id from product_category_rel where cgp_id like ?) "
						+ "order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				ps.setString(2,"3"+"%");
				break;	
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				productVo vo = new productVo();
				
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPd_name(rs.getString("pd_name"));
				vo.setPd_status(rs.getInt("pd_status"));
				vo.setPd_summary(rs.getString("pd_summary"));
				vo.setPd_main_img(rs.getString("pd_main_img"));
				vo.setPd_main_img(rs.getString("pd_detail_img"));
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
	
	
}
