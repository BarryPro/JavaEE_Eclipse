<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������־��ֲ�����(��)��Ա</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("activePhone");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

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
    if("<%=opCode%>" == "2278"){
        document.all.opFlag[2].checked = true;
        opchange();
    }else if("<%=opCode%>" == "2297"){
        document.all.opFlag[1].checked = true;
        opchange();
    }else{
        document.all.opFlag[0].checked = true;
        opchange();
    }
  }
function formclear(){
//	frm.reset();
	if(document.all.opFlag[0].checked==true || document.all.opFlag[2].checked) 
	{
	  	
//	  	document.all.backaccept_id.style.display = "none";
	  }else {
//	  	document.all.backaccept_id.style.display = "";
	  	
	  }
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
	    	frm.action="f2296_1.jsp";
	    	document.all.opcode.value="2296";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	alert("������ҵ����ˮ��");
	    	return;
	    }
	   
	    	frm.action="f2297_1.jsp";
	    	document.all.opcode.value="2297";
	    	
	  }
	  else{
	  	  frm.action="f2278_1.jsp";
	    	document.all.opcode.value="2278";
	  }
	}
  }
	    
	
 
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true || document.all.opFlag[2].checked) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	
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
<input type="hidden" name="opcode" >
      <table cellspacing="0">
	  <TR> 
	          <TD class="blue">��������</TD>
              <TD colspan=3>
        		<input type="hidden" name="opFlag" value="one" onclick="opchange()"  >
        		<input type="hidden" name="opFlag" value="two" onclick="opchange()" >
        		<input type="radio" name="opFlag" value="thr" onclick="opchange()" checked>�˶�
	          </TD>
         </TR>    
         <tr> 
            <td class=blue width="25%" nowrap>�ֻ�����</td>
            <td nowrap cospan=3> 
                <input class="InputGrey"  type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
                <font class="orange">*</font></div>
            
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD class="blue">ҵ����ˮ</TD>
              <TD colspan="3">
			<input type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
	          </TD>
         </TR>    
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
