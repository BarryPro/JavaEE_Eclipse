package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.SPreInvoicePrintInDTO;
import com.sitech.acctmgr.inter.invoice.IPreInvoicePrint;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SPreInvoicePrintTest extends BaseTestCase {

	private IPreInvoicePrint bean;

	@Before
	public void setUp() throws Exception {
		bean = (IPreInvoicePrint) getBean("preInvoicePrintSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForqry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PAY_SN", "30000000010003");
		busiMap.put("CONTRACT_NO", "230370003002116701");
		busiMap.put("TOTAL_DATE", "20170307");
		busiMap.put("INV_NO", "895623");
		busiMap.put("INV_CODE", "89456123");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "0000");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForqry();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, SPreInvoicePrintInDTO.class);
		OutDTO outDto = bean.print(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

}
