<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.8
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
<title>����Ӫ����</title>
<%
	
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    
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
    //document.all.srv_no.focus();
    var opCode = "<%=opCode%>";
    if(opCode=="7964"){
    	document.all.opFlag[1].checked=true;	
    }else if(opCode=="7965"){
    	document.all.opFlag[2].checked=true;	
    }else if(opCode=="7966"){
    	document.all.opFlag[3].checked=true;	
    }else if(opCode=="7967"){
    	document.all.opFlag[4].checked=true;	
    }
    opchange();
  }

 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }


//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  //if(!check(frm)) return false; 
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    	frm.action="f7960_req.jsp";
	    	document.all.opCode.value="7960";
	    	document.all.opName.value="����Ӫ��������";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="f7960_clear.jsp";
	    	document.all.opCode.value="7964";
	    	document.all.opName.value="����Ӫ��������";
	  }
	  else if(opFlag=="three")
	  {
	  		frm.action="f7960_nextSign.jsp";
	    	document.all.opCode.value="7965";
	    	document.all.opName.value="����Ӫ������ǩ";
	  }
	  else if(opFlag=="four")
	  {
	  	if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="f7960_signClear.jsp";
	    	document.all.opCode.value="7966";
	    	document.all.opName.value="����Ӫ������ǩ����";
	  }
	  else if(opFlag=="five")	
	  {
	  		frm.action="f7960_cancel.jsp";
	    	document.all.opCode.value="7967";
	    	document.all.opName.value="����Ӫ����ȡ��";
	  }		
	}
  }
  
  frm.submit();	
  return true;
}
function opchange(){
	
	  if(document.all.opFlag[0].checked==true) {	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else if(document.all.opFlag[1].checked==true){
	  	document.all.backaccept_id.style.display = "";   	
	  }else if(document.all.opFlag[2].checked==true){	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else if(document.all.opFlag[3].checked==true){	  	
	  	document.all.backaccept_id.style.display = "";
	  }else if(document.all.opFlag[4].checked==true) {	  	
	  	document.all.backaccept_id.style.display = "none";
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
		<TD class="blue">��������</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()" >����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" onclick="opchange()" >��ǩ&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="four" onclick="opchange()" >��ǩ����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="five" onclick="opchange()" >ȡ��
		</TD>
		      <input type="hidden" name="op_code" >
         </TR>    
         <tr> 
            <td class="blue"> 
              <div align="left">�ֻ�����</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="text" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
            </td>
            <td > 
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="hidden" name="cus_pass" id="cus_pass" size="20" maxlength="8" value="�û�����" disabled>
            </td>
            
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD class="blue">ҵ����ˮ</TD>
              <TD>
			<input type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
	          </TD>
         </TR>    
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
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
