<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.03
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

      //  ArrayList retArray = new ArrayList();
       // String ret_code  = "";				//������� 
       // String ret_message  = "";      		//������Ϣ         
        String sysAccept = "000000";
        String[][] retInfo = new String[][]{};
       // String[][] result = new String[][]{};
 	   // S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String regionCode = request.getParameter("region_code"); 
  /**      try
        {
                String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
                retArray = callView.view_spubqry32("1",sqlStr);
                result = (String[][])retArray.get(0);
                sysAccept = (result[0][0]).trim(); 
                ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "ȡϵͳ������ˮʧ�ܣ�";
        }
        **/
         String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />

<%
 					
          if(ret_code.equals("0")||ret_code.equals("000000")){
          System.out.println("���÷���sPubSelect in pubSysAccept.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result.length==0){
 	            }else{
 	        	   sysAccept = (result[0][0]).trim(); 
 	        	   
 	        	}
 	        	
 	     	}else{
 			System.out.println("���÷���sPubSelect in pubSysAccept.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			  ret_code = "000001";
            ret_message = "ȡϵͳ������ˮʧ�ܣ�";
 			}


%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
sysAccept = "<%=sysAccept%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);