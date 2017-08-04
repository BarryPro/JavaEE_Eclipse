package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.Map;

import com.sitech.acctmgr.atom.dto.acctmng.SWlanOpenInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SWlanOpenOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.billAccount.IWlanOpen;
import com.sitech.common.CrossEntity;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "cfm", c = SWlanOpenInDTO.class, oc = SWlanOpenOutDTO.class)
})
public class SWlanOpen extends AcctMgrBaseService implements IWlanOpen{

	private IBillAccount billAccount;
	
	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		SWlanOpenInDTO inDto = (SWlanOpenInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		billAccount.getCntWlanOpenW(phoneNo);
		
		//
		MBean inBean = new MBean();
		inBean.setBody("LOGINNAME", phoneNo+"@cmcc-edu");    
		Map<String, String> result = CrossEntity.callService("EAI_WLAN1008_OPEN", inBean);
		log.info("调用PD充值接口返回： " + result);
		String retn = result.get("RETN").toString();  //充值结果代码
		
		int retCode = Integer.parseInt(retn);
		//接口返回失败!
		if (retCode != 0) {
			log.error("接口返回失败!");
			throw new BusiException(AcctMgrError.getErrorCode("0000", "12004"),
					"接口返回失败!");
		}
		
		
		SWlanOpenOutDTO outDto = new SWlanOpenOutDTO();
		return outDto;
	}

	/**
	 * @return the billAccount
	 */
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	/**
	 * @param billAccount the billAccount to set
	 */
	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}
	
}
