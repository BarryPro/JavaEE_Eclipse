package com.sitech.acctmgr.atom.impl.pay;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayBackForMrInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayBackInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayFeeBackInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayBackOprOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayFeeInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayFeeOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayMoneyForMrInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayMoneyForMrLimitInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayMoneyForMrLimitOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderPayMoneyForMrOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderUpBeginEndTimeInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeeOrderUpBeginEndTimeOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SpecialTransRollBackInDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.IFeeOrder;
import com.sitech.acctmgr.inter.pay.ISpecialTrans;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title: 费用工单接口  </p>
 * <p>Description: 包含： 开户交预存款 、 营销分月划拨 、 开户交预存款冲正 、 营销分月划拨冲正 、 销户退预存 、 分月返还退预存  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(c = SFeeOrderPayFeeInDTO.class, m = "payFee", oc = SFeeOrderPayFeeOutDTO.class),
	@ParamType(c = SFeeOrderPayBackInDTO.class, m = "payBackOpr", oc = SFeeOrderPayBackOprOutDTO.class),
	@ParamType(c = SFeeOrderPayMoneyForMrInDTO.class, m = "payMoneyForMr", oc = SFeeOrderPayMoneyForMrOutDTO.class),
	@ParamType(c = SFeeOrderPayMoneyForMrLimitInDTO.class, m = "payMoneyForMrLimit", oc = SFeeOrderPayMoneyForMrLimitOutDTO.class),
	@ParamType(c = SFeeOrderUpBeginEndTimeInDTO.class, m = "upBeginEndTime", oc = SFeeOrderUpBeginEndTimeOutDTO.class)
	})
public class SFeeOrder extends AcctMgrBaseService  implements IFeeOrder{
	
	private IGroup	group;
	private ILogin	login;
	private IUser	user;
	private IProd 	prod;
	private IAccount account;
	private IPayManage	payManage;
	private	IRecord		record;
	private	IControl	control;
	private IBalance	balance;
	private IPreOrder	preOrder;
	private IBillAccount billAccount;
	private ISpecialTrans specialTrans;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.IFeeOrder#payFee(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO payFee(InDTO inParam) {
		
		log.info("-费用工单缴费开始: --inParam=" + inParam.getMbean());
		
		SFeeOrderPayFeeInDTO inDto = (SFeeOrderPayFeeInDTO) inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String payNote = "缴预存[" +inDto.getPayType() + "]"
						+ "[" + (double)inDto.getPaymonty()/100 + "元]";
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		int totalDate = Integer.parseInt(sCurTime.substring(0, 8));

		//1、获取缴费号码
		String phoneNo = getPayPhone(inDto.getPhoneNo(), inDto.getContractNo());
		
		//2、获取缴费账户
		long contractNo = getPayContractNo(inDto.getPhoneNo(), inDto.getContractNo());
		
		//3、获取缴费确认需要基本资料
		PayUserBaseEntity payUserBase = getCfmBaseInfo(phoneNo, contractNo, inDto.getProvinceId(), inDto.getFlag());
		if(inDto.getPhoneNo()!=null && !inDto.getPhoneNo().equals("99999999999"))
			payUserBase.setPhoneFlag(true);
		else
			payUserBase.setPhoneFlag(false);
		
		// 验证号码和账户是否存在账务关系
		if(!phoneNo.equals("99999999999")){
			
			int iConUserFlag = account.cntConUserRel(contractNo,payUserBase.getIdNo(), null);
			if (iConUserFlag == 0) {
				log.info("付费关系不存在,不允许缴费! ID_NO: " + payUserBase.getIdNo() + "CONTRACT_NO: " + contractNo);
				throw new BusiException(AcctMgrError.getErrorCode("8000","00001"), "付费关系不存在,不允许缴费!");
			}
		}
		
