package com.sitech.acctmgrint.common;

public class BlurSensitiveInfo {
	public static String _province_group = "220000";

	public static String _reStr = "*";

	private static String repNull(Object param) {
		if (param == null) {
			return "";
		}
		return param.toString().trim();
	}

	public static String formatName(Object name) {
		String result = "";
		String n = repNull(name);
		if ("".equals(n))
			return "";
		int len = n.length();

		// 默认全*处理
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < len; i++) {
			sb.append("*");
		}
		result = sb.toString();
		return result;
	}

    public static String formatName(Object name, String type) {
        String result = "";
        String n = repNull(name);
        if ("".equals(n))
            return "";
        int len = n.length();

// 默认全*处理
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < len; i++) {
            sb.append("*");
        }
        result = sb.toString();

/**
 * 1：客户名称（两个字或三个字的至少1个字用*代替，大于三个字的至少2个字用*代替,其余字用*代替,张三->*三 李二宝 -> *二宝
 * 欧阳正华 -> 欧阳**） 2：邮件地址（@前面的用3个*代替，13901234567@139.com->***@139.com）
 * 3：护照号码和军官证（末4位用*代替，G12345678-> G1234****;空字第12345678->空字第1234****）
 * 4：身份证号码（18位:出生年月日用*代替，最后一位用*代替330101197701014237
 * ->330101********423*；15位：342322620602141->342322******141）
 * 5、其他证件(大于7位的保留后4位，其余的全部*代替)
 * 6：银行账号（保留前5位和末四位，中间用*代替，9558801202106562334->95588**********2334）
 * 7：证件、联系、家庭、单位地址和工作单位名称（全部用8个*代替）
 * 8：手机号码（保留前三位和末四位，13800001234->138****1234）
 **/
        if (type.equals("1")) {
            if (n.length() == 2) {
                result = n.substring(0, 1) + "*";
            } else if (n.length() == 3) {
                result = n.substring(0, 1) + "**";
            } else if (n.length() == 4) {
                result = n.substring(0, 2) + "**";
            } else if (n.length() > 4) {
                result = formatDataFuzzy(n, 3, n.length());
            }
        } else if (type.equals("2")) {
            int j = n.lastIndexOf("@");
            if (j != -1) {
                result = "***" + n.substring(j, n.length());
            } else {
                result = n;
            }
        } else if (type.equals("3")) {
            if (name.toString().length() > 4) {
                result = n.substring(0, n.length() - 4) + "****";
            } else {
                result = sb.toString();
            }
        } else if (type.equals("4")) {
            if (name.toString().length() == 18) {
                result = n.substring(0, 4) + "**********" + n.substring(14, 18);
            } else if (name.toString().length() == 15) {
                result = n.substring(0, 4) + "*******" + n.substring(11, 15);
            } else if (name.toString().length() > 7) {
                result = n.substring(0, n.length() - 4) + "*****";
            }
        } else if (type.equals("5")) {
            if (name.toString().length() > 7) {
                result = n.substring(0, n.length() - 4) + "*****";
            }
        } else if (type.equals("6")) {
            result = formatDataFuzzy(n, 5, 4);
        } else if (type.equals("7")) {
            result = sb.toString();
        } else if (type.equals("8")) {
            result = formatDataFuzzy(n, 3, 4);
        }

        return result;
    }

	private static String formatDataFuzzy(Object name, int before, int after) {
		String result = "";
		String n = repNull(name);
		if ("".equals(n))
			return "";

		int len = n.length();
		int reqLen = after - before + 1;

		StringBuffer sb = new StringBuffer();
		if (len > reqLen) {
			for (int i = 0; i < reqLen; i++) {
				sb.append(_reStr);
			}
			result = n.substring(0, before - 1) + sb.toString() + n.substring(after);
		}
		return result;
	}

	public static void main(String[] args) {

		Object name = "李二宝";
		System.out.println(formatName(name, "1"));

	}

}
