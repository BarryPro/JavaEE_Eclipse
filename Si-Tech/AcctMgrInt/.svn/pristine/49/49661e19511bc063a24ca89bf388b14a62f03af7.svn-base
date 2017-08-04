package com.sitech.acctmgrint.common.utils;

import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.math.RandomUtils;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 
 * 关于类型转换的静态方法都可放在这个工具类里面。
 * @author 2014/10/31 09:59
 *
 */
public class ValueUtils {
	
	private static final char[] seeds = {
		'0', '1', '2', '3', '4', '5', 
		'6', '7', '8', '9', /*'a', 'b', 
		'c', 'd', 'e', 'f', 'g', 'h', 
		'i', 'j', 'k', 'l', 'm', 'n', 
		'o', 'p', 'q', 'r', 's', 't', 
		'u', 'v', 'w', 'x', 'y', 'z', 
		'A', 'B', 'C', 'D', 'E', 'F',
		'G', 'H', 'I', 'J', 'K', 'L',
		'M', 'N', 'O', 'P', 'Q', 'R',
		'S', 'T', 'U', 'V', 'W', 'X',
		'Y', 'Z', '~', '!', '@', '#',
		'$', '%', '^', '&', '*', '(',
		')', '`', ',', '.', '/', '{',
		'}', '[', ']', '|', '=', '?', 
		'-', '+', ';'*/
	};
	
	/** 
	* 汉语中数字大写 
	*/ 
	private static final String[] CN_UPPER_NUMBER = { "零", "壹", "贰", "叁", "肆", 
	"伍", "陆", "柒", "捌", "玖" }; 
	
	/** 
	* 汉语中货币单位大写，这样的设计类似于占位符 
	*/ 
	private static final String[] CN_UPPER_MONETRAY_UNIT = { "分", "角", "元", 
	"拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "兆", "拾", 
	"佰", "仟" }; 
	
	/** 
	* 特殊字符：整 
	*/ 
	private static final String CN_FULL = "整"; 
	/** 
	* 特殊字符：负 
	*/ 
	private static final String CN_NEGATIVE = "负"; 
	/** 
	* 金额的精度，默认值为2 
	*/ 
	private static final int MONEY_PRECISION = 2; 
	/** 
	* 特殊字符：零元整 
	*/ 
	private static final String CN_ZEOR_FULL = "零元" + CN_FULL; 
	
	/**
	 * 
	 * <dt>将一个Object类型的值转换为long原始数据类型。在使用此类时可以使用静态导入的方式</dt>
	 * <pre>此方法目前只支持BigDecimal, Long, String 类型的类型转换。如果是不兼容的类型会返回0值</pre>
	 * <i>例如:</i>
	 * <pre>
	 * 	<code>
	 *  import static com.sitech.acctmgr.common.utils.ValueUtils.* ;
	 * 	
	 * 	public void test() {
	 * 		Object userNo = null ;
	 * 		long userNoValue = 0;
	 * 		userNo = Map.get("ID_NO");
	 * 		userNoValue = longValue (idNo);
	 * 	}
	 * 	</code>
	 * </pre>
	 * @param sourceValue 
	 * @return
	 */
	
	public static long longValue(Object sourceValue) {
		
		
		long destValue = 0 ;
		BigDecimal decimal = null ;
		String valueString = null;
		Long valueLong = null;
		Integer valueInt=null;
		
		if(sourceValue instanceof BigDecimal) {
			decimal = (BigDecimal) sourceValue ;
			destValue = decimal.longValue();
		} else 
			
		if( sourceValue instanceof String) {
			valueString = (String) sourceValue ;
			if(StringUtils.isNumeric(valueString)) {
				destValue = Long.parseLong(valueString) ;
			}
		} else
		
		if(sourceValue instanceof Long) {
			valueLong = (Long) sourceValue ;
			destValue = valueLong.longValue();
		} else if(sourceValue instanceof Integer){
			valueInt = (Integer)sourceValue;
			destValue = valueInt.longValue();
		}else {
			
			//这里可以抛出一个异常，但是此异常为运行时异常。应该在调用此方法时考虑传入数据的准确性。
			//throw new UnsupportedOperationException("");
		}
		
		//TODO 目前只支持以上几种类型，如果需要可以添加任意类型。
		
		return destValue ;
	}
	
