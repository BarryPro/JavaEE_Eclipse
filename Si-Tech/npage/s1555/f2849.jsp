<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<head>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>



<%@ include file="../../npage/s1555/head_2849_javascript.htm" %>
<%@ page import="com.sitech.boss.s1100.viewBean.S1100View" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  String opCode = "2849";
  String opName = "�������ż��ŷ��������Ϣ��ѯ";
  String strLoginNo = (String)session.getAttribute("workNo");
  String strLoginName = (String)session.getAttribute("workName");
  String strOrgCode = (String)session.getAttribute("orgCode");
  String strRegionCode = strOrgCode.substring(0,2);
    
	System.out.println("strRegionCode="+strRegionCode);
	
	String 	strConAwardCode = "";
	String 	strConAwardDetailCode = "";
	String 	strConAwardName = "";
	String 	strConDetailName = "";
	String 	ConprintAccept = "";
	String  con_user_passwd = "";

	boolean pwrf1=false;
//begin add by diling for ������Ȩ������ @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======f2849.jsp==== pwrf = " + pwrf);
if(pwrf){               
    pwrf1 = true;
}
//end add by diling  
%>
<title><%=opName%></title>
<script language=javascript>

//----------------��֤���ύ����-----------------
function phonequery(){
	
	if (document.frm.phone_no.value.length == 0) {
	  	rdShowMessageDialog("�ٱ����벻��Ϊ�գ����������� !!");
	    document.frm.phone_no.focus();
	    return false;
	} 
	
	var myPacket = new AJAXPacket("f2849phoneqry.jsp","���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
	myPacket.data.add("phone_no",(document.frm.phone_no.value).trim());
	myPacket.data.add("cus_pass",(document.frm.cus_pass.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;  
}

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
//  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(document.frm)) 
  {
 	 return false;
  }
  frm.action="f2849_query.jsp";
  frm.submit();
}

</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������ż��ŷ��������Ϣ��ѯ</div>
	</div>
 	<table cellspacing="0">
		<tr>
    	<td nowrap class="blue">
      	�ٱ�����
      	</td>
      <td nowrap>
      		<input class="button"  type="text" size="12" name="phone_no" id="phone_no" v_minlength=1 v_maxlength=16 v_type="mobphone"  v_name="�������" maxlength="11" value = "" index="0" >
        		<font class="orange">*</font>
      </td>
          <td nowrap class="blue"> 
              �û�����
            </td>
			<%if(pwrf1) {
			  System.out.println("true");
			%>
              <TD>
			     <input type="password" class="button" name="cus_pass" size="20" maxlength="8" disabled> 		    
	         	<input class="b_foot" type="button" name="phoneqry" value="У��" onClick="phonequery()">
		      </TD>
         <% } else { 
         	System.out.println("false");%>
			  <td nowrap> 
					  <jsp:include page="/npage/common/pwd_1.jsp">
						  <jsp:param name="width1" value="16%"  />
						  <jsp:param name="width2" value="34%"  />
						  <jsp:param name="pname" value="cus_pass"  />
						  <jsp:param name="pwd" value="12345"  />
					 </jsp:include>
			  </td>
		 <%}%>

 

          </tr>
		<tr>
    	<td class="blue" nowrap>
      	�ٱ�����
      	</td>
      <td>
      		<input class="button"  type="text" size="12" name="pros_date" id="pros_date" v_minlength=1 v_maxlength=16 v_type="prosdate"  v_name="�ٱ����ڣ�" maxlength="8" value = "" index="0" >
      		(��ʽ:������ ����:20070701)
      </td>
  	<td nowrap class="blue">
      	�ٱ�����
      	</td>
      <td>
      		<input class="button"  type="text" size="36" name="pros_content" id="pros_content" v_minlength=1 v_maxlength=16 v_type="proscontent"  v_name="�ٱ�����" maxlength="128" value = "" index="0" >
      		(���ݹؼ���)
      </td>
		
	</tr>	
          <tr id = "footer">
            <td colspan="5" >
              <div align="center">
                <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2" disabled >
                <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
                <input class="b_foot" type=button name=qryP value="�ر�" onClick="window.close()">
            </div></td>
          </tr>
        </table>
  <%@ include file="/npage/include/footer.jsp" %>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
  <input type="hidden" name="cust_name" value="">
  <input type="hidden" name="id_iccid" value="">
  <input type="hidden" name="id_address" value=""> 
  <input type="hidden" name="con_user_passwd" value="">
  <input type="hidden" name="opcode" value="2249">   
</body>
</html>