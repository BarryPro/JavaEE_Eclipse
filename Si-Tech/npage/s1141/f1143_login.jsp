<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>
	
<head>
<title>���ֻ���</title>
<%
  activePhone=(String)request.getParameter("activePhone"); 
	  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  //String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  //ArrayList agentCodeArr = co.spubqry32("2",sql);
%>

<script language=javascript>
	
  onload=function()
  {
     opchange();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  //controlButt(subButton);//��ʱ���ư�ť�Ŀ�����

  if(!check(frm)) return false; 
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f1143_1.jsp";
	    	document.all.opcode.value="1143";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowConfirmDialog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="f1144_1.jsp";
	    	document.all.opcode.value="1144";
	    	
	  }
	}
  }
 
  frm.submit();	
  return true;
}
function opchange(){
	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  	document.getElementById("backaccept").readOnly=true;
	  }else {
	  	document.all.backaccept_id.style.display = "inline";
	  	document.getElementById("backaccept").readOnly=false;
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
	  	  <tr> 
	          <td class="blue" width="16%">��������</td>
              <td>
				  <input type="hidden" name="opFlag" value="one" onclick="opchange()" >
		          <input type="radio" name="opFlag" value="two" onclick="opchange()" checked>����
	          </td>	          
		          <input type="hidden" name="opcode">		      		      
          </tr>           
          <tr> 
              <td class="blue" width="16%">�ֻ�����</td>
              <td> 
                  <input type="text" size="12" Class="InputGrey" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value="<%=activePhone%>" readOnly>
              </td>            		  			  	     
          </tr>
          <tr class="blue"  id="backaccept_id"> 
	          <td class="blue">ҵ����ˮ</td>
              <td>
			      <input type="text" name="backaccept" v_must=1 size="12" maxlength="12" readOnly>
			      <font color="orange">*</font>
	          </td>	 	 	          
       
         </tr>   
      </table>
      <table cellspacing="0">
         <tr> 
            <td align="center" id="footer"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type="button" name=back value="���" onClick="backaccept.value=''">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
             </td>
         </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
   
</body>
</html>