	public static int intValue(Object sourceValue) {
		
		int destValue = 0 ;
		BigDecimal decimal = null ;
		String valueString = null ;
		Integer valueLong = null ;
		
		if(sourceValue instanceof BigDecimal) {
			decimal = (BigDecimal) sourceValue ;
			destValue = decimal.intValue();
		}
			
		if( sourceValue instanceof String ) {
			valueString = (String) sourceValue ;
			if(StringUtils.isNumeric(valueString)) {
				destValue = Integer.parseInt(valueString) ;
			}
		}
		
		if(sourceValue instanceof Integer) {
			valueLong = (Integer) sourceValue ;
			destValue = valueLong.intValue();
		}
		
		
		if(sourceValue instanceof Long) {
			destValue = ((Long) sourceValue).intValue();
		}

		return destValue;
	}
	

	/**
	 * @description 判断Map中的一个属性是否存在，如果存在则返回这个值，否则返回一个自定义的值
	 * @param map 传入Map
	 * @param name Map中的相应的属性名
	 * @param object 自定义的值
	 * @return
	 */
	public static Object getValueFromMap(Map<String, Object> map,String name,Object object){
		if (map==null||map.get(name)==null) {
			return object;
		}else {
			return map.get(name);
		}
	}
	
	/**
	 * @description 判断MBean中Body部分，某个属性是否存在，如果存在则返回这个值，否则返回一个自定义的值
	 * @param inBean 
	 * @param name 相应的属性名
	 * @param object 自定义的值
	 * @return
	 */
	public static Object getValByBeanBody(MBean inBean, String name, Object object) {
		if (inBean == null || inBean.getBodyObject(name) == null) {
			return object;
		} else {
			return inBean.getBodyObject(name);
		}
	}
	
	public String formatMoney(Object number) {
		
		
		String value = null;
		
		if(number instanceof BigDecimal) {
			BigDecimal _number = (BigDecimal) number;
			_number.divide(new BigDecimal(100.0)).doubleValue();
		}
		
		return value;
	}
	
	/**
	 * 名称：元转分
	 * 如：12.34元转为1234分
	 * @param oDble
	 * @return long
	 */
	public static long transYuanToFen(Object oDble) {
		
		BigDecimal tmpYuan = new BigDecimal(oDble.toString());
		//处理为小数点后两位
		tmpYuan = tmpYuan.setScale(2, BigDecimal.ROUND_HALF_UP);
		//乘数 *100
		BigDecimal multiplier = new BigDecimal(100);
		//做乘法
		BigDecimal result = tmpYuan.multiply(multiplier);
		
		return result.longValue();
	}
	
	/**
	 * 名称：分转元
	 * 描述：并保留小数点后两位。
	 *     1234.5分转为12.35元。
	 * @param obFen
	 * @return
	 */
	public static double transFenToYuan(Object obFen) {
		
		BigDecimal tmpFen = new BigDecimal(obFen.toString());
		BigDecimal divider = new BigDecimal(100);//除数 100
		//做除法，并保留小数点后两位
		BigDecimal result = tmpFen.divide(divider)
				.setScale(2, BigDecimal.ROUND_HALF_UP);
		return result.doubleValue();
	}
	
	
	public static <T> Map<String, T> newHashMap() {
		
		return new HashMap<String, T>();
		
	}
	
