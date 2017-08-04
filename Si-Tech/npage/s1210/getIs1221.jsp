<%
  /*
   * 功能: 判断当前用户的上一次对sim卡的操作是否是1221 
   * 版本: 1.8.2
   * 日期: 2011/6/16
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String) session.getAttribute("regCode");
  
  String cus_id =  request.getParameter("cus_id");
	String verifyType = request.getParameter("verifyType");
	String updateCode="";
	String errCode = "";
	String errMsg = "";
			System.out.println("---------------cus_id---------------------"+cus_id);
	String strSql2="select update_code from dcustsimhis where id_no=? and update_time = ( select max(update_time) from dcustsimhis where id_no=? )";			
  String [] paraIn2 = new String[3];
  paraIn2[0] = strSql2;
  paraIn2[1]="idNo1="+cus_id;		
  paraIn2[2]="idNo2="+cus_id;	
%>	
				
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
<wtc:sql><%=strSql2%></wtc:sql>
          <wtc:param value="<%=cus_id%>"/> 
          <wtc:param value="<%=cus_id%>"/> 
</wtc:pubselect>	
<wtc:array id="updateNoStr" scope="end" />				
<%			
			errCode=retCode;
			errMsg=retMsg;
			System.out.println("---------------errCode---------------------"+errCode);
			if(errCode.equals("000000"))
		  {					System.out.println("---------------updateNoStr.length---------------------"+updateNoStr.length);
				if(updateNoStr.length>0)
				{	
				System.out.println("---------------updateNoStr.length---------------------"+updateNoStr.length);
					updateCode=updateNoStr[0][0];
					System.out.println("---------------updateCode---------------------"+updateCode);
						System.out.println("---------------updateNoStr[0][0]---------------------"+updateNoStr[0][0]);
				}
			}		
%>	
var response = new AJAXPacket();
response.data.add("verifyType","<%=verifyType%>");
response.data.add("updateCode","<%=updateCode%>");
response.data.add("retCode","<%=errCode%>");
response.data.add("retMessage","<%=errMsg%>");
core.ajax.receivePacket(response);



