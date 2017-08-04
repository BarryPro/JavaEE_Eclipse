<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String structvalue=WtcUtil.repNull(request.getParameter("structvalue"));	
	String opCode="";
	String opName="";
%>	
<html>
<SCRIPT type=text/javascript>
function saveTo()
{		
	window.returnValue = document.all.servno.value;
	window.close();
}

</SCRIPT>	
<body onkeydown="if(event.keyCode=='13')return false">
<div id="operation">
<FORM name="attrFm" action="" onload="document.all.servno.focus();" method=post>
<%@ include file="/npage/include/header_pop.jsp" %>	
<div id="operation_table">	
<DIV class="title"><div class="text">值信息</div></DIV>	
  <table cellspacing=0>
            <TR> 
            	<td class='blue' nowrap>旧值编码</Td>
              <TD> 
              	 <input type="text" name="ordernum" class="InputGrey" onchange="" value="<%=structvalue%>" />
              </TD>
              	 <td class='blue' nowrap>请输入新值</Td>
                <TD colspan='3'> 
                  <input type="text" name="servno"  onchange="" value="" />
                   &nbsp;<font class='orange'>*</font>
                </TD>
            </TR>
   <table> 
</div>
<div id="operation_button">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
</div>
<%@ include file="/npage/include/footer_pop.jsp"%>
</FORM>
</DIV>
</BODY>
</HTML>