	/** 
	* 把输入的金额转换为汉语中人民币的大写 
	* 
	* @param numberOfMoney 
	* 输入的金额 
	* @return 对应的汉语大写 
	*/ 
	public static String transYuanToChnaBig(Object obInYuan) { 
		
		BigDecimal numberOfMoney = new BigDecimal(Double.parseDouble(obInYuan.toString())); 
		
		StringBuffer sb = new StringBuffer(); 
	// -1, 0, or 1 as the value of this BigDecimal is negative, zero, or 
	// positive. 
		int signum = numberOfMoney.signum(); 
	// 零元整的情况 
		if (signum == 0) { 
			return CN_ZEOR_FULL; 
		} 
	//这里会进行金额的四舍五入 
		long number = numberOfMoney.movePointRight(MONEY_PRECISION).setScale(0, 4).abs().longValue(); 
	// 得到小数点后两位值 
		long scale = number % 100; 
		int numUnit = 0; 
		int numIndex = 0; 
		boolean getZero = false; 
	// 判断最后两位数，一共有四中情况：00 = 0, 01 = 1, 10, 11 
		if (!(scale > 0)) { 
			numIndex = 2; 
			number = number / 100; 
			getZero = true; 
		} 
		if ((scale > 0) && (!(scale % 10 > 0))) { 
			numIndex = 1; 
			number = number / 10; 
			getZero = true; 
		} 
		int zeroSize = 0; 
		while (true) { 
			if (number <= 0) { 
				break; 
			} 
	// 每次获取到最后一个数 
			numUnit = (int) (number % 10); 
			if (numUnit > 0) { 
				if ((numIndex == 9) && (zeroSize >= 3)) { 
					sb.insert(0, CN_UPPER_MONETRAY_UNIT[6]); 
				} 
				if ((numIndex == 13) && (zeroSize >= 3)) { 
					sb.insert(0, CN_UPPER_MONETRAY_UNIT[10]); 
				} 
				sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]); 
				sb.insert(0, CN_UPPER_NUMBER[numUnit]); 
				getZero = false; 
				zeroSize = 0; 
			} else { 
				++zeroSize; 
				if (!(getZero)) { 
					sb.insert(0, CN_UPPER_NUMBER[numUnit]); 
				} 
				if (numIndex == 2) { 
					if (number > 0) { 
						sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]); 
					} 
				} else if (((numIndex - 2) % 4 == 0) && (number % 1000 > 0)) { 
					sb.insert(0, CN_UPPER_MONETRAY_UNIT[numIndex]); 
				} 
				getZero = true; 
			} 
	// 让number每次都去掉最后一个数 
			number = number / 10; 
			++numIndex; 
		} 
	// 如果signum == -1，则说明输入的数字为负数，就在最前面追加特殊字符：负 
		if (signum == -1) { 
			sb.insert(0, CN_NEGATIVE); 
		} 
	// 输入的数字小数点后两位为"00"的情况，则要在最后追加特殊字符：整 
		if ((!(scale > 0)) || (!(scale % 10 > 0))) { 
			sb.append(CN_FULL); 
		} 
		return sb.toString(); 
	} 
	
	public static boolean isEmpty(String str) {
		return str == null || "".equals(str.trim());
	}

	public static boolean isNotEmpty(String str) {
		return str != null && str.trim().length() > 0;
	}	

	public static String uuid() {
		
		
		return UUID.randomUUID().toString();
	}
	
	public static String getRandomPassword(){
		
		String password = null;
		char[] word = new char[6];
		for(int i = 0; i < 6; i++){
			int index = RandomUtils.nextInt(seeds.length);
			word[i] = seeds[index];
		}
		password = new String(word);
		return password;
	}
	
	public static String transKBToMBOrGB(Object gprs, String type) {
		
		BigDecimal bgprs = new BigDecimal(gprs.toString());
		
		BigDecimal bOne = null;
		if(type.equals("MB")) {
			bOne = new BigDecimal(1024); 
		} else if(type.equals("GB")){
			bOne = new BigDecimal(2 * 1024);
		} else {
			return "";
		}
			
		BigDecimal brgprs = bgprs.divide(bOne);
		
		return brgprs.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
	}
}
