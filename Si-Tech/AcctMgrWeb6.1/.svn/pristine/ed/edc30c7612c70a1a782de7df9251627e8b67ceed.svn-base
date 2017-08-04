package com.sitech.acctmgr.atom.impl.adj;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.adj.S8292AddInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292AddOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292DelInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292DelOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292QueryInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292QueryOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292QueryReasonInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8292QueryReasonOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8014CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8014CfmOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.inter.adj.I8292;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
*
* <p>Title: 退费原因维护相关服务  </p>
* <p>Description: 退费原因维护服务  查询、增加、删除  </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/


@ParamTypes({ @ParamType(m = "add", c = S8292AddInDTO.class, oc = S8292AddOutDTO.class),
    		  @ParamType(m = "query", c = S8292QueryInDTO.class, oc = S8292QueryOutDTO.class),
              @ParamType(m = "del", c = S8292DelInDTO.class, oc = S8292DelOutDTO.class),
              @ParamType(m = "getReasonInfo", c = S8292QueryReasonInDTO.class, oc = S8292QueryReasonOutDTO.class)})
public class S8292 extends AcctMgrBaseService implements I8292 {
	
	private IAdj adj;
	private IGroup group;
	private ILogin login;
	private IRecord record;
	private IControl control;
	private IPreOrder preOrder;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.adj.I8292#query(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		S8292QueryInDTO inDto = (S8292QueryInDTO)inParam;
		
		log.info("8292 query inDto:"+inDto.getMbean());
		
		String secondCode = null;
		//获取入参信息
		String firstCode = inDto.getFirstCode();  //一级退费原因代码
		//String status = inDto.getSpFlag();   //sp标志 1:非sp 2：sp
		String[] status=new String[]{"1","2"};
		if(StringUtils.isNotEmptyOrNull(inDto.getSecondCode()) && !("Value").equals(inDto.getSecondCode())){  
			secondCode = inDto.getSecondCode();  //二级退费原因代码
		}
		String provinceId = inDto.getProvinceId();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		
		//工号归属判断
		if(StringUtils.isEmptyOrNull(groupId)){
			groupId = login.getLoginInfo(loginNo, provinceId).getGroupId();
		}
		
		//获取上级组织代码
		String parentGroupId = group.getRegionDistinct(groupId, "2", provinceId).getParentGroupId();

		//退费原因查询
		List<ComplainAdjReasonEntity> reasonList = adj.getAdjReasonInfo(firstCode, secondCode, status,parentGroupId);
		
		List<ComplainAdjReasonEntity> reasonNewList = new ArrayList<ComplainAdjReasonEntity>(); 
 		for(ComplainAdjReasonEntity complainAdjReasonEntity:reasonList){
			if(StringUtils.isEmptyOrNull(complainAdjReasonEntity.getSecondCode()) || StringUtils.isEmptyOrNull(complainAdjReasonEntity.getSecondName())){
				complainAdjReasonEntity.setSecondName("-T");
			}
			if(StringUtils.isEmptyOrNull(complainAdjReasonEntity.getThirdCode()) || StringUtils.isEmptyOrNull(complainAdjReasonEntity.getThirdName())){
				complainAdjReasonEntity.setThirdName("-T");
			}
			reasonNewList.add(complainAdjReasonEntity);
		}
		
		S8292QueryOutDTO outDto = new S8292QueryOutDTO();
		outDto.setLenReasonInfo(reasonNewList.size());
		outDto.setListReasonInfo(reasonNewList);
		
		log.info("8292 query outDto:"+outDto.toJson());
		
		return outDto;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.adj.I8292#add(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO add(InDTO inParam) {
		// TODO Auto-generated method stub
		
		S8292AddInDTO inDto = (S8292AddInDTO)inParam;
		
		log.info("8292 add inDto:"+inDto.getMbean());
		
		String reasonCode =  inDto.getReasonCode();
		String reasonFlag = inDto.getReasonFlag();
		String reasonName = inDto.getReasonName();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		String spFlag=inDto.getSpFlag();
		if(StringUtils.isEmptyOrNull(groupId)){
			groupId = login.getLoginInfo(loginNo, provinceId).getGroupId();
		}
		
		//获取组织代码
		String parentGroupId = group.getRegionDistinct(groupId, "2", provinceId).getParentGroupId();
		
