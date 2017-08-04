<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/public/3des_enc.jsp" %>
<%
   String sqlStr = WtcUtil.repNull(request.getParameter("selSql"));
   
   sqlStr = uncMe_nokey(sqlStr);
   sqlStr = sqlStr.trim();
    
   System.out.println("---hejwa---------sqlStr----------->"+sqlStr);
   
   
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String selName = WtcUtil.repNull(request.getParameter("selName"));
   String count = String.valueOf(WtcUtil.countSqlCol(sqlStr));
   String strArray="var arrMsg; ";  //must 
   
   if(sqlStr.indexOf("#")>-1){
			int  chPos1 = sqlStr.indexOf("#");
			int  chPos2;
			String chObj="";
			String chStr="";
			String tmp = "";
			while(chPos1>-1){
				chStr = sqlStr.substring(chPos1+1);
				chPos2 = chStr.indexOf("#");
				chObj = chStr.substring(0,chPos2);
				tmp = "#"+chObj+"#";	
				
				String tmpVal = (WtcUtil.repNull((String)session.getAttribute(chObj)))==null?(WtcUtil.repNull((String)request.getParameter(chObj))):(WtcUtil.repNull((String)session.getAttribute(chObj)));
		  if(!tmpVal.equals(""))
		   {
			   sqlStr = sqlStr.replaceAll(tmp,tmpVal);
			 }
				chPos1 = sqlStr.indexOf("#");
			}
		}
System.out.println("#####getDyOptions.jsp#####sqlStr===="+sqlStr);
%>
   <wtc:pubselect name="sPubSelect" outnum="<%=count%>">
   		<wtc:sql><%=sqlStr%></wtc:sql>
   </wtc:pubselect>
   <wtc:array id="rows" scope="end"/>
<%
  strArray = WtcUtil.createArray("arrMsg",rows.length);
%>
<%=strArray%>
	<%
			for(int i = 0; i < rows.length; i ++){
	      	for(int j = 0 ; j < rows[i].length ; j ++)
	      	{
	%>
					arrMsg[<%=i%>][<%=j%>] = '<%=WtcUtil.repNull(rows[i][j])%>';
	<%      
	  			}
					
			}
     	
%>
   	
var response = new AJAXPacket();
response.data.add("selName","<%=selName%>");
response.data.add("retType","<%=retType%>");
response.data.add("arrMsg",arrMsg);
core.ajax.receivePacket(response);
