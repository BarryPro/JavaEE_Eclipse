<%
/********************
 version v2.0
 ������: si-tech
 ģ��:ǿ�ƿ��ػ��ָ�
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%
	 String opCode = request.getParameter("opCode");
  	 String opName = request.getParameter("opName");
  	 String phoneNo = request.getParameter("activePhone");
%>
<HEAD>
<TITLE>������BOSS-���ػ�����ǿ�ƿ��ػ��ָ�</TITLE>

</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
       <TABLE cellSpacing="0">
        <TR>
          <TD class="blue">�������</TD>
		  <TD>
		 	<input class="InputGrey" name="i1" value="<%=phoneNo%>" v_must=1 v_type=mobphone onkeydown="if(event.keyCode==13)if(check(form1))  pageSubmit('1');" readOnly>
		  </TD>
        </TR>
	   </TABLE>
      
        <TABLE cellSpacing="0">
          <TBODY>
            <TR>
              <TD id="footer" align=center>
			  <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(check(form1))  pageSubmit();" >
			  <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
        <input type="hidden" name="opCode" value="<%=opCode%>" >
        <input type="hidden" name="opName" value="<%=opName%>" >
         <%@ include file="/npage/include/footer_simple.jsp" %>   
 </FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/
//document.all.i1.focus();                      //ҳ���ʼ��ʱ������ָ��������


function pageSubmit(){
form1.action="f2355_2.jsp";
form1.submit();
}
</script>