		//退费原因级别判断
		long codeClass = 0L; 
		String status = "";
		if(reasonFlag.equals("1")){
			codeClass = 2410L;
			status = spFlag;
		}else if(reasonFlag.equals("2")){
			codeClass = 2411L;
			List<PubCodeDictEntity> adjReasonList = new ArrayList<PubCodeDictEntity>();
			adjReasonList=adj.getReaosnCodeList(2410L, null, parentGroupId, null, reasonCode,null);
			status=adjReasonList.get(0).getStatus();
		}else if(reasonFlag.equals("3")){
			codeClass = 2412L;
			List<PubCodeDictEntity> adjReasonListThree = new ArrayList<PubCodeDictEntity>();
			adjReasonListThree=adj.getReaosnCodeList(2411L, null, parentGroupId, null, reasonCode,null);
			status=adjReasonListThree.get(0).getStatus();
		}else{
			throw new BaseException(AcctMgrError.getErrorCode("8292", "00003"),"入参退费原因标志错误，请检验！");
		}
		
		//获取当前时间
		String curTime = DateUtil.format(new Date(), PayBusiConst.YYYYMMDDHHMMSS2);
		long totalDate = Long.parseLong(curTime.substring(0, 8).toString());
		
		//获取操作流水
		long oprSn = control.getSequence("SEQ_SYSTEM_SN");
		
		//获取当前最大退费原因代码
		String maxReasonCode = "";		
		//如果该地市没有该级退费原因，则取codeClass+000
		if(StringUtils.isEmptyOrNull(adj.getMaxCodeId(codeClass, parentGroupId)))
		{
			maxReasonCode=codeClass+"000";
		}else{
			maxReasonCode=adj.getMaxCodeId(codeClass, parentGroupId);
		}
		
		long codeId = Long.parseLong(maxReasonCode) + 1;  //计算本次操作原因代码
		
		//判断新增退费原因是否已存在
		if(adj.isReasonInfo(codeClass, parentGroupId, reasonName, status)){
			throw new BaseException(AcctMgrError.getErrorCode("8292", "00002"),"该退费原因已经存在！");
		}
		
		//新增原因
		PubCodeDictEntity adjReasonEnt = new PubCodeDictEntity();
		adjReasonEnt.setBeginTime(curTime);
		adjReasonEnt.setCodeClass(Integer.valueOf(String.valueOf(codeClass)));
		adjReasonEnt.setCodeDesc("");
		adjReasonEnt.setCodeId(String.valueOf(codeId));
		adjReasonEnt.setCodeName(reasonName);
		adjReasonEnt.setCodeValue(reasonCode);
		adjReasonEnt.setEndTime("20200101144928");
		adjReasonEnt.setGroupId(parentGroupId);
		adjReasonEnt.setLoginNo(loginNo);
		adjReasonEnt.setStatus(status);
		
		adj.insReason(adjReasonEnt);
		
		
		//报表发送
        Map<String, Object> adjoweKey = new HashMap<String, Object>();
        adjoweKey.put("CODE_ID", adjReasonEnt.getCodeId());
        adjoweKey.put("CODE_CLASS", adjReasonEnt.getCodeClass());
        adjoweKey.put("GROUP_ID", parentGroupId);
        
        Map inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ACTION_ID", "1019");
        inMapTmp.put("KEY_DATA", adjoweKey);
		inMapTmp.put("LOGIN_NO", loginNo);
		inMapTmp.put("OP_CODE", inDto.getOpCode());
		inMapTmp.put("LOGIN_NO", loginNo);
		inMapTmp.put("LOGIN_SN", oprSn);
		preOrder.sendReportData((Map<String, Object>)inDto.getHeader(), inMapTmp);
		
		//记录营业员操作记录表
		LoginOprEntity loginOprEnt = new LoginOprEntity();
		loginOprEnt.setBrandId("");
		loginOprEnt.setIdNo(0);
		loginOprEnt.setLoginGroup(groupId);
		loginOprEnt.setLoginNo(loginNo);
		loginOprEnt.setLoginSn(oprSn);
		loginOprEnt.setOpCode("8292");
		loginOprEnt.setOpTime(curTime);
		loginOprEnt.setPayFee(0);
		loginOprEnt.setPhoneNo("");
		loginOprEnt.setRemark("投诉退费原因维护--增加");
		loginOprEnt.setPayType("0");
		loginOprEnt.setTotalDate(totalDate);
		record.saveLoginOpr(loginOprEnt);
		
