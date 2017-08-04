package com.sitech.acctmgr.atom.impl.pay;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayDoInter;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.atom.dto.pay.SGrpUnifyBackCfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SGrpUnifyBackCfmInDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.inter.pay.IGrpUnifyBack;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.*;


/**
 * @Title:  总对总缴费冲正 [8003]
 * @Description: 总对总缴费冲正 原子服务
 * @Date : 20161202
 * @Company: SI-TECH
 * @author : qiaolin
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
@ParamTypes({ 
	@ParamType(c = SGrpUnifyBackCfmInDTO.class, oc=SGrpUnifyBackCfmOutDTO.class,m = "cfm")
	})
public class SGrpUnifyBack extends AcctMgrBaseService implements IGrpUnifyBack {
	
	private ILogin 		login;
	private IRecord 	record;
	private IBalance 	balance;
	private IPayDoInter payDoInter;
	private IPreOrder 	preOrder;
	private IControl 	control;

	@Override
	public OutDTO cfm(InDTO inParam) {
		
		SGrpUnifyBackCfmInDTO  inDto = (SGrpUnifyBackCfmInDTO) inParam;
		log.debug("--->ValidAo_in = "+inDto.getMbean());
		String payDate = inDto.getOriActionDate(); //缴费日期
		String foreignSn = inDto.getOriTransactionID(); //缴费外部流水
		String oriReqSys = inDto.getOriReqSys();
		String settleDate = inDto.getSettleDate(); 
		String oriActionDate = inDto.getOriActionDate();
		
		long 	backPaySn=0;
		String 	rspCode = "0000";
		String	rspInfo = "成功";
		int		opFlag =0; //成功标识
		
		String curTime = control.getSysDate().get("CUR_TIME").toString();
		String totalDate = curTime.substring(0, 8);
		String payYm = payDate.substring(0,6);
		String curYm = curTime.substring(0,6);

		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		List<PayMentEntity> payList = null;
		String  phoneNo="";
		String bossPayDate = "";		//boss入账时间
		try {
			
		   /**校验工号*/
			try {
				 LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			} catch (Exception e) {
				opFlag=1;
				rspCode = "2A08";
				rspInfo = "工号["+inDto.getLoginNo()+"]不存在！";
				log.error(rspInfo);
	 			throw new BusiException(AcctMgrError.getErrorCode("8000", "00101"),rspInfo);
			}
			
			/**用外部流水遍历payment表返回list，循环冲正*/
			inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("FOREIGN_SN", foreignSn);
			inMapTmp.put("SUFFIX", payYm);
			payList = record.getPayMentList(inMapTmp);
			if(payList.size()==0){
				//跨月问题:20151001账期记录到201509分区里
				String payDate2 = DateUtil.toStringMinusDays(payDate, 1, "yyyyMMdd");
				String payYm2 = payDate2.substring(0,6);
				log.info("------>kuayue:   payDate="+payDate2+", payYm="+payYm2);
				
 				inMapTmp = new HashMap<String, Object>();
 				inMapTmp.put("FOREIGN_SN", foreignSn);
 				inMapTmp.put("SUFFIX", payYm2);
 				payList = record.getPayMentList(inMapTmp);
 				if(payList.size()==0){
 					opFlag=1;
 					rspCode = "2A08";
 					rspInfo = "缴费记录不存在FOREIGN_SN["+foreignSn+"]";
 					log.error(rspInfo);
 		 			throw new BusiException(AcctMgrError.getErrorCode("8000", "00101"),rspInfo);
 				}else {
 					phoneNo = payList.get(0).getPhoneNo();
 					bossPayDate = payDate2;
				}
			}else{
				phoneNo = payList.get(0).getPhoneNo();
				bossPayDate = payDate;
			}

		} catch (Exception e) {
			e.printStackTrace();
			opFlag=1;
			/**非业务异常：定义总对总二级返回码*/
			if("0000".equals(rspCode)){
				rspCode = "2A08";
				rspInfo = "用户状态异常";
			}
		}
		
		/**校验成功，调用缴费冲正缴费*/
		if("0000".equals(rspCode)){
			try {
				log.debug("------> 循环缴费冲正");
				
				/**遍历缴费记录，循环调用冲正接口进行冲正*/
				inMapTmp = new HashMap<String, Object>();
				safeAddToMap(inMapTmp, "Header", inDto.getHeader());
				safeAddToMap(inMapTmp, "LOGIN_NO", inDto.getLoginNo());
				safeAddToMap(inMapTmp, "OP_CODE", inDto.getOpCode());
				safeAddToMap(inMapTmp, "PHONE_NO", phoneNo);
				safeAddToMap(inMapTmp, "PAY_DATE", bossPayDate);//payDate或payDate-1
				safeAddToMap(inMapTmp, "PAY_PATH", PayBusiConst.PAY_PATH_DEFAULT);
				safeAddToMap(inMapTmp, "PAY_METHOD", PayBusiConst.PAY_METHOD_DEFAULT);
				safeAddToMap(inMapTmp, "PAY_NOTE", inDto.getRevokeReason());
				safeAddToMap(inMapTmp, "FOREIGN_SN", foreignSn);
				outMapTmp = payDoInter.doS8056Foreign(inMapTmp);
				log.info("------> GrpInifyPay 调用缴费服务出参:" + outMapTmp.entrySet());
				int retCode = getIntValue(outMapTmp, "RET_CODE");
				if(retCode==1){
					log.error("------> 冲正失败");
					throw new BusiException(AcctMgrError.getErrorCode("8000", "00101"),rspInfo);
				}else{
					List<PayOutEntity> snList = (List<PayOutEntity>) outMapTmp.get("PAY_BACK_SN");
					backPaySn = snList.get(0).getPaySn();
				}

			} catch (Exception e) {
				e.printStackTrace();
				payDoInter.rollback();
				opFlag=1;
				rspCode = "2A08";
				rspInfo = "充值客户交费冲正出错";
				log.error("----->充值客户交费冲正出错");
			}
		}
		
		log.error(" rspCode="+rspCode+",valid或冲正正常，记录 BAL_TOTALPAY_RECD表");

		String backFlag="";
		if(totalDate.equals(oriActionDate)){
			backFlag="1";
		}else {
			backFlag="2";
		}
		
		log.info("------> settleDate = "+settleDate+" ,totalDate ="+totalDate);
		
		/**更新总对总缴费记录标志、插入冲正记录*/
		inMapTmp=new HashMap<String, Object>();
		inMapTmp.put("PAY_MONTH", bossPayDate.substring(0, 6) );
		inMapTmp.put("BACK_MONTH", curYm);//分区年月一定是当前年月：上月记录已经同步报表库
		inMapTmp.put("ORI_TRANSACTIONID", inDto.getOriTransactionID());
		inMapTmp.put("TRANSACTIONID", inDto.getTransactionId());
		inMapTmp.put("SETTLEDATE", settleDate);  //交易账期: 调账-缴费账期；手动冲正-当前账期
		inMapTmp.put("OP_FLAG",  opFlag);
		inMapTmp.put("BIPCODE", inDto.getBipCode());
		inMapTmp.put("ACTIVITYCODE", inDto.getActivityCode());
		inMapTmp.put("SESSIONID", inDto.getSessionID());
		inMapTmp.put("TRANSIDO", inDto.getTransIDO());
		inMapTmp.put("TRANSIDOTIME", inDto.getTransIDOTime());
		inMapTmp.put("TRANSIDH", inDto.getTransIDH());
		inMapTmp.put("TRANSIDHTIME", inDto.getTransIDHTime());
		inMapTmp.put("MSGSENDER", inDto.getMsgSender());
		inMapTmp.put("MSGRECEIVER", inDto.getMsgReceiver());
		inMapTmp.put("OPCODE", inDto.getOpCode());
		inMapTmp.put("LOGIN_NO",inDto.getLoginNo());
		inMapTmp.put("OP_MSG", rspInfo );  
		inMapTmp.put("REMARK1", inDto.getRevokeReason() );  
		inMapTmp.put("BACK_FLAG", backFlag);  //缴费0；冲正1；退费-隔日冲正2
		inMapTmp.put("RSP_CODE", rspCode );
		log.info("------>doRollBackTotalPayRecd_in="+inMapTmp.entrySet());
		balance.doRollBackTotalPayRecd(inMapTmp);

		log.info("------> opFlag=" + opFlag);
		//将 opFlag==0 的成功记录同步到报表库
		if(opFlag==0){
			log.info("------> bal_totalpay_recd冲正 同步报表库");

			List<Map<String, Object>> keysList = new ArrayList<Map<String,Object>>();

			//更新总队总缴费记录
			Map<String, Object> grpKey = new HashMap<String, Object>();
			grpKey.put("YEAR_MONTH", payYm);
			grpKey.put("TRANSACTIONID", inDto.getOriTransactionID());
			grpKey.put("OP_FLAG", opFlag);
			grpKey.put("BACK_FLAG", backFlag);
			grpKey.put("TABLE_NAME", "BAL_TOTALPAY_RECD");
			grpKey.put("UPDATE_TYPE", "U");
			keysList.add(grpKey);

			//同步总队总冲正记录
			grpKey = new HashMap<String, Object>();
			grpKey.put("YEAR_MONTH", curYm);
			grpKey.put("TRANSACTIONID", inDto.getTransactionId());
			grpKey.put("OP_FLAG", opFlag);
			grpKey.put("BACK_FLAG", backFlag);
			grpKey.put("TABLE_NAME", "BAL_TOTALPAY_RECD");
			grpKey.put("UPDATE_TYPE", "I");
			keysList.add(grpKey);

			Map<String, Object> reportMap = new HashMap<String, Object>();
			reportMap.put("ACTION_ID", "1003");
			reportMap.put("KEYS_LIST", keysList);
			reportMap.put("LOGIN_SN", backPaySn);
			reportMap.put("OP_CODE", inDto.getOpCode());
			reportMap.put("LOGIN_NO", inDto.getLoginNo());
			preOrder.sendReportDataList(inDto.getHeader(), reportMap);
		}

		SGrpUnifyBackCfmOutDTO outDto = new SGrpUnifyBackCfmOutDTO();
		outDto.setOriReqSys(oriReqSys);
		outDto.setOriTransactionID(inDto.getOriTransactionID());
		outDto.setOriActionDate(oriActionDate);
		outDto.setRspCode(rspCode);
		outDto.setRspInfo(rspInfo);
		outDto.setTransactionId(inDto.getTransactionId());
		outDto.setSettleDate(settleDate);
		log.debug("--->cfmAo_out = "+outDto.toJson());
		return outDto;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IPayDoInter getPayDoInter() {
		return payDoInter;
	}

	public void setPayDoInter(IPayDoInter payDoInter) {
		this.payDoInter = payDoInter;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}
