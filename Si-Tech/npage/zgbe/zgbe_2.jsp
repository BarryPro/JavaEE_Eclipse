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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zgbe";
		String opName = "专票虚拟关系管理";
 		String cphm = request.getParameter("phone_no");

%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjtcx()
{
	var phoneNo = document.frm.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入集团虚拟账号!");
		return false;
	}
	else
	{
		//alert(phoneNo);
		var myPacket = new AJAXPacket("zg44_check.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
}
 

 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbe_1.jsp';
 }
 

 function cyzhtj()//成员添加
 {
	 //非空检验
	 var cphm = document.all.cphm.value;
	 var s_tax_no = document.all.s_tax_no.value;
	 var s_tax_name = document.all.s_tax_name.value;
	 var s_tax_address = document.all.s_tax_address.value;
	 var s_tax_phone = document.all.s_tax_phone.value;
	 var zh = document.all.zh.value;
	 var bz = document.all.bz.value;
	 var khh = document.all.khh.value;
	 if(s_tax_no=="" ||s_tax_name=="" ||s_tax_address=="" ||s_tax_phone=="" ||zh=="" ||khh=="")
	 {
		rdShowMessageDialog("请输入纳税人识别号码、地址、电话、开户行、账号等信息!");
		return false;
	 }	
	 else
	 {
		//二次确认
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("是否确定进行虚拟集团添加操作?");
		if (prtFlag==1)
		{
			document.frm.action="zgbe_add.jsp?cphm="+cphm+"&s_tax_no="+s_tax_no+"&s_tax_name="+s_tax_name+"&s_tax_address="+s_tax_address+"&s_tax_phone="+s_tax_phone+"&zh="+zh+"&bz="+bz+"&khh="+khh;//展示分项信息 调用staxtailadd接口进行录入
			document.frm.submit();
		}
		else
		{
			return false;
		}
	 }	
	 //调用接口
	
 }
 
 
 

  
 </script> 
 
<title>成员信息添加</title>
</head>
<BODY >
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
  <table cellspacing="0">
    <tr>
		<td class="blue" width="15%">产品号码</td>
		<td> 
			<input type="text"  name="cphm" value="<%=cphm%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">纳税人识别号码</td>
		<td> 
			<input type="text"  name="s_tax_no" size="24" maxlength="24"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">纳税人名称</td>
		<td> 
			<input type="text"  name="s_tax_name" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">地址</td>
		<td> 
			<input type="text"  name="s_tax_address" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">电话</td>
		<td> 
			<input type="text"  name="s_tax_phone" size="24" maxlength="24"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">开户行</td>
		<td> 
			<input type="text"  name="khh" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">账号</td>
		<td> 
			<input type="text"  name="zh" size="34" maxlength="34"  >
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">备注</td>
		<td> 
			<input type="text"  name="bz" size="134" maxlength="134"  >
		</td>
	</tr> 

 
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="tj" name="query" class="b_foot" value="成员添加"   onclick="cyzhtj()" >
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