		//出参设置
		S8292AddOutDTO outDto = new S8292AddOutDTO();
		outDto.setOprSn(oprSn);
		outDto.setTotalDate(totalDate);
		
		log.info("8292 add outDto:"+outDto.toJson());
		
		return outDto;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.adj.I8292#del(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO del(InDTO inParam) {
		
		S8292DelInDTO inDto = (S8292DelInDTO)inParam;
		
		log.info("8292 del inDto:"+inDto.getMbean());
		
		//获取入参信息
		String reasonCode =  inDto.getReasonCode();
		String reasonFlag = inDto.getReasonFlag();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		
		//工号归属验证
		if(StringUtils.isEmptyOrNull(groupId)){
			groupId = login.getLoginInfo(loginNo, provinceId).getGroupId();
		}
		
		// 获取当前时间
		String curTime = DateUtil.format(new Date(), PayBusiConst.YYYYMMDDHHMMSS2);
		long totalDate = Long.parseLong(curTime.substring(0, 8).toString());

		// 获取操作流水
		long oprSn = control.getSequence("SEQ_SYSTEM_SN");
		
		//获取上级组织代码
		String parentGroupId = group.getRegionDistinct(groupId, "2", provinceId).getParentGroupId();
		
		//退费原因级别判断
		int codeClass = 0; 
		String[] status = null;
		if(reasonFlag.equals("1")){  //一级退费原因代码
			codeClass = 2410;
			status=new String[]{"1","2"};
		}else if(reasonFlag.equals("2")){  //二级退费原因代码
			codeClass = 2411;
			status=new String[]{"1","2"};
		}else if(reasonFlag.equals("3")){  //三级退费原因代码
			codeClass = 2412;
			status=new String[]{"1"};
		}else{
			throw new BaseException(AcctMgrError.getErrorCode("8292", "00004"),"入参退费原因标志错误，请检验！");
		}
		
		//判断是否存在下级原因，存在下级原因，先删除下级原因，一级、二级原因进行判断
		if (reasonFlag.equals("1") || reasonFlag.equals("2")) {
			if (adj.isLowerReason(codeClass+1, parentGroupId, reasonCode, null,status)) {
				throw new BaseException(AcctMgrError.getErrorCode("8292", "00005"), "该退费原因存在下级退费原因，请先删除其下级退费原因！");
			}
		}
		
		//删除原因，更新表状态为失效状态
		int result = adj.updateReasonStatus(codeClass, parentGroupId, reasonCode, "0");  //0:表示失效
		
		if ( result == 0) {
			throw new BaseException(AcctMgrError.getErrorCode("8292", "00006"), "更新退费原因状态出错，原因代码【"+reasonCode+"】，请核查！");
		}
		
		
		//报表发送
        Map<String, Object> adjoweKey = new HashMap<String, Object>();
        adjoweKey.put("CODE_ID", reasonCode);
        adjoweKey.put("CODE_CLASS", codeClass);
        adjoweKey.put("GROUP_ID", parentGroupId);
        
        Map inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("ACTION_ID", "1019");
        inMapTmp.put("KEY_DATA", adjoweKey);
		inMapTmp.put("LOGIN_NO", loginNo);
		inMapTmp.put("OP_CODE", inDto.getOpCode());
		inMapTmp.put("LOGIN_NO", loginNo);
		inMapTmp.put("LOGIN_SN", oprSn);
		
		preOrder.sendReportData((Map<String, Object>)inDto.getHeader(), inMapTmp);
		
		// 记录营业员操作记录表
		LoginOprEntity loginOprEnt = new LoginOprEntity();
		loginOprEnt.setBrandId("");
		loginOprEnt.setIdNo(0);
		loginOprEnt.setLoginGroup(groupId);
		loginOprEnt.setLoginNo(loginNo);
		loginOprEnt.setLoginSn(oprSn);
		loginOprEnt.setOpCode("8292");
		loginOprEnt.setOpTime(curTime);
		loginOprEnt.setPayFee(0);
		loginOprEnt.setPhoneNo("");
		loginOprEnt.setRemark("投诉退费原因维护--删除");
		loginOprEnt.setPayType("0");
		loginOprEnt.setTotalDate(totalDate);
		record.saveLoginOpr(loginOprEnt);

		S8292DelOutDTO outDto = new S8292DelOutDTO();
		outDto.setOprSn(oprSn);
		outDto.setTotalDate(totalDate);
		
