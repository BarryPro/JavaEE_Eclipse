package com.sitech.acctmgr.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.jcfx.util.DateUtil;

/**
 * Created by wangyla on 2016/5/12.
 */
public class DateUtils {
	private static final Logger logger = LoggerFactory.getLogger(DateUtils.class);
	public static final String DATE_FORMAT_YYYYMM = "yyyyMM";
	public static final String DATE_FORMAT_YYYYMMDD = "yyyyMMdd";
	public static final String DATE_FORMAT_YYYYMMDD1 = "yyyy/MM/dd";
	public static final String DATE_FORMAT_YYYYMMDDHHMISS = "yyyyMMddHHmmss";
	public static final String DATE_FORMAT_YYYYMMDDHHMISS1 = "yyyyMMdd HH:mm:ss";
	public static final String DATE_FORMAT_YYYYMMDDHHMISS2 = "yyyy/MM/dd HH:mm:ss";
	public static final String DATE_FORMAT_YYYYMMDDHHMISS3 = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 功能：获取当前系统年月
	 *
	 * @return int yyyymm
	 */
	public static int getCurYm() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		return year * 100 + month;
	}

	/**
	 * 功能：获取系统年月日
	 *
	 * @return yyyymmdd
	 */
	public static int getCurDay() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		return year * 10000 + month * 100 + day;
	}

	/**
	 * 获取当前时间串
	 * 
	 * @param fmtStr
	 * @return
	 */
	public static String getCurDate(String fmtStr) {
		return DateUtil.format(new Date(), fmtStr);

	}

	/**
	 * 功能：月份加减运算
	 *
	 * @param ym
	 *            -被处理的月份
	 * @param amt
	 *            -变化的值，正值为月份增加，负值为月份减小
	 * @return
	 */
	public static int addMonth(int ym, int amt) {
		String yearMonth = String.format("%d", ym);
		Date date = null;
		try {
			date = org.apache.commons.lang.time.DateUtils.parseDate(yearMonth, new String[] { "yyyyMM" });
		} catch (ParseException e) {
			logger.error(e.getMessage());
		}
		Date calcDate = org.apache.commons.lang.time.DateUtils.addMonths(date, amt);
		String dateStr = DateFormatUtils.format(calcDate, "yyyyMM");
		return Integer.parseInt(dateStr);
	}

	/**
	 * 功能：日期天数加减速运算
	 * 
	 * @param ymd
	 * @param amt
	 * @return
	 */
	public static int addDays(int ymd, int amt) {
		String totalDate = String.format("%d", ymd);
		Date date = null;
		try {
			date = org.apache.commons.lang.time.DateUtils.parseDate(totalDate, new String[] { "yyyyMMdd" });
		} catch (ParseException e) {
			logger.error(e.getMessage());
		}
		Date calcDate = org.apache.commons.lang.time.DateUtils.addDays(date, amt);
		String dateStr = DateFormatUtils.format(calcDate, "yyyyMMdd");
		return Integer.parseInt(dateStr);
	}

	/**
	 * 功能：按照format格式对两个时间做比较 如：yyyyMM、yyyyMMdd
	 *
	 * @param date1
	 * @param date2
	 * @param format
	 * @return int
	 *         <p>
	 *         1 <==> date1 > date2
	 *         </p>
	 *         <p>
	 *         0 <==> date1 = date2
	 *         </p>
	 *         <p>
	 *         -1 <==> date1 < date2
	 *         </p>
	 */
	public static int compare(String date1, String date2, String format) {
		DateFormat df = new SimpleDateFormat(format);
		int fmtLen = format.length();
		long t = 0;
		try {
			Date beginDate = df.parse(date1.substring(0, fmtLen));
			Date endDate = df.parse(date2.substring(0, fmtLen));

			t = beginDate.getTime() - endDate.getTime();

		} catch (ParseException e) {
			logger.error(e.getMessage());
		}

		return t < 0 ? -1 : (t == 0 ? 0 : 1);
	}

	public static String format(Date date, String format) {
		DateFormat df = new SimpleDateFormat(format);
		return df.format(date);
	}

	/**
	 * @param
	 * @return int
	 * @Description: 获取指定月份的最后一天
	 * @author: wangyla
	 * @version:
	 * @createTime: 2015-5-18 下午4:58:02
	 */
	public static int getLastDayOfMonth(int ym) {
		/*
		 * Calendar calendar = Calendar.getInstance(); calendar.set(Calendar.YEAR, ym / 100); calendar.set(Calendar.MONTH, ym % 100 - 1); int lastDay = calendar.getLeastMaximum(Calendar.DAY_OF_MONTH); return lastDay; */

		int year = ym / 100;
		int month = ym % 100;

		int lastDay = 0;

		if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
			lastDay = 31;
		} else if (month != 2) {
			lastDay = 30;
		} else {
			if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
				if (month == 2) {
					lastDay = 29;
				}
			} else {
				if (month == 2) {
					lastDay = 28;
				}
			}

		}

		return lastDay;
	}

	/**
	 * 获取两个日期相差天数
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static int minus(String date1, String date2) {
		DateFormat df = new SimpleDateFormat(DATE_FORMAT_YYYYMMDD);
		int fmtLen = DATE_FORMAT_YYYYMMDD.length();
		long amt = 0;
		try {
			Date beginDate = df.parse(date1.substring(0, fmtLen));
			Date endDate = df.parse(date2.substring(0, fmtLen));

			amt = beginDate.getTime() - endDate.getTime();

		} catch (ParseException e) {
			logger.error(e.getMessage());
		}


		return (int) amt / (24 * 60 * 60 * 1000);
	}
}
