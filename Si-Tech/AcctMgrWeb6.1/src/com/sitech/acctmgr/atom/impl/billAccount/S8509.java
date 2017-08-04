package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.GprsChangeRecdEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.S8509ChangeShipStatusInDTO;
import com.sitech.acctmgr.atom.dto.query.S8509ChangeShipStatusOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8509OperRecdInDTO;
import com.sitech.acctmgr.atom.dto.query.S8509OperRecdOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8509QryStatusInDTO;
import com.sitech.acctmgr.atom.dto.query.S8509QryStatusOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I8509;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S8509QryStatusInDTO.class, oc = S8509QryStatusOutDTO.class, m = "queryGprsOrShipNetStatus"),
		@ParamType(c = S8509ChangeShipStatusInDTO.class, oc = S8509ChangeShipStatusOutDTO.class, m = "changeShipStatus"),
		@ParamType(c = S8509OperRecdInDTO.class, oc = S8509OperRecdOutDTO.class, m = "queryOperRecd") })
public class S8509 extends AcctMgrBaseService implements I8509 {
	private IBillAccount billAccount;
	private IUser user;

	@Override
	public OutDTO queryGprsOrShipNetStatus(InDTO inParam) {
		S8509QryStatusInDTO inDto = (S8509QryStatusInDTO) inParam;
		String phoneNo = inDto.getPhoneNo();
		String gprsStatus = "1";
		String shipStatus = "1";

		// 查询用户信息
		user.getUserInfo(phoneNo);

		// 根据服务号码查询GPRS流量提醒状态查询,没有返回表示已经开通
		Map<String, Object> outMap = billAccount.getGPRSStatus(phoneNo);
		if (outMap == null) {
			gprsStatus = "0";
		}

		log.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		// 根据服务号码查询亲情网短信提醒状态，返回0表示已经开通
		int cnt = billAccount.getShipStatus(phoneNo);
		log.debug("********************" + cnt);
		if (cnt == 0) {
			shipStatus = "0";
		}

		S8509QryStatusOutDTO outDto = new S8509QryStatusOutDTO();
		outDto.setGPRSStatus(gprsStatus);
		outDto.setShipStatus(shipStatus);

		return outDto;
	}

	@Override
	public OutDTO queryOperRecd(InDTO inParam) {
		S8509OperRecdInDTO inDto = (S8509OperRecdInDTO) inParam;

		String phoneNo = inDto.getPhoneNo();
		String beginYm = inDto.getBeginYm();
		String endYm = inDto.getEndYm();

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("BEGIN_YM", beginYm);
		inMap.put("END_YM", endYm);

		List<GprsChangeRecdEntity> gprsChangeRecdList = billAccount.getGprsStatusChange(inMap);

		S8509OperRecdOutDTO outDto = new S8509OperRecdOutDTO();
		outDto.setOperRecdList(gprsChangeRecdList);
		return outDto;
	}

	@Override
	public OutDTO changeShipStatus(InDTO inParam) {

		S8509ChangeShipStatusInDTO inDTO = (S8509ChangeShipStatusInDTO) inParam;
		String phoneNo = inDTO.getPhoneNo();
		String flag = inDTO.getFlag();

		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
		long idNo = userInfo.getIdNo();

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("ID_NO", phoneNo);// TODO:表中是14位的，但是IDNo是18位，暂时填入phoneNo
		inMap.put("FLAG", flag);

		billAccount.changeShipStatus(inMap);
		S8509ChangeShipStatusOutDTO outDto = new S8509ChangeShipStatusOutDTO();
		return outDto;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

}
