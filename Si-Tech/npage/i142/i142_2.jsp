<% 
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String work_no = (String)session.getAttribute("workNo");
	
	String opCode = "i142";
    String opName = "VPMNҵ��ʹ��ʱ����ѯ";
  
	String open_time  ="";
	String cust_name  ="";
	String phoneNo  = request.getParameter("phoneNo");
	String work_name=request.getParameter("workName");
	String nopass = (String)session.getAttribute("password");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    

	//����
	String s_grp_id="��";
	String s_grp_name="��";
	String s_manager_name="��";
	String s_manager_phone="��";
	String s_offer_id="��";
	String s_offer_name="��";
	String s_should_minutes="��";
	String s_fav_minutes="��";
	String s_left_minutes="��";
	 
	
	String  inputParsm [] = new String[2];
	inputParsm[0] = phoneNo;
	inputParsm[1] = dateStr;
 
 
%>
	<wtc:service name="sVpmnSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=dateStr%>"/>
	</wtc:service>   
	<wtc:array id="cussidArr" scope="end"/>
<%
	if(cussidArr!=null&&cussidArr.length>0)
	{
		s_grp_id = cussidArr[0][0];
		s_grp_name = cussidArr[0][1];
		s_manager_name = cussidArr[0][2];
		s_manager_phone = cussidArr[0][3];
		s_offer_id =  cussidArr[0][4];
		s_offer_name  =  cussidArr[0][5];
		s_should_minutes  =  cussidArr[0][6];
		s_fav_minutes  =  cussidArr[0][7];
		s_left_minutes  =  cussidArr[0][8];
	}
	//����Ҫ�أ��ֻ����롢�������Ŵ��뼰�������ơ��ͻ������ͻ�����绰��VPMN�ʷ��ײʹ��뼰�ʷ����ơ�Ӧ���͵ķ���������ǰ��ʹ�õķ�������ʣ���������
	 
%>
 
<HTML>
	<HEAD>
	<title>�Ż���Ϣ��ѯ</title>
	</HEAD>
<BODY>
<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">VPMNҵ��ʹ��ʱ���Ż���Ϣ��ѯ</div>
		</div>
		<TABLe cellSpacing="0">
	    <TR> 
	    	<td class="blue">�ֻ�����</TD>
          <td>
          	<input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value="<%=phoneNo%>">
          </td>
          <td class="blue">&nbsp</td>
          <td>
           <input type="hidden" readonly class="InputGrey" name="nopass" size="20" maxlength="11" value="<%=nopass%>">
          </td>
          </TR>
			<TR>
				<td class="blue">�������Ŵ���</TD>
				<TD><input class="InputGrey" name="s_grp_id" value="<%=s_grp_id%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">������������</TD>
				<TD><input class="InputGrey" name="s_grp_name" value="<%=s_grp_name%>" maxlength="25" size=20 readonly></TD>
			</TR>
			<TR>
				<td class="blue">�ͻ�����绰</TD>
				<TD><input class="InputGrey" name="s_manager_phone" value="<%=s_manager_phone%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">�ͻ���������</TD>
				<TD><input class="InputGrey" name="s_manager_name" value="<%=s_manager_name%>" maxlength="25" size=20 readonly></TD>
			</TR> 
			<TR>
				<td class="blue">VPMN�ʷ��ײʹ���</TD>
				<TD><input class="InputGrey" name="s_offer_id" value="<%=s_offer_id%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">VPMN�ʷ�����</TD>
				<TD><input class="InputGrey" name="s_offer_name" value="<%=s_offer_name%>" maxlength="25" size=20 readonly></TD>
			</TR>
			<TR >
				<td class="blue">Ӧ�Żݷ�����</TD>
				<TD><input class="InputGrey" name="s_should_minutes" value="<%=s_should_minutes%>" maxlength="25" size=20 readonly></TD>
				<td class="blue">��ǰ���Żݷ�����</TD>
				<TD><input class="InputGrey" name="s_fav_minutes" value="<%=s_fav_minutes%>" maxlength="25" size=20 readonly></TD>
				 
			</TR>
			<TR >
				<td class="blue">ʣ�������</TD>
				<TD colspan=3><input class="InputGrey" name="s_left_minutes" value="<%=s_left_minutes%>" maxlength="25" size=20 readonly></TD>
			</TR>
			 
			<!--
 			<tr>
				<td class="blue" colspan=4>�ײ���Ӧ�Ż�GPRS����:<input class="InputGrey" value=" " maxlength="25" size=20 readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �ײ������Ż�GPRS����:<input class="InputGrey" value=" " maxlength="25" size=20 readonly> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ײ�����ʹ��GPRS����:<input class="InputGrey" value=" " maxlength="25" size=30 readonly></TD>
		    	 		    	
			</tr>
			-->
		 
	   </table> 
	    
	  
	   
	   

        
	  <TABLE cellSpacing="0">
	    <TR> 
	      <TD id="footer"> 
	          <input type="button"  name="back"  class="b_foot" value="����" onClick="location='i142_1.jsp?activePhone=<%=phoneNo%>'">
	          <input type="button"  name="back"  class="b_foot" value="�ر�" onClick="removeCurrentTab()">
	      </TD>
	    </TR>
		 
	  </TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html>


