   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "2219";
  String opName = "�����ֲ������û�����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
	String orgcode = (String)session.getAttribute("orgCode");  
	String workno=(String)session.getAttribute("workNo");    //���� 
        String workname =(String)session.getAttribute("workName");//��������  	        
        String regionCode = (String)session.getAttribute("regCode"); 
        
String nopass = "111111";
String op_code = "2219"  ;
String remark = request.getParameter("remark");
String serverIp=request.getServerName();
System.out.println("remark:"+remark);
//�������
//�������    


String [][] result = new String[][]{};
String    iErrorNo ="";
String    sErrorMessage = " ";
String    sReturnCode = "";
int   	  flag = 0;
String [] inputPar=new String []{workno,nopass,orgcode,op_code,remark,serverIp};
String total_fee = "";
String total_no = "";
	try
	{	
		//arlist = callView.callFXService("s2219Cfm",inputPar,"3");
%>

	<wtc:service name="s2219Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
		<wtc:params value="<%=inputPar%>"/>					
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>		

<%		
if(result_t1!=null)
		result = result_t1;
		iErrorNo =retCode;
		System.out.println("*********:'"+iErrorNo+"'");
		sErrorMessage = retMsg;
	//	System.out.println("-------------------------"+arlist.size());

		
		//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(iErrorNo));

		if (!iErrorNo.equals("000000"))
		{
			System.out.println(" ��1����� : " + iErrorNo);
			System.out.println(" ����2��Ϣ : " + sErrorMessage);
            flag = -1;
		}

	// �жϴ����Ƿ�ɹ�
	if (flag == 0)
	{	

		total_no = result_t1[0][2];
	
	}
	else
	{
		System.out.println("failed, ���� !");
	}
	
		}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	
%>
<HTML><HEAD><TITLE>������BOSS-�����ֲ������û�����</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript">
<!--
function gohome()
{
document.location.replace("s2219.jsp");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="s2219_3.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�����ֲ������û�����</div>
	</div>

            <table cellspacing="0">
              <tbody> 
              <tr > 
                <td width="13%" class="blue">��������</td>
                <td width="35%">
                  <select name = "SOprType" size = "1" >
                    <option value = "1" selected> �����ֲ������û�����</option>
                  </select>
                </td>
                <td width="13%" class="blue">����</td>
                <td width="39%"><%=orgcode%></td>
              </tr>
              </tbody> 
            </table>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td colspan="2">
                    <div align="center">�����ֲ������û�������ɡ�
					
					<br> 					
					   <% if (flag == 0){%>
                          �����ں�������<%=total_no%>��
                       <% } else { %>
                          �������'<%=iErrorNo%>'��<br>������Ϣ'<%=sErrorMessage%>'��");
                       <% } %>					   
					      <br>ʧ�ܵĺ��룬����<a target="_blank" href="/npage/tmp/<%=orgcode.substring(0,2)%>delay2219.txt.err"><%=orgcode.substring(0,2)%>delay2219.txt.err</a>�ļ���
						  
					 </div>
                  </td>
                </tr>
                </tbody> 
              </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td align=center  width="100%" id="footer"> 
                  <input  name=sure disabled type=submit value=ȷ�� class="b_foot">
                  <input  name=reset type=reset value=���� onClick="gohome()" class="b_foot">
                  &nbsp; </td>
              </tr>
              </tbody> 
            </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>



