package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.invoice.TaxInvoiceFeeEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8248BOSSCfmInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248DataResetInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QryInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QryInvoiceFeeInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QryInvoiceFlowInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QryOnePayInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248QueryRedReasonInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248RedInvoiceReqInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8248TaxInvoCompQryAcctNoInDTO;
import com.sitech.acctmgr.inter.invoice.I8248TaxInvo;
import com.sitech.acctmgr.inter.invoice.I8248TaxInvoAo;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8248Test extends BaseTestCase {

	private I8248TaxInvo bean;
	private I8248TaxInvoAo bean1;

	@Before
	public void setUp() throws Exception {
		bean = (I8248TaxInvo) getBean("8248TaxInvoSvc");
		bean1 = (I8248TaxInvoAo) getBean("8248TaxInvoAoSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
		bean1 = null;
	}

	private String getArgStringForqryAcctNo() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		busiMap.put("PHONE_NO", "20210718234");
		// busiMap.put("", value)
		busiMap.put("END_YM", "201612");
		busiMap.put("BEGIN_YM", "201612");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8247");
		oprMap.put("GROUP_ID", "12345");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQryAcctNo() throws Exception {
		String inStr = getArgStringForqryAcctNo();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248TaxInvoCompQryAcctNoInDTO.class);
		OutDTO outDto = bean.qryAcctNo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForQryInvo() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		// busiMap.put("CONTRACT_NO", "230750003001102500");
		busiMap.put("CONTRACT_NO", "220101100000070006");
		busiMap.put("END_MON", "201611");
		busiMap.put("BEGIN_MON", "201610");
		busiMap.put("DOMAIN", "1");

		// busiMap.put("CONTRACT_NO", "230700003010321003");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQryInvo() throws Exception {
		String inStr = getArgStringForQryInvo();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QryInvoInDTO.class);
		OutDTO outDto = bean1.qryInvo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForQryOnePayInvo() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		// busiMap.put("CONTRACT_NO", "230750003001102500");
		busiMap.put("CONTRACT_NO", "230320003016614251");
		busiMap.put("END_MON", "201703");
		busiMap.put("BEGIN_MON", "201701");
		busiMap.put("DOMAIN", "1");

		// busiMap.put("CONTRACT_NO", "230700003010321003");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQryOnePayInvo() throws Exception {
		String inStr = getArgStringForQryOnePayInvo();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QryOnePayInvoInDTO.class);
		OutDTO outDto = bean1.qryInvNoForOnePay(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForInvoiceFlow() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		busiMap.put("PHONE_NO", "20210718234");
		busiMap.put("END_MON", "201611");
		busiMap.put("BEGIN_MON", "201611");
		busiMap.put("DOMAIN", "1");

		// busiMap.put("CONTRACT_NO", "230700003010321003");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testInvoiceFlow() throws Exception {
		String inStr = getArgStringForInvoiceFlow();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QryInvoiceFlowInDTO.class);
		OutDTO outDto = bean1.qryInvo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForCfmBoss() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		// busiMap.put("PHONE_NO", "20210718234");
		busiMap.put("CONTRACT_NO", "230320003016614251");
		busiMap.put("ORDER_SN", "1212");
		busiMap.put("QRY_TYPE", "2");
		busiMap.put("DATA_SOURCE", "1");
		busiMap.put("REPORT_TO", "aan70W");
		busiMap.put("AUDIT_PHONE_NO", "123456789");
		busiMap.put("REMARK", "123456789");
		busiMap.put("BEGIN_YM", "201701");
		busiMap.put("END_YM", "201702");
		busiMap.put("REMARK", "123456789");
		busiMap.put("INV_TYPE", "0");

		List<TaxInvoiceFeeEntity> taxInvoEntList = new ArrayList<TaxInvoiceFeeEntity>();
		TaxInvoiceFeeEntity taxInvoEnt = new TaxInvoiceFeeEntity();
		taxInvoEnt.setGoodsName("增值业务费");
		taxInvoEnt.setGoodsNum("1");
		taxInvoEnt.setGoodsPrice("1887");
		taxInvoEnt.setInvoiceFee("1887");
		taxInvoEnt.setTaxFee("113");
		taxInvoEnt.setTaxRate("0.06");

		taxInvoEntList.add(taxInvoEnt);
		busiMap.put("TAX_INVOICEFEE_LIST", taxInvoEntList);
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testCfmBoss() throws Exception {
		String inStr = getArgStringForCfmBoss();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248BOSSCfmInDTO.class);
		OutDTO outDto = bean1.cfmBOSS(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForQryRedReason() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQryRedReason() throws Exception {
		String inStr = getArgStringForQryRedReason();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QueryRedReasonInDTO.class);
		OutDTO outDto = bean1.queryRedReason(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForInvoiceFlowInfo() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("QRY_TYPE", "1");
		busiMap.put("PHONE_NO", "20210718234");
		busiMap.put("BEGIN_YM", "201702");
		busiMap.put("END_YM", "201702");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testInvoiceFlowInfo() throws Exception {
		String inStr = getArgStringForInvoiceFlowInfo();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QryInvoiceFlowInDTO.class);
		OutDTO outDto = bean1.invoiceFlowInfo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForInvoiceFeeInfo() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PRINT_SN", "30000000830256");
		busiMap.put("TAX_PAYER_ID", "91230321702701258Q");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testInvoiceFeeInfo() throws Exception {
		String inStr = getArgStringForInvoiceFeeInfo();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248QryInvoiceFeeInDTO.class);
		OutDTO outDto = bean1.invoiceFeeInfo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForRedInvoiceReq() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("AUDIT_SN", "10000000187842");
		busiMap.put("REPORT_TO", "aan70W");
		busiMap.put("FLAG", "1");
		busiMap.put("AUDIT_PHONE_NO", "17600834360");
		busiMap.put("REMARK", "dddddd");
		busiMap.put("RED_INV_CAUSE", "折扣折让");
		busiMap.put("RED_INV_REMARK", "卡发发发");
		busiMap.put("BEGIN_YM", "201702");
		busiMap.put("END_YM", "201703");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testRedInvoiceReq() throws Exception {
		String inStr = getArgStringForRedInvoiceReq();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248RedInvoiceReqInDTO.class);
		OutDTO outDto = bean1.redInvoiceReq(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForReset() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("AUDIT_SN", "10000000211726");
		busiMap.put("INV_TYPE", "1");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8248");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testDataReset() throws Exception {
		String inStr = getArgStringForReset();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8248DataResetInDTO.class);
		OutDTO outDto = bean1.dataReset(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

}