<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ�����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
  response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
%>
<head>
<title>���ʷ���ƻ�����</title>
<%

	String workNo = (String)session.getAttribute("workNo");
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  { }

   /************************************************************
  	*�����7127,7128�����������������߱��,��תһ��ҳ��
  	*7127�Ǽ�ͥ����ƻ������������
  	*7128�Ǽ�ͥ����ƻ����������
  	***********************************************************/
	function doProcess(packet)
	{
		if(eval('frm.qry_type').value =="1")
		{
			var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode"); 
    	var retMessage = packet.data.findValueByName("retMessage");	
    	var retFlag = packet.data.findValueByName("retFlag");	
    	if(retType == "getPwd")
			{
				if(retCode == "000000" && retFlag != "1")
				{
				   rdShowMessageDialog("������֤�ɹ���");
				   document.all.confirm.disabled=false;
				}	        
				else
				{
				  retMessage = retMessage + "������ȷ�ϣ�";
				  document.frm.passwd.value="";
				  document.frm.passwd.focus(); 
				  document.all.confirm.disabled=true;
  				rdShowMessageDialog(retMessage,0);
					return false;
				}
			}
		}
		else
		{
			var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode"); 
    	var retMessage = packet.data.findValueByName("retMessage");	
    	var retFlag = packet.data.findValueByName("retFlag");	
    	if(retType == "getPwd")
			{
				if(retCode == "000000" && retFlag != "1")
				{
				   rdShowMessageDialog("������֤�ɹ���");
				   document.all.confirm.disabled=false;
				}	        
				else
				{
				  retMessage = retMessage + "������ȷ�ϣ�";
				  document.frm.passwd2.value="";
				  document.frm.passwd2.focus(); 
				  document.all.confirm.disabled=true;
  				rdShowMessageDialog(retMessage,0);
					return false;
				}
			}
		}	
	}
	
	function rpc_chkX()
	{
		if(eval('frm.qry_type').value =="1")
		{
				if(document.all.passwd.value == "")
	  		{
	  		    rdShowMessageDialog("���������룡",0);
	  		    document.all.passwd.focus();
	  		    return false;
	  		}
	  		else if(document.all.passwd.value.length != 6)
	  		{
	  				rdShowMessageDialog("���볤����������������6λ���룡",0);
	  				document.all.passwd.value = "";
	  		    document.all.passwd.focus(); 
	  		    return false;
	  		}
	  		
			//2010-10-2 wanghfa�޸� ������� start
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType", "01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo", document.frm.chief_no.value);			//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.all.passwd.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType", "un");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");					//����
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			//2010-10-2 wanghfa�޸� ������� end
		}
		else if(eval('frm.qry_type').value =="2")
	  {
		  	if(document.all.passwd2.value == "")
	  		{
	  		    rdShowMessageDialog("���������룡",0);
	  		    document.all.passwd2.focus();
	  		    return false;
	  		}
	  		else if(document.all.passwd2.value.length != 6)
	  		{
	  				rdShowMessageDialog("���볤����������������6λ���룡",0);
	  				document.all.passwd2.value = "";
	  		    document.all.passwd2.focus(); 
	  		    return false;
	  		}
			//2010-10-2 wanghfa�޸� ������� start
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType", "01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo", document.frm.srv_no.value);			//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.all.passwd2.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType", "un");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");					//����
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd1);
			checkPwd_Packet=null;
			//2010-10-2 wanghfa�޸� ������� end
		}
	}

//2010-10-2 wanghfa�޸� ������� start
function doCheckPwd(packet) {
	var retResult = packet.data.findValueByName("retResult");
	var msg = packet.data.findValueByName("msg");
	
	if (retResult != "000000") {
		rdShowMessageDialog(msg);
		document.frm.passwd.value="";
		document.frm.passwd.focus(); 
		document.all.confirm.disabled=true;
		return false;
	} else {
		rdShowMessageDialog("������֤�ɹ���");
		document.all.confirm.disabled=false;
	}
}

