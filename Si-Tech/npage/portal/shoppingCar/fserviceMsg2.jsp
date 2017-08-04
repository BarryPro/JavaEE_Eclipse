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



  String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select to_char(id_no) from dcustmsg where phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+phone_no;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />

<wtc:service name="sQryUserGrade" outnum="3" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
	   <wtc:param value=""/>
		 <wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
	    <wtc:param value=""/>
	    <wtc:param value=""/>
	  	<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=dcust[0][0]%>"/>

</wtc:service>

<wtc:array id="result"  scope="end" />
<%
if(retCode.equals("000000"))
{
     if(result.length>0){
        xinyongdengji=result[0][0];

     } 
    else {
    	xinyongdengji=retMsg;
    } 


}else{
	xinyongdengji=retMsg;
	}



%>

<div id="form" align="center">

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="list" >

  	<tr>

  	  <td width=30%><b><span class="orange">信用等级</span></b></td>

  	  <td width=70%><%=xinyongdengji%></td>

  	</tr>

 
  </table>

</div>

<script>

$("#wait5").hide();		   

</script>