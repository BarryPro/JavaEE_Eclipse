<%
    /*************************************
    * 功  能: 判断奖品列表形式 2266
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-10-24
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String packetCode = WtcUtil.repStr(request.getParameter("resCode"), "");
	String num = WtcUtil.repStr(request.getParameter("num"), "");
	String resname = WtcUtil.repStr(request.getParameter("resname"), "");
	String operFlag = WtcUtil.repStr(request.getParameter("operFlag"), "");
	String upLoginAcc = WtcUtil.repStr(request.getParameter("upLoginAcc"), "");
	String regCode = (String)session.getAttribute("regCode");
	String tmpresCode = WtcUtil.repStr(request.getParameter("tmpresCode"), "");/*如含字母，将字母进行截取，值留有数字*/
		String isCard = WtcUtil.repStr(request.getParameter("isCard"), "");
			String isPackage = WtcUtil.repStr(request.getParameter("isPackage"), "");
			
				
	/*
	if("getAward".equals(operFlag)){
	  tmpresCode =packetCode.substring(1, packetCode.length()); 
	}else{
	  tmpresCode = packetCode;
	}*/
	System.out.println("-----2266--f2266_ajax_getQryCountNew.jsp----diling----------inParams[1]="+isPackage);
	String qryCountNum = "";
	String qrycountretcodess="000000";
	String qrycountretmsgss="成功";

  String  inParams [] = new String[2];
  if(isPackage.equals("1")) {
  inParams[0] = "select count(*) from dbgiftrun.RS_PROGIFT_PACKAGE_DETAIL a,dbgiftrun.RS_PROGIFT_PT_INFO b where a.res_code = b.res_code and a.package_code =:packetcode";
  inParams[1] = "packetcode="+tmpresCode;
  System.out.println("-----2266--f2266_ajax_getQryCount.jsp----diling----------inParams[0]="+inParams[0]);
  System.out.println("-----2266--f2266_ajax_getQryCount.jsp----diling----------inParams[1]="+inParams[1]);
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="qryCountRetCode" retmsg="qryCountRetMsg" outnum="1"> 
  <wtc:param value="<%=inParams[0]%>"/>
  <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(qryCountRetCode)){
    if(ret.length>0){
      qryCountNum = ret[0][0];
    }else{
      qryCountNum = "";
    }
  }else{
    qryCountNum = "";
  }
  qrycountretcodess=qryCountRetCode;
  qrycountretmsgss=qryCountRetMsg;
  System.out.println("-----2266--f2266_ajax_getQryCount.jsp----diling----------packetCode="+packetCode+"----截取后：tmpresCode="+tmpresCode);
  System.out.println("-----2266--f2266_ajax_getQryCount.jsp----diling----------qryCountNum="+qryCountNum);
  }
%>
var response = new AJAXPacket();
response.data.add("qryCountRetCode","<%=qrycountretcodess%>");
response.data.add("qryCountRetMsg","<%=qrycountretmsgss%>");
response.data.add("qryCountNum","<%=qryCountNum%>");
response.data.add("packetCode","<%=packetCode%>");
response.data.add("tmpresCode","<%=tmpresCode%>");
response.data.add("num","<%=num%>");
response.data.add("resname","<%=resname%>");
response.data.add("operFlag","<%=operFlag%>");
response.data.add("upLoginAcc","<%=upLoginAcc%>");
response.data.add("isCard","<%=isCard%>");
response.data.add("isPackage","<%=isPackage%>");

core.ajax.receivePacket(response);
 
	    