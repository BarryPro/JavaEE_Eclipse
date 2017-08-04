<%
/********************
 version v2.0
 开发商: si-tech
 模块: 虚拟网管理
 update zhaohaitao at 2010.5.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<head>
<title>三城一网</title>
<%

	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String phoneNo1 = request.getParameter("activePhone");
    String workNo =  (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    System.out.println("opCode========="+opCode);
    System.out.println("opName========="+opName);
    System.out.println("phoneNo========="+phoneNo);
    System.out.println("phoneNo1========="+phoneNo1);
    System.out.println("workNo========="+workNo);
    System.out.println("regionCode========="+regionCode);
    
	
%>
<%
	 if(opCode.equals("8439")||opCode.equals("8440")){
	%>
	<wtc:utype name="sLinkOprChk" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:uparam value="<%=phoneNo%>" type="STRING"/>  
	<wtc:uparam value="<%=opCode%>" type="STRING"/>
	<wtc:uparam value="<%=workNo%>" type="STRING"/>
	</wtc:utype>
	 <%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 if(!retCode.equals("0")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
	removeCurrentTab();
</script>
<%	 
	 }%>
	 <%
	 }%>
 
			
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	
	document.all.phoneNo1.focus();
	document.all.opFlag.value= "one";
	document.all.member_id.style.display="none";
	document.all.member_id1.style.display="none";
	document.all.member_id2.style.display="none";
	document.getElementById("opCode").value='8439';
    document.getElementById("opName").value='虚拟网组建';
	
}

function onClick1()
{   
	document.frm.confirm.disabled =false;
	$("#resultListDiv table").remove();
	document.all.opr_type.style.display="";
	document.all.open_type.options[0].selected=true;
	document.all.member_id.style.display="none";
	document.all.member_id1.style.display="none";
	document.all.member_id2.style.display="none";
	document.getElementById("opCode").value='8439';
    document.getElementById("opName").value='虚拟网组建';
    document.all.member_id3.style.display="";

}
  
function onClick3(){
	document.frm.confirm.disabled = false;
	document.all.opr_type.style.display="none";
	document.all.family_id.style.display="";
	document.all.member_id.style.display="none";
	document.all.member_id1.style.display="none";
	document.all.member_id2.style.display="none";
	document.getElementById("opCode").value='8444';
    document.getElementById("opName").value='虚拟网信息查询';  
    document.all.member_id3.style.display="none";
   
}
function chg_opType(){
    	
    	if(document.all.open_type.value=='0')
    	{
    		document.frm.confirm.disabled = false;
    		document.all.member_id.style.display="none";
    		document.all.member_id1.style.display="none";
    		document.all.member_id2.style.display="none";
    		document.getElementById("opCode").value='8439';
    		document.getElementById("opName").value='虚拟网组建';
    		document.getElementById("iccid").value='';
   		}
     	if(document.all.open_type.value=='1')
     	{
        	//document.frm.confirm.disabled = true;
        	document.all.member_id.style.display="";
        	document.all.member_id1.style.display="none";
        	document.all.member_id2.style.display="none";
        	document.getElementById("opCode").value='8440';
    		document.getElementById("opName").value='虚拟网成员加入';
    		document.getElementById("iccid").value='';
    	}
     	if(document.all.open_type.value=='4')
     	{
        	document.frm.confirm.disabled = false;
        	document.all.member_id.style.display="none";
        	document.all.member_id1.style.display="none";
        	document.all.member_id2.style.display="none";
        	document.getElementById("opCode").value='8443';
    		document.getElementById("opName").value='虚拟网成员退出';
    		document.getElementById("iccid").value='';
    	}
    	if(document.all.open_type.value=='3')
     	{
        	//document.frm.confirm.disabled = true;
        	document.all.member_id1.style.display="";
        	document.all.member_id.style.display="none";
        	document.all.member_id2.style.display="none";
        	document.getElementById("opCode").value='8442';
    		document.getElementById("opName").value='虚拟网成员变更';
    		document.getElementById("iccid").value='';
    	}
    	if(document.all.open_type.value=='2')
     	{
        	document.frm.confirm.disabled = false;
        	document.all.member_id1.style.display="none";
        	document.all.member_id.style.display="none";
        	document.all.member_id2.style.display="";
        	document.getElementById("opCode").value='8441';
    		document.getElementById("opName").value='虚拟网成员冲正';
    		document.getElementById("iccid").value='';
    	}
  
   
}
 
function doCfm(subButton)
{
	document.getElementById("phone_no1").value=document.getElementById("phoneNo1").value;
	document.getElementById("iccid1").value=document.getElementById("iccid").value;
	if(document.all.open_type.value=='3')
	{
		document.getElementById("phone_no2").value=document.getElementById("phoneNo3").value;
		if(document.getElementById("phoneNo1").value==document.getElementById("phoneNo3").value)
		{
			rdShowMessageDialog("用户号码不能和变更成员号码相同!",0);
			return false;
		}
		if(document.getElementById("phoneNo3").value=="")
		{
			rdShowMessageDialog("变更成员号码不能为空!",0);
			return false;
		}
	}
	if(document.all.open_type.value=='1')
	{
		document.getElementById("phone_no2").value=document.getElementById("phoneNo2").value;
		if(document.getElementById("phoneNo1").value==document.getElementById("phoneNo2").value)
		{
			rdShowMessageDialog("用户号码不能和已有成员号码相同!",0);
			return false;
		}
		if(document.getElementById("phoneNo2").value=="")
		{
			rdShowMessageDialog("已有成员号码不能为空!",0);
			return false;
		}
	}
	if(document.all.open_type.value=='2')
	{
		if(document.getElementById("vBackAccept").value=="")
		{
			rdShowMessageDialog("流水不能为空!",0);
			return false;
		}
		
	}
	var radio1 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio1.length;i++)
  	{
  		if(radio1[i].checked)
		{
	 		 var opFlag = radio1[i].value;
	 		 if(opFlag=="one")
	 		 {
	 		 	 if(forIdCard(document.getElementById("iccid"))==false)
    	{return false;}
	 		 	frm.action="f8439_2.jsp";
				frm.submit();
	 		 }else{
	 		 	ajaxGetAutoMsg();
	 		 }
	 	}
  	}
}

function ajaxGetAutoMsg()
{
	
	var packet = new AJAXPacket("ajaxGetMsg.jsp","请稍后...");
	packet.data.add("phone_no1" ,document.getElementById("phone_no1").value);
    packet.data.add("opCode","8444");
    packet.data.add("opName" ,"虚拟网信息查询");
 
  	core.ajax.sendPacket(packet,doAjaxGetAutoMsg);
}

function doAjaxGetAutoMsg(packet)
{
	$("#resultListDiv table").remove();
	var return_code = packet.data.findValueByName("return_code"); 
	var return_msg =packet.data.findValueByName("return_msg");
	var retAry = packet.data.findValueByName("retAry");
	if(return_code=='999999')
	{
		rdShowMessageDialog(return_msg); 
	}
	if(return_code == "111111")
	{
		rdShowMessageDialog('没有查到此号码相关的虚拟网信息！');
	}
	else
	{
		initTab(retAry);
	}
	
	
}		
function initTab(retAry)
{
	$("#resultListDiv table").remove();
	$("#resultListDiv").append("<table id='resultListTab'><thead><tr style='cursor:hand'><th>成员号码</th><th>用户名称</th><th>业务受理时间</th><th>生效时间</th><th>失效时间</th></tr></thead></table>");
	for(var i=0 ; i<retAry.length; i++)
	{
		
		var vMemberId = retAry[i][0];
		var vGroupId = retAry[i][1];
		var accNbr = retAry[i][2];
		var vServId=retAry[i][3];
		var vMemberDesc=retAry[i][4];
		var memRoleId=retAry[i][5];
		var vExpDate=retAry[i][6];
		var vEffDate=retAry[i][7];
		var vCustName=retAry[i][8];
		var stateDate=retAry[i][9];
	    $("#resultListTab").append("<tr><td>"+accNbr+"</td><td>"+vCustName+"</td><td>"+stateDate+"</td><td>"+vEffDate+"</td><td>"+vExpDate+"</td></tr>");
	}
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
	      <TR> 
	          <TD class="blue">操作类型</TD>
              <TD colspan=3>
			       <input type="radio" name="opFlag" value="one" checked onClick="onClick1()">业务办理&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" onClick="onClick3()">虚拟网信息查询&nbsp;&nbsp;
	          </TD>
	          
         </TR>
         <tr id="family_id"> 
            <td class="blue" nowrap> 
              <div align="left">用户号码</div>
            </td>
			<td colspan=3> 
                <input class="InputGrey"  type="text" name="phoneNo1" id="phoneNo1" v_minlength=1 v_maxlength=16  v_type="string" v_must=1 index="0" value="<%=phoneNo%>" readonly>
            </td>
            </tr> 
            <tr id="member_id3">
            <td class="blue" nowrap> 
              <div align="left">身份证号码</div>
            </td>
			<td colspan=3> 
                <input class=""  type="text" name="iccid" id="iccid" v_minlength=1 v_maxlength=19 size="18" maxlength=18 v_type="string" v_must=1 index="0">
            </td>
            </tr>
        
		 <tr id="member_id" style='none'> 
            <td class="blue"> 
              <div align="left">已有成员号码</div>
            </td>
			<td colspan=3> 
                <input class="button"  type="text" name="phoneNo2" id="phoneNo2" v_minlength=1 v_maxlength=12 size="11" maxlength=11 v_type="string" v_must=1 index="0" >
               	
            </td>
			
			 
        </tr>
        	 <tr id="member_id1" style='none'> 
            <td class="blue" > 
              <div align="left">变更成员号码</div>
            </td>
			<td colspan=3> 
                <input class="button"  type="text" name="phoneNo3" id="phoneNo3" v_minlength=1 v_maxlength=12 size="11" maxlength=11 v_type="string" v_must=1 index="0" >
               	
            </td>
			
			 
        </tr>
         <tr id="member_id2" style='none'> 
            <td class="blue"> 
              <div align="left">冲正流水</div>
            </td>
			<td colspan=3> 
                <input class="button"  type="text" name="vBackAccept" id="vBackAccept" v_minlength=1  size="18"  v_type="string" v_must=1 index="0" >
               	
            </td>
         </tr>
		 <tr id="opr_type"> 
			<td class="blue" > 
				<div align="left">申请类型</div>
            </td>
			<TD class="blue" colspan=3>
			<SELECT NAME="open_type" id="open_type" onChange="chg_opType()">
                <option value="0" selected>虚拟网组建</option>
                <option value="1">虚拟网成员加入</option>
				<option value="2">冲正</option>
				<option value="3">虚拟网变更</option>
				<option value="4">虚拟网成员退出</option>
				
				
			</SELECT>
			</TD>
         </tr>
         <tr> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button id="confirm" name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=hidden name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
     <div id="resultListDiv">
		</div>
   
   <input type="hidden" name="opCode" id='opCode'>
   <input type="hidden" name="opName" id='opName'>
   <input type="hidden" name="phone_no1" id='phone_no1'>
   <input type="hidden" name="phone_no2" id='phone_no2'>
   <input type="hidden" name="iccid1" id='iccid1'>
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
