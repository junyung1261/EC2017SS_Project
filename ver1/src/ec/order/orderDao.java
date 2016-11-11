package ec.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;
public class orderDao {
	public int orderInitialize(orderVo vo, String ord_opt_color, String ord_opt_size, String ord_opt_count, int ord_account_value,int ord_delivery_pay, int ord_mileage_value, int ord_status, String ord_status_msg) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 27개 중 1개 Auto_inrement, 24(vo) + 2개 매개변수
			String sql = "insert into order_info values(null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt		(1,vo.getOrd_pd_id	())	;
			ps.setString	(2,ord_opt_color)	;
			ps.setString	(3,ord_opt_size)	;
			ps.setInt		(4,Integer.parseInt(ord_opt_count))	;
			ps.setInt		(5,vo.getOrd_mem_id());
			ps.setInt		(6,ord_delivery_pay)	;
			ps.setInt		(7,vo.getOrd_delivery_pay_method())	;
			ps.setString	(8,vo.getOrd_name_recipient())	;
			ps.setString	(9,vo.getOrd_phone_recipient())	;
			ps.setString	(10,vo.getOrd_zipcode())	;
			ps.setString	(11,vo.getOrd_address())	;
			ps.setInt		(12,vo.getOrd_mileage())	;
			ps.setInt		(13,ord_mileage_value)	;
			ps.setInt		(14,vo.getOrd_account_method())	;
			ps.setInt		(15,ord_account_value)	;
			ps.setString	(16,vo.getOrd_account_time())	;
			ps.setInt		(17,vo.getOrd_delivery_co())	;
			ps.setString	(18,vo.getOrd_delivery_num())	;
			ps.setString	(19,vo.getOrd_msg())	;
			ps.setString	(20,vo.getOrd_send_time())	;
			ps.setString	(21,vo.getOrd_receive_time())	;
			ps.setString	(22,vo.getOrd_decision_time())	;
			ps.setString	(23,vo.getOrd_exchange_time())	;
			ps.setString	(24,vo.getOrd_refund_time())	;
			ps.setInt		(25,ord_status)	;
			ps.setString	(26,ord_status_msg)	;
			
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
			switch(req){
				/*전체 결제대기 리스트*/
			case 100:
				sql = "select * from order_info where ord_status = 0 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				/*전체 배송준비 리스트*/
			case 101:
				sql = "select * from order_info where ord_status = 1 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
				
			case 0:
				/*업체별 결제대기 리스트*/
				sql = "select * from order_info where ord_pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status = 0 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			case 1:
				/*업체별 배송준비 리스트*/
				sql = "select * from order_info where ord_pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status = 1 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				orderVo vo = new orderVo();
				
				vo.setOrd_id(rs.getInt("ord_id"));
				vo.setOrd_pd_id(rs.getInt("ord_pd_id"));
				vo.setOrd_opt_color(rs.getString("ord_opt_color"));
				vo.setOrd_opt_size(rs.getString("ord_opt_size"));
				vo.setOrd_opt_count(rs.getInt("ord_opt_count"));
				vo.setOrd_mem_id(rs.getInt("ord_mem_id"));
				vo.setOrd_delivery_pay(rs.getInt("ord_delivery_pay"));
				vo.setOrd_delivery_pay_method(rs.getInt("ord_delivery_pay_method"));
				vo.setOrd_name_recipient(rs.getString("ord_name_recipient"));
				vo.setOrd_phone_recipient(rs.getString("ord_phone_recipient"));
				vo.setOrd_zipcode(rs.getString("ord_zipcode"));
				vo.setOrd_address(rs.getString("ord_address"));
				vo.setOrd_mileage(rs.getInt	("ord_mileage"));
				vo.setOrd_mileage_value(rs.getInt("ord_mileage_value"));
				vo.setOrd_account_method(rs.getInt("ord_account_method"));
				vo.setOrd_account_value(rs.getInt("ord_account_value"));
				vo.setOrd_account_time(rs.getString("ord_account_time"));
				vo.setOrd_delivery_co(rs.getInt("ord_delivery_co"));
				vo.setOrd_delivery_num(rs.getString("ord_delivery_num"));
				vo.setOrd_msg(rs.getString("ord_msg"));
				vo.setOrd_send_time(rs.getString("ord_send_time"));
				vo.setOrd_receive_time(rs.getString("ord_receive_time"));
				vo.setOrd_decision_time(rs.getString("ord_decision_time"));
				vo.setOrd_exchange_time(rs.getString("ord_exchange_time"));
				vo.setOrd_refund_time(rs.getString("ord_refnd_time"));
				vo.setOrd_status(rs.getInt("ord_status"));
				vo.setOrd_status_msg(rs.getString	("ord_status_msg"));

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
