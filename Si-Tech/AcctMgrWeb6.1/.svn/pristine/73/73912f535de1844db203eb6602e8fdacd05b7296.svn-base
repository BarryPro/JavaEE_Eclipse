package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S8076InvoicePrintInDTO;
import com.sitech.acctmgr.inter.invoice.I8076Invoice;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8076InvoiceTest extends BaseTestCase {

	private I8076Invoice bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8076Invoice) getBean("8076InvoiceSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("ID_NO", "230730002012372330");
		busiMap.put("PHONE_NO", "13846016589");
		busiMap.put("INV_CODE", "123001670712");
		busiMap.put("PAY_SN", "30000000470060");
		busiMap.put("REGION_CODE", "2307");
		busiMap.put("PRINT_TYPE", "2");
		busiMap.put("INV_NO", "07612621");
		busiMap.put("CONTRACT_NO", "230730002012372330");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8076");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		InDTO inDTO = parseInDTO(inStr, S8076InvoicePrintInDTO.class);
		OutDTO outDTO = bean.print(inDTO);
		System.err.println(outDTO.toJson());

	}

}
