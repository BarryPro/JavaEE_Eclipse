<%
/********************
 version v2.0
������: si-tech
<!-- baixf 20080613 modify �����������������������Ƹ���Ϊ�����ſͻ���ҵӦ��������  -->
********************/

%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.06
 ģ��:���ſͻ���ҵӦ������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���ſͻ���ҵӦ������</title>
<%

	String phoneNo = request.getParameter("activePhone"); 
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
    String work_no = (String)session.getAttribute("workNo");
    
%>
<%
 
/***************��Ҫ�жϹ����Ƿ��Ǽ��Ź���*****************/

  String sql1 = " select dept_code from dloginmsg where login_no='" +work_no+"'";
  String[] inParams = new String[2];
  inParams[0] = " select dept_code from dloginmsg where login_no=:work_no";
  inParams[1] = "work_no="+work_no;
  //System.out.println("sql1====="+sql1);
  //ArrayList agentCodeArr1 = co1.spubqry32("1",sql1);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="agentCodeStr1"  scope="end"/>
<%
  String dept="";
  if(agentCodeStr1.length>0)
  	dept=agentCodeStr1[0][0];
  //System.out.println("dept========="+agentCodeStr1[0][0]);
 %>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    opchange();
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
	  	
	    	frm.action="f8032_1.jsp";
	    	document.all.opcode.value="8032";
	    	document.all.opname.value="���ſͻ���ҵӦ������";
			document.all.dept.value='<%=dept%>';
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	   
	    	frm.action="f8033_1.jsp";
	    	document.all.opcode.value="8033";
	    	document.all.opname.value="���ſͻ���ҵӦ����������";
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
 <input type="hidden" name="opcode">
 <input type="hidden" name="opname">
 <input type="hidden" name="dept" >

      <table cellspacing="0">
	  <TR> 
          <TD class="blue">��������</TD>
          <TD>
			<input type="hidden" name="opFlag" value="one" onclick="opchange()" >
			<input type="radio" name="opFlag" value="two" onclick="opchange()"  checked >����
	      </TD>
       </TR>    
         <tr> 
            <td class="blue"> 
              <div align="left">�ֻ�����</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  readOnly index="0">
            </td>
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD class="blue">ҵ����ˮ</TD>
              <TD>
				<input type="text" name="backaccept">
				<font color="orange">*</font>
	          </TD>
         </TR>    
         </tr>
         <tr> 
            <td id="footer" colspan="2"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>