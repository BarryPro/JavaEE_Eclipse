<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ԥ���1362
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
 	String opCode="g683";//request.getParameter("opCode");
	String opName="��ͥ�˷�";//request.getParameter("opName");
	 
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	String pwrf1="N";
    
        
	Date date = new Date();
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	 

	activePhone = request.getParameter("activePhone");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>������BOSS-��Ԥ���</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
 
 
<body onload="inits()">
<form action="s1362_2.jsp" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">ѡ���û�����</div>
	</div>
<table cellspacing="0" >
	 
	<tr> 
		<th>�û�����</th>
		<th>
			 
			<input name="busytype" type="radio"  value="1" checked>
			�����û�
		</th>
		<th colspan="2">���ţ�<%=orgCode%> </th>
	</tr>

	<tr> 

		<td  class="blue">��������</td>
		<td colspan=3>
			<select name="bank_name" id= "selOp" onchange="selType()">
				 
				<option value="1" selected>�ҳ�����</option>
				 
			</select>
			<!--
			<select name="bank_name" id= "selOp" onchange="selType()">
				<option value="0" >---��ѡ��</option>
				<option value="1" selected>�ҳ�����</option>
				<option value="2" >��ͥ����</option> 
			</select>
			-->
		</td>


		 
		 
	</tr>

	<tr id="jz"> 
		<td class="blue">�ҳ�����</td>
		<td colspan=3> 
			<input type="text" name="jzPhone" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" value="<%=activePhone%>"  >
		</td>
		 
	</tr>
	
	<tr id="jt"> 
		<td class="blue">��ͥ����</td>
		<td colspan=3>  
			<input type="text" name="jtPhone" maxlength="11"  onKeyPress="return isKeyNumberdot(0)">
		</td>
		
	</tr>
	<!--
	<tr>
		<td class="blue">�û�����</td>
		<td colspan=3>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			
		</td>
	</tr>
-->
	<tr> 
		<td class="blue">��ͥ�ʻ�����</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onKeyPress="return isKeyNumberdot(0)" readonly>
		</td>
		<td class="blue">�û�����</td>
		<td>
			<input type="text" name="textfield7" class="InputGrey" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue">����Ԥ���� </td>
		<td> 
			<input type="text" name="textfield3" class="InputGrey" readonly>
		</td>
		<td class="blue">��Ƿ�� </td>
		<td> 
			<input type="text" name="textfield2" class="InputGrey" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue"> ���˽��</td>
		<td>
			<input type="text" name="textfield" class="InputGrey" readonly>
		</td>
		<td class="blue">�˷ѽ��</td>
		<td> 
			<input class="button" name=remark2 size=20 value="0.00">
		</td>
	</tr>
	<!--  add liuxmc 
	<tr>
		<td class="blue">��Ԥ�����Ϣ��ѯ��</td>
		<td class="blue" colspan="3">			
			���ڣ�<input type="text" class="button" name="reuturn_time" value="<%=now%>">��ʽ��YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="b_text"  type=button value="�� ѯ" onClick="getTKDate();">
		</td>
	</tr>
  end -->
	
	 
	<tr> 
		<td align="center" colspan="4" id="footer"> 
		<!--
			<input class="b_foot" name=sure type=button value=ȷ��>
			-->
			<input class="b_text" type=button value="��ѯ" onClick="docheck();">
			&nbsp;
			<!--<input class="b_foot" name=clear type=reset value=���>-->
			<input class="b_foot" name=clear type=button value=��� onClick="doClean()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="check_flag"  >
</form>
</body>
 <script language="JavaScript">

 function inits()
 {
	 /*
	 document.getElementById("jz").style.display="none";
	 document.getElementById("jt").style.display="none";
	 document.all.jzPhone.value="";
	 document.all.jtPhone.value="";
	*/
	 document.getElementById("jz").style.display="";
	 document.getElementById("jt").style.display="none";
	 document.all.check_flag.value="1";
 }
 function selType()
 {
	  var objSel = document.getElementById("selOp"); 
	   
	  if(objSel.value==1) //jz
	  {
		  document.getElementById("jz").style.display="";
		  document.getElementById("jt").style.display="none";
		  document.all.check_flag.value="1";
	  }
	  if(objSel.value==2) //jt
	  {
		  document.getElementById("jt").style.display="";
		  document.getElementById("jz").style.display="none";
		  document.all.check_flag.value="2";
	  }
 }
 
function docheck()
{
	//����ͨ�� �ҳ����� ����207���� ����ѯ�˷� ��Ա�Ļ� ����

	  var objSel = document.getElementById("selOp"); 
	  if(objSel.value==0)
	  {
		  rdShowMessageDialog("��ѡ���������!");
		  return false;
	  }
	  if(objSel.value==1 && (form.jzPhone.value=="" || form.jzPhone.value.length<11))
	  {
		  rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		  document.form.jzPhone.focus();
		  return false;
	  }	
	  if(objSel.value==2 && (form.jtPhone.value=="" || form.jtPhone.value.length<11))
	  {
		  rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		  document.form.jtPhone.focus();
		  return false;
	  }
	 
		 
        var myPacket = new AJAXPacket("getKdNo_new.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("jzPhone",(document.all.jzPhone.value).trim());
		myPacket.data.add("jtPhone",(document.all.jtPhone.value).trim());
		myPacket.data.add("check_flag",(document.all.check_flag.value).trim());
		myPacket.data.add("return_page","g683_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
    /*
	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    if (document.all.busy_type.value=="2") {
    	
		returnValue =window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
    } else {
	     returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
	}
	
	if(returnValue=='0')
	 {
		rdShowMessageDialog("�ʺŻ��������������",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("��û��ѡ���ʺţ�",0);
		document.form.phoneno.focus();
		return false;
	  }
	  document.form.contractno.value = returnValue;
	 
	 document.form.action="s1362_select.jsp";
     */
	 
	
}

//  add liuxmc
	function getTKDate(){
		
		var time = document.form.reuturn_time.value;
		if(time == "" || time.length==0){
			alert("���ڲ���Ϊ�գ�");
			return false;
		}
		
		if(time.length != 8){
			alert("�Բ�������������ڸ�ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
			return false;
		}

    if(time.length!=0){    
       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
       var r = time.match(reg);     
       if(r==null){
         alert("�Բ�������������ڸ�ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
         return false;
       }
     }
     
		var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
		window.showModelessDialog(path);
	}
	
	//  end
//ԤԼ�����ѯ
  
function doClean()
{
	document.all.orderId.value="";
	document.all.phoneno.value="";
	document.all.cus_pass.value="";
	document.all.contractno.value="";
	document.all.textfield7.value="";
	document.all.textfield3.value="";
	document.all.textfield2.value="";
	document.all.textfield.value="";
	document.all.remark2.value="";
}

function doProcess(packet)
{
   //alert("111");
   var retResult=packet.data.findValueByName("retResult");
   var phone_new=packet.data.findValueByName("s_phone_new");
   var s_contract_out=packet.data.findValueByName("s_contract_out");
   var ret_msg = packet.data.findValueByName("ret_msg");
   //alert("retResult is "+retResult+" ֱ�������ͥ�ʺ� ��ôУ���Ƿ���ȷ?");
   if(retResult=="true")
   {
	   document.form.action="g683_select.jsp?phoneno="+phone_new+"&contractno="+s_contract_out+"&jzPhone="+document.all.jzPhone.value;
	   form.submit();
   }	
   else
   {
	   rdShowMessageDialog(ret_msg);
   }		
   
}
</script>
</HTML>