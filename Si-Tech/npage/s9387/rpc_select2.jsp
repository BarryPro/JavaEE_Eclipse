<%
  /*
   * 功能: 查询sql，返回值个数为：3
   * 版本: 1.8.2
   * 日期: 2011/2/28
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = "01";
	String sql = request.getParameter("sql");
	String sqlParam = request.getParameter("sqlParam");
	String shu = request.getParameter("shu");
	String rpc_flag = WtcUtil.repStr(request.getParameter("rpc_flag")," ");
  String [] params = sqlParam.split("\\|");
	
	System.out.println("sql="+sql);
%>
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retResult" retmsg="retMsg" outnum="3">
		  <wtc:param value="<%=sql%>"/>
		 <%
		 		for(int i=0;i<params.length;i++){
		 %>		
		 		 <wtc:param value="<%=params[i]%>"/>
		 	<%
		 		}
		 %>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
var _code = new Array();
var _text = new Array();
var _offer_id = new Array();
<%
for(int outter = 0 ; result1 != null && outter < result1.length; outter ++)
{
%>
	_code[<%=outter%>] = "<%=result1[outter][0]%>";
	_text[<%=outter%>] = "<%=result1[outter][1]%>";
	_offer_id[<%=outter%>] = "<%=result1[outter][2]%>";
<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("retMsg","00001");
response.data.add("code",_code);
response.data.add("text",_text);
response.data.add("offer_id",_offer_id);
response.data.add("rpc_flag","<%=rpc_flag%>");
response.data.add("shu","<%=shu%>");
core.ajax.receivePacket(response);

