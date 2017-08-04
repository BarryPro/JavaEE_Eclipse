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
		
		String opCode = "g783";
		String opName = "用户信誉度黑名单";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr"); 
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

%>

<HTML>
<HEAD>
<script language="JavaScript">

function do_add()
{
	var phone_no	= frm.InPhoneNo.value ;
	var sTmpBuf	= "&is_limit_owe=0&is_msg=1" ;
	
	if(frm.is_level.checked)
		sTmpBuf+="&is_level=0";
	else
		sTmpBuf+="&is_level=1";
/*
	if(frm.is_msg.checked)
		sTmpBuf+="&is_msg=0";
	else
		sTmpBuf+="&is_msg=1";
*/
	
	document.frm.action="g783_1.jsp?InOpFlag=I&InPhoneNo="+phone_no+sTmpBuf;
	
	document.frm.submit();
}

function do_del()
{
	var phone_no	= frm.InPhoneNo.value ;
	
	document.frm.action="g783_1.jsp?InOpFlag=D&InPhoneNo="+phone_no;

	document.frm.submit();
}

function do_qry()
{
	var phone_no	= frm.InPhoneNo.value ;
	
	document.frm.action="g783_1.jsp?InOpFlag=Q&InPhoneNo="+phone_no;

	document.frm.submit();
}
</script> 

 
<title>用户信誉度黑名单</title>
</head>
<BODY onload=""> 
<form action="g783_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">请输入手机号码：</div>
		</div>
		
	
  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">手机号：</td>
        <td > 
 					<input class="button"type="text" name="InPhoneNo" size="30" >  <font color="orange">*</font>
				</td>
				<td> 
 					<input type="checkbox" name="is_level" value="">不参与评级
 					
				</td>
				
  </tr>
  
  <input type="hidden" name="InOpCode" value="<%=opCode%>">
  <input type="hidden" name="InLoginNo" value="<%=workno%>">


    </tbody>
  </table>
  

           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="加入" onclick="do_add()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="删除" onclick="do_del()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="查询" onclick="do_qry()" >
          &nbsp;
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>