<%
   /*
   * ����: ��ѯ�û���Ϣ
�� * �汾: v1.0
�� * ����: 2008/03/30
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
  String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
    
  String bugid=request.getParameter("bugid");   //����ID
  
	String subjcet      ="";// ����                         
	String content      ="";// ����                         
	String op_time      ="";// ����ʱ��                     
	String buglevel     ="";// ����                         
	String status       ="";// ״̬                         
	String login_no     ="";// ����                         
	String parent_id    ="";// �ظ���ʱ���¼�ظ������bugid
%>
<wtc:service name="sBugSinSel" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=bugid%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
	
	if(result.length>0){
	       bugid     =result[0][0];
	       subjcet   =result[0][1];
	       content   =result[0][2];
	       op_time   =result[0][3];
	       buglevel  =result[0][4];
	       status    =result[0][5];
	       login_no  =result[0][6];         
	       parent_id =result[0][7];   
	    }  
 %>	
			��ϸ���ⷴ��

<form id="layer2_form" method="post" action="">
	<table width=90% >
		<tr>
    	<td>�������</td>
      <td>
		    <input name=bugsubject   type="text"  maxlength="15"  v_type="String" v_must=1 value="<%=subjcet%>">
      </td>
	  </tr>
		<tr>
    	<td>����ʱ��</td>
      <td>
		    <input name=op_time   type="text"  maxlength="15"  v_type="String" v_must=1 value="<%=op_time%>">
      </td>
	  </tr>
		<tr>
    	<td>���⼶��</td>
      <td>
			  <select name="buglevel"  disabled>
			    <option  <% if(buglevel.equals("L"))out.println("selected"); %> value='L'>��</option>	
			    <option  <% if(buglevel.equals("M"))out.println("selected"); %> value='M' >��</option>	
			    <option  <% if(buglevel.equals("H"))out.println("selected"); %> value='H'>��</option>	
				</select>
      </td>
	  </tr>
		<tr>
    	<td>����״̬</td>
      <td>
			  <select name="status" disabled>
			    <option  <% if(status.equals("Y"))out.println("selected"); %> value='Y' >�ѻظ�</option>	
			    <option  <% if(status.equals("N"))out.println("selected"); %> value='N' >δ�ظ�</option>	
				</select>
      </td>
		</tr>
		<tr>
    	<td>��������</td>
      <td>
		  	<textarea name="bugContent"   rows=10 cols= 20  ><%=content%></textarea>
      </td>
		</tr>
		<tr>
			<td align=center colspan=2>
				<input type="button" id=close  onclick="window.close()"   name="submit" value="�ر�" >
			</td>
		</tr>
	</table>
</form>
<%    
}
%>