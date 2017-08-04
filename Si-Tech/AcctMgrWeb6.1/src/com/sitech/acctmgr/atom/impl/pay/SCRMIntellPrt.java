package com.sitech.acctmgr.atom.impl.pay;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.sitech.acctmgr.atom.domains.pay.CRMIntellPrtEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SCRMIntellPrtCollectInDTO;
import com.sitech.acctmgr.atom.dto.pay.SCRMIntellPrtCollectOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SCRMIntellPrtQueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.SCRMIntellPrtQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.pay.ICRMIntellPrt;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({@ParamType(m = "collect", c = SCRMIntellPrtCollectInDTO.class, oc = SCRMIntellPrtCollectOutDTO.class),
	 @ParamType(m = "query", c = SCRMIntellPrtQueryInDTO.class, oc = SCRMIntellPrtQueryOutDTO.class)})
public class SCRMIntellPrt extends AcctMgrBaseService implements ICRMIntellPrt {
	
	protected IAdj adj;
	protected IBalance balance;
	protected IControl control;

	@Override
	public OutDTO collect(InDTO inParam) {
		
		SCRMIntellPrtCollectInDTO inDto = (SCRMIntellPrtCollectInDTO)inParam;
		String loginNo = inDto.getLoginNo();
		String begin = inDto.getBeginDate();
		String end = inDto.getEndDate();
		long paySn = control.getSequence("SEQ_PAY_SN");
		
		log.info("inDto=" + inDto.getMbean());
		
		int days = DateUtils.minus(begin, end);
		
		log.info("日期差------->"+days);
		log.info("工号------->"+loginNo);
		
		if(days > 15){
			throw new BaseException(AcctMgrError.getErrorCode("0000", "00083"),"日期差不得超过15天！");
		}
		
		//排除宽带包年账本类型
		long codeClass = 1109;
		String[] status = {"0"};
		List<PubCodeDictEntity> yearPayTypes = adj.getReaosnCodeList(codeClass, null, null, status, null, null);
		int num = yearPayTypes.size();
		String[] payTypes = new String[num];
		String codeId = "";
		log.info("宽带包年账本类型数量------>"+num);
		for(int i=0;i<num;i++){
			codeId = yearPayTypes.get(i).getCodeId();
			log.info("类型------>"+codeId);
			payTypes[i] = codeId;
		}
		
		//需要排除的opcode（备注：还差g594、g609、i279、m002、m022未对应出来）
		String notOpCode = "8010,8011";
		String payType = StringUtils.join(payTypes,",");
		
		//汇总智能终端CRM缴费数据，插入临时表
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("PAY_TYPE_STR", payTypes);
		inMap.put("NOT_OP_CODE", notOpCode);
		inMap.put("LOGIN_NO", loginNo);
		
		//按天取智能终端CRM缴费数据,同时插入临时表
		int endDateInt = Integer.parseInt(end);
		DateUtils dateUtils = new DateUtils();
		for(int changeDate = Integer.parseInt(begin);changeDate <= endDateInt;changeDate = dateUtils.addDays(changeDate, 1)){
			int changeYM = Integer.parseInt(String.valueOf(changeDate).substring(0,6));
			inMap.put("CHANGE_YM", changeYM);
			inMap.put("CHANGE_DATE", changeDate);
			
			List<Map<String,Object>> list = balance.getIntellInfo(payType,notOpCode,loginNo,changeYM,changeDate,paySn);
			log.info("list内容----->"+list);
			if(list.size() == 0){
				continue;
			}else{
				balance.insertIntellInfo(list);
			}
		}
		
		//获取所有汇总数据，同时插入临时表
		long paySn2 = control.getSequence("SEQ_PAY_SN");
		Map<String,Object> totalInMap = new HashMap<String,Object>();
		totalInMap.put("LOGIN_ACCEPT", paySn);
		totalInMap.put("LOGIN_ACCEPT2", paySn2);
		balance.insertCollectIntellInfo(totalInMap);
		
		//将临时表数据做总计
		balance.insertTotalIntellInfo(paySn2);
		
		SCRMIntellPrtCollectOutDTO outDto = new SCRMIntellPrtCollectOutDTO();
		outDto.setLoginAccept(paySn2);
		return outDto;
	}

	@Override
	public OutDTO query(InDTO inParam) {
		
		SCRMIntellPrtQueryInDTO inDto = (SCRMIntellPrtQueryInDTO)inParam;
		long loginAccept = inDto.getLoginAccept();
		
		//获取智能终端CRM缴费汇总信息
		List<CRMIntellPrtEntity> list = balance.queryIntellInfo(loginAccept);
		log.info("输出list"+list);
		SCRMIntellPrtQueryOutDTO outDto = new SCRMIntellPrtQueryOutDTO();
		outDto.setIntellPrtList(list);
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
	 * @return the balance
	 */
	public IBalance getBalance() {
		return balance;
	}

	/**
	 * @param balance the balance to set
	 */
	public void setBalance(IBalance balance) {
		this.balance = balance;
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
	
}
