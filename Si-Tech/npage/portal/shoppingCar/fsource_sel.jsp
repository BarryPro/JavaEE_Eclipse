<%
   /*
   * 功能: 查询用户资源占用
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

<%@ include file="/npage/common/portalInclude.jsp" %>

<%
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     //String phone_no = (String)session.getAttribute("activePhone");
     String phone_no = (String)request.getParameter("activePhone");
     System.out.println("phone_no = "+phone_no);
     
     String sim_no    	="";
     String switch_no   ="";
     String kim_phone   ="";
%>

<wtc:service name="sIndexSource" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />
<wtc:array id="result1" start="2" length="1" scope="end" />
<%

if(retCode.equals("000000"))
{
     if(result.length>0){
        sim_no   =result[0][0];
        switch_no=result[0][1];
     }  
     
     System.out.println("result1.length=="+result1.length);
     for(int i=0;i<result1.length;i++)
     {
     	 //System.out.println("result[i][2]=="+result1[i][0]);
     	 if(result1[i][0]!=null)
     	 {
     	     kim_phone =kim_phone+result1[i][0]+",";
     	 }
     	 else
     	 {
     	       kim_phone="无";
     	 }
     	 if ( ((i + 1)%3 == 0) && (i>1) )
		 {
		     kim_phone = kim_phone + "<br/>&nbsp;";
     	 } 	   
    }
}

%>
<div id="form" align="center">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="list" >
  	<tr>
  	  <td width=30%><b><span class="orange">SIM卡号</span></b></td>
  	  <td width=70%><%=sim_no%></td>
  	</tr>
  	<tr>
  	  <td><b><span class="orange">IMSI编号</span></b></td>
  	  <td><%=switch_no%></td>
  	</tr>
  	<tr>
  	  <td><b><span class="orange">亲情号码</span></b></td>
  	  <td><%=kim_phone%></td>
  	</tr>
  </table>
</div>
<script>
$("#wait4").hide();		   
</script>