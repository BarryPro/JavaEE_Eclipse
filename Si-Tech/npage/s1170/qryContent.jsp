<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String idNo="";
	String getIdNo="SELECT id_no FROM dcustmsg WHERE phone_no='"+phoneNo+"'";
	String printInfo="";
%>

<wtc:pubselect name="sPubSelect"  retcode="retCodeNo2" retmsg="retMsgNo2" outnum="1">
 <wtc:sql><%=getIdNo%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="retarr" scope="end"/>  
	
<%
			if(retarr.length!=0){
				idNo=retarr[0][0];
			}
			
%>
		<wtc:utype name="sQUserOfferInst" id="retVal" scope="end" >
		<wtc:uparam value="<%=idNo%>" type="LONG"/>      
		<wtc:uparam value="99" type="LONG"/>      
		<wtc:uparam value="0" type="LONG"/>      
		<wtc:uparam value="0" type="LONG"/>    
		</wtc:utype>
   
   <%
			if(opCode.equals("127a"))
			{
				for(int i=0; i<retVal.getSize("2"); i++){  
							if(retVal.getValue("2." + i + ".3").equals("10")){
									if(retVal.getValue("2." + i + ".7").equals("X")){
											printInfo+="当前主资费："+retVal.getValue("2." + i + ".2")+" ";
									}
									if(retVal.getValue("2." + i + ".7").equals("A")){
											printInfo+="预约主资费："+retVal.getValue("2." + i + ".2");
									}
							}				
				}
			}
			else if(opCode.equals("1257"))
			{
				for(int i=0; i<retVal.getSize("2"); i++){  
							if(retVal.getValue("2." + i + ".3").equals("10")){
									if(retVal.getValue("2." + i + ".7").equals("X")){
											printInfo+="当前："+retVal.getValue("2." + i + ".1")+"；";
									}
							}				
				}
			}
   %>
var response = new AJAXPacket();
response.data.add("printInfo","<%=printInfo%>");
core.ajax.receivePacket(response);