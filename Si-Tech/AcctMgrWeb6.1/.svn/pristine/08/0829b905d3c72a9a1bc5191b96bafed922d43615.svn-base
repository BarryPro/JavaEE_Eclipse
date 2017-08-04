package com.sitech.acctmgr.comp.impl.query;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.sitech.ac.rdc.re.api.common.util.MBean;
import com.sitech.acctmgr.atom.dto.query.SSendMailInDTO;
import com.sitech.acctmgr.atom.dto.query.SSendMailOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.comp.busi.EMailSend;
import com.sitech.acctmgr.inter.query.ISendMail;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

@ParamTypes({ @ParamType(c = SSendMailInDTO.class, oc = SSendMailOutDTO.class, m = "sendBill") })
public class SSendMailComp extends AcctMgrBaseService implements ISendMail {
	private EMailSend emailSend;

	@Override
	public OutDTO sendBill(InDTO inParam) {
		// TODO Auto-generated method stub
		SSendMailInDTO inDto = (SSendMailInDTO) inParam;
		MBean mb = new MBean(inDto.getMbean().toString());
		log.debug("mb:" + mb);

		String interfaceName = "com_sitech_acctmgr_inter_feeqry_IFeeQuerySvc_balanceQuery";

		System.err.println(inDto.toString() + ">>>>>>>>>>>>>>>>>>>");
		String outString = ServiceUtil.callService(interfaceName, mb.toString());

		log.debug("调用费用信息查询完成:" + outString);

		MBean mb1 = new MBean(outString);
		// 获取头信息
		String headStr = JSONObject.toJSONString(mb1.getHeader());
		log.debug("headstr:" + headStr);

		// 将str转换成Map格式
		JSONObject headJson = (JSONObject) JSONObject.parse(headStr);

		Map<String, Object> head = new HashMap<String, Object>();

		// 获取Body信息
		Map<String, Object> bodyMap = new HashMap<String, Object>();
		String bodyStr = JSONObject.toJSONString(mb1.getBodyObject("OUT_DATA"));
		log.debug("bodyStr" + bodyStr);

		JSONObject bodyJson = (JSONObject) JSONObject.parse(bodyStr);
		bodyMap = bodyJson;
		bodyMap.put("templateId", "00000428");
		bodyMap.put("queryDate", inDto.getQryDate());
		bodyMap.remove("BRAND_NAME");
		bodyMap.put("BRAND_NAME", "SSSS");
		log.debug("bodyMap:" + bodyMap);
		bodyMap.remove("ACCOUNT_LIST");

		// 调用email邮箱发送服务
		Map<String, Object> outMap = emailSend.send(head, bodyMap);
		// if (!outMap.get("RETURN_CODE").toString().equals("0000")) {
		// throw new BusiException(AcctMgrError.getErrorCode("0000", "09999"),
		// outMap.get("RETURN_MSG").toString());
		// }
		SSendMailOutDTO outDto = new SSendMailOutDTO();
		outDto.setReturnCode(outMap.get("RETURN_CODE").toString());
		outDto.setReturnMsg(outMap.get("RETURN_MSG").toString());
		System.err.println(outDto.toXML());
		return outDto;
	}

	public EMailSend getEmailSend() {
		return emailSend;
	}

	public void setEmailSend(EMailSend emailSend) {
		this.emailSend = emailSend;
	}

}
