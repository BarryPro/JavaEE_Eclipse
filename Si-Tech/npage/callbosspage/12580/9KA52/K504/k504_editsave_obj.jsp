<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%!
public String getCurrDateStr(){
   
   Calendar c = Calendar.getInstance();
   Date date = c.getTime();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
   String  startTime = sdf.format(date);
   
   return startTime;   
}


%>
<%
  String workNo = (String)session.getAttribute("workNo");

  String phone_name=request.getParameter("phone_name")==null?"":request.getParameter("phone_name");
  String phone_mainnum=request.getParameter("phone_mainnum")==null?"":request.getParameter("phone_mainnum");
  String phone_fax=request.getParameter("phone_fax")==null?"":request.getParameter("phone_fax");
  String phone_qq=request.getParameter("phone_qq")==null?"":request.getParameter("phone_qq");
  String phone_email=request.getParameter("phone_email")==null?"":request.getParameter("phone_email");
  String phone_sxe=request.getParameter("phone_sxe")==null?"":request.getParameter("phone_sxe");
  String phone_age=request.getParameter("phone_age")==null?"":request.getParameter("phone_age");
  String phone_unit=request.getParameter("phone_unit")==null?"":request.getParameter("phone_unit");
  String phone_note=request.getParameter("phone_note")==null?"":request.getParameter("phone_note");
  String obj_id=request.getParameter("obj_id")==null?"":request.getParameter("obj_id");
  String objArray = request.getParameter("objArray")==null?"":request.getParameter("objArray");
  String nowTime = getCurrDateStr();
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  
  String ssSql = "select SERIAL_NO from DPHONLIST where ACCEPT_NO = '"+ACCEPT_NO+"' and PERSON_PHONE ='"+phone_mainnum+"' and PERSON_TYPE = '1'";
  
  String arySql[] = new String[]{};
  List arrayList = new ArrayList();
    %>
  <wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=ssSql%>" />
	</wtc:service>
	<wtc:array id="queryList5" scope="end" />
  <%
  if(queryList5.length > 0 && !obj_id.equalsIgnoreCase(queryList5[0][0])){
  %>
  	var response = new AJAXPacket();
	response.data.add("retCode","22222");
	core.ajax.receivePacket(response);
  <%
  }else{
  //System.out.println("==========objArray="+objArray);
  
  String GRP_SERIAL_NO[] = objArray.split(",");
  
  String strInSql = "update DPHONLIST set PERSON_NAME = '"+phone_name+"',PERSON_PHONE = '"+phone_mainnum+"',PERSON_FAX = '"+phone_fax+"'"
                                      +",PERSON_QQ = '"+phone_qq+"',PERSON_EMAIL = '"+phone_email+"',PERSON_SEX = '"+phone_sxe+"',PERSON_BIRTH = '"+phone_age+"',"+
                                      "PERSON_UNIT = '"+phone_unit+"',PERSON_DESCR = '"+phone_note+"' where SERIAL_NO = '"+obj_id+"'";
            
   arrayList.add(strInSql); 
   if(GRP_SERIAL_NO.length>0){
	  	String strDELSQL = "delete from DMSGGRPPHONLIST where LIST_SERIAL_NO = '"+obj_id+"'";
	  	arrayList.add(strDELSQL);
	  	for(int i =0;i<GRP_SERIAL_NO.length;i++){
	  	//chengh ÐÞ¸Äsql
	  	//String aSql = "select nvl(count(LIST_SERIAL_NO),0),b.GRP_NAME from DMSGGRPPHONLIST a left join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where GRP_SERIAL_NO = '"+GRP_SERIAL_NO[i]+"' group by b.GRP_NAME";
	  	//String aSql = "select nvl(count(LIST_SERIAL_NO),0),b.GRP_NAME from DMSGGRPPHONLIST a right join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where b.GRP_NAME =(select grp_name from DMSGGRP where serial_no='"+GRP_SERIAL_NO[i]+"') group by b.GRP_NAME";
      String aSql = "select count(*) from (select a.LIST_SERIAL_NO aa,b.GRP_NAME bb from DMSGGRPPHONLIST a left join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where b.serial_no='"+GRP_SERIAL_NO[i]+"') c";
%>
<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=aSql%>" />
</wtc:service>
<wtc:array id="queryLista" scope="end" />
<%   if(queryLista.length>0){
    if(Integer.parseInt(queryLista[0][0])>20){

%>
var response = new AJAXPacket(); 
response.data.add("retCode","55555");
response.data.add("GRP_NAME","ÓÐ");
core.ajax.receivePacket(response);
<%    
    return;
    }else{
	  		if(GRP_SERIAL_NO[i]!=null&&!"".equals(GRP_SERIAL_NO[i])){
		  		String strInGRPSql = "insert into DMSGGRPPHONLIST (LIST_SERIAL_NO,GRP_SERIAL_NO,CREATE_TIME) values('"+obj_id+"','"+GRP_SERIAL_NO[i]+"','"+nowTime+"')";
		  		arrayList.add(strInGRPSql);
	  		}
	 	}
	 	} 
	 	     
  }
             
  arySql = (String [])arrayList.toArray(new String[arrayList.size()]);              
%>
<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=arySql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);                                    
<%} }%>  
  
  
  
  
  
  
