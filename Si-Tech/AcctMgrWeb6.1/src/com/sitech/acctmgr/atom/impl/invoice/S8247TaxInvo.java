package com.sitech.acctmgr.atom.impl.invoice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IInvFee;
//import com.sitech.acctmgr.atom.busi.invoice.inter.ITaxInvoFlow;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cust.TaxPayerInfo;
import com.sitech.acctmgr.atom.domains.invoice.BalInvauditInfo;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8247CallBackInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247CallBackOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247DisableInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247DisableOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247InvoiceFlowInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247InvoiceFlowOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247ReportInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247ReportOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247SaleTaxInfoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247SaleTaxInfoOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247TransInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8247TransOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.acctmgr.inter.invoice.I8247TaxInvo;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


@ParamTypes({ @ParamType(c = S8247InvoiceFlowInDTO.class, oc = S8247InvoiceFlowOutDTO.class, m = "invoiceFlowInfo"),
		@ParamType(c = S8247ReportInDTO.class, oc = S8247ReportOutDTO.class, m = "report"),
		@ParamType(c = S8247DisableInDTO.class, oc = S8247DisableOutDTO.class, m = "disable"),
		@ParamType(c = S8247CallBackInDTO.class, oc = S8247CallBackOutDTO.class, m = "callback"),
		@ParamType(c = S8247TransInDTO.class, oc = S8247TransOutDTO.class, m = "trans"),
		@ParamType(c = S8247SaleTaxInfoInDTO.class, oc = S8247SaleTaxInfoOutDTO.class, m = "saleTaxInfo"),
})
public class S8247TaxInvo implements I8247TaxInvo {

	private IInvoice invoice;
	private IInvFee invFee;
	private ICust cust;
	private IGroup group;
	private IControl control;
	private IBalance balance;

	@Override
	public OutDTO invoiceFlowInfo(InDTO inParam) {
		S8247InvoiceFlowInDTO inDto = (S8247InvoiceFlowInDTO) inParam;
		String phoneNo="";
		long auditSn=0;
		String taxpayerId="";
		int flag = inDto.getFlag();
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("REPORT_TO", inDto.getLoginNo());

		if (StringUtils.isNotEmptyOrNull(inDto.getPhoneNo())) {
			phoneNo = inDto.getPhoneNo();
			inMap.put("PHONE_NO", phoneNo);
		}
		if (StringUtils.isNotEmptyOrNull(inDto.getTaxPayerId())) {
			taxpayerId = inDto.getTaxPayerId();
			inMap.put("TAX_PAYER_ID", taxpayerId);
			// 获取cust_id
			TaxPayerInfo taxPayerInfo = cust.getTaxPayerInfo(0l, taxpayerId);
			inMap.put("CUST_ID", taxPayerInfo.getCustId());
		}
		if (inDto.getAuditSn() > 0) {
			auditSn = inDto.getAuditSn();
			inMap.put("AUDIT_SN", auditSn);
		}

		// 根据流水，服务号码，纳税人识别号，状态查询
		// 查询开具：查询state为0,4 查询作废：state为0和1
		if (flag == 1) {
			String[] state = { "0", "4", "1" };
			inMap.put("STATE", state);
		}
		if (flag == 2) {
			String[] state = { "4", "1" };
			inMap.put("STATE", state);
		}

		List<BalInvauditInfo> auditInfoList = invoice.getAuditInfoList(inMap);
		// 如果是红字发票申请，需查询蓝票的发票号码和发票代码
		for (BalInvauditInfo auditInfo : auditInfoList) {
			auditInfo.setPositionName(invoice.getPositionName(auditInfo.getState()));
			if (auditInfo.getInvType().equals("1")) {
				long auditSnRel = auditInfo.getAuditSnRel();
				// 查询蓝字发票的发票号码和发票代码
				inMap = new HashMap<String, Object>();
				inMap.put("AUDIT_SN", auditSnRel);
				List<BalInvauditInfo> blueInvoice = invoice.getAuditInfoList(inMap);
				if (blueInvoice.size() == 0) {
					throw new BusiException(AcctMgrError.getErrorCode("8247", "00004"), "未找到关联的蓝字发票信息");
				}
				auditInfo.setInvCodeRel(blueInvoice.get(0).getInvCode());
				auditInfo.setInvNoRel(blueInvoice.get(0).getInvNo());
				auditInfo.setBlueReportTime(blueInvoice.get(0).getReportTime());
				auditInfo.setPositionName(invoice.getPositionName(auditInfo.getState()));
			}
		}

		S8247InvoiceFlowOutDTO outDto = new S8247InvoiceFlowOutDTO();
		outDto.setAuditInfoList(auditInfoList);
		
		return outDto;
	}

