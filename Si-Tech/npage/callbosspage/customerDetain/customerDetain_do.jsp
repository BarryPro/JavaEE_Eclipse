<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.Random"%>

<%
	String HJLS = request.getParameter("HJLS");
	String KHDS = request.getParameter("KHDS");
	String TJWL = request.getParameter("TJWL");
	String YWLX = request.getParameter("YWLX");
	String ZXZT = request.getParameter("ZXZT");
	String BZ = request.getParameter("BZ");
	String DXNR = request.getParameter("DXNR");
	String XHYY = request.getParameter("XHYY");
	String XHJG = request.getParameter("XHJG");
	String SFDKH = request.getParameter("SFDKH");
	String XFQK = request.getParameter("XFQK");
	
	Random r = new Random();
	int i = (int)(r.nextFloat() * 100000);
	
	String insertSql = "INSERT INTO CUSTOMERDETAIN"
		+ "(HJLS, KHDS, TJWL, YWLX, ZXZT, BZ, DXNR, XHYY, XHJG, SFDKH, XFQK, serialnum)"
		+ "VALUES ('" + HJLS + "','" + KHDS + "','" + TJWL + "','" + YWLX + "','"
	  + ZXZT + "','" + BZ + "','" + DXNR + "','" + XHYY + "','" + XHJG + "','"
	  + SFDKH + "','" + XFQK + "', TO_CHAR(systimestamp,'yyyymmddhh24missff')||'" + i + "')";

	String result = null;
	try {
		KFEjbClient.insert("insertPublic", insertSql);
		result = "success";
	} catch(Exception e) {
		e.printStackTrace();
		result = "false";
	}
%>
	var response = new AJAXPacket();
	response.data.add("result","<%=result%>");
	core.ajax.receivePacket(response);