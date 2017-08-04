<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

//通知发送记录删除
//获取参数
    /*midify by yinzx 20091113 公共查询服务替换*/
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String msg_id=request.getParameter("msg_id");

String strSql = "select  t.login_no,t.login_name,t1.kf_login_no from  dloginmsg t ,dloginmsgrelation t1 where t.login_no=t1.boss_login_no ";  
  
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
<wtc:params value="<%=strSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retRows",<%=retRows%>);
core.ajax.receivePacket(response);