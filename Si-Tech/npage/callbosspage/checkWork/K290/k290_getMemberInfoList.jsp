<%
  /*
   * 功能: 质检权限管理->维护质检员和组->ajax获取成员信息
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
	
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));

    String sqlStr = "select t1.check_group_id,t.group_name,t1.check_login_no,b.login_name ";
         sqlStr+=" from  dqccheckgroup t,dqccheckgrouplogin t1, dloginmsg b, dloginmsgrelation c ";
         //modified by liujied 20090923
         sqlStr+=" where t1.check_group_id=t.check_group_id and t1.check_login_no = c.BOSS_LOGIN_NO and c.BOSS_LOGIN_NO = b.LOGIN_NO "+
         "and t1.valid_flag='Y'  and t.is_del='N'  ";
    
	if("0".equalsIgnoreCase(flag)){
		sqlStr+=" and t1.check_login_no like ''||:loginNo||'%' ";
		myParams = "loginNo="+loginNo ;
	}
	if("1".equalsIgnoreCase(flag)){
		sqlStr+="and b.login_name like ''||:loginNo||'%' ";
		myParams = "loginNo="+loginNo ;
	}

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