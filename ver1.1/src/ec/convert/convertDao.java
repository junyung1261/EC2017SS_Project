package ec.convert;

import java.text.DecimalFormat;

public class convertDao {
	public String commify(int value){
		int number = value;
		DecimalFormat df = new DecimalFormat("#,##0");
		return "£Ü "+df.format(number);
	}
}
