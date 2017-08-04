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
		String opCode = "i092";
		String opName = "强制预拆";
		String dateStr = new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
 
	 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }


 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
   function sel4()
   {
		   window.location.href='i092_4.jsp';
   }
   
function do_ftp()
{
	

	if(frm.file_name.value.length<1)
	{
		rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
		document.frm.file_name.focus();
		return false;
	}

	
	//document.frm.action="i092_3_1.jsp" ;

	document.frm.submit();
	
}
  
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="i092_3_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >按手机号码查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">按地市查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" checked >文件导入
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4" >文件处理结果查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">请输入要导入的文件！  请在每月5日之后操作,否则无效</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" align="right">
			请选择文件
		</td>
		<td >
			<input type="file" name="file_name" size="30" class="button">
		</td>
	</tr>
	
	<tr>
		<td class="blue" align="right">
			格式要求:<br>
			&nbsp;&nbsp;
		</td>
		<td>
		注：单个文件最多不要超过2000行<br><br>
		&nbsp;&nbsp;手机号1<br>
		&nbsp;&nbsp;手机号2<br>
		&nbsp;&nbsp;手机号3<br>
		&nbsp;&nbsp;...<br>
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
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %> 
</form>
 </BODY>
</HTML>