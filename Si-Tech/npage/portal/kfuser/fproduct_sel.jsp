<%
   /*
   * 功能: 查询用户产品信息
　 * 版本: v1.0
　 * 日期: 2008年4月17日
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
     String phone_no = (String)session.getAttribute("activePhone");
%>

<wtc:service name="sKFProdInfo_new" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<div  id="form">
 <div class="table_biaoge"   style="overflow:auto">
	<table width="100%" class="ctl" cellpadding="0" cellspacing="0" style='width:770px;'>
	    <tr> 
		    <th width="10%">类型</th>
				<th width="10%">产品代码</th>
				<th width="10%">产品名称</th> 
				<th width="40%">产品有效时间</th> 
				<th width="10%">操作工号</th> 
				<th width="20%">操作时间</th> 
	    </tr>
	    <tr>
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>             
	       <td title="<%=result[i][0]%>" ><%=(("").equals(result[i][0])||result[i][0]==null)?"&nbsp;":result[i][0]%></td>
	       <td title="<%=result[i][1]%>" ><%=(("").equals(result[i][1])||result[i][1]==null)?"&nbsp;":result[i][1]%></td>
	       <td title="<%=result[i][2]%>" ><%=(("").equals(result[i][2])||result[i][2]==null)?"&nbsp;":result[i][2]%></td>
	       <td title="<%=result[i][3]%>" ><%=(("").equals(result[i][3])||result[i][3]==null)?"&nbsp;":result[i][3]%></td>
	       <td title="<%=result[i][4]%>" ><%=(("").equals(result[i][4])||result[i][4]==null)?"&nbsp;":result[i][4]%></td>
	       <td title="<%=result[i][5]%>" ><%=(("").equals(result[i][5])||result[i][5]==null)?"&nbsp;":result[i][5]%></td>
	     </tr>
<%
	  }
	 }
}
		%>
	</table>
</div>
</div>
