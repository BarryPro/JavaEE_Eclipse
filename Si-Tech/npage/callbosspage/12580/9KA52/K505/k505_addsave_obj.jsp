
<%
	 /*
	 * 功能: 12580群组-新建编辑-add群组
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>
<%!public String getCurrDateStr() {

		Calendar c = Calendar.getInstance();
		Date date = c.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
		String startTime = sdf.format(date);

		return startTime;
	}%>

<%
	String opCode = "K505";
	String opName = "群组维护";

	String sqlStr = "select SEQ_12580.nextval from dual";
%>

<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />

<%
	String workNo = (String)session.getAttribute("workNo");
	String[] sqlArr = new String[] {};
	List sqlList = new ArrayList();

	String SERIAL_NO = "";
	SERIAL_NO = request.getParameter("SERIAL_NO") == null ? queryList[0][0]: request.getParameter("SERIAL_NO");
	String GRP_ID = request.getParameter("GRP_ID") == null ? "": request.getParameter("GRP_ID");
	String PERSON_NAME = request.getParameter("PERSON_NAME") == null ? "": request.getParameter("PERSON_NAME");
	String PERSON_PHONE = request.getParameter("PERSON_PHONE") == null ? "": request.getParameter("PERSON_PHONE");
	String PERSON_FAX = request.getParameter("PERSON_FAX") == null ? "": request.getParameter("PERSON_FAX");
	String PERSON_EMAIL = request.getParameter("PERSON_EMAIL") == null ? "": request.getParameter("PERSON_EMAIL");
	String PERSON_QQ = request.getParameter("PERSON_QQ") == null ? "": request.getParameter("PERSON_QQ");
	String PERSON_UNIT = request.getParameter("PERSON_UNIT") == null ? "": request.getParameter("PERSON_UNIT");
	String PERSON_BIRTH = request.getParameter("PERSON_BIRTH") == null ? "": request.getParameter("PERSON_BIRTH");
	String PERSON_SEX = request.getParameter("PERSON_SEX") == null ? "": request.getParameter("PERSON_SEX");
	String PERSON_DESCR = request.getParameter("PERSON_DESCR") == null ? "": request.getParameter("PERSON_DESCR");
	String ACCEPT_NO = request.getParameter("ACCEPT_NO") == null ? "": request.getParameter("ACCEPT_NO");
	String CREATE_TIME = getCurrDateStr();

    String aSql = "select nvl(count(LIST_SERIAL_NO),0) from DMSGGRPPHONLIST where GRP_SERIAL_NO = '"+GRP_ID+"'";
 
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=aSql%>" />
</wtc:service>
<wtc:array id="queryLista" scope="end" />
<%   
    if(Integer.parseInt(queryLista[0][0])>20){

%>
var response = new AJAXPacket(); 
response.data.add("retCode","55555");
response.data.add("SERIAL_NO","<%=GRP_ID%>");
core.ajax.receivePacket(response);
<%    
    
    }else{

	String lSql = "select SERIAL_NO from DPHONLIST where PERSON_PHONE = '"+ PERSON_PHONE + "' and PERSON_TYPE ='1' and ACCEPT_NO = '"+ACCEPT_NO+"'";
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=lSql%>" />
</wtc:service>
<wtc:array id="queryListl" scope="end" />
<%
	
	if (queryListl.length > 0) {

		String gSql = "select a.SERIAL_NO from DPHONLIST a left join DMSGGRPPHONLIST b on b.LIST_SERIAL_NO = a.SERIAL_NO where a.PERSON_PHONE = '"+ PERSON_PHONE+ "' and b.GRP_SERIAL_NO='"+ GRP_ID+ "' and a.PERSON_TYPE ='1'";
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=gSql%>" />
</wtc:service>
<wtc:array id="queryListg" scope="end" />
<%
if (queryListg.length > 0) {
%>
var response = new AJAXPacket(); 
response.data.add("retCode","22222");
response.data.add("SERIAL_NO","<%=GRP_ID%>");
core.ajax.receivePacket(response);
<%
			} else {
			String strInGRPPhoneSql = "insert into DMSGGRPPHONLIST (GRP_SERIAL_NO,LIST_SERIAL_NO,CREATE_TIME,CREATE_LOGIN_NO) values('"+ GRP_ID+ "','"+ queryListl[0][0]+ "','"+ CREATE_TIME + "','"+workNo+"')";
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=strInGRPPhoneSql%>" />
</wtc:service>
<wtc:array id="retRows" scope="end" />
var response = new AJAXPacket(); 
response.data.add("retCode",<%=retCode%>); 
response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
core.ajax.receivePacket(response);
<%
	}
	} else {

		if (request.getParameter("SERIAL_NO") == null|| "".equals(request.getParameter("SERIAL_NO"))) {

			String strInPhoneSql = "insert into DPHONLIST (ACCEPT_NO,SERIAL_NO,PERSON_NAME,PERSON_PHONE,PERSON_FAX,PERSON_EMAIL,PERSON_QQ,PERSON_UNIT,PERSON_BIRTH,PERSON_SEX,PERSON_DESCR,CREATE_TIME,PERSON_TYPE,CREATE_LOGIN_NO,SOURCE_FLAG) "
			+ " values('"+ ACCEPT_NO+ "','"+ SERIAL_NO+ "','"+ PERSON_NAME+ "','"+ PERSON_PHONE+ "','"+ PERSON_FAX+ "','"+ PERSON_EMAIL+ "','"+ PERSON_QQ+ "','"+ PERSON_UNIT+ "','"+ PERSON_BIRTH+ "','"+ PERSON_SEX+ "','"+ PERSON_DESCR + "','" + CREATE_TIME + "','1','"+workNo+"','G')";
			sqlList.add(strInPhoneSql);
		}
		String strInGRPPhoneSql = "insert into DMSGGRPPHONLIST (GRP_SERIAL_NO,LIST_SERIAL_NO,CREATE_TIME,CREATE_LOGIN_NO) values('"+ GRP_ID+ "','"+ SERIAL_NO+ "','"+ CREATE_TIME+ "','"+workNo+"')";
		sqlList.add(strInGRPPhoneSql);

		sqlArr = (String[]) sqlList.toArray(new String[sqlList.size()]);
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:params value="<%=sqlArr%>" />
</wtc:service>
<wtc:array id="retRows" scope="end" />
var response = new AJAXPacket(); 
response.data.add("retCode",<%=retCode%>); 
response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
core.ajax.receivePacket(response);
<%
}
}
%>
