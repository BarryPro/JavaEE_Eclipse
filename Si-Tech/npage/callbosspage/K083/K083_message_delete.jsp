<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/15
　 * 作者: fengliang
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));

	String sqlStr = "update DMESSAGEMODEL_CON set is_del='Y' "+
					"where trim(msg_mod_id) = :v1&&"+item_id.trim();
					
	String sqlStr2 = "select count(msg_mod_id) from DMESSAGEMODEL_CON where trim(msg_mod_par_id) =:v1  and is_del='N'";
	
  	String sqlStr1 = "update DMESSAGEMODEL_CON set msg_leaf_flag='Y' where trim(msg_mod_id) = :v1 and is_del='N'&&"+ parentItem_id.trim(); 
  	
  String[] sqlStrs = null;
   
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqlStr2%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=parentItem_id.trim()%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
		int leafCount = 0;
		if(queryList.length>0){
				
	  		leafCount = Integer.parseInt(queryList[0][0]);
		}
%>	
<%
	if(leafCount<=1&&!("0".equals(parentItem_id.trim()))){
		sqlStrs = new String[]{sqlStr,sqlStr1};
	} else{
		sqlStrs = new String[]{sqlStr};
	}
	%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("leafCount","<%=leafCount%>");
response.data.add("parentItem_id","<%=parentItem_id%>");
core.ajax.receivePacket(response);

