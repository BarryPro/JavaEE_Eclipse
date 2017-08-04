<%
   /*
   * 功能:大客户资料信息
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
	String phone_no = (String)session.getAttribute("activePhone");     
	
	String return_code    = new String();
	String vphone_no       = new String();
	String email_address  = new String();
	String service_no     = new String();
	String vip_no         = new String();
	String remember_date  = new String();
	String owner_name     = new String();
	String limit_name     = new String();
	String big_code       = new String();
	String unit_name      = new String();
	String work_type      = new String();
	String ent_type       = new String();
	String unit_address   = new String();
	String owner_zip      = new String();
	String contact_phone  = new String();
	String fax            = new String();
	String name_phone     = new String();
	String contact_person = new String();
	String login_name     = new String();
	String region_char    = new String();     
%>
<wtc:service name="sHW_bigQuery" outnum="20" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
 System.out.println("fbigQuery.jsp__retCode:"+retCode);
if(retCode.equals("0000")){
    System.out.println("libina  1");
       if(result.length>0){
        System.out.println("libina  2");
			return_code    = result[0][0];
			phone_no       = result[0][1];
			email_address  = result[0][2];
			service_no     = result[0][3];
			vip_no         = result[0][4];
			remember_date  = result[0][5];
			owner_name     = result[0][6];
			limit_name     = result[0][7];
			big_code       = result[0][8];
			unit_name      = result[0][9];                                 
			work_type      = result[0][10];                                 
			ent_type       = result[0][11];                                 
			unit_address   = result[0][12];                                 
			owner_zip      = result[0][13];                                 
			contact_phone  = result[0][14];                                 
			fax            = result[0][15];                                 
			name_phone     = result[0][16];                                 
			contact_person = result[0][17];                                 
			login_name     = result[0][18];                                 
			region_char    = result[0][19];                                    
           }                     
     }   
     System.out.println(result[0][16]);                        
%>	        
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
                     
<div id="content">               
	<div class="table_biaoge">
		<table cellpadding="0" cellspacing="0">
			<tr class="jiange">
				<td width="30%">email地址：</td>
				<td width="20%"><%=email_address.trim().equals("")?"&nbsp;":email_address%></td>
				<td width="30%">集团编号：</td>
				<td width="20%"><%=big_code.trim().equals("")?"&nbsp;":big_code%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">客户经理工号：</td>
				<td width="20%"><%=service_no.trim().equals("")?"&nbsp;":service_no%></td>
				<td width="30%">集团名称：</td>
				<td width="20%"><%=unit_name.trim().equals("")?"&nbsp;":unit_name%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">大客户经理信息：</td>
				<td width="20%"><%=name_phone.trim().equals("")?"&nbsp;":name_phone%></td>
				<td width="30%">集团所属行业：</td>
				<td width="20%"><%=work_type.trim().equals("")?"&nbsp;":work_type%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">VIP卡号 ：</td>
				<td width="20%"><%=vip_no.trim().equals("")?"&nbsp;":vip_no%></td>
				<td width="30%">企业类型：</td>
				<td width="20%"><%=ent_type.trim().equals("")?"&nbsp;":ent_type%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">纪念日：</td>
				<td width="20%"><%=remember_date.trim().equals("")?"&nbsp;":remember_date%></td> 
				<td width="30%">企业通信地址：</td>
				<td width="20%"><%=unit_address.trim().equals("")?"&nbsp;":unit_address%></td>
			</tr>
			<tr class="jiange">
				<td width="30%"> 消费等级：</td>
				<td width="20%"><%=owner_name.trim().equals("")?"&nbsp;":owner_name%></td> 
				<td width="30%">企业邮政编码：</td>
				<td width="20%"><%=owner_zip.trim().equals("")?"&nbsp;":owner_zip%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">贵宾卡级别：</td>
				<td width="20%"><%=limit_name.trim().equals("")?"&nbsp;":limit_name%></td> 
				<td width="30%">企业联系电话：</td>
				<td width="20%"><%=contact_phone.trim().equals("")?"&nbsp;":contact_phone%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="30%">企业传真电话：</td>
				<td width="20%"><%=fax.trim().equals("")?"&nbsp;":fax%></td>
			</tr>
			<tr class="jiange">
				<td width="30%">&nbsp;</td>
				<td width="20%">&nbsp;</td>
				<td width="30%">企业联系人姓名：</td>
				<td width="20%"><%=contact_person.trim().equals("")?"&nbsp;":contact_person%></td>
			</tr>
		</table>
	</div>
</div>
