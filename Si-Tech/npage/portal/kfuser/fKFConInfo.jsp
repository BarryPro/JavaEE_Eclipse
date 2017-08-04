<%
   /*
   * 功能: 帐户基本资料
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
     
     
	String contract_no  = new String();
	String cust_name    = new String();
	String type_name    = new String();
	String payed_status = new String();
	String move_money   = new String();
	String post_sign    = new String();
	String min_ym       = new String();
	String pay_nameall  = new String();
	String owe_fee      = new String();     
     
%>
<wtc:service name="sKFConInfo_new" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
if(retCode.equals("000000")){
       if(result.length>0){
			contract_no  = result[0][0];
			cust_name    = result[0][1];
			type_name    = result[0][2];
			payed_status = result[0][3];
			move_money   = result[0][4];
			post_sign    = result[0][5];
			min_ym       = result[0][6];
			pay_nameall  = result[0][7];
			owe_fee      = result[0][8];   
           }
     }
%>
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
		 <link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
  <div id="content">
							<div class="table_biaoge">
						<table cellpadding="0" cellspacing="0">
						 <tr class="jiange">
						   <td width="30%">帐户编号：</td>
						   <td width="70%"><%=contract_no.trim().equals("")?"&nbsp;":contract_no%></td>
						</tr>
						<tr class="jiange">
						   <td>帐户名称：</td>
						   <td><%=cust_name.trim().equals("")?"&nbsp;":cust_name%></td>
						</tr>
						<tr class="jiange">
						   <td>帐户类型名称：</td>
						   <td><%=type_name.trim().equals("")?"&nbsp;":type_name%></td>
						</tr>
						<tr class="jiange">
						   <td>欠费标志：</td>
						   <td><%=payed_status.trim().equals("")?"&nbsp;":payed_status%></td>
						</tr>
						<tr class="jiange">
						   <td>押金：</td>
						   <td><%=move_money.trim().equals("")?"&nbsp;":move_money%></td>
						</tr>
						<tr class="jiange">
						   <td>邮寄标志：</td>
						   <td><%=post_sign.trim().equals("")?"&nbsp;":post_sign%></td>
						</tr>
						<tr class="jiange">
						   <td>最小付费年月：</td>
						   <td><%=min_ym.trim().equals("")?"&nbsp;":min_ym%></td>
						</tr>
						<tr class="jiange">
						   <td>付费方式名称：</td>
						   <td><%=pay_nameall.trim().equals("")?"&nbsp;":pay_nameall%></td>
						</tr>
						<tr class="jiange">
							<%
							// xingzhan 20090220 19:33 正数为预存 负数为欠费(把负号去掉)
						   double d = Double.parseDouble(owe_fee.trim());
						   
						   if(d>=0){
						   		
						   		%>
						   		<td>欠费：</td>
						   		<td><%=owe_fee.trim().equals("")?"&nbsp;":owe_fee%></td>
						   		<%
						   }else{
							%>
						   <td>预存款：</td>
						   <td><%=d*-1%></td>
						   <%
						   }
						   ///////////////////////////////////////
						   %>
						</tr>
					  </table>
					  </div>
			</div>
