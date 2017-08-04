package com.sitech.acctmgr.atom.entity.hlj;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.sitech.acctmgr.atom.entity.Delay;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class DelayHLJ extends Delay{

	public long getDelayFee(Map<String, Object> inParam) {
		
		int iBillBegin = 0;
		long lOweFee = 0;
		int iDelayBegin = 0;
		double dDelayRate = 0;
		int iBillCycle = 0;
		int iTotalDate = 0;
		
		iBillBegin = Integer.parseInt(inParam.get("BILL_BEGIN").toString());
		lOweFee = Long.parseLong(inParam.get("OWE_FEE").toString());
		iDelayBegin = Integer.parseInt(inParam.get("DELAY_BEGIN").toString());
		dDelayRate = Double.parseDouble(inParam.get("DELAY_RATE").toString());
		iBillCycle = Integer.parseInt(inParam.get("BILL_CYCLE").toString());
		iTotalDate = Integer.parseInt(inParam.get("TOTAL_DATE").toString());
		
		/*欠费不足两个账期，不取滞纳金*/
		int iStartDate = 0;
		iStartDate = Integer.valueOf(DateUtil.toStringPlusMonths(String.valueOf(iBillCycle), 2, "yyyyMM"))
				* 100 + iBillBegin%10;
		
		if(iStartDate > iTotalDate) {
			log.debug("欠费不足两个账期，不取滞纳金");
			
			return 0;
		}
		
		//计算欠费是否超过14个月
		boolean flag;    //true欠费大于14个月    false欠费小于14个月
		int before14 = Integer.valueOf(DateUtil.toStringMinusMonths(new Date(),14,"yyyyMMdd"));
		if(before14 > iBillBegin){
			flag = true;
		}else {
			flag = false;
		}
		log.debug("欠费是否超过14个月计算：before14: " + before14 + " 标识： " + flag);
		
		/*取两个日期之间的天数*/
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date daTotalDate = null;
		Date daStartDate = null;
		try {
			if(flag){			//欠费超过14个月，只计算从欠费2个月开始一年的滞纳金
				daTotalDate = df.parse(DateUtil.toStringPlusMonths(String.valueOf(iBillBegin), 14, "yyyyMMdd"));
				daStartDate = df.parse(DateUtil.toStringPlusMonths(String.valueOf(iBillBegin), 2, "yyyyMMdd"));
			}else{			//欠费不足14个月，按照实际天数计算
				daTotalDate = df.parse(String.valueOf(iTotalDate));
				daStartDate = df.parse(String.valueOf(iStartDate));
			}
		} catch (ParseException e) {
			throw new BusiException("00000", "时间格式不正确");
		}
		
		log.debug("实际计算滞纳金开始时间： "+ daStartDate + "结束时间：" + daTotalDate);
		
		long delayDay = (daTotalDate.getTime() - daStartDate.getTime()) / (1000 * 60 * 60 * 24) - iDelayBegin;
		
		log.debug("DELAY_DAY = " + delayDay);
		
		if(delayDay < 0) {
			delayDay = 0;
		}
		
		//计算滞纳金
		BigDecimal bOweFee = new BigDecimal(lOweFee);
		BigDecimal bDelayRate = new BigDecimal(dDelayRate);
		BigDecimal bDelayDay = new BigDecimal(delayDay);
		
		BigDecimal bDelayFee = bOweFee.multiply(bDelayRate).multiply(bDelayDay);
		
		long lDelayFee = 0L;
		//将BigDecimal转化为long前四舍五入
		lDelayFee = bDelayFee.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
		
		log.debug("bOweFee = " + bOweFee.toString() 
				+ ",bDelayRate = " + bDelayRate.toString() 
				+ ",bDelayDay = " + bDelayDay.toString()
				+ ",bDelayFee = " + bDelayFee.toString()
				+ ",lDelayFee = " + lDelayFee
				+ ",iStartDate = " + iStartDate);
		
		return lDelayFee;
	}
}
