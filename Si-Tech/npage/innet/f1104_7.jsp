<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.08.25
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*
 �������������ͻ�֤���������������Ƿ񳬹�������������Ŀ�������
 ���������
      ������֤������
      ��������
      
 ��������� 
      �������
      ������Ϣ
      �Ѿ���������
      ��������󿪻�����
*/
        //�õ��������
      //  Logger logger = Logger.getLogger("f1104_7.jsp");
      //  ArrayList retArray = new ArrayList();
      //String return_code,return_message;
       // String[][] result = new String[][]{};
 	//	S1100View callView = new S1100View();
	    String retType = request.getParameter("retType");
        String iccId = request.getParameter("iccId");
        String belongCode = request.getParameter("belongCode");
        String idType = request.getParameter("idType");
  		  String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
       System.out.println(regionCode+"   regionCode");
       // String ret_code  = "";
       // String ret_message  = "";
        String Count = "";
        String MaxCount = "";
        
/*		try
        {
            retArray = callView.view_sCheckIccid(iccId,belongCode,idType);
            
			result = (String[][])retArray.get(0);
            ret_code  = result[0][0];
			ret_message  = result[0][1];
            Count = result[0][2];
            MaxCount = result[0][3];          
                         
        }catch(Exception e){
            logger.error("Call sunView(sCheckIccid) is Failed!");
        }
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        **/
%>
		<wtc:service name="sCheckIccid" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
        <wtc:param value="<%=iccId%>"/>
        <wtc:param value="<%=belongCode%>"/>
        <wtc:param value="<%=idType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />

<%		
          
 if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("���÷���sCheckIccid in f1104_7.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	         ret_code="000000";
 			  
            Count = result[0][2];
            MaxCount = result[0][3]; 
 	        	
 	     	}else{
 	     		System.out.println(ret_code+"    ret_code");
 	     		System.out.println(ret_message+"    ret_message");
 			    System.out.println("���÷���sCheckIccid in f1104_7.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			 
 			}    
            
%>

		var response = new AJAXPacket();
		var retType = "";
		var retCode = "";
		var retMessage = "";
		var Count = "";
		var MaxCount = "";
		retType = "<%=retType%>";
		retCode = "<%=ret_code%>";
		retMessage = "<%=ret_message%>";
		Count = "<%=Count%>";
		MaxCount = "<%=MaxCount%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		response.data.add("Count",Count);
		response.data.add("MaxCount",MaxCount);
		core.ajax.receivePacket(response);



