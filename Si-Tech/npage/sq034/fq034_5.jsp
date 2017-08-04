<%
   /*
   * 功能: 订单缓装查询(订单缓装)分页查询_2
　 * 版本: v1.0
　 * 日期: 2009/01/30
　 * 作者: jiangxl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>		

<%
	String workNo = (String)session.getAttribute("workNo");
  int valid = 1;	//0:正确，1：系统错误，2：业务错误
  String errorCode="444444";
  String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
  String strArray="var arrMsg; ";  //must 
  String strArray2="var arrMsg2; ";  //must 

  String retType = request.getParameter("retType");
	String phoneNo = request.getParameter("phoneNo");
	String stateFlag = request.getParameter("stateFlag");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String startRow = request.getParameter("startRow");
	
	String endRow = request.getParameter("endRow");
	String sqlCondition =" and login_no='"+workNo+"'";
	if(!"".equals(phoneNo)) sqlCondition+=" and phone_no ='"+phoneNo+"'";
	if(!"".equals(stateFlag)) sqlCondition+=" and pre_flag ='"+stateFlag+"'";
	if(!"".equals(startTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD') >= '"+startTime+"'";
	// sqlCondition+=" and pre_time >= TO_DATE('"+startTime+"','yyyyMMdd')";
	if(!"".equals(endTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD')  <= '"+endTime+"'";
	//sqlCondition+=" and  pre_time<=TO_DATE('"+endTime+"','yyyyMMdd')";
	
    int recordNum = 0;
    String[][] result = null;

	String orderSelectId=request.getParameter("orderSelectId");	//"A0209021700000230";//request.getParameter("orderSelectId");//A0209022400000019
    
%>
	<%

UType sendInfo  = new UType();  
sendInfo.setUe("STRING", orderSelectId);

if(orderSelectId!=null&&!"".equals(orderSelectId)){
System.out.println("orderSelectId-------------------------"+orderSelectId);
%>
<wtc:utype name="sGetInterface" id="retVal" scope="end" >
	 <wtc:uparam value="<%=orderSelectId %>" type="STRING"/> 
</wtc:utype>
<%
System.out.println("orderSelectId-------------------------"+orderSelectId);
if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")){			
			if(retVal.getUtype(2)!=null){
			UType sendInfo2  = new UType(); 
			sendInfo2.setUe(retVal.getUtype(2));
%>
<wtc:utype name="sCustOrdeBDeal" id="retVal" scope="end" >
	 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
	 <wtc:uparam value="<%=sendInfo2 %>" type="UTYPE"/> 
</wtc:utype>
<%
if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")){
			errorCode="000000";
        	errorMsg = retVal.getValue(1); 
			

}
}
}
if(retVal!=null&&retVal.getSize()>1){
errorCode=retVal.getValue(0);
errorMsg=retVal.getValue(1);
if(errorMsg!=null&&errorMsg.length()>35){
	errorMsg=errorMsg.substring(0,35);
}
}
}else{
errorCode=orderSelectId;
errorMsg=orderSelectId;
}
%>   

		
var response = new AJAXPacket();
response.data.add("retType","<%= retType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");

core.ajax.receivePacket(response);


