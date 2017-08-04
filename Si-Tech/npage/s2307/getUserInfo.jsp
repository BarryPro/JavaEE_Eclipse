<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>


<%
	String workNo = request.getParameter("workNo");						//操作工号
	String phoneNo = request.getParameter("phoneNo").trim();					//用户号码
	String opCode = request.getParameter("opCode");						//操作代码
	String orgCode = request.getParameter("orgCode");					//归属代码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
//	ArrayList arr = F2307Wrapper.callF2307Init(workNo,phoneNo,opCode,orgCode);
//	String[][] userInfo = (String[][])arr.get(0);
//	String[][] errInfo = (String[][])arr.get(1);
    
  //  String sqlStr = "select to_char(id_no) from dcustmsg where phone_no="+phoneNo;
//String sqlStr1 = "select to_number(id_no) from dcustmsg where phone_no="+phoneNo;
     String id_no="";
	 String count_1 = "";
     String SqlStr1 = "select to_char(id_no) from dcustmsg where phone_no = :phoneNo1 ";
	
	String [] paraIn = new String[2];
	paraIn[0] = SqlStr1;
	paraIn[1] = "phoneNo1="+phoneNo ;
%>

	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>

<%  
  if(result1.length>0)
  {
   id_no=result1[0][0];
   System.out.println("---------------------------------------------------"+id_no);
  }
 
    String sqlStr1 ="select to_char(expire_time,'yyyymmdd') from dCustCreditAdj where id_no = to_number("+id_no+")";
    System.out.println("---------------------"+sqlStr1);
     %>
	<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
	<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
String expire="";


if(result.length>0)
{
           System.out.println("--------------------------2307--------------------------------"+result[0][0]);
           expire=result[0][0].trim();
           

}

%>
	<wtc:service name="s2307Init" routerKey="region" routerValue="<%=regionCode%>" outnum="29" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=orgCode%>"/>
		</wtc:service>
	<wtc:array id="userInfo" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	
	// xl add for 2307 2308办理时根据e068的办理情况进行提示 begin
	String sql_count = "select to_char(count(*)) from dCustCreditAdjHis where id_no = '?'  and op_code = 'e068' ";
	// xl add for 2307 2308办理时根据e068的办理情况进行提示 end
	%>
		<wtc:pubselect name="TlsPubSelBoss"    outnum="1">
			<wtc:sql><%=sql_count%></wtc:sql>
			<wtc:param value="<%=id_no%>"/>
			</wtc:pubselect>
		<wtc:array id="count1_new" scope="end" />
	<%
	if(count1_new.length>0)
	{
		count_1 = count1_new[0][0].trim();
	}
	System.out.println(userInfo.length+"aaaaaaaaaaaaaaaaaaaaaaaaaaaa "+count_1);
	if(userInfo.length==0){
	

%>
	var response = new AJAXPacket();
	
	response.data.add("backString","");
	
	response.data.add("flag1","0");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("count_1","<%=count_1%>");
	
	core.ajax.receivePacket(response);



<%
	


		
	}else{
		System.out.println("idNo			用户id               is : "+userInfo[0][0]);
		System.out.println("smCode			业务类型代码         is : "+userInfo[0][1]);
		System.out.println("smName			业务类型名称         is : "+userInfo[0][2]);
		System.out.println("custName		客户名称             is : "+userInfo[0][3]);
		System.out.println("userPassword	用户密码             is : "+userInfo[0][4]);
		System.out.println("runCode			状态代码             is : "+userInfo[0][5]);
		System.out.println("runName			状态名称             is : "+userInfo[0][6]);
		System.out.println("ownerGrade		等级代码             is : "+userInfo[0][7]);
		System.out.println("gradeName		等级名称             is : "+userInfo[0][8]);
		System.out.println("ownerType		用户类型             is : "+userInfo[0][9]);
		System.out.println("ownerTypeName	用户类型名称         is : "+userInfo[0][10]);
		System.out.println("custAddr		客户住址             is : "+userInfo[0][11]);
		System.out.println("idType			证件类型             is : "+userInfo[0][12]);
		System.out.println("idName			证件名称             is : "+userInfo[0][13]);
		System.out.println("idIccid			证件号码             is : "+userInfo[0][14]);
		System.out.println("totalOwe		当前欠费             is : "+userInfo[0][15]);
		System.out.println("totalPrepay		当前预存             is : "+userInfo[0][16]);
		System.out.println("firstOweConNo	第一个欠费帐号       is : "+userInfo[0][17]);
		System.out.println("firstOweFee		第一个欠费帐号金额   is : "+userInfo[0][18]);
		System.out.println("qryFlag		    是否可以查询		 is : "+userInfo[0][19]);
		System.out.println("qryNote		    申请说明		     is : "+userInfo[0][20]);
			System.out.println("qryNote		    申请说明		     is : "+userInfo[0][22]);

%>
<%
	String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);

%>
<%=strArray%>
<%

	for(int i = 0 ; i < userInfo.length ; i ++){
      	for(int j = 0 ; j < userInfo[i].length ; j ++){

 if(j==22){
%>
        userInfo[<%=i%>][<%=j%>] = "<%=expire%>";
<%
}
else{
%>

	userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
<%
}
}
}
%>
	var response = new AJAXPacket();
	
	response.data.add("backString",userInfo);
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("flag1","0");
	response.data.add("count_1","<%=count_1%>");
	core.ajax.receivePacket(response);
<%}%>