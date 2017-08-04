package com.sitech.acctmgr.atom.busi.pay.hlj;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.trans.TransAccount;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.pay.TransOutEntity;
import com.sitech.acctmgr.atom.dto.pay.S8014InitInDTO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.DateUtil;

/**
*
* <p>Title: 集团产品转账  </p>
* <p>Description: 集团产品转账余额查询、特殊业务信息查询及处理  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public class TransGrpProduct extends TransAccount {
	
	public String getTransTypes(){
		return "0";
	}
	
	/* 获取按账本合并后的转账列表 */
	@Override
	public List<TransFeeEntity> getComTranFeeList(long inContractNo){
		List<TransFeeEntity> outList = new ArrayList<TransFeeEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		//集团产品转账，转账本为('0')的预存
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("PAY_TYPE_STR", getTransTypes());
		
		outList = remainFee.getBookList(inMap);
		
		return outList;
	}
	
	/* 个性化业务查询 */
	@Override
	public Map<String, Object> getSpecialBusiness(Map<String, Object> inMap){
		S8014InitInDTO inDto = (S8014InitInDTO) inMap.get("IN_DTO");
		TransOutEntity baseInfo = (TransOutEntity)inMap.get("BASE_INFO");
		
		Map<String, Object> inMapTmp = null;
		long outContractNo = baseInfo.getContractNo();
		String brandId = baseInfo.getBrandId();
		String accountType = baseInfo.getAccountType();
		String yearMonth = DateUtil.format(new Date(), "yyyyMMddHHmmss").substring(0, 6);

		/* 不是集团账户不允许转账 */
		if (!(accountType.equals("1"))) {
			throw new BusiException(AcctMgrError.getErrorCode("8014", "00021"), "不是集团帐户，不允许转帐!");
		}

		/*TODO 集团流量包产品（sm_code="LL"）不允许转账 */
		if (brandId.equals("2310LL")) {
			throw new BusiException(AcctMgrError.getErrorCode("8014", "00027"), "集团行业流量包产品不允许转账!");
		}
		
		/*不允许集团产品给集团宽带转账*/
		if(brandId.equals("2330ki")){
			throw new BusiException(AcctMgrError.getErrorCode("8014", "00045"), "不允许集团产品给集团宽带转账");
		}

		/* 当月转账超过五次不允许转账 */
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("YEAR_MONTH", yearMonth);
		inMapTmp.put("CONTRACTNO_OUT", outContractNo);
		inMapTmp.put("OP_TYPE", "GrpProduct");
		long transNum = balance.qryTransNum(inMapTmp);
		if (transNum >= 5) {
			throw new BusiException(AcctMgrError.getErrorCode("8014", "00028"), "本月已转帐五次，不允许转帐!");
		}
		return null;
	}
	
	/* 获取转账列表 */
	@Override
	public List<Map<String, Object>> getTranFeeList(long inContractNo){
		List<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		//集团产品转账，转账本为('0')的预存
		inMap.put("CONTRACT_NO", inContractNo);
		inMap.put("PAY_TYPE_STR", getTransTypes());
		
		outList = balance.getAcctBookList(inMap);
		
		return outList;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.trans.TransType#getOpNote(java.lang.String)
	 */
	@Override
	public String getOpNote(String opNote) {
		if(opNote == null){
			opNote = "集团产品转账";
		}
		return opNote;
	}
	
	/* 个性化业务处理 */
	@Override
	public void doSpecialBusi(Map<String, Object> inMap){
		
	}
	
	/*确认服务个性化验证*/
	@Override
	public void checkCfm(Map<String, Object> checkMap){
		
		PayUserBaseEntity outInfo = (PayUserBaseEntity) checkMap.get("OUT_TRANS_BASEINFO");
		PayUserBaseEntity inInfo = (PayUserBaseEntity) checkMap.get("IN_TRANS_BASEINFO");
		
		String outBrandId = outInfo.getBrandId();
		String inBrandId = inInfo.getBrandId();
		long idNo = inInfo.getIdNo();
		log.info("判断没有outBrandId---->"+outBrandId+"inBrandId---->"+inBrandId+"idNo----->"+idNo);
		if(outBrandId.equals("2310YC")||outBrandId.equals("2310HL")||outBrandId.equals("2310ZX")){
			log.info("是这些品牌");
			if(!(inBrandId.equals("2310YC")||inBrandId.equals("2310HL")||inBrandId.equals("2310ZX"))){
				throw new BaseException(AcctMgrError.getErrorCode("8014", "00030"), "财铃、划得来、和俱乐部（龙江商业资讯）只能互转！");
			}
		}
		
	}

}
