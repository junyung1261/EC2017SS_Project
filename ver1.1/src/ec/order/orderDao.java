package ec.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import ec.connUtil.ConnUtil;

public class orderDao {
	public long insertOrder(orderVo vo, String now) {
		int rst = 0;

		Connection conn = null;
		PreparedStatement ps = null;

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat vans = new SimpleDateFormat("yyyyMMddhhmmss");
		String datetime = vans.format(cal.getTime());
		Random ran = new Random(System.currentTimeMillis());

		int num = ran.nextInt(99999) + 10000;
		if (num > 100000)
			num -= 10000;

		try {
			conn = ConnUtil.getConnection(); // Column 27개 중 1개 Auto_inrement,
												// 24(vo) + 2개 매개변수
			String sql = "insert into order_info values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);

			ps.setLong(1, Long.parseLong(datetime + num));
			ps.setInt(2, vo.getMem_id());
			ps.setString(3, vo.getMem_name());
			ps.setString(4, vo.getMem_phone());
			ps.setString(5, vo.getMem_zipcode());
			ps.setString(6, vo.getMem_address());
			ps.setInt(7, vo.getOr_total_price());
			ps.setInt(8, vo.getOr_total_discount());
			ps.setInt(9, vo.getOr_total_delivery_price());
			ps.setInt(10, vo.getOr_total_mileage());
			ps.setInt(11, vo.getOr_account_method());
			ps.setInt(12, vo.getOr_account_value());
			ps.setString(13, now);
			ps.setString(14, vo.getOr_msg());
			ps.setInt(15, vo.getOr_status());
			ps.setString(16, vo.getOr_status_msg());

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return Long.parseLong(datetime + num);
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
            sql = "select * from order_info where or_status = 0 order by or_account_time desc";
            ps = conn.prepareStatement(sql);
            break;
         /* 전체 배송준비 리스트 */
         case 1:
            sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where or_status = 1 order by or_account_time desc";
            ps = conn.prepareStatement(sql);
            break;
            /* 전체 배송중/완료/리스트 */   
           
         case 100:
            /* 업체별 결제대기 리스트 */
            sql = "select * from order_info join order_detail on order_info.or_id = order_detail.or_id where co_id = ? and or_status = 0 order by ord_id desc;";
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
            vo.setOr_total_discount(rs.getInt("or_total_discount"));
            vo.setOr_total_delivery_price(rs.getInt("or_total_delivery_price"));
            vo.setOr_total_mileage(rs.getInt("or_total_mileage"));
            vo.setOr_account_method(rs.getInt("or_account_method"));
            vo.setOr_account_value(rs.getInt("or_account_value"));
            vo.setOr_account_time(rs.getString("or_account_time"));
            vo.setOr_msg(rs.getString("or_msg"));
            vo.setOr_status( rs.getInt("or_status"));
            vo.setOr_status_msg(rs.getString("or_status_msg"));

            list.add(vo);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         ConnUtil.close(rs, ps, conn);
      }
      return list;
   }
   

	public orderVo getOrderInfo(long or_id) {
		orderVo vo = new orderVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from order_info where or_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, or_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setOr_id(rs.getLong("or_id"));
				vo.setMem_id(rs.getInt("mem_id"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setMem_phone(rs.getString("mem_phone"));
				vo.setMem_zipcode(rs.getString("mem_zipcode"));
				vo.setMem_address(rs.getString("mem_address"));
				vo.setOr_total_price(rs.getInt("or_total_price"));
				vo.setOr_total_discount(rs.getInt("or_total_discount"));
				vo.setOr_total_delivery_price(rs.getInt("or_total_delivery_price"));
				vo.setOr_total_mileage(rs.getInt("or_total_mileage"));
				vo.setOr_account_method(rs.getInt("or_account_method"));
				vo.setOr_account_value(rs.getInt("or_account_value"));
				vo.setOr_account_time(rs.getString("or_account_time"));
				vo.setOr_msg(rs.getString("or_msg"));
				vo.setOr_status(rs.getInt("or_status"));
				vo.setOr_status_msg(rs.getString("or_status_msg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public int updateOrderStatus(long or_id, int or_status) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "update order_info set or_status = ? where or_id= ?";
			ps = conn.prepareStatement(sql);

			
			ps.setInt(1, or_status);
			ps.setLong(2, or_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	
   
}