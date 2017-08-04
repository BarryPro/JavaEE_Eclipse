<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%   
 String g_cityId=(String)session.getAttribute("cityId");
 String prodId   = request.getParameter("prodId");
 System.out.println("prodId==="+prodId);
 System.out.println("g_cityId==="+g_cityId);
 
 String selByWay = "";
 String fPrefix = "";
 String lPrefix = "";
 String sequencePara ="";
 String inner_no_seq="";
 String inner_no_rule="";
 
 
 System.out.println("-------------------------prodId-----------------------"+prodId);
 if(g_cityId==null) g_cityId = "01"; //hejwa增加测试用
 
 System.out.println("-------------------------g_cityId-----------------------"+g_cityId);
%>
     <wtc:utype name="sGetGenRule" id="retVal" scope="end" >
	      <wtc:uparam value="<%=g_cityId%>" type="STRING"/> 
	      <wtc:uparam value="<%=prodId%>" type="INT"/>    
     </wtc:utype>
<%		
	System.out.println("<<------------查询选号方式开始！！！！！！！！123123！！！！！！！！！！>>")	;
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("------------retMsg-------------"+retMsg);
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);		
	System.out.println(logBuffer.toString());
	if(retCode.equals("0"))
	{ 
		selByWay = retVal.getValue("2.0").trim();//1-选号；2-获得;3-手输；
		fPrefix = retVal.getValue("2.1").trim();//前缀；
		lPrefix = retVal.getValue("2.2").trim();//后缀；
		sequencePara = retVal.getValue("2.3").trim();//获取序列参数；
		inner_no_rule = retVal.getValue("2.4").trim();//判断所选号码是否被占用；
		inner_no_seq = retVal.getValue("2.5").trim();//判断序列是否被占用；
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("selByWay","<%=selByWay%>");
response.data.add("fPrefix","<%=fPrefix%>");
response.data.add("lPrefix","<%=lPrefix%>");
response.data.add("sequencePara","<%=sequencePara%>");
response.data.add("inner_no_rule","<%=inner_no_rule%>");
response.data.add("inner_no_seq","<%=inner_no_seq%>");
core.ajax.receivePacket(response);