<%
	/*
	* ����BOSS-�ײ�ʵ�֣���ѡ�ʷѱ��  2003-10
	* @author  ghostlin
	* @version 1.0
	* @since   JDK 1.4
	* Copyright (c) 2002-2003 si-tech All rights reserved.
  *
  *update:zhanghonga@2008-08-26 ҳ�����,�޸���ʽ
  *
	*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
			String opCode = "1272";
			String opName = "��ѡ�ʷѱ��";
			String[][] favInfo = (String[][])session.getAttribute("favInfo");
			String kf_workno = (String)session.getAttribute("workNo");//��ÿͷ�����
			String kf_PhoneNo = (String)session.getAttribute("userPhoneNo");//��ÿͷ��ֻ�����
%>
<HTML>
<HEAD>
<TITLE>��ѡ�ʷѱ��</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
   <table cellSpacing="0">
     <tr>
			<%//�жϿͷ�����
						String temp_work = "";
						if(!kf_workno.equals(""))
						{
							temp_work = kf_workno;//�����ж��Ƿ�ͷ�����
						}
		
					String favorcode = "a272";
					int m =0;
			   for(int p = 0;p< favInfo.length;p++){//�Żݴ���
						for(int q = 0;q< favInfo[p].length;q++){
							 if(favInfo[p][q].trim().equals(favorcode)){
								   ++m;
							 }
						}
		     }
			%>
			<%if(m == 0 && !temp_work.equals("186100")){//����������Ȩ�޲����ǿͷ�����%>
	        <td class="blue">�������</td>
				  <td>
				  	<input name="i1" size="20" value="<%=activePhone%>" readonly class="InputGrey" maxlength=11 v_must=1 v_type=int v_name=������� onkeydown="if(event.keyCode==13) if(check(form1));">
				  </td>
			<%}else if(m > 0 && !temp_work.equals("186100")){//����������Ȩ�޲����ǿͷ�����%>
          <td class="blue">�������</td>
				  <td>
				  	<input name="i1" size="20" value="<%=activePhone%>" maxlength=11 class="InputGrey" readonly v_must=1 v_type=int v_name=������� onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');">
				  </td>
			<%}else if(m ==0 && temp_work.equals("186100")){//����������Ȩ�޲����ǿͷ�����%>
				  <td class="blue">�������</td>
				  <td>
				 	  <input name="i1" size="20" value="<%=kf_PhoneNo%>" maxlength=11 v_must=1 v_type=int v_name=������� onkeydown="if(event.keyCode==13) if(check(form1));"  readonly >
				  </td>
			<%}else if(m>0 && temp_work.equals("186100")){//����������Ȩ�޲����ǿͷ�����%>
	        <td class="blue">�������</td>
				  <td>
				  	<input name="i1" size="20" value="<%=kf_PhoneNo%>"maxlength=11 v_must=1 v_type=int v_name=������� onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');"  readonly >
				  </td>
			<%}%>			  

          </tr>
	   </TABLE>
      
        <table cellSpacing="0">
          <TBODY>
            <TR>
              <TD id="footer">
						  <%if(m==0){%>
						  		<input name=sure class="b_foot" type=button value=ȷ�� onclick="if(check(form1))  pageSubmit('0');" >
						  <%}else{%>
              		<input name=sure class="b_foot" type=button value=ȷ�� onclick="if(check(form1))  pageSubmit('1');" >
              <%}%>
								  <input name=reset class="b_foot" onClick="" type=reset value=���>
								  <input name=kkkk class="b_foot" onClick="removeCurrentTab()" type=button value=�ر�>
              </td>
            </tr>
          </TBODY>
        </TABLE>
        <%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="pw_favor">
 		 <%--<%@ include file="../../npage/common/pwd_comm.jsp" %>--%>
 </FORM>
 <script language="javascript">

	function pageSubmit(p){
		document.all.pw_favor.value=p;//�������Żݸ�ֵ
		form1.action="f1272_2.jsp";
		form1.submit();
	}
</script>
</BODY>
</HTML>



