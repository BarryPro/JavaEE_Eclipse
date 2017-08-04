<%
	/*
	* 功能: 新增用户接触
　 * 版本: 1.0
　 * 日期: 20100308
　 * 作者: songjia
　 * 版权: sitech
	*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<html>
<head>
<title>新增客户接触</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>


<script language="javascript">
	
	function submitMe(){
		if(document.sitechform.accept_phone.value=="")
		{
			showTip(document.sitechform.accept_phone,"受理号码不能为空");
			document.sitechform.accept_phone.onfocus();
			return;
		}
		else if(document.sitechform.servicecity.value=="")
		{
			showTip(document.sitechform.servicecity,"请选择业务地市");
			document.sitechform.servicecity.onfocus();
			return;
		}
    else{
         hiddenTip(document.sitechform.contact_phone);
         hiddenTip(document.sitechform.servicecity);
    	}
		var contactId=window.opener.getContactId_new();
		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/6777/contactWin_do.jsp","正在添加接触,请稍候...");
		chkInfoPacket.data.add("contactId" ,  contactId);
		chkInfoPacket.data.add("accept_phone" ,  document.sitechform.accept_phone.value);
		chkInfoPacket.data.add("servicecity" ,  document.sitechform.servicecity.value);
		chkInfoPacket.data.add("acc_long" ,  document.sitechform.acc_long.value);
		chkInfoPacket.data.add("contact_way" ,  document.sitechform.contact_way.value);
		chkInfoPacket.data.add("language" ,  document.sitechform.language.value);
		chkInfoPacket.data.add("brand_name" ,  document.sitechform.brand_name.value);
		chkInfoPacket.data.add("brand_grade" ,  document.sitechform.brand_grade.value);
		chkInfoPacket.data.add("region_code" ,  document.sitechform.region_code.value);
		chkInfoPacket.data.add("cust_name" ,  document.sitechform.cust_name.value);
		chkInfoPacket.data.add("fax_no" ,  document.sitechform.fax_no.value);
		chkInfoPacket.data.add("mail_address" ,  document.sitechform.mail_address.value);
		chkInfoPacket.data.add("cust_phone" ,  document.sitechform.cust_phone.value);
		chkInfoPacket.data.add("cust_addr" ,  document.sitechform.cust_addr.value);
		chkInfoPacket.data.add("bak" ,  document.sitechform.bak.value);
		core.ajax.sendPacket(chkInfoPacket,dosubmit);
		chkInfoPacket =null;
	}
	function dosubmit(packet)
	{
	    var retType = packet.data.findValueByName("retCode");
	   
	    if(retType=="00001")
      {
      	rdShowMessageDialog("新增用户接触失败！",2); 
      }
      else{
      	rdShowMessageDialog("新增用户接触成功！"); 
      	document.sitechform.accept_phone.value="";
      	document.sitechform.servicecity.value="";
      	document.sitechform.acc_long.value="0";
      	document.sitechform.contact_way.value="";
      	document.sitechform.language.value="";
      	document.sitechform.brand_name.value="";
      	document.sitechform.brand_grade.value="";
      	document.sitechform.brand_name.value="";
      	document.sitechform.region_code.value="";
      	document.sitechform.cust_name.value="";
      	document.sitechform.fax_no.value="";
      	document.sitechform.mail_address.value="";
      	document.sitechform.cust_phone.value="";
      	document.sitechform.cust_addr.value="";
      	document.sitechform.bak.value="";
      }
	}
function close1(){
	window.close();
	}
function getUserMsg()
{
	document.all.accept_phone.value=document.all.accept_phone.value.replace(/\D/g,'');
	if(document.all.accept_phone.value.length==11)
	{
		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/6777/contactUserInfo.jsp","正在添加接触,请稍候...");
		chkInfoPacket.data.add("accept_phone" ,  document.sitechform.accept_phone.value);
		core.ajax.sendPacket(chkInfoPacket,do_UserMsg);
		chkInfoPacket =null;
	}
	
}
function do_UserMsg(packet)
{
	var userInfo=packet.data.findValueByName("userInfo");
	var arr=userInfo.split("|");
	document.sitechform.cust_name.value=arr[0];
	document.sitechform.brand_name.value=arr[1];
	document.sitechform.region_code.value=arr[2];
	document.sitechform.servicecity.value=arr[3];
}
</script>

</head>
<body>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">		
		<table cellspacing="0" width="100%">
		<div class="title">
			<div id="title_zi">新增客户接触</div>
		</div>
		<tr>
      <td class='Blue' nowrap > 受理号码</td>
      <td  nowrap >
			  <input id="accept_phone" name ="accept_phone" type="text" maxlength="11" onkeyup="getUserMsg()" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
		    <font color="orange">*</font>
		  </td>
		  <td class='Blue' nowrap >业务地市</td>
      <td  nowrap >
			 <select id="servicecity " name="servicecity" size="1">
			 	<option value="" selected>--所有员工地市--</option>
				    <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from sregioncode  order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>
		    <font color="orange">*</font>
		  </td>
		 </tr>
		 <tr>
		 	<td class='Blue' nowrap > 接触时长</td>
      <td  nowrap >
			  <input id="acc_long" name ="acc_long" type="text" value='0' readonly='true'/>
		  </td>
		  <td class='Blue' nowrap > 接触方式</td>
      <td  nowrap >
			 	  <select id="contact_way " name="contact_way" size="1">
			  	<option value="" selected></option>
			  	 <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select accept_code,accept_name from SCALLACCEPTCODE order by accept_code</wtc:sql>
				  </wtc:qoption>
			  </select>	
		  </td>
		 </tr>
		 <tr>
		  <td class='Blue' nowrap > 语种</td>
      <td  nowrap >
			 	  <select id="language" name="language" size="1">
			 			<option value="" selected></option>
				    <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select lang_code,lang_name from SAGLANGUAGE order by lang_code</wtc:sql>
				  </wtc:qoption>
			  </select>	
		  </td>
		  <td nowrap>&nbsp;</td>
		  <td nowrap>&nbsp;</td>
		 </tr>
		 <tr><td colspan='6'><font color="orange">用户信息</font></td></tr>
		 <tr>
		 	<td class='Blue' nowrap > 用户品牌</td>
      <td  nowrap >
			 	  <select id="brand_name" name="brand_name" size="1">
			 			<option value="" selected></option>
				    <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select brand_code,brand_name from SBRANDCODE order by brand_code</wtc:sql>
				  </wtc:qoption>
			  </select>	
		  </td>
		  <td class='Blue' nowrap > 用户级别</td>
      <td  nowrap >
			 	  <select id="brand_grade" name="brand_grade" size="1">
			 			<option value="" selected></option>
				    <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select accept_code,accept_name from SCALLGRADECODE order by accept_code</wtc:sql>
				  </wtc:qoption>
			  </select>	
		  </td>
		 </tr>
		 <tr>
		 	<td class='Blue' nowrap >客户地市</td>
      <td  nowrap >
			 <select id="region_code" name="region_code" size="1">
			 	<option value="" selected></option>
				    <wtc:qoption name="TlsPubSelCrm"  outnum="2">
				    <wtc:sql>select region_code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>
		  </td>
		  <td class='Blue' nowrap > 客户姓名</td>
      <td  nowrap >
			  <input id="cust_name" name ="cust_name" type="text" maxlength="130"/>
		  </td>
		  
		 </tr>
		 <tr>
		 	<td class='Blue' nowrap > 传真</td>
      <td  nowrap >
			  <input id="fax_no" name ="fax_no" type="text" maxlength="20"/>
		  </td>
		 	<td class='Blue' nowrap > 电子邮件</td>
      <td  nowrap >
			  <input id="mail_address" name ="mail_address" type="text" maxlength="80"/>
		  </td>
		  
		 </tr>
		 <tr>
		 	<td class='Blue' nowrap > 客户电话</td>
      <td  nowrap >
			  <input id="cust_phone" name ="cust_phone" type="text" maxlength="20"/>
		  </td>
		 	<td class='Blue' nowrap > 客户地址</td>
      <td  nowrap >
			  <input id="cust_addr" name ="cust_addr" type="text" maxlength="200"/>
		  </td>
		 </tr>
		 <tr>
		 		<td class='Blue' nowrap >备注</td>
		 		<td  class='Blue' nowrap colspan='5'>
		 			<textarea id="bak" name="bak" cols="80" rows="5" maxlength="500"></textarea>
		 	  </td>
		 </tr>
		 <tr >
      <td colspan="6" align="center" id="footer" style="width:600px"> 
       <input name="dosure" type="button" class="b_foot" id="dosure" value="确定" onClick="submitMe()">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="重置">
       <input name="close" type="button" class="b_foot"  id="add" value="关闭" onClick="close1();">
       
      </td>
    </tr>
   </table>
	</div>
</form>
</body>
