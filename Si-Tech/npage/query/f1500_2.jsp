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
 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%--������com.sitech.boss.pub.util.Encrypt,��Ϊ���صļ��ܷ�ʽ��ʱ�޷��滻--%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ";
	
	String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = Department.substring(0,2);
	
  String password = (String)session.getAttribute("password"); //diling add for ��ȫ�ӹ�

//������� ��ѯ���ͣ���ѯ�������������룬���ţ�Ȩ�޴��롣
	String queryType = request.getParameter("QueryType");//��ѯ����
	String condText  = request.getParameter("condText"); //��ѯ����
	String custPass  = request.getParameter("custPass"); //�û�����
System.out.println("-------hejwa1500---------------queryType---------->"+queryType);	
	
	if("7".equals(queryType)){
%>
	<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="1"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="0"/>
		<wtc:param  value="01"/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=workNo%>"/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value=""/>
		<wtc:param  value="<%=condText%>"/>
  </wtc:service>
  <wtc:array id="list" scope="end"/>
<%
			if("000000".equals(errCode)){
				if(list != null && list.length > 0){
				System.out.println("=== list[0][0] ===" + list[0][0]);
					condText = list[0][0];
					queryType = "0";
				}
			}
	}


System.out.println("-------hejwa1500---------------queryType---------->"+queryType);	
System.out.println("-------hejwa1500---------------condText----------->"+condText);	


	/**
		*����ʹ��WtcUtil.encrypt()������.�������ļ��ܷ�ʽ�����ֺ�ɽ���Ķ���һ��.
		*����ʹ����Encrypt�ļ���,��Encrypt�е����˱��ص�java���ܷ�ʽ
	***/
	String passwd = Encrypt.encrypt(custPass);
	System.out.println("-------passwd="+passwd);
	
	session.setAttribute("verifyFlag","false");
	session.setAttribute("userPhoneNo",condText);
	
	String authFlag = "0";
	boolean pwrf = false; 
        System.out.println("===�ڶ���=====f1500_2.jsp==== begin============ ") ;
        //2011/9/2  diling��� ������Ȩ������ start
        	String pubOpCode = opCode;  
        	String pubWorkNo = workNo;
        %>
        	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
        <%
        	System.out.println("===�ڶ���=====f1500_2.jsp==== pwrf = " + pwrf);
        	if(pwrf){
        	    authFlag="1";
        	}
        System.out.println("===�ڶ���=====f1500_2.jsp==== end============ ") ;
        //2011/9/2  diling��� ������Ȩ������ end
     
	/**
	try
	{	 
		s1500View viewBean = new s1500View();//ʵ����viewBean		 
		arlist = viewBean.view_s1500_1(queryType,condText,workNo,passwd,regionCode,opCode); 
 	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	**/
	
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%    	
	System.out.println("------------g3op----s1500PhoneQry------���----------------");
	System.out.println("------------g3op----"+printAccept);
	System.out.println("------------g3op----"+"01");
	System.out.println("------------g3op----"+opCode);
	System.out.println("------------g3op----"+workNo);
	System.out.println("------------g3op----"+password);
	System.out.println("------------g3op----"+"");
	System.out.println("------------g3op----"+passwd);
	System.out.println("------------g3op----"+queryType);
	System.out.println("------------g3op----"+condText);
	System.out.println("------------g3op----"+regionCode);
	System.out.println("------------g3op----s1500PhoneQry------���----------------");
%>  
		<wtc:service name="s1500PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=condText%>"/>
		<wtc:param value="<%=regionCode%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%	
	String return_code = result[0][0];
	String return_message = result[0][1];
	System.out.println("g3op-------------lllllllllllllreturn_code="+return_code);
	System.out.println("g3op-------------result.length="+result.length);
	System.out.println("g3op-------------result[0][2]="+result[0][2]);
	System.out.println("g3op-------------result[0][3]="+result[0][3]);
	String actionFlag = "N";
	
	if(!"2".equals(queryType)){
	
	if ((result.length==1  && return_code.equals("000000"))) {
	/*
		//response.sendRedirect("f1500_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=0&pwd="+passwd);
		request.setAttribute("parStr",result[0][2]+"|"+result[0][3]);
		request.setAttribute("passFlag","0");
		request.setAttribute("queryType",queryType);
		request.setAttribute("pwd",passwd);
		*/
%>
<script>
	location = "f1500_Main.jsp?parStr=<%=result[0][2]+"|"+result[0][3]%>&passFlag=0&pwd=<%=passwd%>&queryType=<%=queryType%>";
</script>
<%	
	/*	
		request.getRequestDispatcher("f1500_Main.jsp").forward(request, response);
		actionFlag = "0";
	*/	
		return;
	} else if (return_code.equals("150099")) {
		/*
		//response.sendRedirect("f1500_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=1&pwd="+passwd);
		request.setAttribute("parStr",result[0][2]+"|"+result[0][3]);
		request.setAttribute("passFlag","1");
		request.setAttribute("pwd",passwd);
		request.setAttribute("queryType",queryType);
		request.getRequestDispatcher("f1500_Main.jsp").forward(request, response);
		actionFlag = "1";
		return;
		*/
%>
<script>
	location = "f1500_Main.jsp?parStr=<%=result[0][2]+"|"+result[0][3]%>&passFlag=1&pwd=<%=passwd%>&queryType=<%=queryType%>";
</script>
<%			
	}
	
	}