function doCheckPwd1(packet) {
	var retResult = packet.data.findValueByName("retResult");
	var msg = packet.data.findValueByName("msg");
	
	if (retResult != "000000") {
		rdShowMessageDialog(msg, 0);
		document.frm.passwd2.value="";
		document.frm.passwd2.focus(); 
		document.all.confirm.disabled=true;
		return false;
	} else {
		rdShowMessageDialog("������֤�ɹ���", 2);
		document.all.confirm.disabled=false;
	}
}
//2010-10-2 wanghfa�޸� ������� end


function onClick1(){
			document.all.confirm.disabled=false;
  	  document.all.opr_type.style.display="";
  	  document.all.family_id.style.display="";
  	  document.all.chief_srv_no.style.display="";
  	  document.all.query_type.style.display="none";
  	  document.all.open_type.options[0].selected=true;
  	  document.all.main_id.style.display="none";
  	  document.all.second_id.style.display="none";
  	}  
function onClick3(){
		document.all.confirm.disabled=true;				
		document.all.family_id.style.display="none";
	  document.all.chief_srv_no.style.display="none";
	  document.all.query_type.style.display="";
	  document.all.opr_type.style.display="none";
	  document.all.qry_type.options[0].selected=true;
	  document.all.chief_no.value="";
	  document.all.srv_no.value="";
		chg_qryType();
		}
function chg_qryType1(){			 	
	 		document.all.main_id.style.display="";
	 		document.all.chief_no.value="<%=phoneNo%>";
	 		document.all.second_id.style.display="none";
	 	}
function chg_qryType2(){
	 		document.all.main_id.style.display="none";
	 		document.all.second_id.style.display="";
	 		document.all.srv_no.value="<%=phoneNo%>";
	 	}	
