package com.sitech.acctmgrint.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import com.sitech.common.utils.PrivacyUtil;
import com.sitech.common.utils.PwdUtil;
import com.sitech.jcfx.util.CodecUtil;

/**
 * <p>
 * Title: 公共配置类
 * </p>
 * <p>
 * Description: 静态方法
 * </p>
 * <p>
 * Copyright: Copyright (c) 2017
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author zhangleij
 * @version 1.0
 */
public class IntControl extends BaseBusi {
	
	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.IControl#pubEncryptData(java.util.Map) */
	public static String pubEncryptData(String inName, int inType) {
		String out_data = "";
		String inName_tmp = "";
		if (inType == 0) {
			out_data = PrivacyUtil.encode(inName);
			out_data = "++" + out_data;

		} else if (inType == 1) {
			try {
				inName = inName.substring(2);
				// out_data=PrivacyUtil.decode(inName);
				//log.debug("inName=" + inName);
				byte[] tmpByte = CodecUtil.decodeBASE64(inName);
				String bufTmp = new String(tmpByte, "GBK");
				out_data = bufTmp;

			} catch (IOException e) {
				e.printStackTrace();
			}

		} else if (inType == 2) {
			// 涉及到客户姓名，只显示姓，名用*替代；
			inName = inName.substring(2);
			try {
				// inName_tmp=PrivacyUtil.decode(inName);

				byte[] tmpByte = CodecUtil.decodeBASE64(inName);
				String bufTmp = new String(tmpByte, "GBK");
				inName_tmp = bufTmp;

			} catch (IOException e) {
				e.printStackTrace();
			}

			/* String n = repNull(inName_tmp); if ("".equals(n)) return ""; int len = n.length();
			 * 
			 * // 默认全*处理 StringBuffer sb = new StringBuffer(); for (int i = 0; i < len; i++) { sb.append("*"); } out_data = sb.toString(); StringBuffer tmp = new StringBuffer(); for (int i = 0; i < n.length() - 1; i++) tmp.append("*"); out_data = tmp.toString() + n.substring(n.length() - 1, n.length()); */

			/* 调用客户管理统一提供的静态类进行客户名称模糊化,这里调用客户管理提供的静态类中的BlurSensitiveInfo. formatName方法， 后续如果模糊化方式，直接从CRM拿到这个类文件覆盖咱们工程下的就可以 */
			out_data = BlurSensitiveInfo.formatName(inName_tmp, "1");
		}

		return out_data;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.IControl#pubEncryptData(java.util.Map) */
	public static String pubNomalEncryptData(String inName, int inType, int blurType) {
		String out_data = "";
		if (inType == 0) {
			try {
				out_data = PwdUtil.encodeDES(inName);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (inType == 1) {
			try {
				out_data = PwdUtil.decodeDES(inName);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (inType == 2) {
			// 涉及到客户姓名，只显示姓，名用*替代；
			String n = repNull(inName);
			if ("".equals(n))
				return "";
			int len = n.length();

			// 默认全*处理
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < len; i++) {
				sb.append("*");
			}
			out_data = sb.toString();
			if (blurType == 2) {// 客户号码显示前3位和末3位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 3, 3);
			} else if (blurType == 3) {// 主教位置、通信时间、时常与流量均用*代替；
				out_data = sb.toString();
			} else if (blurType == 4) {// 客户身份证号码显示前3位和末四位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 3, 4);
			} else if (blurType == 5) {// 集团客户编号显示前两位和末三位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 2, 3);
			} else if (blurType == 6) {// 集团客户名称显示前3个字符和最后3个字符，其他字符用*代替；
				out_data = formatDataFuzzy(inName, 3, 3);
			} else if (blurType == 7) {// 客户居住地址、联系地址显示到市一级别，剩余字符用*代替；?????
				out_data = sb.toString();
			} else if (blurType == 8) {// 联系电话（不包括区号）显示前2位与末2位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 2, 2);
			} else if (blurType == 9) {// 客户兴趣爱好全部用*代替；
				out_data = sb.toString();
			} else if (blurType == 10) {// 客户积分、预存款、信用等级、信用额度、交费历史均用*代替；
				out_data = sb.toString();
			} else if (blurType == 11) {// 各类固定费用、通信费用、数据费用均用*代替。
				out_data = sb.toString();
			} else if (blurType == 12) {// 涉及到客户姓名,保留第一个，其他*替代。
				StringBuffer tmp = new StringBuffer();
				for (int i = 1; i < n.length(); i++)
					tmp.append("*");
				out_data = n.substring(0, 1) + tmp.toString();
			}

		}

		return out_data;
	}

	private static String repNull(Object param) {
		if (param == null) {
			return "";
		}
		return param.toString().trim();
	}

	private static String formatDataFuzzy(Object name, int before, int after) {
		String result = "";
		String _reStr = "*";
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

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.inter.IControl#getSequence(java.lang.String ) */
	@SuppressWarnings("unchecked")
	public static long getSequence(String seqName) {
		Map<String, Object> inParamMap = new HashMap<String, Object>();
		inParamMap.put("SEQ_NAME", seqName);
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("dual_INT.qSequence", inParamMap);
		return Long.parseLong(result.get("NEXTVAL").toString());
	}

}
