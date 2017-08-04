<%
   /*
   * 功能: 集团信息
　 * 版本: v1.0
　 * 日期: 2008/03/30
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>


<%
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     String phone_no   =  WtcUtil.repNull(request.getParameter("activePhone"));
     String workNo = (String) session.getAttribute("workNo");
     String loginNoPass = (String)session.getAttribute("password");
     System.out.println("phone_no = "+phone_no);
     
     String grpnamess    	="";
     String khjlnames   ="";
     String lxdhphones   ="";
%>

 <wtc:service name="sGrpCustMgrQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6"> 
  <wtc:param value=""/>
  <wtc:param value="01"/>
  <wtc:param value="1500"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginNoPass%>"/>
  <wtc:param value="<%=phone_no%>"/>
  <wtc:param value=""/>
  </wtc:service>  
  <wtc:array id="resultss"  scope="end"/>

<%

if(retCode.equals("000000"))
{
     if(resultss.length>0){
				grpnamess=resultss[0][3];
				khjlnames=resultss[0][0];
				lxdhphones=resultss[0][2];
     }  
     

}

%>
<div id="form" align="center">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="list" >
  	<tr>
  	  <td width=30%><b><span class="orange">集团名称</span></b></td>
  	  <td width=70%><%=grpnamess%></td>
  	</tr>
  	<tr>
  	  <td><b><span class="orange">客户经理姓名</span></b></td>
  	  <td><%=khjlnames%></td>
  	</tr>
  	<tr>
  	  <td><b><span class="orange">联系电话</span></b></td>
  	  <td><%=lxdhphones%></td>
  	</tr>
  </table>
</div>
<script>
$("#wait7").hide();		   
</script>