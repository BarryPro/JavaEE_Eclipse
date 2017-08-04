package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryDetailInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoiceRecycleQryInDTO;
import com.sitech.acctmgr.inter.invoice.IPreInvoiceRecycle;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SPreInvoiceRecycleTest extends BaseTestCase {

	private IPreInvoiceRecycle bean;

	@Before
	public void setUp() throws Exception {
		bean = (IPreInvoiceRecycle) getBean("preInvoiceRecycleSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForQuery() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		busiMap.put("UNIT_ID", "123456789");

		busiMap.put("BILL_CYCLE", "201611");
		// busiMap.put("INV_CODE", "123001570712");
		//
		// busiMap.put("YEAR_MONTH", "201603");

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
	public void testQry() throws Exception {
		String inStr = getArgStringForQuery();
		log.debug("入参：" + inStr);
		InDTO inDTO = parseInDTO(inStr, SPreInvoiceRecycleQryInDTO.class);
		OutDTO outDTO = bean.query(inDTO);
		System.err.println(outDTO.toJson());

	}

	private String getArgStringForDisabled() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		// busiMap.put("INV_CODE", "123001570712");
		//
		// busiMap.put("INV_NO", "31392303");
		busiMap.put("UNIT_ID", "123456789");
		busiMap.put("PRINT_SN", "10000000691324");

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
	public void testQryDetail() throws Exception {
		String inStr = getArgStringForDisabled();
		log.debug("入参：" + inStr);
		InDTO inDTO = parseInDTO(inStr, SPreInvoiceRecycleQryDetailInDTO.class);
		OutDTO outDTO = bean.queryDetail(inDTO);
		System.err.println(outDTO.toJson());

	}
}
