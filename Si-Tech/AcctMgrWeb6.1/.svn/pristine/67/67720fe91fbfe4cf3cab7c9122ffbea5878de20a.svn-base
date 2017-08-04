package com.sitech.acctmgr.atom.impl.query;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.SCheckUserInfoInDTO;
import com.sitech.acctmgr.atom.dto.pay.SCheckUserInfoOutDTO;
import com.sitech.acctmgr.atom.dto.query.SBankPostQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SBankPostQueryOutDTO;
import com.sitech.acctmgr.atom.dto.query.SBankQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SBankQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.ICheckUserInfo;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SCheckUserInfoInDTO.class, m = "checkReceipt", oc = SCheckUserInfoOutDTO.class)})

public class SCheckUserInfo extends AcctMgrBaseService implements ICheckUserInfo {
	
	private IInvoice invoice;
	
	@Override
	public OutDTO checkReceipt(InDTO inParam) {
		SCheckUserInfoInDTO inDto = (SCheckUserInfoInDTO)inParam;
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("ID_NO", inDto.getIdNo());
		inMap.put("INV_NO", inDto.getInvNo());
		inMap.put("INV_CODE", inDto.getInvCode());
		List<BalInvprintInfoEntity> receipt = invoice.getInvoInfoByInvNo(inMap);
		
		SCheckUserInfoOutDTO outDto = new SCheckUserInfoOutDTO();
		if(receipt.size() == 0){
			outDto.setFlag("N");
		}else{
			outDto.setFlag("Y");
		}
		return outDto;
	}

	@Override
	public OutDTO checkSim(InDTO inParam) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @return the invoice
	 */
	public IInvoice getInvoice() {
		return invoice;
	}

	/**
	 * @param invoice the invoice to set
	 */
	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}
	
}