		//实时入账
		PayBookEntity bookIn = new PayBookEntity();
		bookIn.setTotalDate(totalDate);
		bookIn.setPayPath(inDto.getPayPath());
		bookIn.setPayMethod(inDto.getPayMethod());
		bookIn.setStatus("0");
		bookIn.setBeginTime(sCurTime);
		bookIn.setPrintFlag(inDto.getIsPrint());
		bookIn.setForeignSn(inDto.getForeignSn());
		bookIn.setForeignTime(inDto.getForeignTime());
		bookIn.setYearMonth(Long.parseLong(sCurYm));
		bookIn.setLoginNo(inDto.getLoginNo());
		bookIn.setGroupId(inDto.getGroupId());
		bookIn.setOpCode(inDto.getOpCode());
		bookIn.setOpNote(payNote);
		bookIn.setPayType(inDto.getPayType());
		bookIn.setPayFee(inDto.getPaymonty());
		long paySn = control.getSequence("SEQ_PAY_SN");
		bookIn.setPaySn(paySn);
		
		//3.实时入账
		payManage.saveInBook(inDto.getHeader(), payUserBase, bookIn);
		
		//4.入payment表
		record.savePayMent(payUserBase, bookIn);
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(payUserBase.getIdNo());
		in.setBrandId(payUserBase.getBrandId());
		in.setPhoneNo(phoneNo);
		in.setPayType(inDto.getPayType());
		in.setPayFee(inDto.getPaymonty());
		in.setLoginSn(paySn);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(totalDate);
		in.setRemark(inDto.getOpCode());
		record.saveLoginOpr(in);
		
		SFeeOrderPayFeeOutDTO outDto = new SFeeOrderPayFeeOutDTO();
		outDto.setPayAccept(paySn);
		outDto.setTotalDate(String.valueOf(totalDate));
		
