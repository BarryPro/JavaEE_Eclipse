<%
  /*
   * ����:�������ź����������Ϣ���룬����������ļ��е��������
   * �汾: 1.0
   * ����: 2010/01/29
   * ����: gaolw
   * ��Ȩ: si-tech
  */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "7513";
	String opName = "�������ź����������Ϣ����";     
  
  String iLoginAccept = "0";
  String iChnSource = "01";
  String iOpCode = opCode;
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String iPhoneNo = "";
	String iUserPwd = "";
  
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
		
	String remark = request.getParameter("remark");
	String serverIp=realip.trim();	
	
	
	String [][] result = new String[][]{};
	int       iErrorNo =0;
	String    sErrorMessage = " ";
	String    sReturnCode = "";
	int   	  flag = 0;

	String [] paramsIn = new String [10];
	
	paramsIn[0]   = iLoginAccept;
	paramsIn[1]   = iChnSource;
	paramsIn[2]   = iOpCode;
	paramsIn[3]   = iLoginNo;
	paramsIn[4]   = iLoginPwd;
	paramsIn[5]   = iPhoneNo;
	paramsIn[6]   = iUserPwd;
	paramsIn[7]   = orgCode;
	paramsIn[8]   = remark;
	paramsIn[9]   = serverIp;
	
	String total_no = "";
%>
	<wtc:service name="s6945Imp" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>	
		<wtc:param value="<%=paramsIn[2]%>"/>						
		<wtc:param value="<%=paramsIn[3]%>"/>	
		<wtc:param value="<%=paramsIn[4]%>"/>		
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
		<wtc:param value="<%=paramsIn[9]%>"/>
	</wtc:service>
	<wtc:array id="results6945" scope="end"/>		
<%
	System.out.println("results6945**================"+results6945.length);
	System.out.println("retCode**================"+retCode);
	System.out.println("retMsg**================"+retMsg);
	for(int i=0;i<results6945.length;i++){
		for(int j=0;j<results6945[i].length;j++){
			System.out.println("results6945["+i+"]["+j+"]="+results6945[i][j]);
		}
	}
	if((results6945 != null) && (results6945.length > 0)){
		result=results6945;
		//sReturnCode=result[0][0];			
		  sReturnCode=retCode;
	}		
	if(!sReturnCode.equals("000000")){
	System.out.println(" ������� ==========: " + sReturnCode);
		flag = -1;
		if(result!=null&&result.length>0){
			//sErrorMessage=result[0][1];
			sErrorMessage=retMsg;
		}
		System.out.println(" ������Ϣ ==========: " + sErrorMessage);
	}

	// �жϴ����Ƿ�ɹ�
	if (flag == 0){	
		if(result!=null&&result.length>0){		
			total_no = result[0][0];
		}
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+""+"&pageActivePhone="+""
		+"&opBeginTime="+opBeginTime+"&contactId="+""+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />

<HTML>
	<HEAD>
		<TITLE>������BOSS-�������ź����������Ϣ����</TITLE>
		<script language="JavaScript">
		<!--
		function gohome()
		{
			document.location.replace("s6945Import.jsp");
		}
		-->
		</script>
	</HEAD>
	<BODY>
		<FORM action="s6945Import2.jsp" method=post name=form>	
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�������ź����������Ϣ����</div>
			</div> 
			<table cellspacing="0" >		     
		              <tbody> 
			              <tr> 
			              		<td class="blue" align=center width="20%">��������</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="�������ź����������Ϣ����">
				                </td>
			              </tr>
		              </tbody> 
			</table>
		        <table cellspacing="0">
		                <tbody> 
			                <tr> 
				                  <td colspan="2" align="center">					
							<% if (flag == 0){%>
							                �������ź����������Ϣ������ɡ�<br>
		                          �ɹ�������<%=total_no%>��
		                       <% } else { %>
		                          ������룺'<%=sReturnCode%>'��<br>������Ϣ��'<%=sErrorMessage%>'��");
		                       <% } %>					   
							<br>ʧ�ܵ���Ϣ������<a target="_blank" href="/npage/tmp/<%=orgCode.substring(0,2)%>gsms_open_web.txt.err"><%=orgCode.substring(0,2)%>gsms_open_web.txt.err</a>�ļ���	
				                  </td>
			                </tr>
		                </tbody> 
		              </table>
		        <table cellspacing="0">
		              <tbody> 
			              <tr> 
			                	<td id="footer"> 
				                  	
				                  	<input class="b_foot" name=reset type=reset value=���� onClick="gohome()">
			                  		&nbsp; 			                  
			                  	</td>
			              </tr>
		              </tbody> 		           
			</table>
			 <%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>



