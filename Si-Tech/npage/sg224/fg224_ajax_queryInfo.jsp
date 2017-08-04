<%
    /*************************************
    * 功  能: 集团成员异步接口交易状态查询 g224
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-10-17
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	String grp_id=WtcUtil.repNull((String)request.getParameter("grp_id"));/*产品id*/
	String beginNum=WtcUtil.repNull((String)request.getParameter("beginNum"));/*开始记录数*/
  String endNum=WtcUtil.repNull((String)request.getParameter("endNum"));/*结束记录数*/
  
  String loginNo = (String)session.getAttribute("workNo");
  String regCode = (String)session.getAttribute("regCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgId = (String)session.getAttribute("orgId");
  
  String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String errorCode="444444";
	String[][] errCodeMsg = null;
	String[][] input_paras = new String[1][13];
	String[][] callData = new String[][]{};
	String[][] callData1 = new String[][]{};
	int no=0;
	String TOKEN = "~";
	List al = null;
	boolean showFlag=false;	//showFlag表示是否有数据可供显示
  int valid = 1;	//0:正确，1：系统错误，2：业务错误
  
  System.out.println("@:**********diling    333**loginNo="+loginNo);
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sg224Qry" routerKey="region" routerValue="<%=regCode%>" retcode="returnCode" retmsg="returnMessage" outnum="8">
	  <wtc:param value="<%=loginNo%>"/>
	  <wtc:param value="<%=orgCode%>"/>
	  <wtc:param value="<%=regCode%>"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=printAccept%>"/>
	  <wtc:param value="<%=ipAddr%>"/>
	  <wtc:param value="<%=orgId%>"/>
		<wtc:param value="<%=grp_id%>"/>
		<wtc:param value="<%=beginNum%>"/>
		<wtc:param value="<%=endNum%>"/>
	</wtc:service>
	<wtc:array id="result_t1" start="0" length="1" scope="end"/>
	<wtc:array id="result_t2" start="1" length="7" scope="end"  /> 
	var resultArray = new Array();
<%
	System.out.println("@:******************************************");
	System.out.println("@:***"+result_t2.length);
	for(int i=0;i<result_t2.length;i++){
	  System.out.println("@:******************************************");
	%>
		resultArray[<%=i%>] = new Array();
	<%
	System.out.println("@:**********diling    111********************************");
			for(int j=0;j<result_t2[i].length;j++){
      System.out.println("@:**********diling    222********************************");
				if(result_t2[i][j]!=null){

				  System.out.println("-----------3218--------------result_t2[i][j]="+result_t2[i][j]);
				  System.out.println("@:**********diling    333********************************");
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
<%
  if(result_t1.length>0){
%>
    response.data.add("resultCnt","<%=result_t1[0][0]%>");
<%
  }
%>
  core.ajax.receivePacket(response);