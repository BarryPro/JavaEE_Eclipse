<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.23
 ģ��: MAS/ADCҵ����ͣ/�ָ�����
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������Ϣ��ѯ</TITLE>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String idNo = request.getParameter("idNo");//��ѯ����
	
	String regCode = (String)session.getAttribute("regCode");
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	String iStartPosStr = iStartPos+""; 
	String iEndPosStr = iEndPos+"";
	//wuxy alter Ϊ���û�в�dgrpnomebmsg��dpadcrblacklist���г�Ա���� 20081205
 
	String workNo     = (String)session.getAttribute("workNo");
	String workpass   = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>
 
  <wtc:service name="sGrpCustQry" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="0" />
		<wtc:param value="01" />	
		<wtc:param value="<%=opCode%>" />		
		<wtc:param value="<%=workNo%>" />			
		<wtc:param value="<%=workpass%>" />		
		<wtc:param value="" />			
		<wtc:param value="" />				
		<wtc:param value="" />				
		<wtc:param value="" />			
		<wtc:param value="" />					
		<wtc:param value="" />				
		<wtc:param value="" />	
		<wtc:param value="" />		
		<wtc:param value="<%=idNo%>" />						
		<wtc:param value="<%=regionCode%>" />		
		<wtc:param value="<%=iStartPosStr%>" />		
		<wtc:param value="<%=iEndPosStr%>" />				
		<wtc:param value="2" />					
		<wtc:param value="" />		
		<wtc:param value="" />		
		<wtc:param value="" />			
		<wtc:param value="" />				
		<wtc:param value="" />				
		<wtc:param value="" />			
		<wtc:param value="" />			
	</wtc:service>
	<wtc:array id="result1" scope="end" />		
		
<%
	System.out.println("result1 ----hejwa----------------------- " + result1.length);	

%>
 <wtc:service name="sGrpCustQry" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="0" />
		<wtc:param value="01" />	
		<wtc:param value="<%=opCode%>" />		
		<wtc:param value="<%=workNo%>" />			
		<wtc:param value="<%=workpass%>" />		
		<wtc:param value="" />			
		<wtc:param value="" />				
		<wtc:param value="" />				
		<wtc:param value="" />			
		<wtc:param value="" />					
		<wtc:param value="" />				
		<wtc:param value="" />	
		<wtc:param value="" />	   	
		<wtc:param value="<%=idNo%>" />						
		<wtc:param value="<%=regionCode%>" />		
		<wtc:param value="" />		
		<wtc:param value="" />				
		<wtc:param value="1" />					
		<wtc:param value="" />		
		<wtc:param value="" />		
		<wtc:param value="" />			
		<wtc:param value="" />				
		<wtc:param value="" />				
		<wtc:param value="" />			
		<wtc:param value="" />			
	</wtc:service>
	<wtc:array id="result2" scope="end" />		
<%
System.out.println("result2 ----hejwa----------------------- " + result2.length);	
	int recordNum = 1;
	if(result2.length>0)
		recordNum = Integer.parseInt(result2[0][0].trim());

%>


</HEAD>
<% if (result1.length==0){%>
<script language="javascript">
	rdShowMessageDialog("û���ҵ��κ�����",0);
	history.go(-1);
</script>
<%	
	return;
	}else{%>
<body>
<FORM method=post name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">������Ϣ��ѯ</div>
		</div>

    <table cellspacing="0">
      <tr align="center">
      	<!--<td>��Ա���</td> -->
        <th><b>��Ա����    </b></th>
		<th><b>��Ա�ʷ�����</b></th>
        <th><b>��Ա����    </b></th>
        <th><b>��Ա�ʺ�    </b></th>
        <th><b>����״̬    </b></th>
        <th><b>���뼯��ʱ��    </b></th>
      </tr>
	  <%
		for(int y=0;y<result1.length;y++){
			String tdClass = (y%2==0)?"":"Grey";
	  %>
	  
	  <tr>
	  <%  //result1[1].length��Ҫ��ȥһ����ȥ����Ա����� 
		for(int j=1;j<result1[0].length-1;j++){
			
	  %>
	    <td class="<%=tdClass%>"><div align="center"> <%=result1[y][j]%></div></td>
	  <%
		}
	  %>
	   </tr>
	  <%
	    }
	  %>
    </table>

	 <table cellspacing="0">
		<tr>
		 <td>
	<%	
	    Page pg = new Page(iPageNumber,iPageSize,recordNum);
		PageView view = new PageView(request,out,pg); 
	   	view.setVisible(true,true,0,0);       
	%>
	     </TD>
	    </TR>
	 </TABLE>

    <table cellspacing="0">
      <tr> 
		<td id="footer">
			  &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
			  &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
			  &nbsp; 
		</td>
	  </tr>
	</table>

 <%@ include file="/npage/include/footer_simple.jsp" %> 
</FORM></BODY></HTML>
<%}%>
