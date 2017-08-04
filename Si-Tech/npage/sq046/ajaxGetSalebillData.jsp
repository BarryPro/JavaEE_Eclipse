<%
/********************
 version v2.0
开发商: si-tech
*
*hejwa 取营销发票数据
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
		String regionCode    = (String)session.getAttribute("regCode");
		String custOrderId   = request.getParameter("custOrderId");
		String opCodeBillPrt = request.getParameter("opCodeBillPrt");
		String billFlag      = request.getParameter("billFlag");
		String iFlag         = request.getParameter("iFlag");
		String retCode       = "";
		String retMsg        = "";
		String searchDate   = WtcUtil.repNull(request.getParameter("searchDate"));
		String opflag   = WtcUtil.repNull(request.getParameter("opflag"));
		
		System.out.println("mylog--custOrderId--"+custOrderId);
		System.out.println("mylog--billFlag-----"+billFlag);
		
try{		
%>
	<wtc:utype   name="sGetPrintInfo" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=custOrderId%>" type="String"/> 
		<wtc:uparam value="<%=billFlag%>"    type="int"/> 	
		<wtc:uparam value="<%=searchDate%>" type="String"/> 
	</wtc:utype>
<%
      retCode = retVal.getValue(0);
      retMsg  = retVal.getValue(1).replace('\n',' ');
     System.out.println("mylog--retCode------"+retCode);
     System.out.println("mylog--retMsg-------"+retMsg);
     System.out.println("mylog--retVal.getSize(2)-------"+retVal.getSize("2"));
		out.print("var retArr = new Array();");
	if(retVal.getSize("2")>0){
		out.print("retArr[0]  = '"+retVal.getValue("2.0.0") +"';");   //--客户订单号                                    
		out.print("retArr[1]  = '"+retVal.getValue("2.0.1") +"';");   //--业务名称                                      
		out.print("retArr[2]  = '"+retVal.getValue("2.0.2") +"';");   //--客户名称                                      
		out.print("retArr[3]  = '"+retVal.getValue("2.0.3") +"';");   //--手机号码                                      
		out.print("retArr[4]  = '"+retVal.getValue("2.0.4") +"';");   //--打印标识：0合打，1分打                        
		out.print("retArr[5]  = '"+retVal.getValue("2.0.5") +"';");   //--打印标识为0时是合计金额：(大写)，为1时是购机款
		out.print("retArr[6]  = '"+retVal.getValue("2.0.6") +"';");   //--打印标识为0时是(小写)，为1时是￥              
		out.print("retArr[7]  = '"+retVal.getValue("2.0.7") +"';");   //--打印标识为1时有效：专款(大写)                 
		out.print("retArr[8]  = '"+retVal.getValue("2.0.8") +"';");   //--打印标识为1时有效：￥(小写)                   
		out.print("retArr[9]  = '"+retVal.getValue("2.0.9") +"';");   //--终端品牌                                      
		out.print("retArr[10] = '"+retVal.getValue("2.0.10")+"';");   //--终端型号                                      
		out.print("retArr[11] = '"+retVal.getValue("2.0.11")+"';");   //--IMEI                                          
		out.print("retArr[12] = '"+retVal.getValue("2.0.12")+"';");   //--开票人                                        
		out.print("retArr[13] = '"+retVal.getValue("2.0.13")+"';");   //--操作信息     
		out.print("retArr[14] = '"+retVal.getValue("2.0.14")+"';");   //--活动代码 
		out.print("retArr[18] = '"+retVal.getValue("2.0.15")+"';");   //--话费余额
		out.print("retArr[19] = '"+retVal.getValue("2.0.16")+"';");   //--未出账话费
		out.print("retArr[20] = '"+retVal.getValue("2.0.17")+"';");   //--当前可用余额    
		out.print("retArr[21] = '"+retVal.getValue("2.0.18")+"';");   //--滞纳金
		if(opflag.equals("g795")) {
				out.print("retArr[23] = '"+retVal.getValue("2.0.21")+"';");   //--话费余额
				out.print("retArr[24] = '"+retVal.getValue("2.0.22")+"';");   //--未出账话费
				out.print("retArr[25] = '"+retVal.getValue("2.0.23")+"';");   //--当前可用余额
				out.print("retArr[26] = '"+retVal.getValue("2.0.24")+"';");   //--滞纳金
				out.print("retArr[27] = '"+retVal.getValue("2.0.25")+"';");   //--订购时候的打印标识
		}
		out.print("retArr[15] = '"+retVal.getValue("2.1.0")+"';");   //--税率     
		out.print("retArr[16] = '"+retVal.getValue("2.1.1")+"';");   //--税额    
		out.print("retArr[17] = '"+retVal.getValue("2.1.2")+"';");   //--税额
		
		
		System.out.println("mylog------客户订单号 -------------------retArr[0]  = '"+   retVal.getValue("2.0.0") +"';");   //--客户订单号                                    
		System.out.println("mylog------业务名称   -------------------retArr[1]  = '"+   retVal.getValue("2.0.1") +"';");   //--业务名称                                      
		System.out.println("mylog------客户名称   -------------------retArr[2]  = '"+   retVal.getValue("2.0.2") +"';");   //--客户名称                                      
		System.out.println("mylog------手机号码   -------------------retArr[3]  = '"+   retVal.getValue("2.0.3") +"';");   //--手机号码                                      
		System.out.println("mylog------打印标识：0-------------------retArr[4]  = '"+   retVal.getValue("2.0.4") +"';");   //--打印标识：0合打，1分打                        
		System.out.println("mylog------打印标识为0-------------------retArr[5]  = '"+   retVal.getValue("2.0.5") +"';");   //--打印标识为0时是合计金额：(大写)，为1时是购机款
		System.out.println("mylog------打印标识为0-------------------retArr[6]  = '"+   retVal.getValue("2.0.6") +"';");   //--打印标识为0时是(小写)，为1时是￥              
		System.out.println("mylog------打印标识为1-------------------retArr[7]  = '"+   retVal.getValue("2.0.7") +"';");   //--打印标识为1时有效：专款(大写)                 
		System.out.println("mylog------打印标识为1-------------------retArr[8]  = '"+   retVal.getValue("2.0.8") +"';");   //--打印标识为1时有效：￥(小写)                   
		System.out.println("mylog------终端品牌   -------------------retArr[9]  = '"+   retVal.getValue("2.0.9") +"';");   //--终端品牌                                      
		System.out.println("mylog------终端型号   -------------------retArr[10] = '"+   retVal.getValue("2.0.10")+"';");   //--终端型号                                      
		System.out.println("mylog------IMEI       -------------------retArr[11] = '"+   retVal.getValue("2.0.11")+"';");   //--IMEI                                          
		System.out.println("mylog------开票人     -------------------retArr[12] = '"+   retVal.getValue("2.0.12")+"';");   //--开票人                                        
		System.out.println("mylog------操作信息   -------------------retArr[13] = '"+   retVal.getValue("2.0.13")+"';");   //--操作信息     

			
	}
	
}catch(Exception e){
		 e.printStackTrace();
	    retCode = "444444";
      retMsg  = "系统错误，请联系管理员";
}
%>		
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("opCodeBillPrt","<%=opCodeBillPrt%>");
response.data.add("iFlag","<%=iFlag%>");
response.data.add("getbillArr",retArr);
core.ajax.receivePacket(response);