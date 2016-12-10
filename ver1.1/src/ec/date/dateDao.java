package ec.date;
import java.util.*;
import ec.date.dateVo;

public class dateDao {
	public dateVo getToday(){
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
	
	
	public String getToday(int offset){
		System.out.println("[System] 현재 날짜 기준 이전 일자 출력 메쏘드 진입");
		Calendar cal = Calendar.getInstance();
		dateVo dvo = new dateVo();
		cal.add(Calendar.DATE, offset);
		dvo.setYear(cal.get(Calendar.YEAR));
		dvo.setMonth(cal.get(Calendar.MONTH)+1);
		dvo.setDate(cal.get(Calendar.DAY_OF_MONTH));
		
		String set_date = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear();
		return set_date;
	}
	
	public String getWeekData(){
		System.out.println("[System] 일주일 그래프 데이터 출력 메쏘드");
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int date = cal.get(Calendar.DAY_OF_MONTH);
		
		String result = "'07/12/2016','06/12/2016','05/12/2016','04/12/2016','03/12/2016','02/12/2016','01/12/2016'";
		System.out.println(result);
		return result;
	}
	
	public String now(){
		
		Calendar cal = Calendar.getInstance();
		dateVo dvo = new dateVo();
		String now = null;
		dvo.setYear(cal.get(Calendar.YEAR));
		dvo.setMonth(cal.get(Calendar.MONTH)+1);
		dvo.setDate(cal.get(Calendar.DAY_OF_MONTH));
		dvo.setHour(cal.get(Calendar.HOUR));
		dvo.setMinute(cal.get(Calendar.MINUTE));
		dvo.setSecond(cal.get(Calendar.SECOND));
		
		
		now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
		return now;
	}
}
