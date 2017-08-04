<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-21 短信回执业务
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
%>
<html>
<head>
<title><%=opName%></title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	var opFlag;
	$(document).ready(function(){
    //opchange();
    if("<%=opCode%>"=="b600"||"<%=opCode%>"=="b601"){
      $("#businessTypeId option[value='01']").attr("selected","true");
    }
    if("<%=opCode%>"=="g734"||"<%=opCode%>"=="g735"){
      $("#businessTypeId option[value='02']").attr("selected","true");
    }
    if("<%=opCode%>"=="b600"||"<%=opCode%>"=="g734"){
      document.all.opFlag[0].checked=true;     
    }
    if("<%=opCode%>"=="b601"||"<%=opCode%>"=="g735"){
      document.all.opFlag[1].checked=true;                  
    }
  });
	
	function submitt(){
		var buttonSub = document.getElementById("cubmitt");
		buttonSub.disabled = "true";
		var businessTypeId = $("#businessTypeId").val(); //业务类型 短信回执、短信签名
		var slecOpFlag =$("input[@name=opFlag][@checked]").val();  //操作类型 订购、退订
		var opr_opCode = ""; //办理业务 opCode
		var opr_opName = "";
		var toPage = "";
		if(businessTypeId=="01"){ //短信回执 
		  if(slecOpFlag=="1"){ //订购 b600 
		    opr_opCode = "b600";
		    opr_opName = "短信回执业务开通";
		    toPage = "fb600_main.jsp";
		  }else{
		    opr_opCode = "b601";
		    opr_opName = "短信回执业务退订";
		    toPage = "fb601_main.jsp";
		  }
		}else{ //短信签名
		  if(slecOpFlag=="1"){ //订购 b600 
		    opr_opCode = "g734";
		    opr_opName = "短信签名订购";
		    toPage = "fg734_main.jsp";
		  }else{
		    opr_opCode = "g735";
		    opr_opName = "短信签名退订";
		    toPage = "fg735_main.jsp";
		  }
		}
		if(opr_opCode!="<%=opCode%>"){
		  //$("#opr_opCode").val(opr_opCode);
		  //$("#opr_opName").val(opr_opName);
		  $("#opCode").val(opr_opCode);
		  $("#opName").val(opr_opName);
		}
		document.all.frm.action = toPage;
		document.all.frm.submit();
	}
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
<input type="hidden" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">短信回执业务</div>
</div>
<table cellspacing="0">
  	<tr>
		<td class="blue" width="30%">
		  业务类型
		</td>
		<td width="70%">
      <select id="businessTypeId" name="businessType" style="width:150px">
		    <option value="01" >短信回执</option>
		    <option value="02" >短信签名</option>
		  </select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="30%">
			操作类型
		</td>
		<td width="70%">
			<input type="radio" name="opFlag" value="1" />开通&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="2" />退订&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td class="blue">
			用户号码
		</td>
		<td>
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="closeBtn" value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>
