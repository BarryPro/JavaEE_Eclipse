<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String[] inParas2 = new String[2];
		String opCode = "e660";
		String opName = "手工系统充值导入";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr"); 
		String regionCode = (String)session.getAttribute("regCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());



      	inParas2[0] = "select to_char(count(*)) from cKeyWordMap where op_code = 'e660' and key_word = 'IS_OK_LOGINNO' and key_value = :login_no";  
      	inParas2[1] = "login_no="+workno ;
%>


      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
		    <wtc:param value="<%=inParas2[0]%>"/>
		    <wtc:param value="<%=inParas2[1]%>"/>
		    </wtc:service>
		    <wtc:array id="IS_LOGIN" scope="end" />
		    	
<%
				if( IS_LOGIN[0][0].equals("0") )
				{
%>
				<script language="JavaScript">
					rdShowMessageDialog("工号没有导入权限！！");	
					removeCurrentTab();
				</script>
<%
				}
%>



<HTML>
<HEAD>
<script language="JavaScript">

function do_ftp()
{
	var document_name	= frm.document_name.value ;
	var document_no		= frm.document_no.value ;
	var import_date		= frm.import_date.value ;
	var	active_name		= frm.active_name.value ;
	var	all_user			= frm.all_user.value ;
	var	all_fee				= frm.all_fee.value ;
	var	ip_Addr				= frm.ip_Addr.value;
	var	shortMsg1			= frm.shortmsg1.value;
	var	shortMsg2			= frm.shortmsg2.value;
	
	
	if(document_name=='')
	{
		rdShowMessageDialog("请输入公文名");
		document.frm.document_name.focus();
		return false;
	}
	if(document_no=='')
	{
		rdShowMessageDialog("请输入公文文号");	
		document.frm.document_no.focus();
		return false;
	}
	if(active_name=='')
	{
		rdShowMessageDialog("请输入营销代码！");	
		document.frm.active_name.focus();
		return false;
	}
	if(all_user=='')
	{
		rdShowMessageDialog("请输入充值总用户数");	
		document.frm.all_user.focus();
		return false;
	}
	if(all_fee=='')
	{
		rdShowMessageDialog("请输入充值总用金额");	
		document.frm.all_fee.focus();
		return false;
	}
	if(import_date=='0')
	{
		rdShowMessageDialog("请选择充值日期");
		document.frm.import_date.focus();
		return false;
	}
	if(frm.file_name.value.length<1)
	{
		rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
		document.frm.file_name.focus();
		return false;
	}
	if(shortMsg1.length > 80)
	{
		rdShowMessageDialog("短信模板 PART1过长，请精简。最大长度40汉字，80个字符。");
		document.frm.shortmsg1.focus();
		return false;
	}
	if(shortMsg2.length > 80)
	{
		rdShowMessageDialog("短信模板 PART2过长，请精简。最大长度40汉字，80个字符。");
		document.frm.shortmsg1.focus();
		return false;
	}
	
	document.frm.action="e660_1.jsp?document_name="+document_name+"&document_no="+document_no+"&import_date="+import_date+"&active_name="+active_name+"&all_fee="+all_fee+"&all_user="+all_user+"&ip_Addr="+ip_Addr+"&shortmsg1="+shortMsg1+"&shortmsg2="+shortMsg2 ;

	document.frm.submit();
	
}

</script> 

 
<title>手工系统充值导入</title>
</head>
<BODY onload=""> 
<form action="e660_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请导入充值公文</div>
		</div>
		
	<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
	
  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">公文名：</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_name" size="50" >  <font color="orange">*</font>
 					<font color="red">最长20汉字</font>
				</td>
				
     </tr>

     <tr>
        <td class="blue" width="15%">公文文号：</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_no" size="50" >  <font color="orange">*</font>
 					<font color="red">最长20汉字</font>
				</td>
				
     </tr>
     
     <tr>
        <td class="blue" width="15%">营销代码：</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="active_name" size="50" >  <font color="orange">*</font>
 					<font color="red">请输入经分系统的后台代码</font>
				</td>
				
     </tr>
     
    <tr>
    	<td class="blue" width="15%">充值总金额：</td>
    	<td>
    		<input class="button"type="text" name="all_fee" size="50" >  <font color="orange">*</font>
    	</td>
    </tr>
    <tr>
    	<td class="blue" width="15%">充值总用户数：</td>
    	<td>
    		<input class="button"type="text" name="all_user" size="50" >  <font color="orange">*</font>
    	</td>
    </tr>
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 

      <td class="blue" width="15%">充值日期：</td>
      <td> 
      	<%
      	String[] inParas1 = new String[2];
      	
      	inParas1[0] = "select back_rule,to_char(back_date) from sBackPayRule where back_rule like 'zzzzzzzz%'";  
      	%>
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />
		  
				<select name="import_date" id="import_date" class="button" onChange="">
					<option value="0" selected>--未选择--</option>
        	<%
        		for(int i=0;i<result.length;i++)
        		{ 
        			
        	%>
        	<option value="<%=result[i][0]%>"><%=result[i][1]%>日</option>
           <%
     
           	}
           %>
        </select>
        
        <font color="orange">*</font>
      </td>
    </tr>
  </table>
  
  <table cellspacing="0">
    <tr> 

      <td class="blue" width="15%">短信模板 PART1：</td>
      <td> 

        <input class="button"type="text" name="shortmsg1" size="70" >
        <font color="red">最长40汉字</font>
      </td>
    </tr>
    <tr>
      <td class="blue" width="15%">短信模板 PART2：</td>
      <td> 
        <input class="button"type="text" name="shortmsg2" size="70" >
        <font color="red">最长40汉字</font>
      </td>
  	</tr>
    <tr>
    	<td class="blue" width="15%">说明：</td>
    	<td>
    			1、不发短信<br>
    			&nbsp;&nbsp;"短信模板 PART1、短信模板 PART2"不用填写。<br>
    			2、发送短信中不需要充值金额作为变量<br>
    			&nbsp;&nbsp;将短信内容直接填写到 "短信模板 PART1"中。<font color="red">短信模板 PART2不要填内容。</font><br>
    			&nbsp;&nbsp;&nbsp;&nbsp;例如："尊敬的客户您好，您参与网龄返话费活动系统已将话费充入您的账户，请注意查收。"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;短信模板 PART1="尊敬的客户您好，您参与网龄返话费活动系统已将话费充入您的账户，请注意查收。"<br>
    			3、短信中包含充值金额<br>
    			&nbsp;&nbsp;必须填写"短信模板 PART1,短信模板 PART2"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;例如："尊敬的客户您好，您参与网龄返话费活动系统已将 <font color="red">XX</font> 元充入您的账户，请注意查收。"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;需要这样配置：<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;短信模板 PART1="尊敬的客户您好，您参与网龄返话费活动系统已将"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;短信模板 PART2="元充入您的账户，请注意查收。"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;程序会自动将本次返费金额替换 "XX"。
    	</td>
  	</tr>
  </table>

    
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">数据导入：</td>
    	<td>
    		<input type="file" name="file_name" size="30" class="button">
    	</td>
    </tr>
    
    <tr>
    	<td class="blue" width="15%">导入文件格式说明:</td>
    	<td>
    		格式要求：服务号码|账号|费用（总费用）|开始时间（YYYYMMDD）|结束时间(YYYYMMDD)|返费次数（总计返费次数）|附注<br>
    		<br>
    			&nbsp;&nbsp;服务号码，必须为移动在网手机号，最长15位。<br>
    			&nbsp;&nbsp;账号，最长19位。<br>
    			&nbsp;&nbsp;总费用，为整数或保留两位小数。<font color="red">（如果是多次充值，此处填总金额总和，而不是每次的平均值）</font><br>
    			&nbsp;&nbsp;附注，最长30个汉字。<br>
    		<br>
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;例如：13845099725|12073469466|120|20100901|20110930|12|测试1<br>
    		<br>&nbsp;&nbsp;&nbsp;&nbsp;注意分隔符为“|” <br>
    	</td>
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="上传" onclick="do_ftp()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
  
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>
