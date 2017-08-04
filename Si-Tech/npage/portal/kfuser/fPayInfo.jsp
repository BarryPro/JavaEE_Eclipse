<%
   /*
   * 功能: 付费信息
　 * 版本: v1.0
　 * 日期: 2008/09/12
　 * 作者: ranlf
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
     String workNo = (String)session.getAttribute("workNo");
     String password = (String)session.getAttribute("password");
     String phoneNo  = (String)session.getAttribute("activePhone");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
%>
<wtc:service name="sKFPayInfo_new" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
	<div class="table_biaoge">
	<table width="100%" cellpadding="0" cellspacing="0">
  	<tr> 
    	<th>付费类型</th>
			<th>服务号码</th>
			<th>客户姓名</th>
			<th>付费项目</th>
			<th>付费额度</th>
			<th>有效时间</th>
	  </tr>
<%	  
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>             
	       <td><%=result[i][0]==null||result[i][0].equals("")?" ":result[i][0]%></td>
	       <td><%=result[i][1]==null||result[i][1].equals("")?" ":result[i][1]%></td>
	       <td><%=result[i][2]==null||result[i][2].equals("")?" ":result[i][2]%></td>
	       <td><%=result[i][3]==null||result[i][3].equals("")?" ":result[i][3]%></td>
	       <td><%=result[i][4]==null||result[i][4].equals("")?" ":result[i][4]%></td>
	       <td><%=result[i][5]==null||result[i][5].equals("")?" ":result[i][5]%></td>
	     </tr>
<%
	  	}
	}
}
%>	
     </table>
	 </div>
        </div>


