<%
  /*
   * ����: �������������
�� * �汾: v1.0
�� * ����: 2009��03��04��
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>

<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
    <input type="hidden" id="unitId" name="unitId" value="" />
</form>
</body>
<%
	String loginNo=(String)session.getAttribute("workNo");    //���� 
    String loginName =(String)session.getAttribute("workName");//��������  	
    String  powerRight= (String)session.getAttribute("powerRight"); 
    String workPwd = (String)session.getAttribute("password");         
     
    String ip_Addr = request.getRemoteAddr();       
    String regionCode = (String)session.getAttribute("regCode");       
    String  GroupId = (String)session.getAttribute("groupId");       
    String  OrgId = (String)session.getAttribute("orgId");
    
    System.out.println("loginNo="+loginNo);
    
	String[] retStr = null;
	String error_code = "";
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
	int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����
	String iErrorNo ="";
    String sErrorMessage = " ";
    
    String opCode = "e539";	
	String opName = "�������������";	//header.jsp��Ҫ�Ĳ���   
    
	
	String[] ParamsIn = null;
	
	
	
	String tmpType=request.getParameter("tmpR1");
	String tmpNumCode=request.getParameter("tmpR2");
	String qryInfo=request.getParameter("qryInfo");
	String queryName=request.getParameter("queryName");
	String phone_no=request.getParameter("phone_no");
	
	System.out.println("tmpType="+tmpType);
	System.out.println("tmpNumCode="+tmpNumCode);
	System.out.println("qryInfo="+qryInfo);
	System.out.println("queryName="+queryName);
	
 try{
%>	
<wtc:service name="se539Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="e539"/>
  <wtc:param value="<%=loginNo%>"/>
  <wtc:param value="<%=workPwd%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=qryInfo%>"/>
  <wtc:param value="<%=queryName%>"/>
  <wtc:param value="<%=phone_no%>"/>
  <wtc:param value="<%=tmpNumCode%>"/>
  <wtc:param value="<%=tmpType%>"/>
  <wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="callData" scope="end" />	
<%
	error_code=retCode1;
	error_msg= retMsg1;
	
	System.out.println("================="+error_code);
	System.out.println("================="+error_msg);

	System.out.println("================="+callData[0][2]);
	System.out.println("================="+callData[0][3]);
	String errPhoneList = callData[0][2];
  String errMsgList   = callData[0][3];

     /* ת������չʾҳ�� */
  %>
            <script type=text/javascript>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                $("#unitId").val("<%=qryInfo%>");
                
                frm.action="fe539_end.jsp";
            	frm.method="post";
            	frm.submit();
            	
            </script>
<%
 
   }catch(Exception e){
    %>
        <script type=text/javascript>
            rdShowMessageDialog("���÷���se539Cfmʧ�ܣ�",0);
            window.location="fe539.jsp";
        </script>
    <%
    	e.printStackTrace();
    }
%>    