
<%
	 /*
	 * ����: 12580Ⱥ��-�½��༭-selectȺ��
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%
  
  String opCode = "K505";
  String opName = "Ⱥ��ά��";
  
  String ACCEPT_NO = request.getParameter("ACCEPT_NO");
  String SERIAL_NO = request.getParameter("SERIAL_NO")!=null?request.getParameter("SERIAL_NO"):"";
  String PERSON_ID = request.getParameter("PERSON_ID")!=null?request.getParameter("PERSON_ID"):"";
  
  String[][] dataRows = new String[][] {};

  String sqlStr = "select GRP_NAME,nvl(count(b.GRP_SERIAL_NO),0),SERIAL_NO, grp_descr from DMSGGRP a left join DMSGGRPPHONLIST b ON b.GRP_SERIAL_NO = a.serial_no ";
  String strAcceptLogSql = " Group by  GRP_NAME,ACCEPT_NO,GRP_DESCR,SERIAL_NO";
  String strOrderSql = " order by SERIAL_NO  ";
  
  String sqlFilter = request.getParameter("sqlFilter");
  if (sqlFilter == null || sqlFilter.trim().length() == 0) {
  
  	sqlFilter = " where 1=1 AND GRP_TYPE = '1' ";
  	if (ACCEPT_NO != null && !ACCEPT_NO.trim().equals("")) {

		sqlFilter += " and ACCEPT_NO = '" + ACCEPT_NO + "'";
	}
  }
  
  sqlStr += sqlFilter+strAcceptLogSql+strOrderSql;
%>

<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr %>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />

<%
	dataRows = rowsC4;
%>

<html>
	<head>
		<title>Ⱥ��</title>
		<script language=javascript>  
		 function reloadPhone(){
		 	parent.frameSelectPERSON.location = "../../../../callbosspage/12580/9KA52/K505/k505_frameSelectPERSON_GRP.jsp?SERIAL_NO=<%=SERIAL_NO%>&ACCEPT_NO=<%=ACCEPT_NO%>&PERSON_ID=<%=PERSON_ID%>";
		 }
		 function submitPhone(id,name,desc){
		 	var SERIAL_NO = id;
		 	parent.document.getElementById("GRP_NAME").value = name;
		 	parent.document.getElementById("GRP_DESCR").value = desc;
		 	parent.document.getElementById("GRP_ID").value = id; 
		 	parent.frameSelectPERSON.location = "../../../../callbosspage/12580/9KA52/K505/k505_frameSelectPERSON_GRP.jsp?SERIAL_NO="+SERIAL_NO+"&ACCEPT_NO=<%=ACCEPT_NO%>&PERSON_ID=<%=PERSON_ID%>";
		 }
		</script>
		<style>
		body,div,td {
			padding: 0px;
			margin: 0px;
			font-size: 12px;
			font-family: "Tahoma","Arial","����";
			line-height: 150%;
			color:#000000;
		}
		.nav{ 
			margin-left:0px;
			padding:0;
			border:0px;
		}
		.ulcss { 
			width:142px;  
		  z-index:3;
		  clear:both;
		  float: left; /* �˵�����ˮƽλ�� */
		  list-style:none;
		  line-height:15px; /* һ���˵��� */  
		  background: #f1f7f9; /* ���в˵��Ƴ�ɫ */
		  font-weight: bold;
		  padding:0px;
		  margin:0px;
		  border:0px solid #ccc;
		  border-right: 0px;
		  border-left: 0px;
		}
		</style>
	</head>
	<body onload="reloadPhone();">
		<div class="nav">
		<ul class="ulcss"><li>Ⱥ���б�</li><li>&nbsp;</li></ul>
		<ul class="ulcss"> 
		  <%
				for (int i = 0; i < dataRows.length; i++) {
							
	      %>
			<li class="ulcss"><a href="#" onclick="submitPhone('<%=dataRows[i][2] %>','<%=dataRows[i][0] %>','<%=dataRows[i][3]==null?"":dataRows[i][3] %>');" ><%=dataRows[i][0] %>(<%=dataRows[i][1] %>)</a></li>
		
		  <%} %>	
		</ul>
		</div>
	</body>
</html>	  