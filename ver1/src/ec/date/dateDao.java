package ec.date;
import java.util.*;
import ec.date.dateVo;

public class dateDao {
	public dateVo getToday(){
		System.out.println("[System] ���� ��¥ �� �ð� ��� �޽�� ����");
		Calendar cal = Calendar.getInstance();
		dateVo dvo = new dateVo();
		
		dvo.setYear(cal.get(Calendar.YEAR));
		dvo.setMonth(cal.get(Calendar.MONTH)+1);
		dvo.setDate(cal.get(Calendar.DAY_OF_MONTH));
		dvo.setHour(cal.get(Calendar.HOUR));
		dvo.setMinute(cal.get(Calendar.MINUTE));
		dvo.setSecond(cal.get(Calendar.SECOND));
		
		return dvo;
	}
	public dateVo getRecentDays(int req){
		System.out.println("[System] ���� ��¥ ���� ���� ���� ��� �޽�� ����");
		Calendar cal = Calendar.getInstance();
		dateVo dvo = new dateVo();
		
		
		return dvo;
	}
}
