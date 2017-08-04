package com.sitech.acctmgr.atom.impl.invoice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.PreInvoiceRecycleEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryDetailInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryDetailOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.invoice.IPreInvoiceRecycle;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SPreInvoiceRecycleQryDetailInDTO.class, oc = SPreInvoiceRecycleQryDetailOutDTO.class, m = "queryDetail"),
		@ParamType(c = SPreInvoiceRecycleQryInDTO.class, oc = SPreInvoiceRecycleQryOutDTO.class, m = "query"),
		@ParamType(c = SPreInvoiceRecycleQryInDTO.class, oc = SPreInvoiceRecycleQryOutDTO.class, m = "invoiceRecycle") })
public class SPreInvoiceRecycle extends AcctMgrBaseService implements IPreInvoiceRecycle {
	private IInvoice invoice;
	private IUser user;
	private IAccount account;
	private IControl control;

	@Override
	public OutDTO query(InDTO inParam) {
		SPreInvoiceRecycleQryInDTO inDto = (SPreInvoiceRecycleQryInDTO) inParam;
		long unitId = inDto.getUnitId();
		int billCycle = inDto.getBillCycle();
		// 根据unit_id查询集团名称
		List<VirtualGrpEntity> virtualGrpList = user.getVirtualGrpList(unitId, "");
		if (virtualGrpList == null) {
			throw new BusiException(AcctMgrError.getErrorCode("8290", "00003"), "未找到该虚拟集团信息");
		}
		String unitName = virtualGrpList.get(0).getUnitName();
		// 根据unit_id查询集团预开发票记录
		List<PreInvoiceRecycleEntity> preInvoiceRecycleList = invoice.getPreInvoiceRecycleTotal(unitId, billCycle);

		SPreInvoiceRecycleQryOutDTO outDto = new SPreInvoiceRecycleQryOutDTO();
		outDto.setPreInvRecList(preInvoiceRecycleList);
		outDto.setUnitId(unitId);
		outDto.setUnitName(unitName);
		return outDto;
	}

	@Override
	public OutDTO queryDetail(InDTO inParam) {
		SPreInvoiceRecycleQryDetailInDTO inDto = (SPreInvoiceRecycleQryDetailInDTO) inParam;
		long unitId = inDto.getUnitId();
		long printSn = inDto.getPrintSn();
		int flag = 0;
		List<PreInvoiceRecycleEntity> preInvociceList = invoice.getPreInvoiceRecycleDetail(unitId, printSn);

		// 查询账户名称
		for (PreInvoiceRecycleEntity preInvoice : preInvociceList) {
			long contractNo = preInvoice.getGrpContractNo();
			ContractInfoEntity contractInfo = account.getConInfo(contractNo);
			String contractName = contractInfo.getContractName();
			preInvoice.setContractName(contractName);
			boolean flagTmp = account.isGrpCon(contractNo);
			if (flagTmp) {
				flag = 1;
			}
			// 判断是否为省内一点支付账户
			Map<String, Object>inMap=new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", contractNo);
			inMap.put("CONTRACTATT_TYPE", "A");
			ContractInfoEntity onePayInfo = account.getConInfo(inMap);
			if (onePayInfo != null) {
				flag = 2;
			}
			preInvoice.setFlag(flag);
		}
		SPreInvoiceRecycleQryDetailOutDTO outDto = new SPreInvoiceRecycleQryDetailOutDTO();
		outDto.setPreInvRecList(preInvociceList);
		return outDto;
	}

	@Override
	public OutDTO invoiceRecycle(InDTO inParam) {

		return null;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}
