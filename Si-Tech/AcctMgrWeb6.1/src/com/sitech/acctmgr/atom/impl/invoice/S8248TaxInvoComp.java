package com.sitech.acctmgr.atom.impl.invoice;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.TaxPayerInfo;
import com.sitech.acctmgr.atom.domains.invoice.CRMOrderInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.CRMTaxEntity;
import com.sitech.acctmgr.atom.domains.invoice.CrmOrderEntity;
import com.sitech.acctmgr.atom.domains.invoice.TaxAcctInfo;
import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8248QryAcctNoOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QrySecCompConOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QrySecConCompInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248SubConInvcCompInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248SubConInvcCompOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompCfmBossInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompCfmBossOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompQryAcctNoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompQryAcctNoOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompQryInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompQryInvoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8248TaxInvo;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author wangxind
 * @version 1.0
 */
@ParamTypes({ @ParamType(c = S8248TaxInvoCompQryAcctNoInDTO.class, m = "qryAcctNo", oc = S8248TaxInvoCompQryAcctNoOutDTO.class),
		@ParamType(c = S8248TaxInvoCompQryInvoInDTO.class, m = "qryInvo", oc = S8248TaxInvoCompQryInvoOutDTO.class),
		@ParamType(c = S8248TaxInvoCompCfmBossInDTO.class, m = "cfmBoss", oc = S8248TaxInvoCompCfmBossOutDTO.class),
		@ParamType(c = S8248QrySecConCompInDTO.class, m = "qryAcctNoRel", oc = S8248QrySecCompConOutDTO.class),
		@ParamType(c = S8248SubConInvcCompInDTO.class, m = "getSubConInvc", oc = S8248SubConInvcCompOutDTO.class) })
public class S8248TaxInvoComp implements I8248TaxInvo {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
	private IControl control;
	private IAccount account;
	private ICust cust;

