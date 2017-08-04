package com.sitech.acctmgr.atom.busi.pay.trans;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title:CRM批量销户可退预存转账接口 </p>
* <p>Description: CRM后台批量销户，用户预消时候办理可退预存转账 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author suzj
* @version 1.0
*/
public class TransAccountXH extends TransAccount{
	
	public String getTransTypes(){
		return null;
	}
	
	/*获取可退金额*/
	@Override
	public long getTranFee(long inContractNo){
		
		Map<String, Object> inTmpMap = null;
		List<Map<String, Object>> backfeeList = null;
		
		// 1.获取账户预存和欠费
		OutFeeData  feeDate = remainFee.getConRemainFee(inContractNo);
		long oweFee = feeDate.getOweFee() + feeDate.getDelayFee() + feeDate.getUnbillFee();
		long prepayFee = feeDate.getPrepayFee();
		// 3.可退账本余额
		long backBalance = 0;

		inTmpMap = new HashMap<String, Object>();
		inTmpMap.put("CONTRACT_NO", inContractNo);
		inTmpMap.put("BACK_FLAG", "0");// pay_attr 第2位- 0可退1不可退
		backfeeList = balance.getAcctBookList(inTmpMap);
		for (Map<String, Object> specMap : backfeeList) {
			backBalance += Long.parseLong(specMap.get("CUR_BALANCE").toString());
		}

		// 4.计算最终可退预存
		long returnMoney = 0;
		if (backBalance > prepayFee - oweFee) {
			if (prepayFee - oweFee > 0) {
				returnMoney = prepayFee - oweFee;
			}
		} else {
			returnMoney = backBalance;
		}
		
		return returnMoney;
	}
	
	/* 获取按账本合并后的转账列表 */
	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo){
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("BACK_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
		
		outList = remainFee.getBookList(inMap);

		return outList;
	}
	
	/* 获取转账列表 */
	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo){
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		inMap.put("CONTRACT_NO", inContractNo);		
		inMap.put("BACK_FLAG", "0");  //账本可转属性  0：表示可转  1：表示不可转
		
		outList = balance.getAcctBookList(inMap);

		return outList;
	}
	
	/*个性化业务信息查询*/
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap){
		
		return null;
	}
	
	/*转账备注信息*/
	@Override
	public String getOpNote(String opNote) {
		if(opNote == null){
			opNote = "[批量销户转账]";
		}else{
			opNote = opNote + "[1:销户]";
		}
		return opNote;	
	}
	
	/*确认服务个性化验证*/
	@Override
	public void checkCfm(Map<String, Object> checkMap){

	}
	
	/* 个性化业务处理 */
	@Override
	public void doSpecialBusi(Map<String, Object> inMap){

	}
	
	/*地市月限额验证*/
	public void checkRegionLimit(String regionGroup,String limitType,long transFee){
		
	}
	
	/* 发送短信 */
	@Override
	public void transFeeSendMsg(Map<String, Object> inMap){
		
		String outPhoneNo = (String)inMap.get("OUT_PHONE_NO");
		String inPhoneNo = (String)inMap.get("IN_PHONE_NO");
		long payFee = (long)inMap.get("TRANS_FEE");
		String loginNo = (String)inMap.get("LOGIN_NO");
		String opCode = (String)inMap.get("OP_CODE");
		
		/*
		 * BOSS_22172:尊敬的客户，您好！销户号码${phone}已经将其剩余可用预存款${prepay_fee}元转存到您的手机中，请注意查收。${sms_release}
		 */
		Map<String, Object> outMapTmp = new HashMap<String, Object>();
		outMapTmp.put("phone",outPhoneNo);
		outMapTmp.put("prepay_fee", ValueUtils.transFenToYuan(payFee));
		outMapTmp.put("sms_release", "");
		MBean outMessage = new MBean();
		outMessage.addBody("PHONE_NO", inPhoneNo);
		outMessage.addBody("LOGIN_NO", loginNo);;
		outMessage.addBody("OP_CODE", opCode);
		outMessage.addBody("CHECK_FLAG", true);
		outMessage.addBody("TEMPLATE_ID", "311200801405");
		outMessage.addBody("DATA", outMapTmp);
		log.info("发送短信内容：" + outMessage.toString());
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);  // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			outMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			outMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		
		shortMessage.sendSmsMsg(outMessage, 1);
	}
	
}
