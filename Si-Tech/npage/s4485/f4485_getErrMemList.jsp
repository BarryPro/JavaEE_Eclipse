<%
    /********************
     * @ OpCode    :  4485
     * @ OpName    :  全网生效成员关系失败列表 
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-3-18 11:11:34
     * @ Update    :  
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String regionCode = iOrgCode.substring(0,2);
    
    String id_no = request.getParameter("id_no");
    String product_id = request.getParameter("product_id");
		String beginNum = request.getParameter("beginNum");
		String endNum = request.getParameter("endNum");
%>		
    <wtc:service name="s4485Qry" outnum="4" retmsg="returnMessage" retcode="returnCode" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=iLoginPwd%>" />
			<wtc:param value="<%=iOrgCode%>" />
			<wtc:param value="<%=iIpAddr%>" />	
			<wtc:param value="<%=id_no%>" />		
			<wtc:param value="<%=product_id%>" />
			<wtc:param value="<%=beginNum%>" />			
			<wtc:param value="<%=endNum%>" />	
		</wtc:service>
		<wtc:array id="result_t1" start="0" length="1" scope="end"/>
		<wtc:array id="result_t2" start="1" length="3" scope="end"  />
	 	var resultArray = new Array();
<%
	for(int i=0;i<result_t2.length;i++){
	%>
		resultArray[<%=i%>] = new Array();
	<%
			for(int j=0;j<result_t2[i].length;j++){
				if(result_t2[i][j]!=null){
%>
					resultArray[<%=i%>][<%=j%>]="<%=result_t2[i][j]%>";
<%				}
				}
		}
%>

var response = new AJAXPacket();
response.data.add("returnCode","<%=returnCode%>");
response.data.add("returnMessage","<%=returnMessage%>");
response.data.add("resultArray",resultArray);
response.data.add("resultCnt","<%=result_t1[0][0]%>");
core.ajax.receivePacket(response);