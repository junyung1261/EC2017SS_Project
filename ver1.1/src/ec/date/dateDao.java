package ec.date;
import java.util.*;
import ec.date.dateVo;

public class dateDao {

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
	
	public String getToday(int offset){
		
		Calendar cal = Calendar.getInstance();
		dateVo dvo = new dateVo();
		cal.add(Calendar.DATE, offset);
		dvo.setYear(cal.get(Calendar.YEAR));
		dvo.setMonth(cal.get(Calendar.MONTH)+1);
		dvo.setDate(cal.get(Calendar.DAY_OF_MONTH));
		
		String set_date = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear();
		return set_date;
	}
}
