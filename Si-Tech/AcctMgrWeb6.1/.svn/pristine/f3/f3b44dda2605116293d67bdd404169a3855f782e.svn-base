package com.sitech.acctmgr.atom.impl.adj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.dto.adj.S8054GetGPRSReasonInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8054GetGPRSReasonOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8054GetSPInfoInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8054GetSPInfoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.adj.I8054;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "getGPRSReason", c = S8054GetGPRSReasonInDTO.class, oc = S8054GetGPRSReasonOutDTO.class),
	@ParamType(m = "getSPInfo", c = S8054GetSPInfoInDTO.class, oc = S8054GetSPInfoOutDTO.class)})
public class S8054  extends AcctMgrBaseService 
					implements I8054{
	
	private IControl control;
	private IProd prod;

	

	@Override
	public OutDTO getGPRSReason(InDTO inParam) {
		// TODO Auto-generated method stub
		S8054GetGPRSReasonInDTO inDto = (S8054GetGPRSReasonInDTO)inParam;
		log.info("getGPRSReason inDto:"+inDto.getMbean());
		
		List<PubCodeDictEntity> GPRSReasonList = null;
		GPRSReasonList = control.getPubCodeList(2421L, null, null, "1");
		
		List<ComplainAdjReasonEntity> reasonList = new ArrayList<ComplainAdjReasonEntity>();
		for(PubCodeDictEntity pubCodeDictEntity:GPRSReasonList){
			String codeValue = pubCodeDictEntity.getCodeValue();
			String codeId = pubCodeDictEntity.getCodeId();
			ComplainAdjReasonEntity complainAdjTmp = new ComplainAdjReasonEntity();
			complainAdjTmp.setReasonCode(codeId);
			complainAdjTmp.setReasonName(codeValue);
			reasonList.add(complainAdjTmp);
		}
		
		S8054GetGPRSReasonOutDTO outDto = new S8054GetGPRSReasonOutDTO();
		
		outDto.setLenReasonInfo(reasonList.size());
		outDto.setListReasonInfo(reasonList);
		
		log.info("getGPRSReason outDto:"+outDto.toJson());
		return outDto;
	}

	
	@Override
	public OutDTO getSPInfo(InDTO inParam) {
		// TODO Auto-generated method stub
		S8054GetSPInfoInDTO inDto = (S8054GetSPInfoInDTO)inParam;
		log.info("getSPInfo inDto:"+inDto.getMbean());
		
		String phoneNo = inDto.getPhoneNo();
		
		List<SpInfoEntity> userSPInfoList = new ArrayList<SpInfoEntity>();
		Map inMap = new HashMap();
		inMap.put("PHONE_NO", phoneNo);
		userSPInfoList=prod.qUserSPPdPrcInfo(inMap);
		if(userSPInfoList.size()==0){
			throw new BaseException(AcctMgrError.getErrorCode("8054", "00021"),"该用户没有SP业务！");
		}
		S8054GetSPInfoOutDTO outDto = new S8054GetSPInfoOutDTO();
		
		outDto.setLenSPInfo(userSPInfoList.size());
		outDto.setListSPInfo(userSPInfoList);
		
		log.info("getSPInfo outDto:"+outDto.toJson());
		return outDto;
	}

	
	
	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}
	
	public IProd getProd() {
		return prod;
	}


	public void setProd(IProd prod) {
		this.prod = prod;
	}


}
