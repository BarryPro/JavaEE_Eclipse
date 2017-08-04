<%
  /*
   * 功能: 数据库信息表
   * 版本: 0.9
   * 日期: 2009/04/01
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regionCode");
	String owner_name  = request.getParameter("owner_name");
	String table_name  = request.getParameter("table_name");
	String strArray="var arrMsg; "; 
	String sql = "select table_name,owner_name,app_belong,table_space,table_type,create_login,busi_login,busi_desc,key_info,struc_main_type,busi_crtime,space_msize,use_type,offline_use_flag,data_bus_time,need_clean,back_use_target,back_use_demand,back_use_support,back_use_mathod from dTableInfoMsg  where table_name=UPPER('"+table_name+"') and owner_name=UPPER('"+owner_name+"')";
	System.out.println("sql="+sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="20">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
	String custId ="";
	if(retCode.equals("000000")){
		strArray = WtcUtil.createArray("arrMsg",result.length);
	}else{
		retCode = "000001";
		retMsg  = "数据清理控制表！！";
	}
%>
<%=strArray%>
<%
for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){

if(result[i][j].trim().equals("") || result[i][j] == null){
   result[i][j] = "";
}
System.out.println("||---------" + result[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
<%
  }
}
%>
var response = new AJAXPacket();
var retCode  = "<%=retCode%>";
var retMsg   = "<%=retMsg%>";
var retType  = "1";
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg" ,"<%=retMsg%>");
response.data.add("owner_name","<%=owner_name%>");
response.data.add("table_name" ,"<%=table_name%>");
response.data.add("retType",retType);
response.data.add("arrMsg",arrMsg);
core.ajax.receivePacket(response);
