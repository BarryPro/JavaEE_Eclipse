<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghfa@2010-8-16 校验密码是否正确
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String workNo = WtcUtil.repStr(request.getParameter("workNo"),"");	//工号
String opCode = WtcUtil.repStr(request.getParameter("opCode"),"");	//功能代码
int popedomNo = 0;
System.out.println("====pubCheckPopedom.jsp====wanghfa====检查是否有权限====" + workNo + opCode);

String sql = "select *"
	 +" from (SELECT c.popedom_code, c.reflect_code, c.order_code"
	 +" FROM sPopeDomCode a,"
	 +" sPopeDomInfo b,"
	 +" sPopeDomCode c,"
	 +" sLoginPdomRelation d,"
	 +" sPopedomInfo e"
	 +" WHERE a.reflect_code = '99999'"
	 +" AND a.popedom_code = b.par_domcode"
	 +" AND b.dom_level <= 999"
	 +" AND b.dom_level > 0"
	 +" AND b.popedom_code = c.popedom_code"
	 +" AND c.PDT_CODE = '05'"
	 +" AND c.use_flag = 'Y'"
	 +" AND c.popedom_code = e.par_domcode"
	 +" AND d.popedom_code = e.popedom_code"
	 +" AND d.login_no = '" + workNo +"'"
	 +" AND d.rela_type = '0'"
	 +" AND SYSDATE BETWEEN d.begin_date AND d.end_date"
	 +" UNION ALL"
	 +" SELECT c.popedom_code, c.reflect_code, c.order_code"
	 +" FROM sPopeDomCode a,"
	 +" sPopeDomInfo b,"
	 +" sPopeDomCode c,"
	 +" sLoginRoalRelation d,"
	 +" sRolePdomRelation e"
	 +" WHERE a.reflect_code = '99999'"
	 +" AND a.popedom_code = b.par_domcode"
	 +" AND b.dom_level <= 999"
	 +" AND b.dom_level > 0"
	 +" AND b.popedom_code = c.popedom_code"
	 +" AND c.PDT_CODE = '05'"
	 +" AND c.use_flag = 'Y'"
	 +" AND d.login_no = '" + workNo +"'"
	 +" AND SYSDATE BETWEEN d.begin_date AND d.end_date"
	 +" AND d.role_code = e.role_code"
	 +" AND b.popedom_code = e.popedom_code"
	 +" UNION ALL"
	 +" SELECT c.popedom_code, c.reflect_code, c.order_code"
	 +" FROM sPopeDomCode a,"
	 +" sPopeDomInfo b,"
	 +" sPopeDomCode c,"
	 +" DTmpLOGINPDOMRELATION d,"
	 +" sPopedomInfo e"
	 +" WHERE a.reflect_code = '99999'"
	 +" AND a.popedom_code = b.par_domcode"
	 +" AND b.dom_level <= 999"
	 +" AND b.dom_level > 0"
	 +" AND b.popedom_code = c.popedom_code"
	 +" AND c.PDT_CODE = '05'"
	 +" AND c.use_flag = 'Y'"
	 +" AND c.popedom_code = e.par_domcode"
	 +" AND d.popedom_code = e.popedom_code"
	 +" AND d.login_no = '" + workNo +"'"
	 +" and ((d.end_date > sysdate and d.allow_count = 0) or"
	 +" (d.end_date > sysdate and d.allow_count > d.op_count))"
	 +" MINUS"
	 +" SELECT c.popedom_code, c.reflect_code, c.order_code"
	 +" FROM sLoginPdomRelation a, sPopeDomInfo b, sPopeDomCode c"
	 +" WHERE a.login_no = '" + workNo +"'"
	 +" AND a.rela_type = '1'"
	 +" AND SYSDATE BETWEEN a.begin_date AND a.end_date"
	 +" AND a.popedom_code = b.par_domcode"
	 +" AND b.popedom_code = c.popedom_code)"
	 +" where reflect_code='" + opCode + "'";

System.out.println("====wanghfa==== sql =" + sql);
%> 
	<wtc:pubselect name="sPubSelect" outnum="3" retmsg="retMsg1" retcode="retCode1">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="popedomResult" scope="end" />
<%
	System.out.println("====pubCheckPopedom.jsp====wanghfa==== " + retMsg1 + retCode1 + "," + popedomResult.length);
	if ("000000".equals(retCode1) && popedomResult.length > 0) {
		popedomNo = popedomResult.length;
		for (int i = 0; i < popedomResult.length; i ++ ) {
			System.out.println("====pubCheckPopedom.jsp====wanghfa==== popedomResult[i][0] =" + popedomResult[i][0]);
		}
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("popedomNo","<%=popedomNo%>");

core.ajax.receivePacket(response);
