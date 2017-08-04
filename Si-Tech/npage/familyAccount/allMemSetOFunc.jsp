<%
/********************
 version v2.0
开发商: si-tech
hejwa 2013-4-28 10:46:05
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode     = request.getParameter("opCode");
	String opName     = request.getParameter("opName");
%>
<HTML>
<HEAD>
<TITLE>中国移动客户关系管理系统</TITLE>
<%
  request.setCharacterEncoding("GBK");
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
//限额方式onchange事件
function setThisTrInpt(bt){
	if($(bt).val()==0){//限额
		$("#feelimit").val("");
		$("#feelimit").removeAttr("disabled");
	}else{//全额
		$("#feelimit").val("0");
		$("#feelimit").attr("disabled","disabled");
	}
}

function retFunc(){
	if($("#feelimitselect").val()=="0"){
		var feeLimit  = $("#feelimit").val();
		var t1 = /^\d+$/;
		if(!t1.test(feeLimit)){
			rdShowMessageDialog("限额必须为数组字");
			$("#feelimit").val("");
			$("#feelimit").focus();
			return false;
		}
		
		if(parseInt(feeLimit)>5000){
			rdShowMessageDialog("家庭为成员每月支付限额不能超过5000元");
			$("#feelimit").val("");
			$("#feelimit").focus();
			return false;
		}
		
		if(parseInt(feeLimit)==0){
			rdShowMessageDialog("限额付费限额应大于0，请重新输入");
			$("#feelimit").val("");
			$("#feelimit").focus();
			return false;
		}
	}
	window.returnValue=$("#feelimitselect").val()+"|"+$("#feelimit").val();
	window.close();
}
</script>

<BODY>
<FORM action="" method=post name="frm">
<%@ include file="/npage/include/header_pop.jsp" %>
<table cellspacing="0">
    <TBODY> 
    	<TR> 
      	<th align="center"> 
        	限额方式
      	</th>
      	<th  align="center"> 
        	限额
      	</th>
    </TR>
    <TR> 
      	<td  align="center"> 
        	<select onchange='setThisTrInpt(this)'  name="feelimitselect"  id="feelimitselect"    >
        		<option value='0' selected>限额付费</option>
        		<option value='1' >全额付费</option>
        	</select>
      	</td>
      	<td  align="center"> 
        	<input type="text" name="feelimit"  id="feelimit"    maxlength="4" />
      	</td>
    </TR>
    
<TD COLSPAN=2>
<DIV ALIGN="CENTER">
<INPUT class="b_foot" TYPE="BUTTON"  value="确定" onClick="retFunc()">
<INPUT class="b_foot" TYPE="BUTTON"  value="关闭" onClick="window.close()">
</DIV>
</TD>
</TR>
   </TBODY> 
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
 </BODY></HTML>
