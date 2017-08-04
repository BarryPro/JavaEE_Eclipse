package com.sitech.acctmgr.common.utils;

public class UnitUtils {
	public static final String GPRS_UNIT_KB = "KB";
	public static final String GPRS_UNIT_MB = "MB";
	public static final String GPRS_UNIT_GB = "GB";

	public static String trans(long netKb, String unitFormat) {
		String returnValue = null;
		switch (unitFormat) {
		case GPRS_UNIT_KB:
			returnValue = String.format("%d", netKb);
			break;
		case GPRS_UNIT_MB:
			returnValue = kb2mb(netKb);
			break;
		case GPRS_UNIT_GB:
			returnValue = kb2gb(netKb);
			break;
		default:
			returnValue = String.format("%d", netKb);
			break;

		}
		return returnValue;
	}

	private static String kb2mb(long value) {
		return String.format("%.2f", value / 1024.0);
	}

	private static String kb2gb(long netKb) {
		String outNet = "";
    	long netMb = 0;
    	long netGb = 0;
		
		if(netKb >= 1024){
			netMb = netKb / 1024;  //转换成M
        	if(netMb >= 1024){
        		netGb = netMb / 1024; //转换成G
        		if(netGb > 0){
        			outNet = netGb + "GB" + Double.parseDouble(String.format("%.2f", (netKb - netGb  * 1024 * 1024) / 1024.0)) + "MB" ;
        		} 
        	} else {                        
        		outNet = String.format("%.2f", (netKb / 1024.0)) + "MB" ;
        	}
        } else {
        	outNet = netKb + "KB";
        }

		return outNet;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
