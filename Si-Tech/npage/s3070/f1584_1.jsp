   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "�����ӳ���Ч��";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GbK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<HEAD>
<TITLE>������BOSS-�����ӳ���Ч��</TITLE>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->

<BODY>

<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>                         

	<div class="title">
		<div id="title_zi">�����ӳ���Ч��</div>
	</div>

            <TABLE cellspacing="0">
 
			        <%
						      //out.println("m="+m);   m=0 �������Ż�Ȩ��  m!=0 �������Ż�Ȩ��
						      int m=0;   
						      boolean pwrf = false;
                  //2011/9/2  diling��� ������Ȩ������ start
                  	String pubOpCode = opCode;
                  %>
                  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
                  <%
                  	System.out.println("==�ڶ���======f1584_1.jsp==== pwrf = " + pwrf);
                  if(pwrf){
                  		m=1;
                  }else{
                      m=0;
                  }
                  //2011/9/2  diling��� ������Ȩ������ end
			      
			      %>

		      	<% 
		      	if(m == 0){
		      	String ph_no = (String)request.getParameter("ph_no");
		      	%>

		      	<TR>
              <TD class="blue">�������</TD>
			        <TD >
			          <input  name="i1" size="20"  maxlength=11  v_must=1 v_type=mobphone v_name=�������
			          onkeydown="if(event.keyCode==13 && check(form1))document.all.i2.focus();" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
			        </TD>
			        <TD class="blue">����</TD>
			        <TD>
			          <input  type="password" name="i2" size="20" v_must=0 v_type=int  value=""
			          onkeydown="if(event.keyCode==13) if(check(document.all.form1)) pageSubmit('0');">
			          <input  name=sure22 type=button value="��֤" onClick="if(check(document.all.form1)) pwValidate(0)">
			       </TD>
			     <%
		      	}else{
		      		String ph_no = (String)request.getParameter("ph_no");
         	%>
          <TR>
            <TD  class="blue">�������</TD>
			      <TD >
			      <input  name="i1" size="20"   maxlength=11 v_must=1 v_type=mobphone v_name=�������
			      onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');"value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
			      </TD>

			    <%}%>
          </TR>
       </table>

       <table   cellspacing="0" >
       <tbody> 
          <tr > 
			      <td align="center" id="footer">
			        <% if(m==0){%>
			        <input name=sure type="button"  value=ȷ�� onClick="if(check(form1)) pageSubmit('0');" class="b_foot">&nbsp;
			        <%
			         }else{ %>
              <input name=sure type="button"  value=ȷ�� onClick="if(check(form1)) pageSubmit('1');" class="b_foot">&nbsp;
              <%}%>
			        <input name=reset onClick="" type=reset value=��� class="b_foot">&nbsp;
			        <input name=kkkk onClick="removeCurrentTab()" type="button" value=�ر� class="b_foot">&nbsp;
            </td>
          </tr>
        </tbody> 
        </table>

		<!-------------------------�ı������������form1��----------------------------->
<input type="hidden" name="pw_favor" value="0">��<!--�����Żݱ�־ -->
<input type="hidden" name="pw_flag" value="1" >��<!--������֤��־ -->
<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>

<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/
document.all.i1.focus();  //ҳ���ʼ��ʱ������ָ��������

function pageSubmit(p){
  document.all.pw_favor.value=p; //�������Żݸ�ֵ
  document.all.pw_flag.value=1;  //���Ƿ���֤���븳ֵ
  form1.action="f1584_2.jsp?Send_Op_Code=1584";
  form1.submit();
}

function pwValidate(p){
  document.all.pw_favor.value=p;
  document.all.pw_flag.value=p;
  form1.action="f1584_2.jsp?Send_Op_Code=1584";
  form1.submit();
}

</script>
