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
<title>���ʷ��ײͰ��²���</title>
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
    if(opCode=="5471"){
    	document.all.opFlag[0].checked=true;	
    }
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
	    	frm.action="f5471_confAdd.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="A";
	    	document.all.opName.value="�����ʷ��ײͰ��·�";
	    	
	  }else if(opFlag=="two")
	  {   
	    	frm.action="f5471_confAlt.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="U";
	    	document.all.opName.value="�޸��ʷ��ײͰ��·�";
	  }
	  else if(opFlag=="three")
	  {   
	    	frm.action="f5471_confDlt.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="D";
	    	document.all.opName.value="ɾ���ʷ��ײͰ��·�";
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
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
	  <TR> 
		<TD class="blue">��������</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" checked >����&nbsp;&nbsp;			
			<input type="radio" name="opFlag" value="two" >�޸�&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" >ɾ��
		</TD>
         </TR>    
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type="hidden" name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
      
 <input type="hidden" name="opCode" value="<%=opCode%>" >
 <input name="op_flag" type="hidden"  id="op_flag" >  
<input type="hidden" name="opName" value="<%=opName%>" >
 <%@ include file="/npage/include/footer_simple.jsp" %>        
   </form>
   
</body>
</html>
