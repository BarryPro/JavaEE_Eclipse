<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%
       
	
	String regionCode =  (String)session.getAttribute("regCode");		
	String work_no = (String)session.getAttribute("workNo");	
	
	String iFlag  = request.getParameter("iFlag");
	String xqdm  = request.getParameter("xqdm");
	String xqName  = request.getParameter("xqName");
	String propertyUnit  = request.getParameter("propertyUnit");
	String iManagerName  = request.getParameter("iManagerName");
	String iManagerPhone  = request.getParameter("iManagerPhone");
	
	String manageFlag = "";
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = "m337";
			inputParsm[3] = work_no;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";	
			String beizhuss =work_no+"����С��������Ϣ��ѯ";
			
			inputParsm[7] = iFlag;
			inputParsm[8] = xqdm;
			inputParsm[9] = propertyUnit;
			inputParsm[10] = iManagerName;
			inputParsm[11] = iManagerPhone;
%>
     	
	<wtc:service name="sBroadManager" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="15">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>
			<wtc:param value="<%=inputParsm[11]%>"/>
					
	</wtc:service>
		<wtc:array id="result2" scope="end"  />

	
<HTML>
	<HEAD>
	<TITLE></TITLE>
</HEAD>
<body>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">С���ͻ�������Ϣ(<font color="red"><%=xqName%></font>)</div>
			</div>
			<%if("000000".equals(retCode) && result2.length > 0){
				manageFlag = "u";
			%>
				<table cellspacing="0" >
					<tr>
						<td class='blue' width="20%">С���ͻ���������</td>
		        <td width="30%">
							<input type="text" id="managerName" name="managerName" v_must="1" onblur="checkElement(this)" value="<%=result2[0][0]%>"/>
		        </td>
		        <td class='blue' width="20%">С���ͻ�����绰</td>
		        <td width="30%">
							<input type="text" id="managerPhone" name="managerPhone" v_must="1" v_type="smobilePhone" onblur="checkElement(this)" value="<%=result2[0][1]%>"/>
		        </td>
			      </tr>
					</tr>
					
			  </table>
			<%
			}else{
				manageFlag = "a";
			%>
				<table cellspacing="0" >
					<tr>
						<td class='blue' width="20%">С���ͻ���������</td>
		        <td width="30%">
							<input type="text" id="managerName" name="managerName" v_must="1" value=""/>
		        </td>
		        <td class='blue' width="20%">С���ͻ�����绰</td>
		        <td width="30%">
							<input type="text" id="managerPhone" name="managerPhone" v_must="1" v_type="smobilePhone" onblur="checkElement(this)" value=""/>
		        </td>
			      </tr>
					</tr>
			  </table>
			<%
			}
			%>
			<input type="hidden" name="manageFlag" id="manageFlag" value="<%=manageFlag%>"/>
			<input type="hidden" name="manageXqdm" id="manageXqdm" value="<%=xqdm%>"/>
			<input type="hidden" name="managePropertyUnit" id="managePropertyUnit" value="<%=propertyUnit%>"/>
	    
		</div>

	</BODY>
</HTML>

