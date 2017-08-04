<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%   
 String g_cityId=(String)session.getAttribute("cityId");
 String prodId   = request.getParameter("prodId");
 String vasProds = request.getParameter("vasProds");
 String orgCode = (String)session.getAttribute("orgCode");
 System.out.println("prodId==="+prodId);
 System.out.println("vasProds==="+vasProds);
 System.out.println("g_cityId==="+g_cityId);

  if(g_cityId==null) g_cityId = "01"; //hejwaÔö¼Ó²âÊÔÓÃ
  
 System.out.println("---------------------------g_cityId-------------------------"+g_cityId); 
 System.out.println("---------------------------prodId-------------------------"+prodId); 
 System.out.println("---------------------------vasProds-------------------------"+vasProds); 
%>
     <wtc:utype name="sSelNum" id="retVal" scope="end" >
          <wtc:uparam value="<%=prodId%>" type="String"/> 
          <wtc:uparam value="<%=vasProds%>" type="String"/>
          <wtc:uparam value="<%=g_cityId%>" type="String"/>     
     </wtc:utype>
     
 
<%			
	System.out.println("retCode in ajax================"+retVal.getValue(0));
	System.out.println(retVal.getValue(1));	
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	String path="";
	if(retCode.equals("0"))
	{ 
		UType total = (UType)retVal.getUtype(2);			
		path=total.getValue(3);
		System.out.println(path);
	}
	System.out.println("PATH="+path);
	
%>
var response = new AJAXPacket();
response.data.add("path","<%=path%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);