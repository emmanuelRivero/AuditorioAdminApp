package com.auditorio.date;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class epochTime {
	
	public static long convert(String Fecha) throws ParseException {	
		long unixtime;
		Date date;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		date = dateFormat.parse(Fecha);
		unixtime = (long) date.getTime()/1000;

		return unixtime;
	}
}
