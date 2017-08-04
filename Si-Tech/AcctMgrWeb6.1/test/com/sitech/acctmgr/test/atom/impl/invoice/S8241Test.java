package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8241PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8241QryInDTO;
import com.sitech.acctmgr.inter.invoice.I8241;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8241Test extends BaseTestCase {

	private I8241 bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8241) getBean("8241Svc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForqry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("BEGIN_DATE", "20161101");
		busiMap.put("END_DATE", "20161111");

		busiMap.put("UNIT_ID", "123456789");

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
	public void testQryPayInfo() throws Exception {
		String inStr = getArgStringForqry();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8241QryInDTO.class);
		OutDTO outDto = bean.query(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		List<VirtualGrpEntity> contractNoList = new ArrayList<>();
		busiMap.put("PRINT_FEE", "15");
		busiMap.put("PRINT_ITEM", "20161102");
		busiMap.put("INV_NO", "1");
		busiMap.put("INV_CODE", "1");
		busiMap.put("BEGIN_DATE", "20170101");
		busiMap.put("END_DATE", "20170119");
		busiMap.put("UNIT_ID", "1");
		busiMap.put("UNIT_NAME", "ZS");
		busiMap.put("PRINT_ITEM", "dfasdfasfadsfads");

		VirtualGrpEntity vge = new VirtualGrpEntity();
		// vge.setGrpContractNo("230810002011408124");
		// vge.setIdNo(230810002011408124l);
		// vge.setGrpPhoneNo("13946712784");
		vge.setPaySn(30000000190000l);

		contractNoList.add(vge);
		busiMap.put("VIRTUAL_GRP_LIST", contractNoList);

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8241");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println("***************" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8241PrintInDTO.class);
		OutDTO outDto = bean.print(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

}
