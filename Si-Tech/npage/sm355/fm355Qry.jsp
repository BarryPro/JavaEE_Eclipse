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
	String querymsg2  = request.getParameter("querymsg2");	
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m355";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = querymsg2;


	
%>
     	
	<wtc:service name="sm355Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="17">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>


	</wtc:service>

        <wtc:array id="result2" scope="end"  />
<%
System.out.println("-----sm355Qry-------------retCode------------>"+retCode);
System.out.println("-----sm355Qry-------------retMsg------------->"+retMsg);

%>
<HTML><HEAD><TITLE></TITLE>
<script language="javascript">
	var alertFlag=false;
</script>
</HEAD>
<body>
    	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">ONT�豸Ѻ����Ϣ</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th>�ͻ�����</th>
	        <th>֤������</th>
	        <th>����ONT�豸Ѻ��</th>
	        <th>ONT�豸S/N��</th>
	        <th>������ˮ</th>
					<th>��������</th>
					<th></th>
	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
			
			System.out.println("result2["+y+"]["+0+"]===="+result2[y][0]);
			System.out.println("result2["+y+"]["+1+"]===="+result2[y][1]);
			System.out.println("result2["+y+"]["+2+"]===="+result2[y][2]);
			System.out.println("result2["+y+"]["+3+"]===="+result2[y][3]);
			System.out.println("result2["+y+"]["+4+"]===="+result2[y][4]);
			System.out.println("result2["+y+"]["+5+"]===="+result2[y][5]);
			System.out.println("result2["+y+"]["+6+"]===="+result2[y][6]);
			System.out.println("result2["+y+"]["+7+"]===="+result2[y][7]);
			System.out.println("result2["+y+"]["+8+"]===="+result2[y][8]);
			System.out.println("result2["+y+"]["+9+"]===="+result2[y][9]);
			System.out.println("result2["+y+"]["+10+"]===="+result2[y][10]);
			System.out.println("result2["+y+"]["+11+"]===="+result2[y][11]);
			System.out.println("result2["+y+"]["+12+"]===="+result2[y][12]);
			System.out.println("result2["+y+"]["+13+"]===="+result2[y][13]);
			System.out.println("result2["+y+"]["+14+"]===="+result2[y][14]);
			System.out.println("result2["+y+"]["+15+"]===="+result2[y][15]);
			System.out.println("result2["+y+"]["+16+"]===="+result2[y][16]);//liangyl 20170213 �����Ż���è����ϵͳ��������ĺ�
			
				if("1".equals(result2[y][12])){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][15]%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>
						<td class="<%=tbClass%>"><%=result2[y][3]%></td> 
		
			<% 
			if("1".equals(result2[y][12])){
				%>
				<td class="<%=tbClass%>" width="3%"><img src='/nresources/default/images/task-item-close.gif' alt='����Ѻ��'/></td>
				<%
			}else{
				%>
				<td class="<%=tbClass%>" width="3%"><img src='/nresources/default/images/task-item-close1.gif' style='cursor:hand' alt='����Ѻ��' onclick="deleteoffer('<%=result2[y][5]%>','<%=result2[y][11]%>','<%=result2[y][0]%>','<%=result2[y][1]%>','<%=result2[y][9]%>','<%=result2[y][2]%>','<%=result2[y][10]%>','<%=querymsg2%>','<%=result2[y][13]%>','<%=result2[y][4]%>','<%=result2[y][14]%>','<%=result2[y][6]%>')" /></td>
				<%
			}
			//liangyl 20170213 �����Ż���è����ϵͳ��������ĺ�
			if(result2[y][16]!=null){
				if(!("0".equals(result2[y][16].trim()))){
					%>
					<script language="javascript">
					alertFlag=true;
					</script>
					<%
				}
			}
			%>
		</tr>
		<%
		    }
	 %>
	  <script language="javascript">
 	    rdShowMessageDialog("ONT�豸Ѻ�𷵻�ʱ���û��践��ONT�豸��Ѻ��Ʊ�����ṩ��Ч֤�����˶�ϵͳ�ڸÿ���˺ſ���ն�ʹ�ü�¼���ɣ�����˶�SN�롣",1);
 	    //liangyl 20170213 �����Ż���è����ϵͳ��������ĺ�
 	    if(alertFlag){
 	  		rdShowMessageDialog("���û���δ�����ONT�վݣ�������m447����豸�����վݲ��������в���",1);
 	  	}
 	    </script>
	 <%	    
		    
		  }else {
		%>
<tr height='25' align='center' ><td colspan='6'>��ѯONT�豸Ѻ����ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='6'>��ѯʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

