<%
/********************
 version v2.0
 开发商: si-tech
 作者: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>公务测试号转入</title>
<%
	
    String opCode = "4264";
    String opName = "公务测试号转入";
    String phoneNo = request.getParameter("activePhone");
    
    /*begin add 要求指定工号并且工号权限级别是8级及以上才可以办理此功能 by diling @2012/5/8 17:23:28*/
    String regCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
    String rightFlag_4264 = "Y";
    String  inParams [] = new String[2];
      inParams[0]="SELECT COUNT(*) FROM dloginmsg a, shighlogin b WHERE a.login_no = b.login_no AND b.op_code =:opcode AND a.power_right >= 8  AND a.login_no =:loginno";
      inParams[1]="opcode="+opCode+",loginno="+loginNo;
%>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
        <wtc:param value="<%=inParams[0]%>"/>
        <wtc:param value="<%=inParams[1]%>"/> 
      </wtc:service>  
      <wtc:array id="retPowerRight"  scope="end"/>
  <%
      if(!"000000".equals(retCode1)){
  %>
        <script language=javascript>
          rdShowMessageDialog("retcode：<%=retCode1%><br>retmsg：<%=retMsg1%>",0);
          removeCurrentTab();
        </script>
  <%
      }else{
        if(Integer.parseInt(retPowerRight[0][0])<=0){ /*count(*)>0代表该工号不能办理4264功能，否则允许*/
          rightFlag_4264 = "N";
  %>
          <script language=javascript>
            rdShowMessageDialog("该工号无权限办理公务测试号转入业务！",1);
            //removeCurrentTab();
          </script>
  <%       
        }
      }
    /*end by diling @2012/5/8 17:23:28*/
%>
</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	var phoneNo = "<%=phoneNo%>";
	if(phoneNo==null||phoneNo=="")
	removeCurrentTab();
	var opCode = "<%=opCode%>";
	if(opCode=="4264"&&"<%=rightFlag_4264%>"=="Y")
	{
		document.all.opFlag[0].checked=true;	
	}else
	{
		document.all.opFlag[1].checked=true;
		document.all.opFlag[0].disabled=true;	
	} 
	opchange();
}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}


//----------------验证及提交函数-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("请输入手机号码!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
		rdShowMessageDialog("手机号码只能是11位!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm(subButton)
{
	if(document.frm.phoneNo.value=="")
  	{
	     rdShowMessageDialog("请输入手机号码!");
	     document.frm.phoneNo.focus();
	     return false;
  	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
	     rdShowMessageDialog("手机号码只能是11位!");
	     document.frm.phoneNo.value = "";
	     return false;
  	}
  	if(!$("#emidTr").is(":hidden")){
  		var emId = $("#emId").val().trim();
  		if(emId==""){
  			rdShowMessageDialog("员工编号不能为空!");
  		    return false;
  		}
  	}
  	if(!$("#oanumTr").is(":hidden")){
  		var oaNum = $("#oaNum").val().trim();
  	  	if(oaNum==""){
  			rdShowMessageDialog("OA编号不能为空!");
  		    return false;
  		}
  	}
  	
  	
  	
  	controlButt(subButton);//延时控制按钮的可用性
  	var radio1 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio1.length;i++)
  	{
    	if(radio1[i].checked)
		{
	  		var opFlag = radio1[i].value;
	  		if(opFlag=="one")
	  		{
	  			
	  	//		String inPsersonNo = WtcUtil.repNull(request.getParameter("inPsersonNo"));
	  	//		String inPhoneType = WtcUtil.repNull(request.getParameter("inPhoneType"));
	  	//		String oaNumber = WtcUtil.repNull(request.getParameter("oaNumber"));
	  			
	  			 var packet = new AJAXPacket("f4263_checkOa.jsp","请稍后...");
	  	        packet.data.add("opCode","<%=opCode%>");//
	  	      	packet.data.add("phoneNo",$("#phoneNo").val().trim());//
	  	      	packet.data.add("inPsersonNo",$("#emId").val().trim());
	  	    	packet.data.add("inPhoneType",$("#sale_kind").val().trim());
	  	        packet.data.add("oaNumber",$("#oaNum").val().trim());
	  	    	core.ajax.sendPacket(packet,do_checkOa);
	  	    	packet =null;
	  			
	    	//	frm.action="f4264_1.jsp";
	    	//	document.all.opcode.value="4264";
	    		
	    		
		  	}else if(opFlag=="two")
		  	{
	    		frm.action="f4265_1.jsp";
	    		document.all.opcode.value="4265";	
	    		frm.submit();
		  	}
		}
 	}
  	
  	
}
function do_checkOa(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    submitFlag=false;
    if(error_code=="000000"){//操作成功
    	frm.action="f4264_1.jsp";
		document.all.opcode.value="4264";
		frm.submit();
    }else{//调用服务失败
    	rdShowMessageDialog("预存校验失败，"+error_code+"："+error_msg,0);
    }
}