		return outDto;
	}
	
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.IFeeOrder#payBackOpr(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO payBackOpr(InDTO inParam) {
		
		log.info( "费用工单冲正 payBackOpr begin: " + inParam.getMbean());
		
		SFeeOrderPayBackInDTO inDto = (SFeeOrderPayBackInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}

		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		if(inDto.getOriBusiCode().equals("KHJYC")){	//开户交预存
			
			SFeeOrderPayFeeBackInDTO tmp = new SFeeOrderPayFeeBackInDTO();
			tmp.decode(inDto.getAllJson());
			this.payFeeBack(tmp);
		}else if(inDto.getOriBusiCode().equals("BNZHZZ")){
			
			SpecialTransRollBackInDTO tmp = new SpecialTransRollBackInDTO();
			tmp.decode(inDto.getAllJson());
			specialTrans.rollBack(tmp);
		}else if(inDto.getOriBusiCode().equals("YXFYHB")){
			
			SFeeOrderPayBackForMrInDTO tmp = new SFeeOrderPayBackForMrInDTO();
			tmp.decode(inDto.getAllJson());
			this.payBackForMr(tmp);
		}else{
			//报错
			log.info("该业务不支持冲正！");
			throw new BusiException(AcctMgrError.getErrorCode("0000","00001"), "该业务不支持冲正！");
		}
		
		SFeeOrderPayBackOprOutDTO outDto = new SFeeOrderPayBackOprOutDTO();
		outDto.setTotalDate(sTotalDate);
		
		return outDto;
	}
	
	
	/**
	* 名称：开户交预存，冲正
	*/
	public OutDTO payFeeBack(InDTO inParam) {
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		log.info( "开户交预存冲正 payFeeBack begin: " + inParam.getMbean());
		
		SFeeOrderPayFeeBackInDTO inDto = (SFeeOrderPayFeeBackInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String	payDate = inDto.getOriginForeignTime().substring(0, 8);
		String	yearMonth = payDate.substring(0 , 6);
		String  originForeignSn = inDto.getOriginForeignSn();	//要冲正的外部流水(订单行号)
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		List<Map<String, Object>> paySnList = payManage.getPaySnByForeign(originForeignSn, yearMonth);
		if (0 == paySnList.size()) {
			log.info("外部流水交费记录不存在foreign_sn : " + originForeignSn);
			throw new BusiException(AcctMgrError.getErrorCode("8056", "00002"),
					"外部流水交费记录不存在foreign_sn :  " + originForeignSn);
		}
		List<PayOutEntity>	payBackSnList = new ArrayList<PayOutEntity>();
		String totalDate="";
		for(Map<String, Object> paySnMap : paySnList){
			
			String status = paySnMap.get("STATUS").toString();
			if( status.equals("1") || status.equals("3") ){
				log.info("该条缴费记录已经冲正 foreignSn : " + originForeignSn );
				throw new BusiException(AcctMgrError.getErrorCode("8056","00004"), "该条缴费记录已经冲正 " );
			}
			
			long paySn = Long.parseLong(paySnMap.get("PAY_SN").toString());
			String payOpCode = (String)paySnMap.get("OP_CODE");
		
			//实际冲正流程
			LoginBaseEntity loginEntity = new LoginBaseEntity();
			loginEntity.setLoginNo(inDto.getLoginNo());
			loginEntity.setGroupId(inDto.getGroupId());
			loginEntity.setOpCode(inDto.getOpCode());
			loginEntity.setOpNote("CRM发起冲正");
			
			/**
			 *1、缴费冲正退现金费用pPayBackCashFee 
			 */
			long backPaysn = payManage.doRollbackCashFee(paySn, null, payDate, loginEntity);
			
			
			/*
			 *2、 回退缴费资金受理(缴费、空充、退费)日志记录
			 **/
			Map<String, Object> inRollbackMap = new HashMap<String, Object>();
			inRollbackMap.put("PAY_SN", paySn);
			inRollbackMap.put("PAY_YM", Long.parseLong(yearMonth));
			inRollbackMap.put("PAY_DATA", payDate);
			inRollbackMap.put("BACK_PAYSN", backPaysn);
			inRollbackMap.put("PAY_PATH", inDto.getPayPath());
			inRollbackMap.put("PAY_METHOD", inDto.getPayMethod());
			inRollbackMap.put("Header", inDto.getHeader());
			inRollbackMap.put("PHONE_NO", inDto.getPhoneNo());
			inRollbackMap.put("LOGIN_ENTITY", loginEntity);
			inRollbackMap.put("PAY_OPCODE", "CRM发起冲正");
			outMapTmp =  payManage.doRollbackRecord(inRollbackMap);
			long sumBackFee = Long.parseLong(outMapTmp.get("SUM_BACKFEE").toString());
			
			PayOutEntity payBackSnEnt = new PayOutEntity();
			payBackSnEnt.setPaySn(backPaysn);
			payBackSnList.add(payBackSnEnt);
			
		}
		
		SFeeOrderPayBackOprOutDTO outDto = new SFeeOrderPayBackOprOutDTO();
		outDto.setPaybackSnList(payBackSnList);
		outDto.setTotalDate(sTotalDate);
		
		return outDto;
	}
	
	/**
	* 名称：营销分月划拨缴费接口	</br>
	* 流程：	</br>
	* 1.	</br>
	* @author qiaolin
	*/
	public OutDTO payMoneyForMr(InDTO inParam){
		
		log.info("分月划拨业务begin: " + inParam.getMbean());
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		SFeeOrderPayMoneyForMrInDTO inDto = (SFeeOrderPayMoneyForMrInDTO) inParam;
		
		String mktType = inDto.getMktType();		//业务类型 A：终端  B：存送。
		if(mktType == null || mktType.equals("")){
			
			mktType = "B";
			
			if(inDto.getPayType().equals("8")){        //匹配套餐赠费日结程序
				mktType = "C";
			}
		}
		
		String phoneNo = inDto.getPhoneNo();
		long contractNo = inDto.getContractNo();

		//取工号归属
		LoginEntity loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
		String	groupId = loginEntity.getGroupId();
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			inDto.setGroupId(groupId);
		}
		
		// 取用户基本信息
		UserInfoEntity userInfoEntity = user.getUserEntityByPhoneNo(phoneNo, true);
		long defContractNo = userInfoEntity.getContractNo();
		long defIdNo = userInfoEntity.getIdNo();

		//只传入号码，金额落到账户选择
		if ( 0 == contractNo ){
			contractNo = defContractNo;	//如果没有传入账户，则费用落到默认账户
		}
		long idNo = defIdNo;
		
		// 取用户品牌标识
		UserBrandEntity userBrandEntity = user.getUserBrandRel(idNo);
		String brandId = userBrandEntity.getBrandId();
		
		//取用户归属
		GroupchgInfoEntity groupEntity = group.getChgGroup(phoneNo, null, null);
		String userGroupId = groupEntity.getGroupIdPhone();
		
		//取用户归属地市
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(userGroupId, "2", inDto.getProvinceId());
		String uReginCode = groupRelEntity.getRegionCode();
		
		//将用“+”拼接的每月到账金额分割到数组中
		String payFeeStr = inDto.getReturnFee();
		log.info(" payFeeStr :  " + payFeeStr);
		String flag = "\\+";
		String payFeeArray[] = payFeeStr.split(flag);
		int payMonth = payFeeArray.length;
		log.info("每月分月划拨情况:[" + payFeeArray[0] +"],划拨月份：" + payFeeArray.length);
		
		/**
		 * 根据配置规则创建返费List<Map<String, Object>> Map中存放 BEGIN_TIME、PAY_FEE、IS_FZ（  Y 有条件  N 无条件）
		 */
		List<Map<String, Object>> feeList = new ArrayList<Map<String,Object>>();
		
		List<Map<String, Object>> returnrelList = control.getReturnrel(inDto.getRuleId());
		int times = 0;
		for(Map<String, Object> mapTmp : returnrelList){
			
			String beginTime = "";
			
			String childType = mapTmp.get("CHILD_TYPE").toString();	// 子规则类型 1 ： 生效时间
			String childRule = mapTmp.get("CHILD_RULE").toString();
			int offSet = Integer.parseInt(mapTmp.get("OFFSET").toString());		//偏移量，单位：月
			
			for(;;){
				
				times = times + 1;
				
				if(times > payMonth){
					
					log.info("计算返费规则完毕！");
					break;
				}
				
				long payFee = Long.parseLong(payFeeArray[times-1]);
				
				if(childType.equals("1")){		//配置生效时间
					
					outMapTmp = control.getChildrule(childRule);
					log.info("====== " + outMapTmp);
					String ruleType = outMapTmp.get("RULE_TYPE").toString();
					String ruleValue = outMapTmp.get("RULE_VALUE").toString();
					
					if(ruleType.equals("1")){		//传入时间
						
						beginTime = inDto.getFirstEff();
					}else if(ruleType.equals("3")){	 //指定日时分秒
						
						String firstYm = inDto.getFirstEff().substring(0, 6);
						String beginYm = DateUtil.toStringPlusMonths(firstYm, times-1,"yyyyMM"); 
						
						beginTime = beginYm + ruleValue;
						
						log.debug("ruleType 3 ===  beginYm: " + beginYm + " times: " + times + " beginTime" + beginTime);
						
					}else if(ruleType.equals("4")){		//月底生效
						
						String firstYm = inDto.getFirstEff().substring(0, 6);
						//从第二笔开始走月底生效
						String beginYm2 = control.getLastDay( firstYm, times-1 + offSet );
						
						beginTime = beginYm2 + ruleValue;
						log.debug("ruleType 4 ===  beginYm: " + beginYm2 + " times: " + times + " beginTime" + beginTime);
						
					}else{
						
						log.debug("目前没有支持");
					}
					
				}else{
					
					log.debug("目前只支持配置生效时间，应该报错");
					
				}
				String endTime = "20491231000000";
				if(inDto.getExpFlag().equals("0")){
					
					endTime = inDto.getExpDate();
				}else if(inDto.getExpFlag().equals("1")){
					
					endTime = control.getLastDay(beginTime.substring(0, 6), Integer.valueOf(inDto.getValidMonth())-1)
							 + "235959";
				}else{
					throw new BusiException(AcctMgrError.getErrorCode("8000", "10001"),"不支持这种失效方式" + inDto.getExpFlag());
				}
				
				Map<String, Object> feeMap = new HashMap<String, Object>();
				feeMap.put("BEGIN_TIME", beginTime);
				feeMap.put("END_TIME", endTime);
				feeMap.put("PAY_FEE", payFee);
				
				/*
				 * 根据接口定义确定每笔是否有条件到账*
				 *  ACT_TYPE
				 * 0  -- 所有都是有条件返费（第一笔 + 后面所有笔）
			     * 1  --第一笔无条件返费，后面几笔有条件返费
				 * 2  --所有都是无条件返费
				 */
				String actType = inDto.getActType();
				String isFz = "";					//是否有条件返费   Y 有条件  N 无条件
				if(actType.equals("0")){
					
					isFz = "Y";
				}else if(actType.equals("1")){
					
					if(times == 1){
						
						isFz = "N";
					}else{
						
						isFz = "Y";
					}
					
				}else if(actType.equals("2")){
					
					isFz = "N";
				}else{
					
					log.debug("ACT_TYPE标识错误！");
				}
				
				feeMap.put("IS_FZ", isFz);
				feeList.add(feeMap);
				
				if(mapTmp.get("COMM_FLAG").toString().equals("0")){		//个性规则，以表中配置的返费次数 times为准
					
					//如果添加次数达到配置次数或者达到返费总次数,则退出改规则
					if(times == Integer.parseInt(mapTmp.get("TIMES").toString()) || times == payMonth){
						
						break;
					}
					
				}else{				//通用规则，直接处理到总返还次数为止
					
					if(times == payMonth){
						
						log.info("计算返费规则完毕！");
						break;
					}
					
				}
			}
			
		}
		
		log.info("营销分月划拨，根据规则计算完毕后返费List： " + feeList.toString());
		
		int monthNum = 0;    //返还月数
		long sumFee = 0;
		long sumNFee = 0;	//无条件 到账金额  -- 向个人账户payment表立即记录金额
		long sumYFee = 0;	//有条件且现金类到账金额--向公共账户payment表到账金额
		
		long paySn = control.getSequence("SEQ_PAY_SN");
		
		PayUserBaseEntity payUserBase = new PayUserBaseEntity();
		payUserBase.setIdNo(idNo);
		payUserBase.setPhoneNo(phoneNo);
		payUserBase.setContractNo(contractNo);
		payUserBase.setUserGroupId(userGroupId);
		payUserBase.setRegionId(uReginCode);
		payUserBase.setBrandId(brandId);
		
		PayBookEntity bookIn = new PayBookEntity();
		bookIn.setPaySn(paySn);
		bookIn.setTotalDate(Integer.valueOf(sTotalDate));
		bookIn.setPayPath(inDto.getPayPath());
		bookIn.setPayMethod(inDto.getPayMethod());
		bookIn.setStatus("2");
		bookIn.setPrintFlag(inDto.getIsPrint());
		bookIn.setForeignSn(inDto.getForeignSn());
		bookIn.setForeignTime(inDto.getForeignTime());
		bookIn.setYearMonth(Long.parseLong(sCurYm));
		bookIn.setLoginNo(inDto.getLoginNo());
		bookIn.setGroupId(inDto.getGroupId());
		bookIn.setOpCode(inDto.getOpCode());
		bookIn.setOpNote(inDto.getRemark());
		bookIn.setPayType(inDto.getPayType());
		
		//直接拆分返费List
		for(Map<String, Object> feeMap : feeList){
			
			monthNum++;        //返还次数增加
			
			long lPayFee = Long.parseLong(feeMap.get("PAY_FEE").toString());
			String beginTime = feeMap.get("BEGIN_TIME").toString();
			String endTime = feeMap.get("END_TIME").toString();
			String isFz = feeMap.get("IS_FZ").toString();	//  Y 有条件  N 无条件
			
			bookIn.setPayFee(lPayFee);
			bookIn.setBeginTime(beginTime);
			bookIn.setEndTime(endTime);
			
			sumFee = sumFee + lPayFee;
			
			if (isFz.equals("N")) {			//如果是无条件
				
				sumNFee = sumNFee + lPayFee;

				//3.实时入账
				payManage.saveInBook(inDto.getHeader(), payUserBase, bookIn);

				// 入batchpay表
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("ACT_ID", inDto.getActId());
				inMapTmp.put("PHONE_NO", phoneNo);
				inMapTmp.put("ID_NO", idNo);
				inMapTmp.put("REGION_CODE", uReginCode);
				inMapTmp.put("CONTRACT_NO", contractNo);
				inMapTmp.put("TOTAL_DATE", sTotalDate);
				inMapTmp.put("PAY_TYPE", inDto.getPayType());
				inMapTmp.put("PAY_FEE", lPayFee);
				inMapTmp.put("PAY_SN", paySn);
				inMapTmp.put("LOGIN_NO", inDto.getLoginNo());
				inMapTmp.put("BEGIN_TIME", beginTime);
				inMapTmp.put("END_TIME ", endTime);
				inMapTmp.put("FOREIGN_SN", inDto.getForeignSn());
				inMapTmp.put("AUDIT_FLAG", "0");
				inMapTmp.put("OP_CODE", inDto.getOpCode());
				inMapTmp.put("YEAR_MONTH", sCurYm);
				balance.saveBatchpay(inMapTmp);
				
			}else if(isFz.equals("Y")){
				
				sumYFee = sumYFee + lPayFee;
				long balanceId = control.getSequence("SEQ_BALANCE_ID");
				/**
				 *有条件返费 直接记录 bal_returnacctbook_info 
				 *如果是现金类账本且有条件 则需要记录公共账户  STATUS记录（2:  现金类账本 需要从公共账户转账做到账）
				 * STATUS -- 0： 未返还         1： 预存款-- 已经到账payment表 触发后直接移入账本表
				 *           2: 现金类账本 需要从公共账户转账做到账         3： 冲正         4:  不满足条件，不进行到账
				 */
				String status = "1";
				
				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("BALANCE_ID", balanceId);
				inMapTmp.put("CONTRACT_NO", contractNo);
				inMapTmp.put("PAY_TYPE", inDto.getPayType());
				inMapTmp.put("INIT_BALANCE", lPayFee);
				inMapTmp.put("CUR_BALANCE", lPayFee);
				inMapTmp.put("BALANCE_TYPE", "3");
				inMapTmp.put("BEGIN_TIME", beginTime);
				inMapTmp.put("END_TIME", endTime);
				inMapTmp.put("PAY_SN", paySn);
				inMapTmp.put("STATUS", status);
				inMapTmp.put("BILL_CYCLE", beginTime.substring(0, 6));
				inMapTmp.put("PRINT_FLAG", inDto.getIsPrint());
				inMapTmp.put("FOREIGN_SN", inDto.getForeignSn());
				inMapTmp.put("FOREIGN_TIME", inDto.getForeignTime());
				inMapTmp.put("ACT_ID", inDto.getActId());
				inMapTmp.put("MEANS_ID", inDto.getMeansId());
				inMapTmp.put("ACT_TYPE", inDto.getMktType());     //A：终端类，B：缴费回馈，存送类，C:营销赠费类
				inMapTmp.put("FLAG", "0");
				balance.saveReturnAcctbook(inMapTmp);
			}
		}

		//入payment表
		bookIn.setPayFee(sumFee);
		record.savePayMent(payUserBase, bookIn);
		
		/**
		 *1、涉及到底线预存情况 入账务处理接口表SBILLTOTCODE_USER 
		 *逻辑：目前只有专款类型为FB情况才会有底限消费限制
		 */
		if(inDto.getBilltotcodeUser() != null){
			
			String firstYm = inDto.getFirstEff().substring(0, 6);
			String endYm = DateUtil.toStringPlusMonths(firstYm, Integer.parseInt(inDto.getReturnMonth()), "yyyyMM"); 
			Map<String, Object> inbilltotcodeUserMap = new HashMap<String, Object>();
			inbilltotcodeUserMap.put("CONTRACT_NO", contractNo);
			inbilltotcodeUserMap.put("ID_NO", idNo);
			inbilltotcodeUserMap.put("PHONE_NO", phoneNo);
			inbilltotcodeUserMap.put("BASE_FEEMAP", inDto.getBilltotcodeUser());
			inbilltotcodeUserMap.put("REGION_ID", uReginCode);
			inbilltotcodeUserMap.put("END_TIME", endYm);
			inBilltotcodeUser(inbilltotcodeUserMap);
		}
		
		SFeeOrderPayMoneyForMrOutDTO	outDto = new SFeeOrderPayMoneyForMrOutDTO();
		
		return outDto;
	}
	
	
	/**
	* 名称：开户交预存，冲正
	*/
	public OutDTO payBackForMr(InDTO inParam) {
		
		log.info( "payBackForMr begin: " + inParam.getMbean());
		
		SFeeOrderPayBackForMrInDTO inDto = (SFeeOrderPayBackForMrInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String  originForeignSn = inDto.getOriginForeignSn();	//要冲正的外部流水(订单行号)
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		List<Map<String, Object>> paySnList = payManage.getPaySnByForeign(originForeignSn, inDto.getOriginForeignTime().substring(0, 6), inDto.getPayType());
		if (0 == paySnList.size()) {
			log.info("外部流水交费记录不存在foreign_sn : " + originForeignSn);
			throw new BusiException(AcctMgrError.getErrorCode("8056", "00002"),
					"外部流水交费记录不存在foreign_sn :  " + originForeignSn);
		}
		List<PayOutEntity>	payBackSnList = new ArrayList<PayOutEntity>();
		for(Map<String, Object> paySnMap : paySnList){
			
			String status = paySnMap.get("STATUS").toString();
			if( status.equals("1") || status.equals("3") ){
				log.info("该条缴费记录已经冲正 foreignSn : " + originForeignSn );
				continue;
			}
			
			long paySn = Long.parseLong(paySnMap.get("PAY_SN").toString());
		
			//实际冲正流程
			LoginBaseEntity loginEntity = new LoginBaseEntity();
			loginEntity.setLoginNo(inDto.getLoginNo());
			loginEntity.setGroupId(inDto.getGroupId());
			loginEntity.setOpCode(inDto.getOpCode());
			loginEntity.setOpNote("CRM发起冲正");
			
			long backPaysn = payManage.dRollbackForMr(paySn, null, inDto.getForeignSn(), inDto.getOriginForeignTime().substring(0, 8), loginEntity);
			
			PayOutEntity payBackSnEnt = new PayOutEntity();
			payBackSnEnt.setPaySn(backPaysn);
			payBackSnList.add(payBackSnEnt);
		}
		
		SFeeOrderPayBackOprOutDTO outDto = new SFeeOrderPayBackOprOutDTO();
		outDto.setPaybackSnList(payBackSnList);
		outDto.setTotalDate(sTotalDate);
		
		return outDto;
	}
	
	private void inBilltotcodeUser(Map<String, Object> inParam){
		
		Map<String, Object> baseFeeMap = (Map<String, Object>)inParam.get("BASE_FEEMAP");
		String prcId = baseFeeMap.get("PRC_ID").toString();
		long baseFee = Long.parseLong(baseFeeMap.get("BASE_FEE").toString());
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		inMap.put("ID_NO", inParam.get("ID_NO"));
		inMap.put("PHONE_NO", inParam.get("PHONE_NO"));
		inMap.put("REGION_ID", inParam.get("REGION_ID"));
		inMap.put("PRC_ID", prcId);
		inMap.put("BASE_FEE", baseFee);
		inMap.put("END_TIME", inParam.get("END_TIME"));
		billAccount.inSbillcodeUser(inMap);
	}
	
	
	@Override
	public OutDTO payMoneyForMrLimit(InDTO inParam){
		log.info("分月划拨业务校验begin: " + inParam.getMbean());
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		SFeeOrderPayMoneyForMrLimitInDTO inDto = (SFeeOrderPayMoneyForMrLimitInDTO) inParam;
		
		if(inDto.getMktPayMethod().equals("5")){	// 统一d账本转入
			String lastDay = control.getLastDay(sCurYm, 0);	//月末
			String tmp = sCurYm + "01080000";               //月初1号8点
			
			log.debug("当前时间：" + sCurTime + " 月末最后一天： " + lastDay);
			//月末最后一天 和月初8点前不允许办理
			if(sTotalDate.equals("lastDay") || sCurTime.compareTo(tmp)<=0){
				
				throw new BusiException(AcctMgrError.getErrorCode("8000","00104"), "月底最后一天和月初第一天的八点之前不可以办理!");
			}
		}
		
		
		SFeeOrderPayMoneyForMrLimitOutDTO outDto = new SFeeOrderPayMoneyForMrLimitOutDTO();
		
		return outDto;
	}
	
	@Override
	public OutDTO upBeginEndTime(InDTO inParam){
		
		log.info("宽带竣工更新预存款生效时间: " + inParam.getMbean());
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		SFeeOrderUpBeginEndTimeInDTO inDto = (SFeeOrderUpBeginEndTimeInDTO) inParam;
		
		
		SFeeOrderUpBeginEndTimeOutDTO outDto = new SFeeOrderUpBeginEndTimeOutDTO();
		return outDto;
	}
	
	/**
	 *功能：获取缴费号码，如果传入缴费号码，则按照入参中返回，否则根据账户获取，通用规则，获取账户下优先级最高的号码
	 */
	protected String getPayPhone(String phoneNo, Long contractNo){
		
		if(phoneNo != null && !phoneNo.equals("")){
			
			return phoneNo;
		}else{
			
			String defPhone = account.getPayPhoneByCon(contractNo);
			if (defPhone.equals("")) {
				defPhone = "99999999999";
			}
			
			return defPhone;
		}
		
	}
	
	/***
	 *功能：获取缴费账户，如果传入账户，则按照入参中返回，否则根据缴费号码获取，通用规则，缴费到号码的默认账户
	 */
	private long getPayContractNo(String phoneNo, Long contractNo){
		
		if(contractNo != null && contractNo != 0){
			return contractNo;
		}else{
				UserInfoEntity uie = user.getUserEntity(null, phoneNo, null, true);
				return  uie.getContractNo();
			}
		
	}
	
	private PayUserBaseEntity getCfmBaseInfo(String phoneNo, long contractNo, String provinceId,String ykhFlag){
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		//Map<String, Object> userMap = null;
		UserInfoEntity userInfo = null;
		String brandId = "XX";
		long   idNo = 0;
		if(!phoneNo.equals("99999999999")){
			
			UserInfoEntity uie = user.getUserEntity(null, phoneNo, null, true);
			idNo = uie.getIdNo();

			if (!ykhFlag.equals("YKH")) {
				UserBrandEntity ube = user.getUserBrandRel(uie.getIdNo());
				brandId = ube.getBrandId();
			}
		}
		
		//取账户归属
		GroupchgInfoEntity groupChgEntity = group.getChgGroup(null, null, contractNo);
		
		// 缴费用户归属地市
		ChngroupRelEntity groupEntity = group.getRegionDistinct(groupChgEntity.getGroupIdPay(), "2", provinceId);
		String regionId = groupEntity.getRegionCode();
		
		PayUserBaseEntity payUserBase = new PayUserBaseEntity();
		payUserBase.setIdNo(idNo);
		payUserBase.setPhoneNo(phoneNo);
		payUserBase.setContractNo(contractNo);
		payUserBase.setUserGroupId(groupChgEntity.getGroupId());
		payUserBase.setRegionId(regionId);
		payUserBase.setBrandId(brandId);
		
		return payUserBase;
	}

	public IGroup getGroup() {
		return group;
	}



	public void setGroup(IGroup group) {
		this.group = group;
	}



	public ILogin getLogin() {
		return login;
	}



	public void setLogin(ILogin login) {
		this.login = login;
	}



	public IUser getUser() {
		return user;
	}



	public void setUser(IUser user) {
		this.user = user;
	}



	public IProd getProd() {
		return prod;
	}



	public void setProd(IProd prod) {
		this.prod = prod;
	}



	public IAccount getAccount() {
		return account;
	}



	public void setAccount(IAccount account) {
		this.account = account;
	}



	public IPayManage getPayManage() {
		return payManage;
	}



	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
	}



	public IRecord getRecord() {
		return record;
	}



	public void setRecord(IRecord record) {
		this.record = record;
	}



	public IControl getControl() {
		return control;
	}



	public void setControl(IControl control) {
		this.control = control;
	}



	public IBalance getBalance() {
		return balance;
	}



	public void setBalance(IBalance balance) {
		this.balance = balance;
	}



	public IPreOrder getPreOrder() {
		return preOrder;
	}



	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}



	public IBillAccount getBillAccount() {
		return billAccount;
	}



	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}



	public ISpecialTrans getSpecialTrans() {
		return specialTrans;
	}



	public void setSpecialTrans(ISpecialTrans specialTrans) {
		this.specialTrans = specialTrans;
	}
	
	

}
