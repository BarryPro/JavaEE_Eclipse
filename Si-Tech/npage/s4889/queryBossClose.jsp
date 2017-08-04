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
  	String iVpmnGrpNo = WtcUtil.repNull((String)request.getParameter("vpmn_grp_no"));
  	String iUnitId = WtcUtil.repNull((String)request.getParameter("unit_id"));
  	String sqlStr = "SELECT CLOSE_NO,CLOSE_NAME,FEE_INDEX,MAX_USER_NUM,(SELECT COUNT(*) FROM DCLOSEMEBMSG B WHERE B.CLOSE_NO = A.CLOSE_NO) FROM DCLOSEGRPMSG A WHERE VPMN_NO = " + iVpmnGrpNo +" AND UNIT_ID = "+ iUnitId +"ORDER BY CLOSE_NO";
  	String retCode = "";
  	String retMessage = "";
  	System.out.println("\n\n# 查询BOSS侧闭合群信息："+sqlStr+"\n\n");
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="5" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
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
	response.data.add("bossCloseArr",colNameArr);
	core.ajax.receivePacket(response);
