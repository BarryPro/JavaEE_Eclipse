<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: Ԥ�����̻������ѿɷ��� 7671
   * �汾: 1.0
   * ����: 2010/4/7
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ԥ�����̻������ѿɷ���</title>
<%
    //String opCode="7671";
	//String opName="Ԥ�����̻������ѿɷ���";
	
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String PhoneHead = phoneNo.substring(0, 3);
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

onload=function()
{
  	var opCode = "<%=opCode%>";
  	if(opCode=="7671")
  	{
		
		opchange();		
  	}
  	if(opCode=="7672")
  	{
		
		opchange();			
  	}
}

//============weigp
function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check147SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
function check157SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check157SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
var flagTD = "true";
function getResult(packet){
	var result=packet.data.findValueByName("result");
	if("false"==result){
		//rdShowMessageDialog("147�Ŷ�ֻ��TD����������ܰ����ҵ��");
		//return false;
		flagTD = "false";
	}else{
		flagTD = "true";
	}
}
//============

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
	var phoneHead = <%=PhoneHead%>;
  	
  //==================weigp

  
  		if(phoneHead == '147'){
  			check147SuperTD("<%=phoneNo%>");
  			if(flagTD == "false"){
  			rdShowMessageDialog("147�Ŷ�ֻ��TD����������ܰ����ҵ��");
  			return false;
 				}
  		}
  		if(phoneHead == '157'){
  			check157SuperTD("<%=phoneNo%>");
  			if(flagTD == "false"){
  			rdShowMessageDialog("157�Ŷ�ֻ��TD����������ܰ����ҵ��");
  			return false;
 				}
  		}
 		else
      	{
				rdShowMessageDialog("ֻ��157�Ŷ�TD���������147�Ŷ�TD����������ܰ����ҵ��");
  			return false;
      	}  
  
  //====================
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				frm.action="f7671_1.jsp";
				document.all.opcode.value="7671";
			
			}else if(opFlag=="two")
			{
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��",1)
					return;
				}
				frm.action="f7672_1.jsp";
				document.all.opcode.value="7672";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange()
{
	 
	  	document.all.backaccept_id.style.display = "";
	
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked >����
		</td>
	</tr>    
	<tr> 
		<td class="blue">�ֻ����� </td>
		<td> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">ҵ����ˮ</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
