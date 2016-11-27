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
	public int orderInitialize(orderVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		 Calendar cal = Calendar.getInstance();
	     SimpleDateFormat vans = new SimpleDateFormat("yyyyMMddhhmm");
	     String datetime = vans.format(cal);
	     Random ran = new Random();
	     ran.setSeed(vo.getMem_id());
	     

		
		try {
			conn = ConnUtil.getConnection();  //Column 27개 중 1개 Auto_inrement, 24(vo) + 2개 매개변수
			String sql = "insert into order_info values(?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			int num = ran.nextInt(999999)+100000;
			if(num > 1000000) num -=100000;
			
			ps.setInt	(1, Integer.parseInt(datetime+"mvo.getMem_id()"+num));
			ps.setInt	(, x);
			
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
			case 100:
				sql = "select * from order_info where ord_status = 0 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;
			/* 전체 배송준비 리스트 */
			case 101:
				sql = "select * from order_info where ord_status = 1 order by ord_id desc";
				ps = conn.prepareStatement(sql);
				break;

			case 0:
				/* 업체별 결제대기 리스트 */
				sql = "select * from order_info where ord_pd_id in("
						+ "select pd_id from product_company_rel where co_id = ?) and ord_status = 0 order by ord_id desc;";
				ps = conn.prepareStatement(sql);
				ps.setString(1, co_id);
				break;
			case 1:
				/* 업체별 배송준비 리스트 */
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
				vo.setOrd_mileage(rs.getInt("ord_mileage"));
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
				vo.setOrd_status_msg(rs.getString("ord_status_msg"));

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
