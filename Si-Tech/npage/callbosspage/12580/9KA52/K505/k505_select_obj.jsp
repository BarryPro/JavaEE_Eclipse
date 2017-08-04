
<%
	 /*
	 * 功能: 12580群组-新建编辑-select群组
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%

  String opCode = "K505";
  String opName = "群组维护";

  String SERIAL_NO = "";
  String org_code = (String)session.getAttribute("orgCode");
  String workNo = (String)session.getAttribute("workNo");
	
  String phone_name = "";
  String phone_mainnum = "";
  String phone_fax = "";
  String phone_qq = "";
  String phone_email = "";
  String phone_sxe = "";
  String phone_yeas = "";
  String phone_month = "";
  String phone_date = "";
  String phone_unit = "";
  String phone_note = "";
  String phone_birth = "";
  
  String strINType = "button";
  String strUPType = "hidden";
  String sxeMCheck = "checked";
  String sxeFCheck = "";
  
  SERIAL_NO = request.getParameter("idvalue")==null?"":request.getParameter("idvalue");
  
  if(SERIAL_NO==null||"".equals(SERIAL_NO)){
%>  
var response = new AJAXPacket();
response.data.add("retCode","2");
core.ajax.receivePacket(response);

<%   
    }else{
       
       
       strINType = "hidden";
	   strUPType = "button";
       String sqlStr = "select PERSON_NAME,PERSON_PHONE,PERSON_FAX,PERSON_QQ,PERSON_EMAIL,PERSON_SEX,PERSON_BIRTH,PERSON_UNIT,PERSON_DESCR FROM DPHONLIST  WHERE SERIAL_NO = '"+SERIAL_NO+"' AND PERSON_TYPE = '1'";    
    
  System.out.println("===============1"+SERIAL_NO);
%>

<wtc:service name="s151Select" outnum="9">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />

<% 
    if(queryList.length !=0){
      System.out.println("===============2"+queryList[0][0]);
       
       phone_name = (queryList[0][0].length() != 0) ? queryList[0][0]: "";
       phone_mainnum = (queryList[0][1].length() != 0) ? queryList[0][1]: "";
       phone_fax = (queryList[0][2].length() != 0) ? queryList[0][2]: "";
       phone_qq = (queryList[0][3].length() != 0) ? queryList[0][3]: "";
       phone_email = (queryList[0][4].length() != 0) ? queryList[0][4]: "";
       phone_sxe = (queryList[0][5].length() != 0) ? queryList[0][5]: "";
       phone_birth = (queryList[0][6].length() != 0) ? queryList[0][6]: "";
       phone_unit = (queryList[0][7].length() != 0) ? queryList[0][7]: "";
       phone_note = (queryList[0][8].length() != 0) ? queryList[0][8]: "";
       
       if("F".equalsIgnoreCase(phone_sxe)){
       
           sxeMCheck = "";
		   sxeFCheck = "checked";
       }
       
       if(!"".equals(phone_birth)){
           
           String Time[] = phone_birth.split("-");
           if(Time.length>0){
	           phone_yeas = Time[0];
	           phone_month = Time[1];
	           phone_date = Time[2];
           }
       }
    
%>

var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("phone_name","<%=phone_name %>");
response.data.add("phone_mainnum","<%=phone_mainnum %>");
response.data.add("phone_fax","<%=phone_fax %>");
response.data.add("phone_qq","<%=phone_qq %>");
response.data.add("phone_email","<%=phone_email %>");
response.data.add("phone_sxe","<%=phone_sxe %>");
response.data.add("phone_unit","<%=phone_unit %>");
response.data.add("phone_note","<%=phone_note %>");
response.data.add("phone_yeas","<%=phone_yeas %>");
response.data.add("phone_month","<%=phone_month %>");
response.data.add("phone_date","<%=phone_date %>");
response.data.add("SERIAL_NO","<%=SERIAL_NO %>");
core.ajax.receivePacket(response);

<%} else{
%>
var response = new AJAXPacket();
response.data.add("retCode","2");
core.ajax.receivePacket(response);
<%}
}%>