<%
/********************
* ����: ��ѡ�ײͰ��� 3250
* version v3.0
* ������: si-tech
* update by qidp @ 2008-11-25
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  request.setCharacterEncoding("GBK");
%>

<%
    String opCode=(String)request.getParameter("opCode");
    String opName=(String)request.getParameter("opName");
    String[][]  favInfo = (String[][])session.getAttribute("favInfo");
    String userPhone = (String)request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
<TITLE>��ѡ�ײͰ���</TITLE>
<script language=javascript>
    onload = function()
    {
        self.status="";
        <%if (opCode.equals("3250")){%>
            document.all.opFlag[0].checked=true;
        <%}else if (opCode.equals("3264")){%>
            document.all.opFlag[1].checked=true;
            document.all.backaccept_id.style.display = "";
        <%}else if (opCode.equals("3275")){%>
            document.all.opFlag[2].checked=true;
        <%}%>
    } 
</script>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="frm">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
       <div id="title_zi">����ѡ��</div>
    </div>
    <input type="hidden" name="opcode" >

       <TABLE border=0>
			<TR> 
	          <TD class="blue">��������</TD>
              <TD class="blue" colspan="3">
				<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >����
				<input type="radio" name="opFlag" value="two" onclick="opchange()" >����
				<input type="radio" name="opFlag" value="three" onclick="opchange()" >ȡ��
	          </TD>
			</TR>    
            <TR>
			
              <TD class="blue">�ֻ�����</TD>
			  <TD class="blue" colspan=3>
			  <input class="button" name="srv_no" size="15" value="<%=userPhone%>" maxlength=11  v_must=1 v_minlength=1 v_maxlength=16 v_type="mobphone" readOnly>
			  </TD>
			  
			<TR style="display:none" id="backaccept_id"> 
				<TD class="blue">ҵ����ˮ</TD>
				<TD class="blue" colspan="3">
				<input class="button" type="text" name="backaccept" v_must=1 >
				<font class="orange">*</font>
				</TD>
			</TR>    
          <tr>
                <td nowrap colspan="4" id="footer">
                    <div align="center"> 
                    <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
                  	<input class="b_foot" type=button name=back value="���" onClick="doReset()">
    		      	<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
                </div>
                </td>
            </tr>
        </TABLE>

		<!-------------------------�ı������������frm��----------------------------->

		<input type="hidden" name="opcode" >
		<input type="hidden" name="iAddStr" value="">
		<%@ include file="/npage/include/footer_simple.jsp" %>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 </FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/
document.all.srv_no.focus();                      //ҳ���ʼ��ʱ������ָ��������


function doReset(){
    location.reload();
    document.all.opFlag[0].checked=true;
}

function opchange(){
	 if(document.all.opFlag[0].checked==true)
	 {
	  	document.all.backaccept_id.style.display = "none";
	 }else if(document.all.opFlag[1].checked==true){
	  	document.all.backaccept_id.style.display = "";
	 }else if(document.all.opFlag[2].checked==true){
	  	document.all.backaccept_id.style.display = "none";
	 }
}
function doCfm(subButton)
{
  var radio1 = document.getElementsByName("opFlag");

  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    	frm.action="f3250_1.jsp";
	    	document.all.opcode.value="3250";
	  }
	  else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	    frm.action="f3264_1.jsp";
	    document.all.opcode.value="3264";
	  }
	  else if(opFlag=="three")
	  {
	    	frm.action="f3275_1.jsp";
	    	document.all.opcode.value="3275";
	  }
	}
  }
  frm.submit();	
  return true;
}

</script>