function chg_qryType(){
	
	if(eval('frm.qry_type').value =="1")
	{
	  chg_qryType1();
	}
	else if(eval('frm.qry_type').value =="2")
	{
	  chg_qryType2();
	 }	
}
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
		{
	  	var opFlag = radio1[i].value;
	  	if(opFlag=="one")
	  	{
	  		if(eval('frm.open_type').value =="one")
	  		{
	  			document.all.opName.value="���ʷ�������"; 
	  			document.all.opCode.value="7327";
	  			document.all.op_flag.value="a";
	  		  document.frm.action="f7327_2.jsp";
	  		}else if(eval('frm.open_type').value =="two")
	  		{
	  			document.all.opName.value="���ʷ�����";
	  			document.all.opCode.value="7387";
	  		  document.all.op_flag.value="u";
	  		  document.frm.action="f7327_3.jsp";
	  		}else if(eval('frm.open_type').value =="three")
	  		{
	  			document.all.opName.value="���ʷ���ȡ��";
	  			document.all.opCode.value="7389";
	  		  document.all.op_flag.value="d";
	  		  document.frm.action="f7327_4.jsp";
	  		}
	  	}
	  	else if(opFlag=="two")
	  	{
	    	if(eval('frm.qry_type').value =="1")
	    	{
	    		if(document.all.chief_no.value=="")
	    		{
	    			rdShowMessageDialog("�������벻��Ϊ�գ�");	
	    			document.all.chief_no.focus();
	    			return false;
	    		}	
	    		else if(document.all.chief_no.value.length < 11)
	    		{
	    			rdShowMessageDialog("���볤�ȴ������������룡");
	    			document.all.chief_no.value="";	
	    			document.all.chief_no.focus();
	    			return false;
	    		}
	    		document.all.op_Flag.value="0";	
	    	}
	    	else if(eval('frm.qry_type').value =="2")
	    	{
	    		if(document.all.srv_no.value=="")
	    		{
	    			rdShowMessageDialog("�������벻��Ϊ�գ�");	
	    			document.all.srv_no.focus();
	    			return false;
	    		}	
	    		else if(document.all.srv_no.value.length < 11)
	    		{
	    			rdShowMessageDialog("���볤�ȴ������������룡");	
	    			document.all.srv_no.value="";	    			
	    			document.all.srv_no.focus();	    			
	    			return false;
	    		}
	    		document.all.op_Flag.value="1";		
	    	}
	    	document.all.opCode.value="7327";
	    	//alert(document.all.banli.value+"|"+document.all.opCode.value+"|"+document.all.op_Flag.value);	
	    	frm.action="f7327_5.jsp";
	  	}	
		}
  }
  //alert(document.all.op_flag.value);
  frm.submit();
  return true;
}
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  } 
  
  
  
  /************************************************************
  	*�����7127,7128�����������������߱��,��תһ��ҳ��
  	*7127�Ǽ�ͥ����ƻ������������
  	*7128�Ǽ�ͥ����ƻ����������
  	***********************************************************/
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
	          <TD class="blue">��������</TD>
              <TD colspan="3">
			       <input type="radio" name="opFlag" value="one" checked onClick="onClick1()">ҵ�����&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" onClick="onClick3()">��Ϣ��ѯ&nbsp;&nbsp;
	          </TD>
         </TR>
         <tr id="family_id">
            <td class="blue">
              <div align="left">�������</div>
            </td>
					<td>
                <input type="text" class="InputGrey" name="chief_srv_no" id="chief_srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0" value="<%=phoneNo%>" readonly >
                <font color="orange"></font>
            </td>			           
         </tr>
         <tr id="opr_type"> 
			<td class="blue" > 
				<div align="left">��������</div>
            </td>
			<TD class="blue" colspan=3>
			<SELECT NAME="open_type" id="open_type">
                <option value="two">���ʷ�����</option>
				<option value="three" >���ʷ���ȡ��</option>
			</SELECT>
		</tr>
			<tr id="query_type" style="display:none"> 
			<td class="blue" > 
				<div align="left">��ѯ����</div>
            </td>
			<TD class="blue" colspan=3>
			<SELECT NAME="qry_type" id="qry_type" onChange="chg_qryType()">
                <option value="1" selected >������ѯ</option>
                <option value="2" >������ѯ</option>
			</SELECT>
			</TD>
      </tr>
      <tr id="main_id" style="display:none"> 
         <td class="blue" nowrap> 
             <div align="left">��������</div>
         </td>
			<td> 
          <input class="button"  type="text" name="chief_no" id="chief_no" v_minlength=1 v_maxlength=16  v_type="string" index="0" >
          <font color="orange">*</font>
      </td>
      <td class="blue" nowrap> 
              <div align="left" >���룺</div>
      </td>
             <TD>
			    <input name="passwd" type="password" class="button" id="passwd" >	
					<input type="button" name="idCheck" class="b_text" value="��֤" onclick="rpc_chkX()" >			
				  </td>

     </tr>
		 <tr id="second_id" style="display:none"> 
            <td class="blue"> 
              <div align="left">��������</div>
            </td>
			<td> 
                <input class="button"  type="text" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 maxlength="12" v_type="string" index="0">
                <font color="orange">*</font>
            </td>
			<td nowrap class="blue"> 
              <div align="left">���룺</div>
       </td>
       <TD>
        	<input name="passwd2" type="password" class="button" id="passwd2" >	
					<input type="button" name="idCheck" class="b_text" value="��֤" onclick="rpc_chkX()" >							  
			</td>
     </tr>
         <tr>
            <td colspan="5" id="footer">
              <div align="center">
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
   <input name="op_flag" type="hidden"  id="op_flag" >  
   <input name="op_Flag" type="hidden"  id="opFlag" >
   <input type="hidden" name="op_code" value="7327">
   <input type="hidden" name="opCode">
   <input type="hidden" name="mem_num">
   <input type="hidden" name="opName" value="<%=opName%>">
    <%@ include file="/npage/include/footer_simple.jsp" %> 
    <%@ include file="/npage/common/pwd_comm.jsp" %> 
   </form>
</body>
</html>
