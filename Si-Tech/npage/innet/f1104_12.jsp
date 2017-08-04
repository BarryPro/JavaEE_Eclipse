<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.27  nt
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
        //得到输入参数
      //  ArrayList retArray = new ArrayList();
      //  String return_code,return_message;
      //  String[][] result = new String[][]{};
 	//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	    String retType = request.getParameter("retType");
	    String idIccid = request.getParameter("idIccid");
	  String orgCode = (String)session.getAttribute("orgCode");
        String region_code = orgCode.substring(0,2);
		String phoneNo = request.getParameter("phoneNo");
		String phoneTime = request.getParameter("phoneTime");
	    String sqlStr = "select id_no,phone_no from dcustoccupied "+
		 				"where id_no='"+idIccid+"'"+ 
		 				" and phone_no='"+phoneNo+"'"+
						" and to_char(begin_time,'yyyy-mm-dd hh24:mi:ss')<='"+phoneTime+"'"+
						" and to_char(hold_time,'yyyy-mm-dd hh24:mi:ss')>='"+phoneTime+"'";
						
	    //String ret_code  = "";
       // String ret_message  = "";
       
     System.out.println("________________________________________________");  
     System.out.println(sqlStr);
     System.out.println("________________________________________________");  
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="ret_code" retmsg="ret_message" outnum="3">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
			int recordNum = 0;




        if(ret_code.equals("0")||ret_code.equals("000000")){
             System.out.println("调用服务sPubSelect in f1104_12.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
             System.out.println(result.length);
		 	        	if(result.length==0){
		 	        	     System.out.println("result.length==0");
		 	        	     ret_code = "000001";
		 	            }else{
		 	            		if(result[0][0].equals(""))
									{  recordNum=0;}else{ recordNum=1;}
								
								
								   if(recordNum == 1)
							            {   
							                ret_code  = "000000";
							            }
							            else
							            {
							                ret_code = "000001";
							            }
		 	            	
		 	        	}
 	        	
 	     	}else{
 	     		 ret_code = "000002";
 	         	System.out.println(ret_code+"    ret_code");
 	     		System.out.println(ret_message+"    ret_message");
 			    System.out.println("调用服务sPubSelect in f1104_12.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}
		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";

retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);

core.ajax.receivePacket(response);

