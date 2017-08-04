<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
    String opCode = (String)request.getParameter("opCode");
   	String opName = (String)request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*"%>
<%  request.setCharacterEncoding("GBK"); %>


<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<HTML>
<HEAD>

<script language="JavaScript">
<!--	
	
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
		document.frm.action="s2287_1.jsp";
		document.frm.submit();
}
function doclear()
{
	frm.reset();
}
-->
 </script> 
 
<title>黑龙江BOSS-动感地带地盘护照换卡</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">动感地带护照换卡</div>
	</div>
<input type="hidden" name="opCode" value="">


		     <table cellspacing="0">
		       <tr > 
                 <td class="blue">操作类型</td>
                 <td class="blue"> 
                 <input name="busyType" type="radio"  value="2287" checked  >
                  换卡申请
                 <input name="busyType" type="radio"  value="2288"  >
				  换卡冲正 
				</td>

			   </tr>

                <tr > 
                  <td width="13%" nowrap  class="blue">服务号码</td>
                  <td width="35%"> 
                    <input type="text" name="phoneNo" size="20" maxlength="11"  value =<%=activePhone%>  Class="InputGrey" readOnly >	
                  </td>


                </tr>
              </table>

        <table cellspacing="0">
          <TR > 
            <TD noWrap align="center" id="footer"> 
                <input type="button" name="query" value="查询" onclick="check_HidPwd()" class="b_foot">
                &nbsp;
                <input type="button" name="return1" value="清除" onclick="doclear()" class="b_foot">
                &nbsp;
				<input type="button" name="return2" value="关闭" onClick="removeCurrentTab()" class="b_foot">
             </TD>
          </TR>
        </TABLE>


<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>
