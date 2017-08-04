<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String groupId = (String)session.getAttribute("groupId");
		String sqlV1   = (String)request.getParameter("sqlV1");  
		String regionCode = (String)session.getAttribute("regCode");
		
		
		System.out.println("\n\n\n\n\n\n\n\n");
		System.out.println(sqlV1);
		System.out.println("\n\n\n\n\n\n\n\n");
%>		
 	<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlV1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	 	var offerLimitArray = new Array();
<%
	System.out.println("mylog   code== "+code);
	System.out.println("mylog   msg== "+msg);
	
	for(int iii=0;iii<result_t2.length;iii++){
	%>
	offerLimitArray[<%=iii%>] = new Array();
	<%
				for(int jjj=0;jjj<result_t2[iii].length;jjj++){
				
				if(result_t2[iii][jjj]!=null){
					System.out.println("mylog---------------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
%>
		offerLimitArray[<%=iii%>][<%=jjj%>]="<%=result_t2[iii][jjj]%>";
<%					}
				}
		}
%>

var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
response.data.add("offerLimitArray",offerLimitArray);
core.ajax.receivePacket(response);