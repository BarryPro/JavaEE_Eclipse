<%
   /*
   * ����: ���ſͻ�����
�� * �汾: v1.0
�� * ����: 2007/08/20
�� * ����: baixf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-1-19      qidp       �޸���ʽ
 ��*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
 

<%
	
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");               //��½����
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String ret_code="";
	String retMessage="";
	Logger logger = Logger.getLogger("f1994_del.jsp");
	
	String unit_id = request.getParameter("cust_id"); 
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%
	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1994";
	paraArr[3] = unit_id;
	paraArr[4] = ip_Addr;
	
	//acceptList = impl.callFXService("sGrpCustMsgDele",paraArr,"2");
	%>
    <wtc:service name="sGrpCustMsgDele" routerKey="region" routerValue="<%=regionCode%>" retcode="sGrpCustMsgDeleCode" retmsg="sGrpCustMsgDeleMsg" outnum="2" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
    </wtc:service>
    <wtc:array id="sGrpCustMsgDeleArr" scope="end"/>
    <%
	String errCode=sGrpCustMsgDeleCode;
	String errMsg=sGrpCustMsgDeleMsg;
//-------modify by qidp-------
 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"1994"+"&retCodeForCntt="+errCode+"&retMsgForCntt="+errMsg
    +"&opName="+"���ſͻ�����"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
    System.out.println("url=========="+url);
//----------------------------


		if(errCode.equals("000000")){
		
  %>
             <script language='jscript'>
                rdShowMessageDialog("���ſͻ����������ɹ���",2);
				        
            </script>                  
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=errMsg%>" + "[" + "<%=errCode%>" + "]" ,0);
                
            </script>
<%        
        }
%>
		      
        