<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String offerId = WtcUtil.repNull(request.getParameter("offerId"));//销售品编码
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));//销售品名称
  
  String strArray="var retResult; ";  //must
%>

<wtc:utype name="sChkQhOffer" id="retVal" scope="end">
			<wtc:uparam value="<%=offerId%>" type="LONG"/>  
			<wtc:uparam value="<%=login_no%>" type="STRING"/>  
			<wtc:uparam value="<%=phoneNo%>" type="STRING"/>
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1);
	 
	 String location = "";
	 if(retCode.equals("0"))
	{
  	int retValNum = retVal.getUtype("2").getSize();
		strArray = WtcUtil.createArray("retResult",retValNum);	
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<retValNum;i++)
		 {
			location = "2."+i;
			int n =0;
			for(int j=0;j<32;j++){
		  	if(j==1||j==2||j==3||j==16||j==17||j==20||j==31){
			    String temp = retVal.getUtype(location).getValue(j);
						if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
					%>
					retResult[<%=i%>][<%=n%>] = "<%=temp.trim()%>";
					<%
					n++;
			  }
			}
	%>			
	<%		
		}	
	}else{
		%>
		retResult=null;
		<%
		}
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);