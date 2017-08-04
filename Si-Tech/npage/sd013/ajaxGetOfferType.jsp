<%
  /*
   * 功能: 两城一家
   * 版本: 2.0
   * 日期: 2010/12/23
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	StringBuffer strBuffer = new java.lang.StringBuffer("{'offerArr':[");
	StringBuffer bufferStr = new java.lang.StringBuffer("{'newOfferArr':[");
	String opCode = request.getParameter("opCode");
	String loginAccept = request.getParameter("loginAccept");
	String phoneNo = request.getParameter("phoneNo");
	String userPwd = request.getParameter("userPwd");
	String workNo = request.getParameter("workNo");
	String loginPwd = request.getParameter("loginPwd");
	String iChnSource = request.getParameter("iChnSource");
	String iQrytype = request.getParameter("iQrytype");
	String iSaleType = request.getParameter("iSaleType");
	String iOfferType = request.getParameter("iOfferType");
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String flag = "";
	String offerNum = "";
	String offerExpDate = "";
	String retCode = "";
	String retMsg  = "";
	if("1".equals(iQrytype)){//申请
		flag = "new";
		System.out.println("==========1=========");
%>
<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="0"/>
  <wtc:param value="<%=iChnSource%>"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginPwd%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=userPwd%>"/>
  <wtc:param value="1"/>
  <wtc:param value="<%=iSaleType%>"/>
  <wtc:param value="<%=iOfferType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
		System.out.println("====wanghfa==== result1.length = " + result1.length);

		if(result1.length > 0){
			for(int i=0;i<result1.length;i++){
				strBuffer.append("{'offerId':'"+result1[i][0]+"','offerName':'"+result1[i][1]+"'},");
			}
			if (result1[0][2] != null) {
				offerExpDate = result1[0][2];
			}
		}
		if(strBuffer.toString().endsWith(",")){
			strBuffer.deleteCharAt(strBuffer.toString().length()-1);
		}
		strBuffer.append("]}");
		retCode = retCode1;
		retMsg  = retMsg1;
		System.out.println("错误代码:"+retCode1+",错误内容："+retMsg1);
		%>
		<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:param value="0"/>
	    <wtc:param value="<%=iChnSource%>"/>
	    <wtc:param value="<%=opCode%>"/>
	    <wtc:param value="<%=workNo%>"/>
	    <wtc:param value="<%=loginPwd%>"/>
	    <wtc:param value="<%=phoneNo%>"/>
	    <wtc:param value="<%=userPwd%>"/>
	    <wtc:param value="4"/>
	    <wtc:param value="<%=iSaleType%>"/>
	    <wtc:param value="<%=iOfferType%>"/>
		</wtc:service>
		<wtc:array id="resultNum" scope="end" />
		<%
		System.out.println("====wanghfa==== retCode2 = " + retCode2);
		System.out.println("====wanghfa==== resultNum.length = " + resultNum.length);
		if ("000000".equals(retCode2) && resultNum.length > 0) {
			offerNum = resultNum[0][0];
		}
	}else if("3".equals(iQrytype)){//变更
		System.out.println("==========3============");
		flag = "change";
%>

<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="0"/>
    <wtc:param value="<%=iChnSource%>"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=loginPwd%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="<%=userPwd%>"/>
    <wtc:param value="3"/>
    <wtc:param value="<%=iSaleType%>"/>
    <wtc:param value="<%=iOfferType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" start="0" length="2" />
<wtc:array id="result2" scope="end" start="2" length="2" />
<%
	System.out.println("====wanghfa==== result1.length = " + result1.length);
	System.out.println("====wanghfa==== result2.length = " + result2.length);
		System.out.println("result1.length="+result1.length);
		System.out.println("result2.length="+result2.length);
		//第一个返回信息
		if(result1.length > 0){
			for(int i=0;i<result1.length;i++){
				strBuffer.append("{'oldOfferId':'"+result1[i][0]+"','oldOfferName':'"+result1[i][1]+"'},");
			}
		}
		if(strBuffer.toString().endsWith(",")){
			strBuffer.deleteCharAt(strBuffer.toString().length()-1);
		}
		strBuffer.append("]}");	
		//第二个返回信息
		if(result2.length > 0){
			for(int i=0;i<result2.length;i++){
				bufferStr.append("{'newOfferId':'"+result2[i][0]+"','newOfferName':'"+result2[i][1]+"'},");
			}
		}
		if(bufferStr.toString().endsWith(",")){
			bufferStr.deleteCharAt(bufferStr.toString().length()-1);
		}
		bufferStr.append("]}");	
		retCode = retCode1;
		retMsg  = retMsg1;
		System.out.println("错误代码:"+retCode1+",错误内容："+retMsg1);
	}else if("2".equals(iQrytype)){//取消
		flag = "cancel";
		System.out.println("=======================================================2=========");
%>
<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="0"/>
    <wtc:param value="<%=iChnSource%>"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=loginPwd%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="<%=userPwd%>"/>
    <wtc:param value="2"/>
    <wtc:param value="<%=iSaleType%>"/>
    <wtc:param value="<%=iOfferType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
		if(result1.length > 0){
			for(int i=0;i<result1.length;i++){
				strBuffer.append("{'offerId':'"+result1[i][0]+"','offerName':'"+result1[i][1]+"'},");
			}
		}
		if(strBuffer.toString().endsWith(",")){
			strBuffer.deleteCharAt(strBuffer.toString().length()-1);
		}
		strBuffer.append("]}");
		retCode = retCode1;
		retMsg  = retMsg1;
		System.out.println("错误代码:"+retCode1+",错误内容："+retMsg1);	
	}
	System.out.println("====wanghfa==== strBuffer = " + strBuffer);
%>

var response = new AJAXPacket();
response.data.add("offerData","<%=strBuffer%>");
response.data.add("offerNum","<%=offerNum%>");
response.data.add("offerExpDate","<%=offerExpDate%>");

response.data.add("iOfferType","<%=iOfferType%>");
response.data.add("newOfferData","<%=bufferStr%>");
response.data.add("flag","<%=flag%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
