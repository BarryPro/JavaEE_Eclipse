<%
  /*
   * 功能: 安保部身份证查询 g688
   * 版本: 1.0
   * 日期: 2012/5/20
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>

<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String workNo=(String)session.getAttribute("workNo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	window.onload=function() {
    var opCode = "<%=opCode%>";
    if(opCode=="g688"){
      document.all.opFlag[0].checked=true; 
      $("#qryTr").css("display","");
	    $("#qryInputTr").css("display","none");       
    }
    if(opCode=="g689"){
      document.all.opFlag[1].checked=true;  
      $("#qryTr").css("display","none");
	    $("#qryInputTr").css("display","");                
    }
	}
	
	function changOpFlay(obj){
	  if(obj.value=="g689"){
	    var markDiv=$("#intablediv"); 
      markDiv.empty();
	    $("#qryTr").css("display","none");
	    $("#qryInputTr").css("display","");
	    $("#idIccid").val("");
	    $("#idIccid_input").val("");
	  }else{
	    $("#qryTr").css("display","");
	    $("#qryInputTr").css("display","none");
	    $("#idIccid").val("");
	    $("#idIccid_input").val("");
	  }
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function submitt(submitBtn2) {
		//controlBtn(true);
		/* 按钮延迟 */
		controlButt(submitBtn2);
		if (!check(frm)) {//idIccid
			return false;
		}
		if($("input[@name=opFlag][@checked]").val()=="g688"){//查询
      var markDiv=$("#intablediv"); 
      markDiv.empty();
      var idIccid = $("#idIccid").val();
      if(idIccid==""||idIccid==null){
        rdShowMessageDialog("请输入查询信息！",1);
        return false;
      }
      var packet = new AJAXPacket("fg688_ajax_query.jsp","正在获得数据，请稍候......");
      packet.data.add("idIccid",idIccid);
      packet.data.add("opCode","<%=opCode%>");
      packet.data.add("opName","<%=opName%>");
      core.ajax.sendPacketHtml(packet,doQuery);
      packet = null;
		}else{ //录入
		  var idIccid_input = $("#idIccid_input").val();
      if(idIccid_input==""||idIccid_input==null){
        rdShowMessageDialog("请输入查询信息！",1);
        return false;
      }
		  var packet = new AJAXPacket("fg689_ajax_subInfo.jsp","正在获得数据，请稍候......");
      packet.data.add("idIccid_input",idIccid_input);
      packet.data.add("opCode","<%=opCode%>");
      packet.data.add("opName","<%=opName%>");
      core.ajax.sendPacket(packet,doSub);
      packet = null;
		}
	}
  
  function doQuery(data){
    //找到添加表格的div
    var markDiv=$("#intablediv"); 
    markDiv.empty();
    markDiv.append(data);
    var retCode = $("#retCode").val();
    var retMsg = $("#retMsg").val();
    if(retCode!="000000"){
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="fg688_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }
  }
  
  function doSub(packet){
    var retCode = packet.data.findValueByName("retcode");
    var retMsg = packet.data.findValueByName("retmsg");
    if(retCode=="000000"){
      rdShowMessageDialog("录入成功！",2);
      window.location.href="fg688_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }else{
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="fg688_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      
    }
  }
  
  function goBack(){
    window.location.href="fg688_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table>
  <tr>
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
		  <input type="radio" id="" name="opFlag" value="g688" onclick="changOpFlay(this)" />安保部身份证查询
		  <input type="radio" id="" name="opFlag" value="g689" onclick="changOpFlay(this)" />安保部身份证查询录入
		</td>
	</tr>
	<tr id="qryTr">
		<td class="blue" width="20%">查询类型</td>
		<td width="30%">
			<select name="idCardType" id="idCardType">
				<option value="01">身份证</option>
			</select>
		</td>
		<td class="blue" width="20%">查询信息</td>
		<td width="30%">
			<input type="text" name="idIccid" id="idIccid" v_type="idcard" value=""  maxlength="18" />
		</td>
	</tr>
	<tr>
  <tr id="qryInputTr" style="display:none">
    <td class="blue" width="20%">录入类型</td>
    <td width="30%">
      <select name="idCardType_input" id="idCardType_input">
      <option value="01">身份证</option>
      </select>
    </td>
    <td class="blue" width="20%">录入信息</td>
    <td width="30%">
      <input type="text" name="idIccid_input" id="idIccid_input" v_type="idcard" value=""  maxlength="18" />
    </td>
  </tr>
  <tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="submitt(this)">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="重置" onClick="goBack()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
 <div id="intablediv"></div>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
