<%
/********************
 * version v2.0
 * ������: si-tech
 * author: daixy
 * date  : 20100226
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>BlackBerry����ҵ��</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
	String userPhoneNo=request.getParameter("activePhone");
    if(null==userPhoneNo||userPhoneNo.equals("")){
      userPhoneNo = request.getParameter("phone_no");
    }
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    if("<%=opCode%>" == "9455"){
        document.all.opFlag[0].checked = true;
    }else if("<%=opCode%>" == "9456"){
        document.all.opFlag[1].checked = true;
    }else if("<%=opCode%>" == "9457"){
        document.all.opFlag[2].checked = true;
    }else{
    	document.all.opFlag[3].checked = true;
    }
  }
function formclear(){
	frm.reset();
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
	    	frm.action="f9455_1.jsp";
	    	document.all.opCode.value="9455";
	    	document.all.opName.value="BlackBerry����ҵ��ע��"
	    	
	  }else if(opFlag=="two")
	  {
	    	frm.action="f9456_1.jsp";
	    	document.all.opCode.value="9456";
	    	document.all.opName.value="BlackBerry����ҵ��ע��"
	    	
	  }else  if(opFlag=="thr")
	  {
	  	  	frm.action="f9457_1.jsp";
	    	document.all.opCode.value="9457";
	    	document.all.opName.value="BlackBerry����ҵ���û���Ϣ���"
	  }else{
	  	  	frm.action="f9458_1.jsp";
	    	document.all.opCode.value="9458";
	    	document.all.opName.value="BlackBerry����ҵ����ͣ/�ָ�"
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
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="">
    <table cellspacing="0">
	  <TR> 
	     <TD class="blue">��������</TD>
         <TD colspan=4>
        	<input type="radio" name="opFlag" value="one" >ע��
        	<input type="radio" name="opFlag" value="two" >ע��
        	<input type="radio" name="opFlag" value="thr" >�û���Ϣ���
        	<input type="radio" name="opFlag" value="four" >��ͣ/�ָ�
	     </TD>
      </TR>
         
      <tr> 
         <td class=blue width="25%" nowrap>�ֻ�����</td>
         <td nowrap colspan=3> 
             <input class="InputGrey"  type="text" size="12" name="iPhoneNo" value="<%=userPhoneNo%>" id="iPhoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
             <font class="orange">*</font></div>
      </tr>
         
      <tr id="footer"> 
          <td colspan="4" > 
            <div align="center"> 
            <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">  
            <input class="b_foot" type=button name=back value="���" onClick="formclear();">  
		    <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
            </div>
         </td>
      </tr>
    </table>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
