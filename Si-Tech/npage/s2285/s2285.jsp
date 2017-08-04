<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.04
 模块: 动感地带地盘护照申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	request.setCharacterEncoding("GBK"); 
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("activePhone");
	
%>
<HEAD>

<script language="JavaScript">
<!--	
	
  onload=function()
 { 
   
 }
 
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
		{
			rdShowMessageDialog("请输入服务号码!");
	 	    document.frm.phoneNo.focus();
	 	    return false;
	    }	  
    if(document.frm.phoneNo.value.length != 11 )
		{
	        rdShowMessageDialog("服务号码只能是11位!");
	 	    document.frm.phoneNo.value = "";
	 	    document.frm.phoneNo.focus();
	 	    return false;
	    }
		document.frm.action="s2285_1.jsp";
		document.frm.submit();
}
function doclear()
{
	frm.reset();
}
-->
 </script> 
 
<title>黑龙江BOSS-动感地带地盘护照注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
<input type="hidden" name="opCode" value="">

       
	 <table cellspacing="0"> 
	   <tr> 
	     <td class="blue">操作类型</td>
	     <td> 
	     <input name="busyType" type="radio"  value="2285" checked>
	      申请
	     <input name="busyType" type="radio"  value="2286"  >
		  冲正 
		</td>
	   </tr>
        <tr> 
          <td class="blue">服务号码</td>
          <td> 
            <input class="InputGrey"type="text" name="phoneNo" value="<%=phoneNo%>" size="20" maxlength="11" readOnly>
          </td>
      </table>
           
       <table cellspacing="0"> 
          <TR > 
            <TD id="footer"> 
                <input type="button" name="query"  class="b_foot" value="查询" onclick="check_HidPwd()" >
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
				<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
             </TD>
          </TR>
        </TABLE>
</form>
	<%@ include file="/npage/include/footer_simple.jsp" %>   
 </BODY>
</HTML>