	@Override
	public OutDTO report(InDTO inParam) {

		S8247ReportInDTO inDto = (S8247ReportInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();

		long auditSn = inDto.getAuditSn();
		String invType = inDto.getInvType();
		String invNo = inDto.getInvNo();
		String invCode = inDto.getInvCode();
		String orderNo = "";
		if (StringUtils.isNotEmptyOrNull(inDto.getRedInvOrderNo())) {
			orderNo = inDto.getRedInvOrderNo();
			inMap.put("REDINV_ORDERNO", orderNo);
		}
		// 更新bal_audit_info表中的state，inv_no，inv_code，如果是红字发票，更新ordersn
		inMap.put("INV_NO", invNo);
		inMap.put("INV_CODE", invCode);
		inMap.put("AUDIT_SN", auditSn);
		inMap.put("REPORT_TIME", "Y");
		inMap.put("STATE", CommonConst.OPEN_STATE);
		invoice.updateAuditState(inMap);
		
		// 如果为蓝字发票，更新bal_invprint_info表中的inv_no和inv_code，state状态更改为1
		if (invType.equals("0")) {
			inMap.put("STATE", "1");
			inMap.put("PRINT_SN", inDto.getPrintSn());
			inMap.put("SUFFIX", inDto.getInsertTime());
			invoice.updateStateByInvNo(inMap);
		}
		S8247ReportOutDTO outDto = new S8247ReportOutDTO();
		return outDto;
	}

	@Override
	public OutDTO disable(InDTO inParam) {
		S8247DisableInDTO inDto = (S8247DisableInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();
		long auditSn = inDto.getAuditSn();
		String invType = inDto.getInvType();
		if (invType.equals("1")) {
			// 如果为红字发票，更新audit_info表中的inv_type为2（作废）
			inMap.put("INV_TYPE", "2");
		}
		inMap.put("AUDIT_SN", auditSn);
		inMap.put("STATE", CommonConst.CANCLE_STATE);
		invoice.updateAuditState(inMap);
		S8247DisableOutDTO outDto = new S8247DisableOutDTO();
		return outDto;
	}

	@Override
	public OutDTO callback(InDTO inParam) {
		S8247CallBackInDTO inDto = (S8247CallBackInDTO) inParam;
		Map<String, Object>inMap=new HashMap<String,Object>();
		long auditSn = inDto.getAuditSn();
		inMap.put("AUDIT_SN", auditSn);
		inMap.put("STATE", CommonConst.BACK_STATE);
		invoice.updateAuditState(inMap);
		S8247CallBackOutDTO outDto = new S8247CallBackOutDTO();
		return outDto;
	}

	@Override
	public OutDTO trans(InDTO inParam) {
		S8247TransInDTO inDto = (S8247TransInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();
		long auditSn = inDto.getAuditSn();
		inMap.put("AUDIT_SN", auditSn);
		inMap.put("STATE", CommonConst.TRANS_STATE);
		invoice.updateAuditState(inMap);
		S8247TransOutDTO outDto = new S8247TransOutDTO();
		return outDto;
	}


	@Override
	public OutDTO saleTaxInfo(InDTO inParam) {
		// 根据地市获取受理服务器和开票服务器
		S8247SaleTaxInfoInDTO inDto = (S8247SaleTaxInfoInDTO) inParam;
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		// 根据groupId获取地市信息
		ChngroupRelEntity chnGroup = group.getRegionDistinct(groupId, "2", provinceId, false);

		String regionCode = "0";
		if (chnGroup != null) {
			regionCode = chnGroup.getRegionCode();
		}
		long codeClass = 104;
		List<PubCodeDictEntity> pubCodeList = control.getPubCodeList(codeClass, "", regionCode, "");
		if (pubCodeList.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8247", "00002"), "查询受理服务器和开票服务器错误！");
		}

		// 查询销方的信息（地址，名称，电话，开户行，银行卡号）
		codeClass = 109;
		List<PubCodeDictEntity> taxInfoList = control.getPubCodeList(codeClass, "", regionCode, "");
		if (taxInfoList.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8247", "00003"), "查询销方信息错误！");
		}

		S8247SaleTaxInfoOutDTO outDto = new S8247SaleTaxInfoOutDTO();
		outDto.setAcceptSever(pubCodeList.get(0).getCodeDesc() + ":8001");
		outDto.setKpServer(pubCodeList.get(0).getCodeName());
		outDto.setAddressPhone(taxInfoList.get(0).getCodeName());
		outDto.setSaleName(taxInfoList.get(0).getCodeValue());
		outDto.setBankInfo(taxInfoList.get(0).getCodeDesc());

		return outDto;
	}



	public CommonOutDTO getProvinceDTO(int flag) {
		return null;
	}


	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IInvFee getInvFee() {
		return invFee;
	}

	public void setInvFee(IInvFee invFee) {
		this.invFee = invFee;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
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

}
