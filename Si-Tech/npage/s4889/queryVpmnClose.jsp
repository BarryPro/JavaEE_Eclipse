<%
/*****************************
 * 模块名称：智能网闭合群综合查询
 * 程序版本：version 1.0
 * 开 发 商: SI-TECH
 * 作    者: shengzd
 * 创建时间: 2010-05-12
 *****************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
  	String retType = WtcUtil.repNull((String)request.getParameter("retType"));
  	String iOpType = WtcUtil.repNull((String)request.getParameter("op_type"));
  	String iUnitId = WtcUtil.repNull((String)request.getParameter("unit_id"));
  	String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmn_grp_no"));
  	String retCode = "";
  	String retMessage = "";
%>
    <wtc:service name="s4889Qry" retcode="retCode1" retmsg="retMsg1" outnum="5" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=workNo%>"/>
    	<wtc:param value="<%=iOpType%>"/>
        <wtc:param value="<%=iUnitId%>"/>
        <wtc:param value="<%=iVpmnGrpNo%>"/>
        <wtc:param value=""/>
    </wtc:service>
    <wtc:array id="retArr1" scope="end"/>
<%
    retCode = retCode1;
    retMessage = retMsg1;
	  String[][] colNameArr = retArr1;	
    String strArray = WtcUtil.createArray("colNameArr",colNameArr.length);
    System.out.println(strArray);
%>
    <%=strArray%>
<%
for(int i = 0 ; i < colNameArr.length ; i ++){
    for(int j = 0 ; j < colNameArr[i].length; j ++){
        System.out.println(colNameArr[i][j].trim());
    %>
        colNameArr[<%=i%>][<%=j%>] = "<%=colNameArr[i][j].trim()%>";
    <%
    }
}
%>
	var response = new AJAXPacket();
	var retType = "";
	var retCode = "";
	var retMessage = ""
	
	retType = "<%=retType%>";
	retCode = "<%=retCode%>";
	retMessage = "<%=retMessage%>";
	
	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);
	response.data.add("vpmnCloseArr",colNameArr);
	core.ajax.receivePacket(response);