function opchange()
{
	$("#emidTr").hide();
	$("#emId").val("");
	$("#oaNum").val("");
	$("#useType").val("0");
	$("#useRange").val("0");
	if(document.all.opFlag[0].checked==true) 
	{
		document.all.salekin_id.style.display="";
		document.all.sale_kind.value="0";
		
		$("#usetypeTr").show();
		$("#userangeTr").show();
		$("#oanumTr").show();
		
	}
	else{
		document.all.salekin_id.style.display="none";
		$("#usetypeTr").hide();
		$("#userangeTr").hide();
		$("#oanumTr").hide();
	}
}
function salekindChg(){
	var sale_kind = $("#sale_kind").val().trim();
	$("#emId").val("");
	$("#oaNum").val("");
	$("#useType").val("0");
	$("#useRange").val("0");
	if(sale_kind=="1"){
		$("#emidTr").show();
		$("#usetypeTr").hide();
		$("#userangeTr").hide();
	}
	else{
		$("#emidTr").hide();
		$("#usetypeTr").show();
		$("#userangeTr").show();
	}
}


</script>
</head>
<body>
	
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
	  <TR> 
		<TD class="blue">操作类型</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" onclick="opchange()" >申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
		</TD>
		      <input type="hidden" name="opcode" >
         </TR>
         <tr>
            <td class="blue">手机号码</div></td>
            <td> 
        		<input class="button"type="text" id="phoneNo" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      			<font color="orange">*</font>
      		</td>
         </tr>
         <TR id="salekin_id">
	          <TD class="blue">号码类型</TD>
	          <TD>
				<select id="sale_kind" name="sale_kind" onchange="salekindChg()">
				<option value="0"> 0-->测试号</option>
				<option value="1"> 1-->公务号</option>
				</select>
				<font color="orange">*</font>
	         </TD>
         </TR> 
         <tr id="emidTr" style="display:none;">
            <td class="blue">员工编号</div></td>
            <td> 
        		<input class="button"type="text" id="emId" name="emId" size="20" maxlength="30">
        		<font color="orange">*</font>
      		</td>
         </tr>
         <tr id="oanumTr">
            <td class="blue">OA编号</div></td>
            <td> 
        		<input class="button"type="text" id="oaNum" name="oaNum" size="20" maxlength="30">
        		<font color="orange">*</font>
      		</td>
         </tr>
         <tr id="usetypeTr">
	          <td class="blue">使用类型</td>
	          <td>
				<select id="useType" name="useType">
				<option value="0">人用</option>
				<option value="1">机用</option>
				</select>
				<font color="orange">*</font>
	         </td>
         </tr>
         <tr id="userangeTr">
	          <td class="blue">使用范围</td>
	          <td>
				<select id="useRange" name="useRange">
				<option value="0">省内</option>
				<option value="1">省外</option>
				</select>
				<font color="orange">*</font>
	         </td>
         </tr> 
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
      
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>

</html>