	@Override
	public OutDTO qryAcctNo(InDTO inParam) {

		S8248TaxInvoCompQryAcctNoInDTO inArg = (S8248TaxInvoCompQryAcctNoInDTO) inParam;
		S8248TaxInvoCompQryAcctNoOutDTO outArg = new S8248TaxInvoCompQryAcctNoOutDTO();

		String sPhoneNo = inArg.getPhoneNo();

		String outStr = "";
		/* 依次查询大区 */
		String interfaceName = "com_sitech_acctmgr_inter_invoice_I8248TaxInvoAoSvc_qryAcctNo";
		/* 入参报文 */
		MBean inPubInfo = new MBean();
		inPubInfo.setHeader(inArg.getHeader());
		inPubInfo.addBody("BUSI_INFO.PHONE_NO", sPhoneNo);
		inPubInfo.addBody("BUSI_INFO.QRY_TYPE", "" + inArg.getQryType());
		inPubInfo.addBody("BUSI_INFO.BEGIN_YM", inArg.getBeginYm() + "");
		inPubInfo.addBody("BUSI_INFO.END_YM", inArg.getEndYm() + "");
		inPubInfo.addBody("BUSI_INFO.CONTRACT_NO", "" + inArg.getContractNo());
		inPubInfo.addBody("BUSI_INFO.TAX_PAYER_ID", "" + inArg.getTaxPayerId());
		inPubInfo.addBody("OPR_INFO.GROUP_ID", inArg.getGroupId());
		inPubInfo.addBody("OPR_INFO.LOGIN_NO", inArg.getLoginNo());
		inPubInfo.addBody("OPR_INFO.OP_CODE", inArg.getOpCode());

		outStr = ServiceUtil.callService(interfaceName, inPubInfo);

		MBean mb = new MBean(outStr);
		String jsonStr = JSON.toJSONString(mb.getBodyObject("OUT_DATA"));

		S8248QryAcctNoOutDTO qryout = JSON.parseObject(jsonStr, S8248QryAcctNoOutDTO.class);// new S8248QryAcctNoOutDTO(outStr);

		List<TaxAcctInfo> acctInfo = qryout.getAcctInfo();

		/* 判断账户数 */
		if (acctInfo.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01014"), "没有具有资质的付费关系账户！");
		}

		outArg.setAcctInfo(acctInfo);

		return outArg;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.inter.invoice.I8248TaxInvo#qryInvo(com.sitech.jcfx.dt.in.InDTO) */
	@Override
	public OutDTO qryInvo(InDTO inParam) {

		S8248TaxInvoCompQryInvoInDTO inArg = (S8248TaxInvoCompQryInvoInDTO) inParam;
		S8248TaxInvoCompQryInvoOutDTO outArg = new S8248TaxInvoCompQryInvoOutDTO();
		int domain = inArg.getDomain();
		log.debug("domain:" + domain);
		switch (domain) {
		case 1:
			// BOSS业务
			String outStr = "";
			String interfaceName = "com_sitech_acctmgr_inter_invoice_I8248TaxInvoAoSvc_qryInvo";
			// String interfaceNameOne = "com_sitech_acctmgr_inter_invoice_I8248TaxInvoAoSvc_qryInvNoForOnePay";
			MBean inPubInfo = new MBean();
			inPubInfo.setHeader(inArg.getHeader());
			inPubInfo.addBody("BUSI_INFO.BEGIN_MON", "" + inArg.getBeginMon());
			inPubInfo.addBody("BUSI_INFO.END_MON", "" + inArg.getEndMon());
			inPubInfo.setBody("BUSI_INFO.CONTRACT_NO", "" + inArg.getContractNo());
			inPubInfo.setBody("BUSI_INFO.FLAG", "" + inArg.getFlag());
			inPubInfo.addBody("OPR_INFO.GROUP_ID", inArg.getGroupId());
			inPubInfo.addBody("OPR_INFO.LOGIN_NO", inArg.getLoginNo());
			inPubInfo.addBody("OPR_INFO.OP_CODE", inArg.getOpCode());
			outStr = ServiceUtil.callService(interfaceName, inPubInfo);
			MBean mb = new MBean(outStr);
			String jsonStr = JSON.toJSONString(mb.getBodyObject("OUT_DATA"));
			outArg = (S8248TaxInvoCompQryInvoOutDTO) JSON.parseObject(jsonStr, S8248TaxInvoCompQryInvoOutDTO.class);
			break;
		case 2:
			// Crm接口1
			log.debug("开始调用营销的接口");
			String crminterfaceName = "com_sitech_crm_order_inter_service_billManageService_queryOrdInvc";
			MBean crminPubInfo = new MBean();
			crminPubInfo.setHeader(inArg.getHeader());
			crminPubInfo.addBody("SERVICE_NO", inArg.getContractNo());
			crminPubInfo.addBody("CUST_ID", "");
			crminPubInfo.addBody("ID_ICCID", "");
			crminPubInfo.addBody("START_TIME", inArg.getBeginMon());
			crminPubInfo.addBody("END_TIME", inArg.getEndMon());
			crminPubInfo.addBody("QUERY_TYPE", "1");
			log.info("crminPubInfo===" + crminPubInfo);
			String crmoutStr = ServiceUtil.callService(crminterfaceName, crminPubInfo);
			MBean crmmb = new MBean(crmoutStr);
			String crmjsonStr = JSON.toJSONString(crmmb.getBodyObject("OUT_DATA"));
			CrmOrderEntity order = JSON.parseObject(crmjsonStr, CrmOrderEntity.class);
			log.debug("封装的出参：" + order);
			List<TaxInvoiceFeeEntity> taxInvoiceFeeList = new ArrayList<TaxInvoiceFeeEntity>();
			List<CRMOrderInfoEntity> orderInfoList = order.getCrmOrderlist();
			for (CRMOrderInfoEntity orderInfo : orderInfoList) {

				String orderId = orderInfo.getOrderId();
				List<CRMTaxEntity> taxList = orderInfo.getTaxList();
				for (CRMTaxEntity taxInfo : taxList) {
					String goodsNum = "1";
					if (StringUtils.isNotEmptyOrNull(taxInfo.getResourceNum()) && !taxInfo.getResourceNum().equals("0")) {
						goodsNum = taxInfo.getResourceNum();
					}
					TaxInvoiceFeeEntity taxInvoiceFee = new TaxInvoiceFeeEntity();
					taxInvoiceFee.setGoodsName(taxInfo.getResourceName());
					taxInvoiceFee.setGoodsNum(goodsNum);
					taxInvoiceFee.setGoodsPrice(new BigDecimal(ValueUtils.longValue(taxInfo.getTaxShould()) / ValueUtils.intValue(goodsNum)
							/ (1 + Double.parseDouble(taxInfo.getTaxRate()) / 100)).setScale(0, BigDecimal.ROUND_HALF_UP)
							+ "");
					taxInvoiceFee.setTaxFee(new BigDecimal(ValueUtils.longValue(taxInfo.getTaxFee()) / ValueUtils.intValue(goodsNum) * 1.0).setScale(
							0, BigDecimal.ROUND_HALF_UP) + "");
					taxInvoiceFee.setInvoiceFee(new BigDecimal(ValueUtils.longValue(taxInfo.getTaxShould())
							/ (1 + Double.parseDouble(taxInfo.getTaxRate()))).setScale(0, BigDecimal.ROUND_HALF_UP)
							+ "");
					taxInvoiceFee.setTaxRate(Double.parseDouble(taxInfo.getTaxRate()) / 100 + "");
					taxInvoiceFee.setFeeAccept(taxInfo.getFeeAccept());
					taxInvoiceFee.setFeeType(taxInfo.getFeeType());
					taxInvoiceFee.setFeeCode(taxInfo.getFeeCode());
					taxInvoiceFee.setFeeCodeSeq(taxInfo.getFeeCodeSeq());
					taxInvoiceFee.setOrderId(orderId);
					taxInvoiceFeeList.add(taxInvoiceFee);
					outArg.setTaxInvoiceList(taxInvoiceFeeList);
				}

			}

			break;
		default:
			break;
		}
		// 根据账户查询客户ID
		ContractInfoEntity contractInfo = account.getConInfo(ValueUtils.longValue(inArg.getContractNo().split(",")[0]));
		long custId = contractInfo.getCustId();
		// 查询纳税人信息
		TaxPayerInfo taxPayerInfo = cust.getTaxPayerInfo(custId, "");
		outArg.setAddressPhone(taxPayerInfo.getAddress() + "-" + taxPayerInfo.getPhoneNo());
		outArg.setBankNameAndAccount(taxPayerInfo.getBankName() + "-" + taxPayerInfo.getBankAccount());
		outArg.setUnitName(taxPayerInfo.getUnitName());
		outArg.setTaxPayerId(taxPayerInfo.getTaxpayerId());
		return outArg;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.inter.invoice.I8248TaxInvo#cfmBoss(com.sitech.jcfx.dt.in.InDTO) */
	@Override
	public OutDTO cfmBoss(InDTO inParam) {

		S8248TaxInvoCompCfmBossInDTO inArg = (S8248TaxInvoCompCfmBossInDTO) inParam;
		S8248TaxInvoCompCfmBossOutDTO outArg = new S8248TaxInvoCompCfmBossOutDTO();

		return null;
	}

	@Override
	public OutDTO qryCrmQry(InDTO inParam) {

		return null;

	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

}
