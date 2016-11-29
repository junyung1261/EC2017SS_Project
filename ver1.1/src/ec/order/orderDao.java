package ec.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import ec.connUtil.ConnUtil;
import ec.member.memberVo;
import ec.product.productVo;
import ec.product_detail.product_detailVo;

public class orderDao {
	public long order_insert(orderVo vo) {
		int rst = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;

		 Calendar cal = Calendar.getInstance();
		
	     SimpleDateFormat vans = new SimpleDateFormat("yyyyMMddhhmmss");
	     String datetime = vans.format(cal.getTime());
	     
	     Random ran = new Random(System.currentTimeMillis());
	     
	     
	     int num = ran.nextInt(99999)+10000;
		 if(num > 100000) num -=10000;
		
		try {
			conn = ConnUtil.getConnection();  //Column 27개 중 1개 Auto_inrement, 24(vo) + 2개 매개변수
			String sql = "insert into order_info values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			
			
			
			ps.setLong	(1, Long.parseLong(datetime+num));
			ps.setInt	(2, vo.getMem_id());
			ps.setString	(3, vo.getMem_name());
			ps.setString	(4, vo.getMem_phone());
			ps.setString	(5, vo.getMem_zipcode());
			ps.setString	(6, vo.getMem_address());
			ps.setInt	(7, vo.getOr_total_price());
			ps.setInt	(8, vo.getOr_total_delivery_price());
			ps.setInt	(9, vo.getOr_total_mileage());
			ps.setInt	(10, vo.getOr_use_mileage());
			ps.setInt	(11, vo.getOr_account_method());
			ps.setInt	(12, vo.getOr_account_value());
			ps.setString	(13, vo.getOr_account_time());
			ps.setString	(14, vo.getOr_msg());
			ps.setInt	(15, vo.getOr_status());
			ps.setString	(16, vo.getOr_status_msg());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return Long.parseLong(datetime+num);
	}
	
	public int order_detail_insert(orderVo vo, long or_id) {
		int rst = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;

		 
	     
	     
	    
		
		try {
			conn = ConnUtil.getConnection();  //Column 27개 중 1개 Auto_inrement, 24(vo) + 2개 매개변수
			String sql = "insert into order_detail values(null,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			
			
			ps.setLong	(1, or_id);
			ps.setString	(2, vo.getCo_id());
			ps.setInt	(3, vo.getPd_id());
			ps.setInt	(4, vo.getPdd_id());
			ps.setInt	(5, vo.getOrd_count());
			ps.setInt	(6, vo.getOrd_price());
			ps.setInt	(7, vo.getOrd_use_mileage());
			ps.setInt	(8, vo.getOrd_delivery_pay());
			ps.setInt	(9, vo.getOrd_delivery_method());
			ps.setInt	(10, vo.getOrd_delivery_co_id());
			ps.setInt	(11, vo.getOrd_delivery_num());
			ps.setInt	(12, vo.getOrd_status());
			
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}


	public ArrayList<orderVo> orderList(int req, String co_id) {
		ArrayList<orderVo> list = new ArrayList<orderVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();

			String sql = null;
			switch (req) {
			/* 전체 결제대기 리스트 */
			case 0:
				sql = "select distinct * from order_info join order_detail on order_info.or_id = order_detail.or_id where or_status = 0";
				ps = conn.prepareStatement(sql);
				break;
			/* 전체 배송준비 리스트 */
			case 1:
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where or_status = 1 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				/* 전체 배송중/완료/구매확정 리스트 */	
			case 2:
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where ord_status >= 200 and ord_status <=202 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				/* 전체 주문취소접수 리스트 */	
			case 3:
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where ord_status >=300 and ord_status <= 305 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				/* 전체 교환접수 리스트 */	
			case 4:
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where ord_status >=400 and ord_status <= 405 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				/* 전체 환불접수 리스트 */	
			case 5:
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where ord_status >=500 and ord_status <= 505 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				
				
			case 100:
				/* 업체별 결제대기 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and or_status = 0 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			
			case 101:
				/* 업체별 배송준비 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and or_status = 1 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			
			case 102:
				/* 업체별 상품발송 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status >= 200 and ord_status <=202 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
				
			case 103:
				/* 업체별 주문취소 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status >= 300 and ord_status <=305 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;	
				
			case 104:
				/* 업체별 교환접수 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status >= 400 and ord_status <=405 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;	
				
			case 105:
				/* 업체별 환불접수 리스트 */
				sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status >= 500 and ord_status <=505 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;	
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				orderVo vo = new orderVo();
				
				
				vo.setOr_id(rs.getLong("or_id"));
				vo.setMem_id(rs.getInt("mem_id"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setMem_phone(rs.getString("mem_phone"));
				vo.setMem_zipcode(rs.getString("mem_zipcode"));
				vo.setMem_address(rs.getString("mem_address"));
				vo.setOr_total_price(rs.getInt("or_total_price"));
				vo.setOr_total_delivery_price(rs.getInt("or_total_delivery_price"));
				vo.setOr_total_mileage(rs.getInt("or_total_mileage"));
				vo.setOr_use_mileage(rs.getInt("or_use_mileage"));
				vo.setOr_account_method(rs.getInt("or_account_method"));
				vo.setOr_account_value(rs.getInt("or_account_value"));
				vo.setOr_account_time(rs.getString("or_account_time"));
				vo.setOr_msg(rs.getString("or_msg"));
				vo.setOr_status( rs.getInt("or_status"));
				vo.setOr_status_msg(rs.getString("or_status_msg"));
				
				
				vo.setCo_id(rs.getString("co_id"));
				vo.setPd_id( rs.getInt("pd_id"));
				vo.setPdd_id( rs.getInt("pdd_id"));
				vo.setOrd_count( rs.getInt("ord_count"));
				vo.setOrd_price( rs.getInt("ord_price"));
				vo.setOrd_use_mileage( rs.getInt("ord_use_mileage"));
				vo.setOrd_delivery_pay( rs.getInt("ord_delivery_pay"));
				vo.setOrd_delivery_method( rs.getInt("ord_delivery_method"));
				vo.setOrd_delivery_co_id( rs.getInt("ord_delivery_co_id"));
				vo.setOrd_delivery_num( rs.getInt("ord_delivery_num"));
				vo.setOrd_status( rs.getInt("ord_status"));
				

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
