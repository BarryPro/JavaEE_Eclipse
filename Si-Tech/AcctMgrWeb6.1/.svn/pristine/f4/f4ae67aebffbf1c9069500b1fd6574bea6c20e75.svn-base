package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.junit.Test;

import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.CrossEntity;
import com.sitech.common.utils.StringUtils;
import com.sitech.hsf.common.logger.Logger;
import com.sitech.hsf.common.logger.LoggerFactory;
import com.sitech.jcfx.dt.MBean;

public class EInvoiceTest {
	private IControl control;
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Test
	public void test1() throws Exception {
		long requestSn = 1111;
		Map<String, String> outPut = new HashMap<String, String>();
		// 获取数据交换流水号（唯一） requestCode+8位日期(YYYYMMDD)+9位序列号
		long changerSn = 111111111;
		String dataExchangeId = "23" + DateUtils.getCurYm() + changerSn;

		MBean serviceMBean = new MBean();
		serviceMBean.setBody("terminalCode", "1"); // 终端类型标识代码 0:B/S请求来源 1:C/S请求来源
		serviceMBean.setBody("appId", "DZFP"); // 应用标识 默认为ZZS_PT_DZFP：增值税普通电子发票
		serviceMBean.setBody("version", "2.0"); // 接口版本 默认为2.0
		serviceMBean.setBody("interfaceCode", "ECXML.FPKJ.BC.E_INV_SYN"); // 接口编码
		serviceMBean.setBody("userName", "13310101"); // 平台编码
		serviceMBean.setBody("password", "29829888"); // 密码64444842
		serviceMBean.setBody("requestCode", "23"); // 各省区域编码 黑龙江23
		serviceMBean.setBody("requestTime", DateUtils.getCurDate("yyyy-MM-dd HH:mm:ss SSS")); // 数据交换请求发出时间
		serviceMBean.setBody("taxpayerId", "23001866751050002577"); // 纳税人识别号23001866751050002577
		serviceMBean.setBody("authorizationCode", "23111370"); // 纳税人授权码
		serviceMBean.setBody("responseCode", "121"); // 数据交换请求接受方代码,由平台提供，企业调用时为空
		serviceMBean.setBody("dataExchangeId", "2320170601000368020"); // 数据交换流水号（唯一） requestCode+8位日期(YYYYMMDD)+9位序列号
		serviceMBean.setBody("returnCode", "");
		serviceMBean.setBody("returnMessage", "");
		serviceMBean.setBody("zipCode", "0");
		serviceMBean.setBody("encryptCode", "0");
		serviceMBean.setBody("codeType", "0");
		// 设置content
		String content = "<REQUEST_FPKJXX class=\"REQUEST_FPKJXX\" ><FPKJXX_FPTXX class=\"FPKJXX_FPTXX\"><FPQQLSH>DZFP1000000000368023</FPQQLSH><DSPTBM>13310101</DSPTBM><NSRSBH>23001866751050002577</NSRSBH><NSRMC>中国移动通信集团黑龙江有限公司哈尔滨分公司</NSRMC><NSRDZDAH></NSRDZDAH><SWJG_DM></SWJG_DM><DKBZ>0</DKBZ><PYDM>000001</PYDM><KPXM>1302</KPXM><BMB_BBH></BMB_BBH><XHF_NSRSBH>23001866751050002577</XHF_NSRSBH><XHFMC>中国移动通信集团黑龙江有限公司哈尔滨分公司</XHFMC><XHF_DZ>哈尔滨市香坊区进乡街114号</XHF_DZ><XHF_DH>10086</XHF_DH><XHF_YHZH>23001866751050002577</XHF_YHZH><GHFMC>临时 15004675560</GHFMC><GHF_NSRSBH></GHF_NSRSBH><GHF_SF></GHF_SF><GHF_DZ></GHF_DZ><GHF_GDDH></GHF_GDDH><GHF_SJ></GHF_SJ><GHF_EMAIL></GHF_EMAIL><GHFQYLX>03</GHFQYLX><GHF_YHZH></GHF_YHZH><HY_DM></HY_DM><HY_MC></HY_MC><KPY>aaaaxp</KPY><SKY></SKY><FHR></FHR><KPRQ></KPRQ><KPLX>1</KPLX><YFP_DM></YFP_DM><YFP_HM></YFP_HM><CZDM>10</CZDM><CHYY></CHYY><TSCHBZ>0</TSCHBZ><QD_BZ>0</QD_BZ><QDXMMC></QDXMMC><KPHJJE>5.00</KPHJJE><HJBHSJE>0.00</HJBHSJE><HJSE>0.00</HJSE><BZ>本次交话费：  现金         5.00 支票         0.00 刷卡         0.00话费余额:          1326.10未出帐话费:           0.00  当前可用余额:      1326.10</BZ><BYZD1></BYZD1><BYZD2></BYZD2><BYZD3></BYZD3><BYZD4></BYZD4><BYZD5></BYZD5></FPKJXX_FPTXX><FPKJXX_XMXXS class=\"FPKJXX_XMXX;\" size=\"1\"><FPKJXX_XMXX><XMMC>号码缴费</XMMC><XMDW></XMDW><GGXH></GGXH><XMSL>1</XMSL><HSBZ>1</HSBZ><FPHXZ>0</FPHXZ><XMDJ>5.00</XMDJ><SPBM></SPBM><ZXBM></ZXBM><YHZCBS>0</YHZCBS><LSLBS>0</LSLBS><ZZSTSGL></ZZSTSGL><XMJE>5.00</XMJE><SL>0.00</SL><SE>0.00</SE><BYZD1></BYZD1><BYZD2></BYZD2><BYZD3></BYZD3><BYZD4></BYZD4><BYZD5></BYZD5></FPKJXX_XMXX></FPKJXX_XMXXS><FPKJXX_DDXX class=\"FPKJXX_DDXX\"><DDH>DZFP1000000000368023</DDH><THDH></THDH><DDDATE></DDDATE></FPKJXX_DDXX><FPKJXX_DDMXXXS class=\"FPKJXX_DDMXXX;\" size=\"1\"><FPKJXX_DDMXXX><DDMC></DDMC><DW></DW><GGXH></GGXH><BYZD1></BYZD1><BYZD2></BYZD2><BYZD3></BYZD3><BYZD4></BYZD4><BYZD5></BYZD5></FPKJXX_DDMXXX></FPKJXX_DDMXXXS><FPKJXX_ZFXX class=\"FPKJXX_ZFXX\"><ZFFS></ZFFS><ZFLSH></ZFLSH><ZFPT></ZFPT></FPKJXX_ZFXX><FPKJXX_WLXX class=\"FPKJXX_WLXX\"><CYGS></CYGS><SHSJ></SHSJ><WLDH></WLDH><SHDZ></SHDZ></FPKJXX_WLXX></REQUEST_FPKJXX>";
		System.err.println(content);
		String aa = "";
		aa = java.net.URLEncoder.encode(content.replace("\"", "\""), "GBK");

		System.out.println("content:" + aa);

		serviceMBean.setBody("content", aa);
		String sEaiServe = "EAI_ElecInvoicePrint_SYN";

		// 调用CRMPD接口
		long HXstart = ValueUtils.longValue(DateUtils.getCurDate("yyyyMMddHHmmssSSS"));
		Map<String, String> EaiResult = CrossEntity.callService(sEaiServe, serviceMBean);
		log.debug("调用开具请求报文: " + serviceMBean);
		log.debug("调用开具响应结果: " + EaiResult);
		long HXend = ValueUtils.longValue(DateUtils.getCurDate("yyyyMMddHHmmssSSS"));
		log.error("调用航信开始时间--" + HXstart + "--调用航信结束时间--" + HXend + "--调用航信总用时--" + (HXend - HXstart));
		// 对返回报文转码
		String returnMsgByPd = "";
		if (EaiResult != null) {
			log.debug("===> reQuestSn : {},调用开具转码响应结果:{} " + ">>>" + requestSn + "****" + EaiResult);
		}

		// 解析返回报文
		String retCode = MapUtils.getString(EaiResult, "returnCode", "8888");
		String returnMsg = "";
		try {
			// 处理返回信息
			if (StringUtils.isNotEmptyOrNull(EaiResult.get("returnMessage"))) {
				returnMsg = EaiResult.get("returnMessage");
				log.debug("===> reQuestSn : {},调用开具返回信息:{} " + ">>>>" + requestSn + "****" + returnMsg);
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("===> reQuestSn : " + requestSn + ",调用开具returnMsg :" + EaiResult.get("returnMessage"));
		}

		if (!retCode.equals("0000")) {
			log.error("===> reQuestSn : {},航信开具失败，错误代码:{} ，错误信息:{}" + requestSn + ">>>>>" + retCode + ">>>>" + returnMsg);
			MapUtils.safeAddToMap(outPut, "RETURN_CODE", "0002");
			MapUtils.safeAddToMap(outPut, "RETURN_MSG", "航信开具失败，错误代码：" + retCode + "，错误信息：" + returnMsg);
			MapUtils.safeAddToMap(outPut, "TIME", (HXend - HXstart) + "");
		}
		System.err.println(outPut);
	}


	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}
