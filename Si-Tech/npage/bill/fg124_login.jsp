<%
/********************
 version v2.0
 开发商: si-tech
 update wangyua at 2010.5.11
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
<title>购TD商务固话赠通信费(铁通)</title>
<%

    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String PhoneHead = phoneNo.substring(0, 3);
    String count="";
	String sqlStr = "select count(1)  from group_instance_member a, product_offer_instance b, dgrpusermsg c, dcustmsg d where a.group_id = b.group_id " +
    				"and b.serv_id = c.id_no and c.sm_code = 'TG' and a.exp_date > sysdate and a.serv_id = d.id_no and d.phone_no ='"+phoneNo+"'";
%>

<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode2" retmsg="retMsg2" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray!=null&& retArray.length > 0)
	{
		count = retArray[0][0];
	}
%>
<%  String num="";
	String SqlStr = "select count(1) from group_instance_member a, dcustmsg b where a.serv_id = b.id_no and b.phone_no = '"+phoneNo+"' and a.member_role_id = 10335";
%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode1" retmsg="retMsg1" routerValue="<%=phoneNo%>">
	<wtc:sql><%=SqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray1" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray1!=null && retArray1.length > 0)
	{
		num = retArray1[0][0];
	}
%>
<%  String number="";
	String sqlstr = "SELECT COUNT (1) FROM dcustmsgadd a, dcustmsg b, svpmnpkgcodetglimit c ,svpmnpkgcodetglimit d,dcustmsgadd e "+
					"WHERE a.id_no = b.id_no and b.id_no=e.id_no AND SUBSTR (b.belong_code, 1, 2) = c.region_code               "+
					"and SUBSTR (b.belong_code,1,2) =d.region_code AND a.field_code ='80003' and trim(a.field_value) = trim(c.pkg_code) "+
           			"and e.field_code = '80004' and trim(e.field_value) = trim(d.pkg_code) AND b.phone_no ='"+phoneNo+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode1" retmsg="retMsg1" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sqlstr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray2" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray2!=null && retArray2.length > 0)
	{
		number = retArray2[0][0];
	}
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
    if(opCode=="7689")
    {
    	
    }
    opchange();
  }

 function controlButt(subButton)
 {
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
  
//============weigp
function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check147SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
var flagTD = "true";
function getResult(packet){
	var result=packet.data.findValueByName("result");
	if("false"==result){
		//rdShowMessageDialog("147号段只有TD公话号码才能办理该业务！");
		//return false;
		flagTD = "false";
	}else{
		flagTD = "true";
	}
}
//============
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	var phoneHead = <%=PhoneHead%>;
  	
  //==================weigp

  if(phoneHead !='157'){
  		if(phoneHead == '147'){
  			check147SuperTD("<%=phoneNo%>");
  		}
  		if(flagTD == "false"){
  			rdShowMessageDialog("147号段只有TD公话号码才能办理该业务！");
  			return false;
 		}
 		else if(phoneHead !='147' )
      	{
			rdShowMessageDialog("只有157 号段和147号段TD公话号码才能办理该业务！");
  			return false;
      	}  
  }
  //====================
  	if("<%=count%>" <= 0 )
  	{
  		rdShowMessageDialog("该用户不是TD商务固话产品的用户，不能办理此业务!");
  		return false;
	}
	if("<%=num%>" > 0)
  	{
  		if("<%=number%>" <= 0 )
  		{
  			rdShowMessageDialog("TD商务固话用户只允许使用规定的智能网个性资费，该用户智能网资费不满足业务规定!");
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
	    	frm.action="fg124_1.jsp";
	    	document.all.opcode.value="g124";
	  }else if(opFlag=="two")
	  {
			if(document.all.backaccept.value=="")
			{
	    		rdShowMessageDialog("请输入业务流水！");
	    		return;
	    	}
	    	frm.action="fg125_1.jsp";
	    	document.all.opcode.value="g125";
	  }
	}
  }
  frm.submit();
  return true;
}
function opchange(){
	document.all.backaccept_id.style.display = "";
}
</script>
</head>
<body>

<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
	<tr>
		<TD class="blue">操作类型</TD>
		<TD>
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正&nbsp;&nbsp;
		</TD>
			<input type="hidden" name="opcode" >
	</tr>
	<tr>
		<td class="blue">
		<div align="left">手机号码</div>
		</td>
		<td>
		<div align="left">
			<input class="InputGrey"  type="text" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id">
		<TD class="blue">业务流水</TD>
 		<TD>
			<input type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR>
	<TR>
		<td colspan="2" id="footer">
		<div align="center">
			<input class="b_foot" type="button" name="confirm" value="确认" onClick="doCfm(this)" index="2">
			<input class="b_foot" type=button name="back" value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name="qryP" value="关闭" onClick="removeCurrentTab();">
		</div>
		</td>
	</tr>
	</table>

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<input type="hidden" name="iOpCode" value="<%=opCode%>">
 <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>

</body>
</html>