		log.info("8292 del outDto:"+outDto.toJson());
		
		return outDto;
	}
	
	@Override
	public OutDTO getReasonInfo(InDTO inParam){
		S8292QueryReasonInDTO inDto = (S8292QueryReasonInDTO)inParam;
		S8292QueryReasonOutDTO outDto = new S8292QueryReasonOutDTO();
		
		log.info("8292 getReasonInfo inDto:"+inDto.getMbean());
		
		String reasonFlag = inDto.getReasonFlag();  //退费原因标志：1:一级原因 2：二级原因 3：三级原因
		String reasonCode = inDto.getReasonCode();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		String opCode = inDto.getOpCode();
	
		//工号归属信息验证
		if(StringUtils.isEmptyOrNull(groupId)){
			groupId = login.getLoginInfo(loginNo, provinceId).getGroupId();
		}
		
		//获取营业厅上级组织代码groupId
		
		String parentGroupId = group.getRegionDistinct(groupId, "2", provinceId).getParentGroupId();
		
		//获取地市代码
		//String regionCode = group.getRegionDistinct(groupId, "2", provinceId).getRegionCode();
		
		List<PubCodeDictEntity> ajdReasonList = null;
		if (reasonFlag.equals("1")) {
			// 一级退费原因查询
			ajdReasonList = adj.getReaosnCodeList(2410L, null, parentGroupId, new String[]{"1","2"},null,null);
		} else if (reasonFlag.equals("2")) {
			// 二级退费原因查询
			if(StringUtils.isEmpty(reasonCode))
				return outDto;
			ajdReasonList = adj.getReaosnCodeList(2411L, reasonCode, parentGroupId, new String[]{"1","2"},null,null);
			
		} else if (reasonFlag.equals("3")) {
			// 三级退费原因查询
			if(StringUtils.isEmpty(reasonCode))
				return outDto;
			if(reasonCode.equals("0000")){
				String pageFlag = inDto.getPageFlag();
				//GPRS退费
				if( pageFlag.equals("1")){
					ajdReasonList = adj.getReaosnCodeList(2412L, reasonCode, null, new String[]{"4"},null,"3");
				}
				//移动梦网退费
				else if(pageFlag.equals("2")){
					ajdReasonList = adj.getReaosnCodeList(2412L, reasonCode, null, new String[]{"4"},null,"2");
				}
				
			}else{
				ajdReasonList = adj.getReaosnCodeList(2412L, reasonCode, parentGroupId, new String[]{"1","2"},null,null);	
			}
			
			
		} else {
			throw new BaseException(AcctMgrError.getErrorCode("8292", "00001"),"退费原因标志传入错误，请检查！");
		}
		
		//出参信息拼装
		List<ComplainAdjReasonEntity> reasonList =  new ArrayList<ComplainAdjReasonEntity>();
		for(PubCodeDictEntity codeDictEnt : ajdReasonList){
			String reasonCodeTmp = codeDictEnt.getCodeId();
			String codeName = codeDictEnt.getCodeName();
			String spStatus = codeDictEnt.getStatus();
			//String reasonName = reasonCodeTmp +"->"+ codeName;
			String reasonName = codeName;
			//出参实体设值
			ComplainAdjReasonEntity reasonEnt = new ComplainAdjReasonEntity();  
			
			if(opCode.equals("8292")){
				if(spStatus.equals("2")){
					reasonName="SP原因->"+reasonName;
				}else{
					reasonName="非SP原因->"+reasonName;
				}
			}
			reasonEnt.setReasonCode(reasonCodeTmp);
			reasonEnt.setReasonName(reasonName);
	
			reasonList.add(reasonEnt);
		}
		
		outDto.setLenReasonInfo(reasonList.size());
		outDto.setListReasonInfo(reasonList);
		
		log.info("8292 getReasonInfo outDto:"+outDto.toJson());
		
		return outDto;
	}

	/**
	 * @return the adj
	 */
	public IAdj getAdj() {
		return adj;
	}

	/**
	 * @param adj the adj to set
	 */
	public void setAdj(IAdj adj) {
		this.adj = adj;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the login
	 */
	public ILogin getLogin() {
		return login;
	}

	/**
	 * @param login the login to set
	 */
	public void setLogin(ILogin login) {
		this.login = login;
	}

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}
	
	

}
