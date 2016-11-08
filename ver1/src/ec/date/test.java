package ec.date;

import java.util.Calendar;

public class test {
	public static void main(String[] args){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -3);
		System.out.println(cal.get(Calendar.DAY_OF_MONTH));
	}
}
