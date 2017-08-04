<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
	String strArray="var arrMsg; ";  //must

%>
<wtc:utype name="sBand" id="retVal" scope="end" >
		<wtc:uparams name="CataItemMsg" iMaxOccurs="1">  
		</wtc:uparams>
</wtc:utype>
<%
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
			for(int j=0;j<3;j++)
			{

				if(j==0||j==2)
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
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);