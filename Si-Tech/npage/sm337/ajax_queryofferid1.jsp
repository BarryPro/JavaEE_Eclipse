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
	String xiaoqudaima  = request.getParameter("xiaoqudaima");
	String oprtypes  = request.getParameter("oprtypes");
	String offeridss  = request.getParameter("offeridss");
	String statess  = request.getParameter("statess");
	String propertyUnitVal  = request.getParameter("propertyUnitVal");
	
	String opflag = (String)request.getParameter("opflag") == null ? "" : (String)request.getParameter("opflag") ;
	
	
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
			inputParsm[7] = propertyUnitVal;	
			
			String beizhuss =work_no+"����С����Ӧ�ʷ���Ϣ��ѯ";
%>
     	
	<wtc:service name="sM337Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="15">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=beizhuss%>"/>
			<wtc:param value="<%=oprtypes%>"/>
			<wtc:param value="<%=xiaoqudaima%>"/>
			<wtc:param value="<%=offeridss%>"/>
			<wtc:param value="<%=statess%>"/>
				
		<%if("".equals(opflag)) {%>
			<wtc:param value="<%=inputParsm[3]%>"/>
		<%}else{%>
		  <wtc:param value=""/>
		<%}%>
			<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
		<wtc:array id="result2" scope="end"  />

	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	<%if("".equals(opflag)) {%>
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">С����Ӧ�ʷ���Ϣ&nbsp;&nbsp;<input type="button" name="toexcel" class="b_foot" value="����" onclick="printTable(t1);" /></div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th><input type="checkbox"   id="ssd" onclick="if(this.checked==true) { checkAll(); } else { clearAll(); }"/></th>
	        <th width="80px">С������</th>
	        <th>С������</th>
	        <th>�ʷѴ���</th>
	        <th>�ʷ�����</th>
	        <th>��װ��</th>
	      <!--  <th>����״̬</th>
	        <th>����ԭ��</th>
	    <th>Ӫ���</th>
	        <th>��ע��Ϣ</th>
	        <th>Ӫ������״̬</th>
	        <th>Ӫ������ԭ��</th>
	        <th>ɾ������</th>-->
	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>" ><input type="checkbox"  value="<%=result2[y][0]%>#$#<%=result2[y][2]%>" id="ckbox" /></td>
						<td width="80px" class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>">
							<input type="hidden" id="zfzt" value="<%=result2[y][4]%>"/>
							<input type="hidden" id="yxzt" value="<%=result2[y][13]%>"/>
							<input type="hidden" id="delType" value="Y-N"/>
							<%=result2[y][9]%>
						</td>
						<!--<td class="<%=tbClass%>"><% if("Y".equals(result2[y][4])){out.print("����ͨ��");}
																   else if("N".equals(result2[y][4])){out.print("������ͨ��");}
																   else if("A".equals(result2[y][4])){out.print("������");}%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>
						<td class="<%=tbClass%>"><%=result2[y][11]%></td>
						<td class="<%=tbClass%>"><%=result2[y][12]%></td>
						<td class="<%=tbClass%>"><% if("Y".equals(result2[y][13])){out.print("����ͨ��");}
																   else if("N".equals(result2[y][13])){out.print("������ͨ��");}
																   else if("A".equals(result2[y][13])){out.print("������");}%></td>
						<td class="<%=tbClass%>"><%=result2[y][14]%></td>
						<td class="<%=tbClass%>">
							<input type="hidden" id="zfzt" value="<%=result2[y][4]%>"/>
							<input type="hidden" id="yxzt" value="<%=result2[y][13]%>"/>
							<input type="hidden" id="delType" value="Y-N"/>
							<!-- <select id="delType">
								<option value="N-N">-��ѡ��-</option>								
								<option value="Y-N">ɾ��С����Ӧ�ʷ�</option>
								<option value="N-Y">ɾ��Ӫ����ͱ�ע</option>
								<option value="Y-Y">������ɾ��</option>
							</select> -->
						</td>
		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='13'>��ѯС����Ӧ�ʷ���ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='13'>��ѯС����Ӧ��Ϣʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>
		</div>

 
<%}else {%> 
			<div class="title">
				<div id="title_zi">С����Ӧ�ʷ���Ϣ</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th width=5%>�ʷѴ���</th>
	        <th width=16%>�ʷ�����</th>
	        <th width=5%>����</th>
	        <th width=5%>�۸�</th>
	        <th width=8%>����</th>
	        <th width=8%>��װ��</th>
	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		<% if(!"".equals(result2[y][2])){%>
					<tr align="center"  >
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>
						<td class="<%=tbClass%>"><%=result2[y][6]%></td>
						<td class="<%=tbClass%>"><%=result2[y][7]%>Ԫ</td>
						<td class="<%=tbClass%>"><%=result2[y][8]%>��</td>
						<td class="<%=tbClass%>"><%=result2[y][9]%></td>
					</tr>
		<%
		    }
		    }
		    %>
		  
		    <%
		  }else {
		%>
<tr height='25' align='center' ><td colspan='8' >��ѯС����Ӧ�ʷ���ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='8'>��ѯС����Ӧ��Ϣʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}
	
	
	%>
	
		</table>
		<div class="title">
			<div id="title_zi">Ӫ�����ע��Ϣ</div>
		</div>
    <table cellspacing="0" name="t1" id="t1">
      <tr align="center"> 
        <th width=8%>Ӫ���</th>
	      <th width=8%>��ע��Ϣ</th>
      </tr>
      <% if(result2.length>0){ %>
	      <tr align="center"> 
	        <td><%=result2[0][11]%></td>
					<td><%=result2[0][12]%></td>
	      </tr>
      <%}else{%>
      	<tr height='25' align='center' ><td colspan='2' >��ѯӪ�����ע��ϢΪ�գ�</td></tr>
      	<%}%>
     </table>
<%}%>    


	</BODY>
</HTML>

