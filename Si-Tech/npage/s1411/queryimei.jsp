<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
   //得到输入参数
          // ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	  //  String[][] baseInfoSession = (String[][])arrSession.get(0);
   		 //	String org_Code = baseInfoSession[0][16];
   		  //String group_id = baseInfoSession[0][21];
   		    String org_Code = (String)session.getAttribute("orgCode");
   		    String  group_id = (String)session.getAttribute("groupId");
   			String imei_no = WtcUtil.repStr(request.getParameter("imei_no")," ");
			String brand_code = WtcUtil.repStr(request.getParameter("brand_code")," ");
			String style_code = WtcUtil.repStr(request.getParameter("style_code")," ");
            String retType = WtcUtil.repStr(request.getParameter("retType")," ");
	        String op_code = WtcUtil.repStr(request.getParameter("opcode")," ");
	        String regionCode = org_Code.substring(0,2);

	        System.out.println("op_codeop_code="+op_code);

			//ArrayList retArray = new ArrayList();
           // String[][] result = new String[][]{};
           // SPubCallSvrImpl callView = new SPubCallSvrImpl();
			//String retResult = "000000";
			//String[][] result1 = new String[][]{};
			//ArrayList retArray1 = new ArrayList();
			//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
				String sqlStr1 = "";
           /******** String sqlStr = "";
			sqlStr = "select count(*) from dChnResMobInfo a,schnresstatusswitch b where a.group_id='" +group_id+ "' and  a.imei_no='" +imei_no+ "' and a.res_code='" +style_code+ "' and b.func_code='" +op_code+ "'and a.kind_code=b.kind_code and b.func_type='0' and a.status_code=b.src_status";
			retArray = callView.sPubSelect("1",sqlStr);
            result  = (String[][])retArray.get(0);
			System.out.println("result="+result);
            String num = (result[0][0]).trim();
			System.out.println("num="+num);
			if(num.equals("0")){
				ArrayList retArray1 = new ArrayList();
				String[][] result1 = new String[][]{};
				SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
				String sqlStr1 = "";************************/
				sqlStr1="select count(*) from dChnResMobInfo a,schnresstatusswitch b where a.group_id='" +group_id+ "' and a.imei_no='" +imei_no+ "' and a.res_code='"+style_code+"' and b.func_code='"+op_code+"' and a.kind_code=b.kind_code and b.func_type='0' and a.status_code=b.src_status";
				System.out.println("sqlStr1="+sqlStr1);
				//retArray1 = callView1.sPubSelect("1",sqlStr1);
				//result1  = (String[][])retArray1.get(0);
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
							if(num1.equals("0")){
									retResult="000003";
							}else{
									retResult="000000";
							}
 	        	
 	        	
 	        	
 	     	}else{
 			System.out.println("调用服务sPubSelect in queryimei.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

			
			
			
			
				    
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


 