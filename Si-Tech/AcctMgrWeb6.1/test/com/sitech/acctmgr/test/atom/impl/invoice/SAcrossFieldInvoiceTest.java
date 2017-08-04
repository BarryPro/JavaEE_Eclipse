package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.invoice.AcrossFieldInvEntity;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldPrintCfmInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SAcrossFieldQryInvoInDTO;
import com.sitech.acctmgr.inter.invoice.IAcrossFieldInvo;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SAcrossFieldInvoiceTest extends BaseTestCase {

	private IAcrossFieldInvo bean;

	@Before
	public void setUp() throws Exception {
		bean = (IAcrossFieldInvo) getBean("acrossFieldInvoSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForqry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		busiMap.put("ID_TYPE", "0");
		busiMap.put("ID_VALUE", "15945286688");
		busiMap.put("BEGIN_DATE", "201607");
		busiMap.put("END_DATE", "201608");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		// oprMap.put("OP_CODE", "8006");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQry() throws Exception {
		String inStr = getArgStringForqry();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, SAcrossFieldQryInvoInDTO.class);
		OutDTO outDto = bean.qryInvo(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		// busiMap.put("CONTRACT_NO", "230840003001023436");
		// busiMap.put("BILL_CYCLE", "201608");
		busiMap.put("ID_TYPE", "01");
		busiMap.put("PRINTED_DATE", "20161123");
		busiMap.put("ID_VALUE", "15945286688");
		busiMap.put("HANDLING_NUM", "aan70W");

		// busiMap.put("INV_NO", "34323");
		// busiMap.put("INV_CODE", "789546");

		AcrossFieldInvEntity invBillCycle = new AcrossFieldInvEntity();
		invBillCycle.setMonth("201608");
		invBillCycle.setMonthAmount("30");
		invBillCycle.setInvNo("12345");

		// invBillCycle.setInvCode("879456123");
		// invBillCycle.setInvNo("9531");
		//
		// InvBillCycleEntity invBillCycle2 = new InvBillCycleEntity();
		// invBillCycle2.setBillCycle(201607);
		// invBillCycle2.setInvCode("879456123");
		// invBillCycle2.setInvNo("9531");
		List<AcrossFieldInvEntity> invBillCycleList = new ArrayList<AcrossFieldInvEntity>();
		invBillCycleList.add(invBillCycle);
		// invBillCycleList.add(invBillCycle2);
		busiMap.put("INFO_CONT", invBillCycleList);
		// busiMap.put("INFO_CONT", value)

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		// oprMap.put("OP_CODE", "8224");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, SAcrossFieldPrintCfmInDTO.class);
		OutDTO outDto = bean.printCfm(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

}
