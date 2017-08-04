<%

   /*

   * 功能: 查询用户属性

　 * 版本: v1.0

　 * 日期: 2011、12、20

　 * 作者: wanghyd

　 * 版权: sitech

   * 修改历史

   * 修改日期      修改人      修改目的

 　*/

%>

<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ include file="/npage/common/portalInclude.jsp" %>

<%

     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     String phone_no = (String)request.getParameter("activePhone");
     String workNo = (String)session.getAttribute("workNo");
	   String nopass = (String)session.getAttribute("password");
     System.out.println("phone_no = "+phone_no);
     String xinyongdengji="";
		String smzflag ="";	
		String smzname ="";

  	String[] inParamsss2 = new String[2];
		inParamsss2[0] = "select to_char(a.TRUE_CODE) from dTrueNamemsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phonesNO ";
		inParamsss2[1] = "phonesNO="+phone_no;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust2" scope="end" />
<%
	if(dcust2.length>0) {
			smzflag=dcust2[0][0];
			
			if(smzflag.equals("1")) {
					smzname="实名";
			}
			if(smzflag.equals("2")) {
					smzname="准实名";
			}
			if(smzflag.equals("3")) {
					smzname="非实名";
			}
	}
%>



<div id="form" align="center">

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="list" >

  	<tr>

  	  <td width=30%><b><span class="orange">实名状态</span></b></td>
			<%if(smzflag.equals("3")){%>
  	  <td width=70% style="color:red;font-weight:bold"><%=smzname%></td>
<%}else {%>
	<td width=70% ><%=smzname%></td>
	<%}%>
  	</tr>

 
  </table>

</div>

<script>

$("#wait5").hide();		   

</script>