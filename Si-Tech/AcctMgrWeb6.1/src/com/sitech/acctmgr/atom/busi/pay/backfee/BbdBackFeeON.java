package com.sitech.acctmgr.atom.busi.pay.backfee;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.atom.impl.pay.S8008;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BusiException;

public class BbdBackFeeON extends BackFeeType{

		public BbdBackFeeON(S8008 inBack8008) {
		super(inBack8008);
		// TODO Auto-generated constructor stub
		}
	
	// 获取预存、欠费、可退预
		public Map<String, Object> getBackFeeFinal(long idNo, long contractNo) {
			Map<String, Object> inTmpMap = null;
			List<Map<String, Object>> backfeeList = null;
			long zifei = 0; 
			UserInfoEntity userInfo = back8008.getUser().getUserEntityByConNo(contractNo, false);
			String phoneNo = userInfo.getPhoneNo();
			String expenses = back8008.getProd().getExpenses(phoneNo);
			if(!(expenses == "NO")){
				zifei = Long.valueOf(expenses);
			}else{
				zifei = 0;
			}
			String beginDateStr = "";
			String endDateStr = "";
			long days = 0;
			String ifGetMonth = "";//是否取整月
			Long idNo2 = idNo;
			
			log.info("getBackFeeFinal inParam:idNo="+ idNo + "-->contractNo="+contractNo);
			
			// 1.获取账户预存和欠费
			OutFeeData  feeDate =  back8008.getRemainFee().getConRemainFee(contractNo);
			long oweFee = feeDate.getOweFee() + feeDate.getDelayFee() + feeDate.getUnbillFee();
			long prepayFee = feeDate.getPrepayFee();
			
			// 2.可退账本余额
			long backBalance = 0;

			inTmpMap = new HashMap<String, Object>();
			inTmpMap.put("CONTRACT_NO", contractNo);
			inTmpMap.put("BACK_FLAG", "0");// pay_attr 第2位- 0可退1不可退
			backfeeList = back8008.getBalance().getAcctBookList(inTmpMap);
			for (Map<String, Object> specMap : backfeeList) {
				backBalance += Long.parseLong(specMap.get("CUR_BALANCE").toString());
			}

			// 3.计算最终可退预存
			long returnMoney = 0;
			if (backBalance > prepayFee - oweFee) {
				if (prepayFee - oweFee > 0) {
					returnMoney = prepayFee - oweFee;
				}
			} else {
				returnMoney = backBalance;
			}
			
			//4.获取日期差
			Map<String,Object> dateMap = back8008.getUser().getDateSub(idNo);
			if(!(dateMap == null || dateMap.isEmpty())){
				days = MapUtils.getLongValue(dateMap, "DATE_SUB");
				beginDateStr = MapUtils.getString(dateMap, "EFF_DATE");
				endDateStr = MapUtils.getString(dateMap, "EXP_DATE");
			}else{
				days = 0;
				zifei = 0;
				beginDateStr = "00000000";
				endDateStr = "00000000";
			}
			//包年不减资费
			//可退金额需减去资费
			if(days > 15){
				ifGetMonth = "是";
				returnMoney = returnMoney - zifei;
			}else{
				ifGetMonth = "否";
				returnMoney = returnMoney - zifei/2;
			}
			if(returnMoney < 0){
				returnMoney = 0;
			}
			
			log.info("总欠费------->" + oweFee);
			log.info("最终可退预存------->" + returnMoney);
			
			log.info("出参们：预存-->"+prepayFee+"欠费-->"+oweFee+"开始日期-->"+beginDateStr);

			// 5. 返回值
			Map<String, Object> outMap = new HashMap<>();
			outMap.put("PREPAY_FEE", prepayFee);
			outMap.put("OWE_FEE", oweFee);
			outMap.put("RETURN_MONEY", returnMoney);
			outMap.put("BEGIN_DATE", beginDateStr);
			outMap.put("END_DATE", endDateStr);
			outMap.put("ZI_FEI", zifei);
			outMap.put("DATE_SUB", days);
			outMap.put("IF_GET_MONTH", ifGetMonth);
			return outMap;
		}
		
		/*个性化业务验证*/
		public void checkSpecialBusiness(Map<String, Object> inMap){
			
		}
		
		
	
}
