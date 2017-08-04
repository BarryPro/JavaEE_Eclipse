package com.sitech.acctmgr.atom.impl.pay;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.dto.pay.S2310AuditInDTO;
import com.sitech.acctmgr.atom.dto.pay.S2310AuditOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I2310;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 手工系统充值导入  </p>
 * <p>Description: 手工系统充值数据文件入库等操作。支持到账多个月  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author hanfl
 * @version 1.0
 */

@ParamTypes({ @ParamType(c = S2310AuditInDTO.class, oc = S2310AuditOutDTO.class, m = "audit")})

public class S2310 extends AcctMgrBaseService  implements I2310 {

	protected IControl 	control;
	protected IGroup 	group;
	protected IBalance 	balance;
	private ILogin login;
	
	public OutDTO audit(InDTO inParam) {
		
		Map<String, Object> inAuditMap = new HashMap<String, Object>();

		S2310AuditInDTO inDto = (S2310AuditInDTO) inParam;
		log.error("-------> audit_in " + inDto.getMbean());
		
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		

		// 判断工号是否有审批权限
		/*ChngroupRelEntity groupRelEntity = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String regionCode = groupRelEntity.getRegionCode();
		String loginNos = control.getPubCodeValue(2018, "AUDIT_LOGIN", regionCode);
		if (loginNos.indexOf(inDto.getLoginNo()) == -1) {
			throw new BusiException(AcctMgrError.getErrorCode("8208", "00002"),
					"您的工号没有审批权限，请联系管理员配置！");
		}*/

		// 更改总记录
		inAuditMap = new HashMap<String, Object>();
		safeAddToMap(inAuditMap, "BATCH_SN", inDto.getBatchSn());
		safeAddToMap(inAuditMap, "AUDIT_FLAG", inDto.getAuditFlag());
		safeAddToMap(inAuditMap, "OLD_AUDIT_FLAG", "N");
		safeAddToMap(inAuditMap, "AUDIT_LOGIN", inDto.getLoginNo());
		balance.updateBatchPayRecd(inAuditMap);

		S2310AuditOutDTO outDto = new S2310AuditOutDTO();
		outDto.setBatchSn(inDto.getBatchSn());
		log.error("------> auditCfm_out" + outDto.toJson());
		return outDto;
	}

	public IControl getControl() {
		return control;
	}

	public IGroup getGroup() {
		return group;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

}
