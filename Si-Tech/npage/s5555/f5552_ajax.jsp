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
	String sql = "select table_name,owner_name,ol_use_flag,ol_store_flag,need_clean,clean_stime,clean_freq,back_type,back_add_type,back_path,back_ind_type,back_ana_type,clean_type,clean_add_type,clean_desc,clean_ol_behave,need_docum,docum_stime,docu_store_type,docu_store_time from CTABLECLEANMSG  where table_name=UPPER('"+table_name+"') and owner_name=UPPER('"+owner_name+"')";
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
