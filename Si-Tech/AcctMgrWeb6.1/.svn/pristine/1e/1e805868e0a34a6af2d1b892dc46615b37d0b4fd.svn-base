package com.sitech.acctmgr.comp.webservice;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMFactory;
import org.apache.axiom.om.OMNamespace;
import org.apache.axiom.soap.SOAP11Constants;
import org.apache.axis2.Constants;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.axis2.context.ConfigurationContextFactory;
import org.apache.axis2.description.TransportInDescription;
import org.apache.axis2.description.TransportOutDescription;
import org.apache.axis2.transport.http.HTTPConstants;
import org.apache.ws.security.handler.WSHandlerConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgr.common.InterProperties;

/**
 * ESBsoap服务调用封装
 */
public class ESBServiceAxisSoap implements Runnable {
	private static final Logger log = LoggerFactory.getLogger(ESBServiceAxisSoap.class);

	public static String endpointReference = InterProperties.getConfigByMap("ESB_WEBSERVICE_URL");
	static private ConfigurationContext configContext = null;
	static private OMFactory fac = null;
	static private OMNamespace omNs = null;
	static private OMNamespace omHeaderNs = null;
	static private Map senderMap = new HashMap();

	private static boolean _run_flag = true;
	public static int count = 0;
	private int num;

	private static ESBServiceAxisSoap instance = new ESBServiceAxisSoap();

	public ESBServiceAxisSoap() {
	}

	public ESBServiceAxisSoap(int num) {
		this.num = num;
	}

	public static ESBServiceAxisSoap getInstance() {
		return instance;
	}

	public String callService(String serviceName, String inStr, String flag) throws ESBBusiAppException {
		return callService(serviceName, inStr, null, null, flag);
	}

	public String callService(String serviceName, String inStr, String routerKey, String routerValue, String flag) throws ESBBusiAppException {
		try {
			ESBServiceClientEx sender = (ESBServiceClientEx) senderMap.get(serviceName);
			if (null == sender) {
				synchronized (senderMap) {
					sender = (ESBServiceClientEx) senderMap.get(serviceName);
					if (null == sender) {// 防止第一次并发访问时的重复创建
						log.info("ESBServiceAxis!!!!!!!!");
						// configContext上下文配置
						if (null == configContext) {
							configContext = ConfigurationContextFactory.createConfigurationContextFromFileSystem(null, null);
						}
						sender = new ESBServiceClientEx(configContext, null);
						sender.disengageModule("addressing");
						// 消息传送方式选项
						Options options = sender.getOptions();
						// options.setProperty(WSDL2Constants.ATTR_WHTTP_QUERY_PARAMETER_SEPARATOR,
						// "&");
						options.setTransportInProtocol(Constants.TRANSPORT_HTTP);
						TransportOutDescription transOut = sender.getAxisConfiguration().getTransportOut(Constants.TRANSPORT_HTTP);
						TransportInDescription transIn = sender.getAxisConfiguration().getTransportIn(Constants.TRANSPORT_HTTP);
						options.setTransportOut(transOut);
						options.setTransportIn(transIn);
						options.setSoapVersionURI(SOAP11Constants.SOAP_ENVELOPE_NAMESPACE_URI);
						options.setAction("urn:callService");
						options.setCallTransportCleanup(false);
						options.setTimeOutInMilliSeconds(0);
						options.setExceptionToBeThrownOnSOAPFault(true);
						options.setProperty(WSHandlerConstants.MUST_UNDERSTAND, "false");
						options.setProperty(HTTPConstants.AUTO_RELEASE_CONNECTION, Boolean.FALSE);
						options.setProperty(HTTPConstants.CHAR_SET_ENCODING, "GBK");
						options.setProperty(HTTPConstants.HTTP_PROTOCOL_VERSION, HTTPConstants.HEADER_PROTOCOL_10);
						options.setExceptionToBeThrownOnSOAPFault(true);
						options.setUseSeparateListener(false);
						sender.setTargetEPR(new EndpointReference(ESBServiceAxisSoap.endpointReference + serviceName));
						sender.setServiceContextOptions(options);
						fac = OMAbstractFactory.getOMFactory();
						// omNs =
						// fac.createOMNamespace("http://xmlWS.esb.sitech.com",
						// "ns");
						omNs = fac.createOMNamespace("http://ws.sitech.com", "ns");
						omHeaderNs = fac.createOMNamespace("http://***.***.com", "hns");
						senderMap.put(serviceName, sender);
					}
				}
			}
			OMElement header = OMAbstractFactory.getOMFactory().createOMElement("ROUTER_VALUE", omHeaderNs);
			header.setText("router_valuexxx");

			OMElement method = fac.createOMElement("callService", omNs);
			OMElement value = fac.createOMElement("pin", omNs, method);
			value.setText(inStr);
			return sender.sendReceiveStr(method, header, flag);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "<?xml version='1.0' encoding='GBK' standalone='no' ?><ROOT></ROOT>";
	}

	public String TestService(String pin, String url, String ServiceName) {

		ESBServiceAxisSoap.endpointReference = url;
		String rut = null;

		try {
			rut = callService(ServiceName, pin, "1");
		} catch (ESBBusiAppException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rut;
	}

	public static void main(String[] args) {

		int ClientCount = 10;
		for (int i = 0; i < ClientCount; i++) {
			new Thread(new ESBServiceAxisSoap(i)).start();
		}

		try {
			System.in.read();
			_run_flag = false;

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Thread t1 = new Thread(new ESBServiceAxisSoap(1));
		// t1.start();
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		String url = "http://10.152.30.77:51000/esbWS/services/";
		String pin = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\" ?>" + "<ROOT><SVC_NAME type=\"string\">dESB05</SVC_NAME>"
				+ "<OUTDATANAME type=\"string\">RESULT_SET</OUTDATANAME></ROOT>";
		String serviceName = "sDynSvc0";

		System.out.println("Thread " + num + "开始执行");

		while (_run_flag) {
			long startTime = System.currentTimeMillis();
			String str = TestService(pin, url, serviceName);
			// System.out.println("str = " + str);
			long endTime = System.currentTimeMillis();
			System.out.println("执行时长 : " + (endTime - startTime));
			count++;
		}

		System.out.println("调用次数：" + count + ",  线程: " + num + " 正常退出！");

	}

}
