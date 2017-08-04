<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	    /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	  String receive_login_no     = WtcUtil.repNull(request.getParameter("receive_login_no"));
	  
	  //吉林登陆为统一boss工号登陆，修改工号判断的列，改为判断boss工号 by fangyuan 20090825
	  //String sqlStr = "select count(*) from dstaffstatus where ccsworkno='"+receive_login_no+"'";
	  String sqlStr = "select to_char(count(*)) from dstaffstatus where login_no=:receive_login_no";
	  myParams = "receive_login_no="+receive_login_no ;
	  String counts="0";
  
%>
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	       <wtc:param value="<%=sqlStr%>" />
	       <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
       <wtc:array id="queryList"  scope="end"/>
 <%
 if(queryList.length>0){
   counts=queryList[0][0];
 }
 		//修改以适应吉林的boss工号统一登录方式 by fangyuan 20090825
 	  //sqlStr = "select count(*) from dloginmsg where login_no = (select boss_login_no from dloginmsgrelation where trim(kf_login_no)='"+receive_login_no+"') ";
	  sqlStr = "select a.KF_LOGIN_NO "+
    					"from dloginmsgrelation a "+
              "where exists "+
                      "(select b.login_no from dloginmsg b "+
                      "where b.login_no =:receive_login_no and a.BOSS_LOGIN_NO=b.LOGIN_NO)";
	  myParams = "receive_login_no="+receive_login_no ;
	  String loginExist="0";
	//  System.out.println("sqlStr="+sqlStr);
%>
	     <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	       <wtc:param value="<%=sqlStr%>" />
	       <wtc:param value="<%=myParams%>"/>
	     </wtc:service>
       <wtc:array id="queryList1"  scope="end"/>
 <%
 if(queryList1.length>0){
   loginExist=queryList1[0][0];
 }
 %>
 
 
var response = new AJAXPacket();
response.data.add("counts",<%=counts%>);
response.data.add("loginExist",<%=loginExist%>);
core.ajax.receivePacket(response);
