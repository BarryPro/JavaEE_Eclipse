<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode =  (String)session.getAttribute("regCode");
	String noList = request.getParameter("noList");
	String iNoList = request.getParameter("iNoList");

	//comImpl co=new comImpl();

	String sq1="select max(login_no) from dLoginMsg where login_no like '"+noList+"%' ";
	System.out.println(sq1);
	String sq2 = "select max(substr(org_code,8,2)) from dLoginMsg where org_code like '"+iNoList+"%'";
	System.out.println(sq2);
	String sq3 = "select SEQ_MailCode.NEXTVAL from dual";//20100317 add
	System.out.println(sq3);//20100317 add
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sq1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="testtt" scope="end" />
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sq2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="nott" scope="end" />
//20100317 add
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:sql><%=sq3%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="SEQ_MailCodeStr" scope="end" />
//20100317 end
<%
	//ArrayList passArr=co.spubqry32("1",sq1);
	//ArrayList noArr = co.spubqry32("1",sq2);
	//String[][] testtt = (String[][])passArr.get(0);
	//String[][] nott = (String[][])noArr.get(0);
	System.out.println(testtt.length);
	System.out.println("当前最大工号为："+testtt[0][0]);
if(testtt[0][0].trim().equals("")){
	if(noList.length()==1){
	testtt[0][0]=noList+"00000";
	}else{
	testtt[0][0]=noList+"00";
}
	
}
if(nott[0][0].trim().equals("")){
	nott[0][0]="00";
}

System.out.println("最后工号："+nott[0][0]);
System.out.println("工号序列："+SEQ_MailCodeStr[0][0]);//20100317 add
System.out.println("aaaa："+testtt[0][0]+" "+nott[0][0]+" "+SEQ_MailCodeStr[0][0]+ " ");//20100317 add
%>
var response = new AJAXPacket();
response.data.add("backString","<%=testtt[0][0]%>");
response.data.add("nott","<%=nott[0][0]%>");
response.data.add("SEQ_MailCode","<%=SEQ_MailCodeStr[0][0]%>");//20100317 add
response.data.add("flag","10");
core.ajax.receivePacket(response);
