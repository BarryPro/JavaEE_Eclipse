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
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	
	String phone_no  = request.getParameter("phone_no");	
	String starttimes=request.getParameter("starttimes");
	String work_no=request.getParameter("work_no");
	String endtimes=request.getParameter("endtimes");
	
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = "m161";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = "ZY";
	inputParsm[8] = "045106";
	inputParsm[9] = "ZY0601";
	inputParsm[10] = "21";
	inputParsm[11] = current_timeNAME;
	inputParsm[12] = "20501230000000";
	inputParsm[13] = current_timeNAME;
	inputParsm[14] = "��ά����ݱ�ʶ������־��ѯ";
	inputParsm[15] = starttimes;
	inputParsm[16] = endtimes;
	
%>
     	
	<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>
			<wtc:param value="<%=inputParsm[11]%>"/>
			<wtc:param value="<%=inputParsm[12]%>"/>
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>
			<wtc:param value="<%=inputParsm[16]%>"/>

	</wtc:service>

        <wtc:array id="MarkExchArr" scope="end"/>
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 

	        <th>�ֻ�����</th>
	        <th>��������</th>
	        <th>����ʱ��</th>
	        <th>��������</th>

	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(MarkExchArr.length);

		if(MarkExchArr.length>0) {
			 String[] phonestr1=MarkExchArr[0][0].split("\\|");
			 String[] worknostr1=MarkExchArr[0][1].split("\\|");
			 String[] optimesstr1=MarkExchArr[0][2].split("\\|");
			 String[] optypesstr1=MarkExchArr[0][3].split("\\|");
			String tbClass="";
			for(int y=0;y<phonestr1.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=phonestr1[y]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=worknostr1[y]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=optimesstr1[y]%>&nbsp;</td>
          <td class="<%=tbClass%>"><%if(optypesstr1[y].equals("01")){out.print("�·�");}else if(optypesstr1[y].equals("02")){out.print("����");}else if(optypesstr1[y].equals("03")){out.print("����");}else if(optypesstr1[y].equals("04")){out.print("����");}else if(optypesstr1[y].equals("05")){out.print("�ⶳ");}else if(optypesstr1[y].equals("06")){out.print("������������");}else if(optypesstr1[y].equals("07")){out.print("�ر���������");}%>&nbsp;</td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='4'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='4'>��ѯʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

