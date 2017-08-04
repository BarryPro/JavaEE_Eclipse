<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
	
	String band_id = WtcUtil.repNull(request.getParameter("band_id"));
	String goodKind = WtcUtil.repNull(request.getParameter("goodKind"));
	String openFlag = WtcUtil.repNull(request.getParameter("openFlag"));
	String strArray="var arrMsg; ";  //must

	if(openFlag.equals("")||openFlag==null){
		System.out.println("openFlag.equals()||openFlag==null");
	}else{
		goodKind = "P";
	}
	
	System.out.println("------------------------band_id---------------------"+band_id);
	System.out.println("------------------------goodKind--------------------"+goodKind);
	
	
%>
<wtc:utype name="sCatalog_Item" id="retVal" scope="end" >
		<wtc:uparams name="CataItemMsg" iMaxOccurs="1">
			<wtc:uparam value="<%=band_id%>" type="LONG"/>
			<wtc:uparam value="<%=goodKind%>" type="STRING"/>      
		</wtc:uparams>
</wtc:utype>
<%

	  StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println(logBuffer.toString());
   
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 String location = "";
	  if(retCode.equals("0"))
	{

	
		int retValNum = retVal.getUtype("2").getSize();
		strArray = WtcUtil.createArray("arrMsg",retValNum);
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<retValNum;i++)
		 {
			location = "2."+i;
			int n = 0;
			for(int j=0;j<6;j++)
			{

				if(j==0||j==2||j==3||j==5)
				{
					String temp = retVal.getUtype(location).getValue(j);
					if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
	%>
					arrMsg[<%=i%>][<%=n%>] = "<%=temp.trim()%>";
	<%
					n++;
				}
			}
	%>
			
	<%		
		}	
	}else{
		%>
		arrMsg=null;
		<%
		}
%>

var response = new AJAXPacket();
response.data.add("band_id","<%= band_id %>");
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);