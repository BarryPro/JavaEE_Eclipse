<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
   		    String org_Code = (String)session.getAttribute("orgCode");
   		    String  group_id = (String)session.getAttribute("groupId");
   			String imei_no = WtcUtil.repStr(request.getParameter("imei_no")," ");
			String brand_code = WtcUtil.repStr(request.getParameter("brand_code")," ");
			String style_code = WtcUtil.repStr(request.getParameter("style_code")," ");
            String retType = WtcUtil.repStr(request.getParameter("retType")," ");
	        String op_code = WtcUtil.repStr(request.getParameter("opcode")," ");
	        String regionCode = org_Code.substring(0,2);

	        System.out.println("op_codeop_code="+op_code);

				String sqlStr1 = "";

				//sqlStr1="select count(*) from dChnResMobInfo a,schnresstatusswitch b where a.group_id='" +group_id+ "' and a.imei_no='" +imei_no+ "' and a.res_code='"+style_code+"' and b.func_code='"+op_code+"' and a.kind_code=b.kind_code and b.func_type='0' and a.status_code=b.src_status";
				
				sqlStr1 ="SELECT COUNT(1) FROM DBCHNTERM.V_DCHNNETIMEICOUNT WHERE IMEI_CODE = '"+imei_no+"' AND SALE_CODE = '"+group_id+"' AND RES_CODE = '"+style_code+"' ";
				//sqlStr1 ="SELECT COUNT(1) FROM DBCHNTERM.V_DCHNNETIMEICOUNT WHERE IMEI_CODE = '359202033131110' AND SALE_CODE = '10543' AND RES_CODE = '20000221' ";
				System.out.println(":="+sqlStr1);

%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult" retmsg="retMsg" outnum="1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />

<%
			 if(retResult.equals("0")||retResult.equals("000000")){
          System.out.println("调用服务sPubSelect in queryimei.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	String num1 = (result1[0][0]).trim();
							System.out.println("num1="+num1);
							if(num1.equals("1")){
									retResult="000000";
							}else{
									retResult="000003";
							}
 	        	
 	        	
 	        	
 	     	}else{
 			System.out.println("调用服务sPubSelect in queryimei.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

			
			
			
			//retResult="000000";
				    
		System.out.println("&&&&&&&&&&&&  retResult="+retResult);
		System.out.println("&&&&&&&&&&&&  retType="+retType);
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var retType = "<%=retType%>";
response.data.add("retType","<%= retType %>");
response.data.add("retResult","<%=retResult%>");
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