%>

 
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
	<TITLE>�ۺ���Ϣ��ѯ+<%=authFlag%></TITLE>
	<script language="javascript">
		$(document).ready(function(){
		//	var actionFlag = "<%=actionFlag%>";
		//	if(actionFlag != "N"){
		//		$("#parStr").val("<%=result[0][2]%>"+"|"+"<%=result[0][3]%>");
		//		$("#passFlag").val(actionFlag);
		//		$("#pwd").val("<%=passwd%>");
		//		$("#frm1500").attr("action","f1500_Main.jsp");
		//		$("#frm1500").submit();
		//	}
		});
	</script>
</HEAD>
<BODY>

<FORM method=post name="frm1500" id="frm1500">
<input type="hidden" name="parStr" id="parStr"  />
<input type="hidden" name="passFlag" id="passFlag"  />
<input type="hidden" name="pwd" id="pwd"  />
<input type="hidden" name="opCode"  value="1500">
<%@ include file="/npage/include/header.jsp" %> 
<!------------------------>
<%
if(!"2".equals(queryType)){
%>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
    <table>
      <tr align="center">
        <th>�������</th>
        <th>�û�ID��</th>
        <th>�û�����</th>
        <th>��������</th>
        <th>��ǰ״̬</th>  
        <th>״̬���ʱ��</th>  
        <th>����ʱ��</th>
      </tr>
	<%

		for(int y=0;y<result.length;y++){

	%>
			<tr>
				<%    
					for(int j=2;j<result[y].length;j++){
					/*2014/10/08 9:51:16 gaopeng ��������BOSS�;���ϵͳ�ͻ���Ϣģ����չʾ�ĺ���201409�� 
							�޸� �û����� ģ���� ��j==4ʱ Ϊ�û����� ͬʱ��1500�ۺ���Ϣ��ѯ�Ĺ��� ����ӵ�в�����Ȩ�޵ĲŽ���ģ����
							���������1550����һ��!pwrf ��У��
						*/
						if(j == 4){
								String cust_name = result[y][j];
								if(cust_name != null && !"".equals(cust_name) && !pwrf && !"NULL".equals(cust_name)){
									if(cust_name.length() == 2 ){
										cust_name = cust_name.substring(0,1)+"*";
									}
									if(cust_name.length() == 3 ){
										cust_name = cust_name.substring(0,1)+"**";
									}
									if(cust_name.length() == 4){
										cust_name = cust_name.substring(0,2)+"**";
									}
									if(cust_name.length() > 4){
										cust_name = cust_name.substring(0,2)+"******";
									}
								}
							%>
							<td height="25">
								<div align="center">
									<a href="f1500_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>" ><%=cust_name %> </a>
								</div>
							</td>
							<%
						}else{
				%>
						<td height="25">
							<div align="center">
								<a href="f1500_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>" ><%= result[y][j]%> </a>
							</div>
						</td>
				<%
					}
				}
				%>
			</tr>
	<%
	  }
	%>
	</tr>
	</td>
</table>
<%}else{
	
	
	
	%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
	
  <wtc:service name="sm366Qry" outnum="6"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=condText%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="1"/>
  </wtc:service>
  
		<wtc:array id="result22" scope="end"  start="0"  length="1"/>
		<wtc:array id="result33" scope="end"  start="1"  length="1"/>
		
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
<%
  		if(retCode11.equals("000000")) {
			      		String recordNum = "0";
								if(result33.length>0) {
										recordNum=result33[0][0];
								}
			    		  out.print("<table cellspacing='0'><TR>");
			    		       out.print("<TD >");
			    		           out.print("<div>�ܼ�������:");
			    		           out.print(recordNum);
			    		           out.print("</div>");
			    		       out.print("</TD>");
			
			    		    out.print("</TR></table>");
			    		    
	    		  }else {
	    		  		
			    		  out.print("<table cellspacing='0'><TR>");
			    		       out.print("<TD >");
			    		           out.print("<div>��ѯ������Ϣʧ�ܣ�������룺"+retCode11+"��������Ϣ��"+retMsg11);
			    		           out.print("</div>");
			    		       out.print("</TD>");
			
			    		    out.print("</TR></table>");	    		  		
	    		  		
	    		  }
     
     
}%>
<table>
  <tr> 
    <td id="footer">
      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
