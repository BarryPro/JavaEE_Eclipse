<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String goodNo = WtcUtil.repNull(request.getParameter("goodNo"));//ö¦ºÅ
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  
  
  String sqlInfo="";
  String strArray="var retResult; ";  //must
  String goodTyp=null;
  String regCode=null;
  System.out.println("#####################################################################################goodNo==="+goodNo);
  /* <wtc:sql>select good_type,region_code from dcustres where phone_no='?'</wtc:sql> */
%>

    <wtc:service name="sGoodNoCheck" outnum="15" retmsg="retMsg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=goodNo%>" />
			<wtc:param value="<%=workNo%>" />
		</wtc:service>
		<wtc:array id="rows" scope="end" />		
<%

     System.out.println("# from ajax_qryGoodTypeByGoodNo.jsp -> retCode = "+retCode); 
     System.out.println("# from ajax_qryGoodTypeByGoodNo.jsp -> retMsg = "+retMsg); 
     System.out.println("# from ajax_qryGoodTypeByGoodNo.jsp -> rows.length = "+rows.length); 
	 if(retCode.equals("000000"))
	{
		strArray = WtcUtil.createArray("retResult",rows.length);	
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<rows.length;i++)
		 {
		 		for(int j=0;j<rows[i].length;j++){
			    String temp = rows[i][j];
			    System.out.println("######################################rows["+i+"]["+j+"]=="+temp);
						if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
					%>
					retResult[<%=i%>][<%=j%>] = "<%=temp.trim()%>";			
	<%		
			}
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