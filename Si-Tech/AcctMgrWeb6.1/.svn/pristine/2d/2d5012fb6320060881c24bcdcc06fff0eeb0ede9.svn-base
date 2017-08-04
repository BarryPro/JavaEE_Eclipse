package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.query.*;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.IGroupCon;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

@ParamTypes({
		@ParamType(m = "queryOnLineCon", c = SGrpUserByUnitIdInDTO.class, oc = SGrpUserOnLineByUnitIdOutDTO.class),
		@ParamType(m = "queryOffLineCon", c = SGrpUserByUnitIdInDTO.class, oc = SGrpUserOffLineByUnitIdOutDTO.class),
		@ParamType(m = "query", c = SGroupConQueryInDTO.class, oc = SGroupConQueryOutDTO.class)
})
public class SGroupCon extends AcctMgrBaseService implements IGroupCon {

	private IUser user;
	private IProd prod;
	private ICust cust;
	private IControl control;

	@Override
	public OutDTO queryOnLineCon(InDTO inparam) {
		SGrpUserByUnitIdInDTO inDto = (SGrpUserByUnitIdInDTO) inparam;
		log.debug("inDto=" + inDto.getMbean());

		long unitId = Long.parseLong(inDto.getUnitId());

		// 根据unit_id查询集团账户
		List<UserInfoEntity> userInfoListTmp = user.getGrpUserInfoByUnitId(unitId);
		List<UserInfoEntity> userInfoList = new ArrayList<UserInfoEntity>();
		for (UserInfoEntity userInfo : userInfoListTmp) {
			long idNo = userInfo.getIdNo();
			// 设置集团主产品名称
			UserPrcEntity userPrc = prod.getUserPrcidInfo(idNo, true);
			String prodName = userPrc.getProdPrcName();
			userInfo.setProdName(prodName);
			userInfoList.add(userInfo);
		}

		if (userInfoList == null || userInfoList.isEmpty()) {
			throw new BusiException(AcctMgrError.getErrorCode("8412", "20001") , "该集团未办理集团产品！");
		}

		SGrpUserOnLineByUnitIdOutDTO outDto = new SGrpUserOnLineByUnitIdOutDTO();
		outDto.setCnt(userInfoList.size());
		outDto.setUserList(userInfoList);
		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}

	@Override
	public OutDTO queryOffLineCon(InDTO inparam) {
		SGrpUserByUnitIdInDTO inDto = (SGrpUserByUnitIdInDTO) inparam;

		long unitId = Long.parseLong(inDto.getUnitId());

		// 根据unit_id查询集团账户
		List<UserDeadEntity> userInfoListTmp = user.getGrpUserDeadInfo(unitId);
		List<UserDeadEntity> userInfoList = new ArrayList<UserDeadEntity>();
		// 根据集团账号查询集团主产品名称
		for (UserDeadEntity userInfo : userInfoListTmp) {
			long idNo = userInfo.getIdNo();
			// 设置集团主产品名称
			UserPrcEntity userPrc = prod.getUserPrcidInfo(idNo, true);
			String prodName = userPrc.getProdPrcName();
			userInfo.setProdName(prodName);
			userInfoList.add(userInfo);
		}

		if (userInfoList == null || userInfoList.isEmpty()) {
			throw new BusiException(AcctMgrError.getErrorCode("8412", "20001") , "该集团未办理集团产品！");
		}

		SGrpUserOffLineByUnitIdOutDTO outDto = new SGrpUserOffLineByUnitIdOutDTO();
		outDto.setCnt(userInfoList.size());
		outDto.setUserList(userInfoList);
		log.debug(outDto.toJson());
		return outDto;
	}

	@Override
	public OutDTO query(InDTO inParam) {

		SGroupConQueryInDTO inDto = (SGroupConQueryInDTO) inParam;
		log.debug("inDto=" + inDto.getMbean());

		Long custId = inDto.getCustId();
		String idIccid = inDto.getIdIccid();
		Long unitId = inDto.getUnitId();

		String encIdIccid = "";



		if (StringUtils.isNotEmpty(idIccid)) {
			encIdIccid = control.pubEncryptData(idIccid, 0);
		}

		List<GrpCustEntity> grpCustList = cust.getGrpCustList(custId,unitId, encIdIccid);


		SGroupConQueryOutDTO outDTO = new SGroupConQueryOutDTO();
		outDTO.setGrpCustList(grpCustList);


		log.debug("outDto=" + outDTO.toJson());

		return outDTO;
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

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}
}
