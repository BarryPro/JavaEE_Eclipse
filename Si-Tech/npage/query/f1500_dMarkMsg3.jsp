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
<%        

	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û����ֲ�ѯ";
	
	String regionCode =  (String)session.getAttribute("regCode");
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	String btime=request.getParameter("btime");
	String etime=request.getParameter("etime");
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
%>

        	
     <wtc:service name="sMarkExchQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum=
"16">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=btime%>"/>
        <wtc:param value="<%=etime%>"/>
        </wtc:service>
        <wtc:array id="MarkExchArr" scope="end"/>
	
	



<HTML><HEAD><TITLE>�û����ֲ�ѯ</TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">�Ѷһ�������Ϣ</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>����ʱ��</th>
	        <th>�Ż�����</th>
	        <th>�Ż�����</th>
	        <th>���ѻ���</th>
	        <th>����ģ��</th>  
	        <th>��������</th>
	        <th>������ע</th>  
	      </tr>
		<%
		if(retCode2.equals("000000")) {
		if(MarkExchArr.length>0) {
			String tbClass="";
			for(int y=0;y<MarkExchArr.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=MarkExchArr[y][8]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][1]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][3]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][5]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][6]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=MarkExchArr[y][9]%>&nbsp;</td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='7'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='7'><%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

