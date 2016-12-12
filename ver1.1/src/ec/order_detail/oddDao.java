package ec.order_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;
import ec.member.memberVo;

public class oddDao {
	public int insertOrderDetail(oddVo vo, long or_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into order_detail values(null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);

			ps.setLong(1, or_id);
			ps.setString(2, vo.getCo_id());
			ps.setInt(3, vo.getPd_id());
			ps.setInt(4, vo.getPdd_id());
			ps.setInt(5, vo.getOrd_count());
			ps.setInt(6, vo.getOrd_price());
			ps.setInt(7, vo.getOrd_discount());
			ps.setInt(8, vo.getOrd_use_mileage());
			ps.setInt(9, vo.getOrd_delivery_pay());
			ps.setInt(10, vo.getOrd_delivery_co_id());
			ps.setInt(11, vo.getOrd_delivery_num());
			ps.setString(12, vo.getOrd_send_time());
			ps.setString(13, vo.getOrd_receive_time());
			ps.setString(14, vo.getOrd_decision_time());
			ps.setString(15, vo.getOrd_exchange_time());
			ps.setString(16, vo.getOrd_refund_time());
			ps.setInt(17, vo.getOrd_status());

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public int updateOrderDetailStatus(long or_id, int ord_id, int or_status, int odc, String odn, String ost) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = null;
			
			switch(or_status){
			case 1:
				sql = "update order_detail set ord_status = ? where or_id= ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, or_status);
				ps.setLong(2, or_id);
				break;
				
			case 2:
				sql = "update order_detail set ord_status = 200 , ord_delivery_co_id = ? , ord_delivery_num = ?, ord_send_time = ? where ord_id= ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, odc);
				ps.setString(2, odn);
				ps.setString(3, ost);
				ps.setLong(4, ord_id);
				break;
				
			case 3:
				break;
			}

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<oddVo> orderDetailList(int req, String co_id) {
		ArrayList<oddVo> list = new ArrayList<oddVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();

			String sql = null;
			switch(req){
				case 1:
					sql = "select * from order_detail where ord_status = 1 order by co_id asc";
					ps = conn.prepareStatement(sql);
					break;
				case 2:
					sql = "select * from order_detail where ord_status >= 200 and ord_status <= 201 order by ord_send_time desc";
					ps = conn.prepareStatement(sql);
					break;	
				case 6:
					sql = "select * from order_detail where ord_status >= 600 and ord_status <= 601 order by ord_decision_time desc";
					ps = conn.prepareStatement(sql);
					break;	
				case 101:
					sql = "select * from order_detail where ord_status = 1 and co_id = ? order by ord_send_time desc";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					break;
				case 102:
					sql = "select * from order_detail where ord_status >= 200 and ord_status <= 201 and co_id = ? order by ord_send_time desc";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					break;	
				case 106:
					sql = "select * from order_detail where ord_status >= 600 and ord_status <= 601 and co_id = ? order by ord_decision_time desc";
					ps = conn.prepareStatement(sql);
					ps.setString(1, co_id);
					break;		
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				oddVo vo = new oddVo();
				
				vo.setOrd_id(rs.getInt("ord_id"));
				vo.setOr_id(rs.getLong("or_id"));
				vo.setCo_id(rs.getString("co_id"));
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPdd_id(rs.getInt("pdd_id"));
				vo.setOrd_count(rs.getInt("ord_count"));
				vo.setOrd_price(rs.getInt("ord_price"));
				vo.setOrd_discount(rs.getInt("ord_discount"));
				vo.setOrd_use_mileage(rs.getInt("ord_use_mileage"));
				vo.setOrd_delivery_pay(rs.getInt("ord_delivery_pay"));
				vo.setOrd_delivery_co_id(rs.getInt("ord_delivery_co_id"));
				vo.setOrd_delivery_num(rs.getInt("ord_delivery_num"));
				vo.setOrd_send_time(rs.getString("ord_send_time"));
				vo.setOrd_receive_time(rs.getString("ord_receive_time"));
				vo.setOrd_decision_time(rs.getString("ord_decision_time"));
				vo.setOrd_exchange_time(rs.getString("ord_exchange_time"));
				vo.setOrd_refund_time(rs.getString("ord_refund_time"));
				vo.setOrd_status(rs.getInt("ord_status"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public ArrayList<oddVo> orderPopList(long or_id) {
		ArrayList<oddVo> list = new ArrayList<oddVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();

			String sql = "select * from order_detail where or_id = ? order by co_id asc";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, or_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				oddVo vo = new oddVo();
				
				vo.setOrd_id(rs.getInt("ord_id"));
				vo.setOr_id(rs.getLong("or_id"));
				vo.setCo_id(rs.getString("co_id"));
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPdd_id(rs.getInt("pdd_id"));
				vo.setOrd_count(rs.getInt("ord_count"));
				vo.setOrd_price(rs.getInt("ord_price"));
				vo.setOrd_discount(rs.getInt("ord_discount"));
				vo.setOrd_use_mileage(rs.getInt("ord_use_mileage"));
				vo.setOrd_delivery_pay(rs.getInt("ord_delivery_pay"));
				vo.setOrd_delivery_co_id(rs.getInt("ord_delivery_co_id"));
				vo.setOrd_delivery_num(rs.getInt("ord_delivery_num"));
				vo.setOrd_send_time(rs.getString("ord_send_time"));
				vo.setOrd_receive_time(rs.getString("ord_receive_time"));
				vo.setOrd_decision_time(rs.getString("ord_decision_time"));
				vo.setOrd_exchange_time(rs.getString("ord_exchange_time"));
				vo.setOrd_refund_time(rs.getString("ord_refund_time"));
				vo.setOrd_status(rs.getInt("ord_status"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public oddVo getOrderDetailInfo(int ord_id) {
		oddVo vo = new oddVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from order_detail where ord_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ord_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setOrd_id(rs.getInt("ord_id"));
				vo.setOr_id(rs.getLong("or_id"));
				vo.setCo_id(rs.getString("co_id"));
				vo.setPd_id(rs.getInt("pd_id"));
				vo.setPdd_id(rs.getInt("pdd_id"));
				vo.setOrd_count(rs.getInt("ord_count"));
				vo.setOrd_price(rs.getInt("ord_price"));
				vo.setOrd_discount(rs.getInt("ord_discount"));
				vo.setOrd_use_mileage(rs.getInt("ord_use_mileage"));
				vo.setOrd_delivery_pay(rs.getInt("ord_delivery_pay"));
				vo.setOrd_delivery_co_id(rs.getInt("ord_delivery_co_id"));
				vo.setOrd_delivery_num(rs.getInt("ord_delivery_num"));
				vo.setOrd_send_time(rs.getString("ord_send_time"));
				vo.setOrd_receive_time(rs.getString("ord_receive_time"));
				vo.setOrd_decision_time(rs.getString("ord_decision_time"));
				vo.setOrd_exchange_time(rs.getString("ord_exchange_time"));
				vo.setOrd_refund_time(rs.getString("ord_refund_time"));
				vo.setOrd_status(rs.getInt("ord_status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
