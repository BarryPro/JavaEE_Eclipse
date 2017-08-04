<%
  /*
   * 功能: 通知发送记录删除
　 * 版本: 1.0
　 * 日期: 2009/09/08
　 * 作者: guozw
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//通知发送记录删除
//获取参数
String workNo = (String)session.getAttribute("workNo");

String serialnum=request.getParameter("serialnum");

String getDCCContact_id = "select recordernum,objectid,contentid,plan_id,staffno,checkflag from dqcinfo where serialnum = :serialnum ";
myParams = "serialnum="+serialnum ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=getDCCContact_id%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
<wtc:array id="dCCContact_id" scope="end"/>
<%
String contact_id = "";
String objectid = "";   //考评对象id
String contentid = "";	//考评内容id
String plan_id = "";		//计划id
String staffno = "";		//被检工号
String checkflag = "";		//复核标识  0 为复核时产生的质检记录，-1为正常质检产生的记录

if(dCCContact_id.length!=0){
					contact_id = dCCContact_id[0][0];
					objectid = dCCContact_id[0][1];
					contentid = dCCContact_id[0][2];
					plan_id = dCCContact_id[0][3];
					staffno = dCCContact_id[0][4];
					checkflag = dCCContact_id[0][5];

}		
		 
/**old sql : String strCheck = "update dqcinfo set isremarkflag = '00'  where serialnum = '" + serialnum + "' ";
*/
String strCheck = "update dqcinfo set isremarkflag = '00' where serialnum = :v1 ";
%>
    
<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strCheck%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=serialnum%>"/>
	</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);