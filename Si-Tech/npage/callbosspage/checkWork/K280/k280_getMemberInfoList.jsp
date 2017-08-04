<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->ajax获取成员信息
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	/*midify by guozw 20091114 公共查询服务替换*/
	 String myParams="";
	 String org_code = (String)session.getAttribute("orgCode");
	 String regionCode = org_code.substring(0,2); 
	
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));   

	String sqlStr = "select t1.login_group_id,t.login_group_name,t1.login_no,b.login_name ";
    sqlStr += "from  DQCLOGINGROUP t,DQCLOGINGROUPLOGIN t1,dloginmsg b, dloginmsgrelation c ";
    sqlStr += " where t1.login_group_id=t.login_group_id and t1.login_no = c.BOSS_LOGIN_NO and c.BOSS_LOGIN_NO = b.LOGIN_NO";
    sqlStr += " and t1.valid_flag='Y'  and t.is_del='N' ";
    
	if("0".equalsIgnoreCase(flag)){
		sqlStr+=" and t1.login_no like ''||:loginNo||'%'";
		myParams = "loginNo="+loginNo ;
	}
	if("1".equalsIgnoreCase(flag)){
		sqlStr+="and b.login_name like ''||:loginNo||'%'";
		myParams = "loginNo="+loginNo ;
	}
	
	//System.out.println("###################################");
	//System.out.println(sqlStr);
	//System.out.println("###################################");
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="4">
	<wtc:param value="<%=sqlStr%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="4">
var nodes = new Array();
<%
	for (int i = 0; i < resultList.length; i++) {
%>
    var tmpArr = new Array();
	<%
		for (int j = 0; j < resultList[i].length; j++) {
	%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%
		}
	%>
	nodes[<%=i%>] = tmpArr;
<%
	}
%>
var response = new AJAXPacket();
response.data.add("loginNoList",nodes);
core.ajax.receivePacket(response);
</wtc:array>