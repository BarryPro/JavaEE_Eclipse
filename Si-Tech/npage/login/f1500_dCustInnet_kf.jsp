<%
/********************
 * version v2.0
 * ������: si-tech
 * add by sunbya @ 2013-03-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.* ,java.text.SimpleDateFormat,java.util.*"%>
<%
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û�������Ϣ";

	/*���Session*/
	String workNo   = (String)session.getAttribute("workNo"); //��ù���
	String iLoginPwd =(String)session.getAttribute("password"); //��������
	String phone_no=request.getParameter("phoneNo");
	
	//��α���
	String iLoginAccept="0"; //��ˮ
	String iChnSource="1";		//������ʶ
	String iOpCode="1500";			//��������
	String iLoginNo=workNo;	//��������
	String iLoginPwd1=iLoginPwd;		//��������
	String iPhoneNo=phone_no; 		//�ֻ�����
	String iUserPwd="";			//�ֻ�����

%>
<wtc:service name="sDcustInnetQry" outnum="12" retcode="oRetCode" routerKey="region">
	<wtc:param value="<%=iLoginAccept%>"/>	
  <wtc:param value="<%=iChnSource%>"/>  
  <wtc:param value="<%=iOpCode%>"/>    
  <wtc:param value="<%=iLoginNo%>"/>   
  <wtc:param value="<%=iLoginPwd1%>"/>  
  <wtc:param value="<%=iPhoneNo%>"/>   
  <wtc:param value="<%=iUserPwd%>"/>    
</wtc:service>
<wtc:array id="result" scope="end"/>

<body>
<FORM method=post name="f1500_dCustInnet">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û�������Ϣ</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="15%">����ʱ��</td>
          <td width="18%"><%=result[0][0]%>&nbsp;</TD>
          <TD class="blue" width="15%">��������</td>
          <td width="18%"><%=result[0][1]%>&nbsp;</TD>
          <TD class="blue" width="15%">��������</td>
          <td width="17%"><%=result[0][10]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">�� �� ��</td>
          <td><%=result[0][2]%>&nbsp;</TD>
          <TD class="blue">ѡ �� ��</td>
          <td><%=result[0][3]%>&nbsp;</TD>
          <TD class="blue">�� �� ��</td>
          <td><%=result[0][4]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">SIM ����</td>
          <td><%=result[0][5]%>&nbsp;</TD>
          <TD class="blue">�ֽ𽻿�</td>
          <td><%=result[0][6]%>&nbsp;</TD>
          <TD class="blue">֧Ʊ����</td>
          <td><%=result[0][7]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">�����ܶ�</td>
          <td><%=result[0][8]%>&nbsp;</TD>
          <TD class="blue">�û���ע</td>
          <td colspan="3"><%=result[0][9]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">��������</td>
          <td colspan="5"><%=result[0][11]%></TD>
        </TR>
      </TBODY>
    </TABLE>
    <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="close_window();return false;" type=button value=�ر�/>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
	<script>
		function close_window(){
			window.close();	
		}	
	</script>
</HTML>