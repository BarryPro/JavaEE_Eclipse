<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String opCode = request.getParameter("opCode")==null?"":request.getParameter("opCode");
	String opName = request.getParameter("opName")==null?"":request.getParameter("opName");
	String workNo = request.getParameter("workNo")==null?"":request.getParameter("workNo");
	String retCodeForCntt = request.getParameter("retCodeForCntt")==null?"":request.getParameter("retCodeForCntt");
	String retMsgForCntt = request.getParameter("retMsgForCntt")==null?"":request.getParameter("retMsgForCntt");	
	String opBeginTime = request.getParameter("opBeginTime")==null?"":request.getParameter("opBeginTime");
	String loginAccept = request.getParameter("loginAccept")==null?"":request.getParameter("loginAccept");		
	String ipAddr = request.getRemoteAddr();
	String _pageContactId = request.getParameter("contactId");
	String userId=_pageContactId;
	String regCode=(String)session.getAttribute("regCode");

	
	if(retCodeForCntt.equals("000000"))retMsgForCntt="SUCCESS";
	//if(!retCodeForCntt.equals("000000"))loginAccept="0";
	
       retCodeForCntt=retCodeForCntt+"#"+retMsgForCntt;
                       
	//��request��ȡ�Ӵ�id���û�user �ͻ� cust �ʻ� acc
	//0-�ͻ���1-�û���2-�ʻ���3-���ſͻ���ʶ

	String _contactIdType = request.getParameter("contactType");
	
	if(_contactIdType==null||_contactIdType.equals(""))
	{
		_contactIdType="1";
	}else if(_contactIdType.equals("user"))
	{
		_contactIdType="1";			
	String sqlStr="select id_no from dcustmsg where phone_no='"+_pageContactId+"' and substr(run_code,2,1)<'a'";
	%>
	<wtc:service name="sPubSelect"   outnum="1" 	
		routerKey="region" routerValue="<%=regCode%>"  >
		<wtc:param value="<%=sqlStr%>"/>
		</wtc:service>
	<wtc:array id="resId"  scope="end"/>
	<%  

		if ( resId.length!=0 )
		{
			userId=resId[0][0];
		}
	}else if(_contactIdType.equals("cust"))
	{
		_contactIdType="0";
	}else if(_contactIdType.equals("acc"))
	{
		_contactIdType="2";
	}else if(_contactIdType.equals("grp"))
	{
		_contactIdType="3";
	}else
	{
		_contactIdType="1";
	}
	//�Ӵ�ƽ̨״̬
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
  System.out.println("%%%%%%ͳһ�Ӵ�ƽ̨��ǰ״̬��%%%%%%% "+appCnttFlag);
    System.out.println("----appCnttFlag------"+appCnttFlag);
   System.out.println("----in ROnceCntt------"); 
if(appCnttFlag!=null&&"Y".equals(appCnttFlag)){
   //System.out.println("----appCnttFlag------"+appCnttFlag);
   //System.out.println("----in ROnceCntt------");
   System.out.println("%%%%%%����һ�νӴ���������%%%%%%%");
   try{
%>
	<wtc:service name="sOnceCntt" 
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="sOnceCnttRetCode" retmsg="sOnceCnttRetMsg" outnum="1" >
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=_contactIdType%>"/>
		<wtc:param value="<%=_pageContactId%>"/>
		<wtc:param value="01"/>
		<wtc:param value="00"/>
		<wtc:param value="i"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=opName%>" />
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=retCodeForCntt%>" />
		<wtc:param value="<%=retMsgForCntt%>" />
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=userId%>"/>
		<wtc:param value="<%=opBeginTime%>"/>
	</wtc:service>
<%
  System.out.println("%%%%%%һ�νӴ����óɹ�%%%%%%%%%%"+sOnceCnttRetCode);
  System.out.println("%%%%%%һ�νӴ����óɹ�%%%%%%%%%%"+sOnceCnttRetMsg);
 }catch(Throwable e)
      {
    
      }
}

  System.out.println("%%%%%%һ�νӴ����óɹ�%%%%%%%%%%");
  //System.out.println("----out ROnceCntt------");
%>
