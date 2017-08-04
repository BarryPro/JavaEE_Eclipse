package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S8005PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8056QryInDTO;
import com.sitech.acctmgr.inter.invoice.I8056ZFInvoice;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8056InvoiceTest extends BaseTestCase {

	private I8056ZFInvoice bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8056ZFInvoice) getBean("8056ZFInvoiceSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForqry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PAY_SN", "30000000940011");
		busiMap.put("TOTAL_DATE", "20170420");
		busiMap.put("CONTRACT_NO", "230300001000040094");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8006");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = getArgStringForqry();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8056QryInDTO.class);
		OutDTO outDto = bean.query(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("USER_FLAG", "0");
		busiMap.put("PAY_SN", "30000000860025");
		busiMap.put("PRINT_FLAG", "0");
		busiMap.put("AUTH_FLAG", "");
//		busiMap.put("PHONE_NO", "20230022250");
		// busiMap.put("CONTRACT_NO", "230370003002116701");
		busiMap.put("PAY_LOGIN_NO", "gead02");
		busiMap.put("TOTAL_DATE", "20170403");
		busiMap.put("INV_NO", "07612676");
		busiMap.put("INV_CODE", "123001670712");
		busiMap.put("IS_PRINT", "");
		busiMap.put("INV_TYPE", "PM3002");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "gead02");
		oprMap.put("OP_CODE", "8074");
		oprMap.put("GROUP_ID", "10453");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8005PrintInDTO.class);
		// OutDTO outDto = bean.print(inDTO);
		// System.err.println("outdto:" + outDto.toJson());
	}

}
