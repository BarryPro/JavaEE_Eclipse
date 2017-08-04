 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String phone_no= request.getParameter("phoneNo");
	
	System.out.println("phone_no================"+phone_no);
	
	String sql = "SELECT a.op_code,b.type_name FROM wsimoutdata a,ssaletype b,dcustmsg c WHERE c.phone_no='"+phone_no+"' and c.id_no=a.id_no and a.op_code=b.op_code group by a.op_code,b.type_name";
	System.out.println("sql============"+sql);
	%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
	<%
	
	String retCode2=retCode1;
	String retMsg2=retMsg1;
	System.out.println("retMsg2============"+retMsg2);
	
 	if(retMsg2.equals("")){ 		
		retMsg2 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode2));
		if( retMsg2.equals("null")){			
			retMsg2 ="未知的错误信息";
		}
	}
	System.out.println("retMsg2============"+retMsg2);
if(result.length==0){
System.out.println("11111111111111111============"+retMsg2);
%>
var response = new AJAXPacket();
response.data.add("backString","");
response.data.add("flag","8");
response.data.add("errCode",'<%=retCode2%>');
response.data.add("errMsg",'<%=retMsg2%>');

core.ajax.receivePacket(response);

<%

}else{
	System.out.println("22222222222222222222222============"+retMsg2);
%>
<%
String strArray = CreatePlanerArray.createArray("result",result.length);

%>
<%=strArray%>
var result;
var _code = new Array();
var _text = new Array();
<%
 

      for(int j = 0 ; j < result.length ; j ++){


%>
       
       _code[<%=j%>] = "<%=result[j][0]%>";
		_text[<%=j%>] = "<%=result[j][1]%>";
<%
}

%>

	var response = new AJAXPacket();
	response.data.add("backString",result);
	response.data.add("code",_code);
	response.data.add("text",_text);
	response.data.add("errCode",'<%=retMsg2%>');
	response.data.add("errMsg",'<%=retMsg2%>');
	response.data.add("flag","1");
	core.ajax.receivePacket(response);
<%
System.out.println("===========================================================");


}%>
