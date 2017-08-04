package com.sitech.acctmgr.test.inter;

import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SJtPrepayInitInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SJtPrepayInitOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SQry1500OutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SQry1500VwOutDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SRemainFeeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPayTypeInitOutDTO;
import com.sitech.acctmgr.inter.feeqry.IRemainFeeQry;
import com.sitech.acctmgr.inter.query.IPayTypeQry;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

public class SRemainFeeQryTest 		extends BaseTestCase{
		
		@Test
		public void test1500Query() {
			try {
				IRemainFeeQry iRemainFeeQry = (IRemainFeeQry) getBean("remainFeeQrySvc");

				MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
					"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
					+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\"}}}}");
				//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
				InDTO in = parseInDTO(inMBean, SRemainFeeInitInDTO.class);
				SQry1500OutDTO out = (SQry1500OutDTO)iRemainFeeQry.qry1500(in);
				String result = out.toJson();
				System.out.println("result = " + result);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@Test
		public void test1500VwQuery() {
			try {
				IRemainFeeQry iRemainFeeQry = (IRemainFeeQry) getBean("remainFeeQrySvc");

				MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
					"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
					+ ",\"BUSI_INFO\":{\"PHONE_NO\":\"18663000630\"}}}}");
				//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
				InDTO in = parseInDTO(inMBean, SRemainFeeInitInDTO.class);
				SQry1500VwOutDTO out = (SQry1500VwOutDTO)iRemainFeeQry.qry1500Vw(in);
				String result = out.toJson();
				System.out.println("result = " + result);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		@Test
		public void testJtQuery() {
			try {
				IRemainFeeQry iRemainFeeQry = (IRemainFeeQry) getBean("remainFeeQrySvc");

				MBean inMBean = new MBean("{\"ROOT\":{\"HEADER\":{\"POOL_ID\":\"11\",\"DB_ID\":\"\",\"ENV_ID\":\"\",\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}}" +
					"    ,\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"qea602\",\"GROUP_ID\":\"12345\"}"
					+ ",\"BUSI_INFO\":{\"CONTRACT_NO\":\"220101100000030015\"}}}}");
				//InDTO in = parseInDTO(inMBean, S8000InitInDTO.class);
				InDTO in = parseInDTO(inMBean, SJtPrepayInitInDTO.class);
				SJtPrepayInitOutDTO out = (SJtPrepayInitOutDTO)iRemainFeeQry.jtQuery(in);
				String result = out.toJson();
				System.out.println("result = " + result);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
