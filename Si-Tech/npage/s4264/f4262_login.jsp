<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
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
<title>������Ժ���Ϣ�޸�</title>
<%
	
    String opCode = "4262";
    String opName = "������Ժ���Ϣ�޸�";
    String phoneNo = request.getParameter("activePhone");
%>
<%
    /*begin add Ҫ��ָ�����Ų��ҹ���Ȩ�޼�����8�������ϲſ��԰���˹��� by diling @2012/5/8 17:23:28*/
    String regCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
    String  inParams [] = new String[2];
    inParams[0]="SELECT COUNT(*) FROM dloginmsg a, shighlogin b WHERE a.login_no = b.login_no AND b.op_code =:opcode AND a.power_right >= 8 AND a.login_no =:loginno";
    inParams[1]="opcode="+opCode+",loginno="+loginNo;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
      <wtc:param value="<%=inParams[0]%>"/>
      <wtc:param value="<%=inParams[1]%>"/> 
    </wtc:service>  
    <wtc:array id="retPowerRight"  scope="end"/>
<%
    System.out.println("----------4262---------retPowerRight[0][0]="+retPowerRight[0][0]);
    if(!"000000".equals(retCode1)){
%>
      <script language=javascript>
        rdShowMessageDialog("retcode��<%=retCode1%><br>retmsg��<%=retMsg1%>",0);
        removeCurrentTab();
      </script>
<%
    }else{
      System.out.println("----------4262---------retPowerRight[0][0]="+retPowerRight[0][0]);
      if(Integer.parseInt(retPowerRight[0][0])<=0){ /*count(*)>0����ù����ܰ���4262���ܣ���������*/
%>
        <script language=javascript>
          alert("<%=retPowerRight[0][0]%>");
          rdShowMessageDialog("�ù�����Ȩ�ް�������Ժ���Ϣ�޸�ҵ��",1);
          removeCurrentTab();
        </script>
<%       
      }
    }
      /*end by diling @2012/5/8 17:23:28*/
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
	var opCode = "<%=opCode%>";
}

//----------------��֤���ύ����-----------------
function check_HidPwd()
{
	if( document.frm.phoneNo.value.length != 11 )
	{
		 rdShowMessageDialog("�ֻ�����ֻ����11λ!");
		 document.frm.phoneNo.value = "";
		 return false;
	}
}

function doCfm(subButton)
{
	if(document.frm.phoneNo.value=="")
  	{
	     rdShowMessageDialog("�������ֻ�����!");
	     document.frm.phoneNo.focus();
	     return false;
  	}
	frm.submit();	
	return true;
}

</script>
</head>
<body>
<form name="frm" method="POST" action="f4262_1.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
	  	<tr> 
		  <td class="blue">��������</td>
		  <td>
			<input type="text" name="opFlag" class="InputGrey" value="��Ϣ�޸�" readonly>&nbsp;&nbsp;
		  </td>
      	</tr>    
      	<tr> 
          <td class="blue">�ֻ�����</div></td>
          <td> 
        		<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      	  </td>
      	</tr>
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
<%@ include file="/npage/include/footer_simple.jsp" %>     
</form>
</body>
</html>
