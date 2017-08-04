<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
update:liutong@2008.08.25
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
		 int recordNum = 0; 
		  String retInfo = "";
	    String retType = request.getParameter("retType");
        String fieldNum = request.getParameter("fieldNum");
        int fieldNum1= Integer.parseInt(fieldNum)+1;
        fieldNum=""+fieldNum1;
        String sqlStr = request.getParameter("sqlStr");
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
        //String regionCode=request.getParameter("regionCode");
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage" outnum="<%=fieldNum%>">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
recordNum = result.length;
System.out.println("_________________________________________________________________________");
	    for(int i=0;i<result.length;i++){
	      for(int j=0;j<result[i].length;j++){
	      System.out.println("############################result["+i+"]["+j+"]"+"   "+result[i][j]);
	      
	      }
	    
	    
	    }
System.out.println("_________________________________________________________________________");
 if(recordNum > 0)
            {   
                for(int i=0;i<recordNum;i++)
                {
                    for(int j=0;j<Integer.parseInt(fieldNum);j++)
                    {
                        retInfo = retInfo + result[i][j] + "|";
                    }
                }
            }   

}
     
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = ""
var recordNum = "";
var retInfo = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
recordNum = "<%=recordNum%>";
retInfo = "<%=retInfo%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("recordNum",recordNum);
response.data.add("retInfo",retInfo);
core.ajax.receivePacket(response);

