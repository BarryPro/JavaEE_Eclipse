package com.sitech.acctmgr.test.atom.impl.feeqry;

import com.sitech.acctmgr.atom.dto.feeqry.SBalanceQryBackFeeInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SGMBalanceQueryInDTO;
import com.sitech.acctmgr.inter.feeqry.IGMBalance;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2016/6/2.
 */
public class SGMBalanceTest extends BaseTestCase {
	IGMBalance bean = null;

	@Before
	public void setUp() throws Exception {
		bean = (IGMBalance) getBean("gMBalanceSvc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "15945484564");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("GROUP_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, SGMBalanceQueryInDTO.class);

		OutDTO outDto = bean.query(inDto);
		System.err.println(outDto.toJson());

	}

}