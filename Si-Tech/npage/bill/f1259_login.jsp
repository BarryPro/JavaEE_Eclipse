<%
/********************
 version v2.0
������: si-tech
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
<head>
<title>������ǩ</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = "������ǩ";
  
	activePhone = request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	
  onload=function()
  {
  	var opCode = "<%=opCode%>";
  	var tempF = 0;
    if(opCode=="1259"){
  	 tempF=0;
  	}else if(opCode=="125a"){
  	 tempF=1;
  	}
  	 var radio1 = document.getElementsByName("opFlag");
	  for(var i=0;i<radio1.length;i++)
	  {
	    if(i==tempF){
	    		radio1[i].checked = true;
	    	}
	  }
	 ajaxGetAutoMsg();
  }


function ajaxGetAutoMsg(){ //����û��Ƿ����Զ���ǩ�û�
	
	var packet = new AJAXPacket("ajaxRetAutoMsg.jsp","���Ժ�...");
    packet.data.add("phone_no" ,"<%=activePhone%>");
  	core.ajax.sendPacket(packet,doAjaxGetAutoMsg);
  }

function doAjaxGetAutoMsg(packet){
	var vOfferAttrType = packet.data.findValueByName("return_code"); 
	if(vOfferAttrType == "000000")
	{
		rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�Զ���ǩ�û�����ʾ�û��Ƿ�������������ǩ��');
	}
	
}				




//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag == "four")
	  {
		frm.action="f1259Main.jsp";
	  }else if(opFlag == "five")
	  {
		  frm.action = "f125aMain.jsp";
	  }
	}
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�����������ײ�</div>
		</div>
		     
      <table cellspacing="0">        
	      <tr> 
	          <td class="blue">��������</td>
              <td colspan="2">
				   <input type="radio" name="opFlag" value="four" >��ǩ&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="five" >��ǩ���� 					
	          </td>
	        
         </tr>
         <tr> 
            <td class="blue">�ֻ�����</td>
            <td>                
                <input Class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">               
            </td>
            <td  class="blue" style="display:none"> 
                <div align="left">�û�����</div>
            </td>                     
			    <input type="hidden" Class="InputGrey" name="cus_pass" size="20" maxlength="8"> 		    				
         </tr>       
         <tr> 
            <td colspan="3"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">&nbsp;&nbsp;&nbsp;                 
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     
 	<input type="hidden" name="returnPage" value="f1205_login.jsp?activePhone=<%=activePhone%>"
    <%@ include file="/npage/include/footer_simple.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
