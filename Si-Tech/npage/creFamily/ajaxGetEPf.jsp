<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String tempNote_info2v = WtcUtil.repNull(request.getParameter("tempNote_info2v"));
	String opCodeIn = WtcUtil.repNull(request.getParameter("opCode"));
	System.out.println("tempNote_info2v="+tempNote_info2v);
	String regionCode = (String)session.getAttribute("regCode");
	if(opCodeIn==null||"".equals(opCodeIn)){
		opCodeIn = "q001";
	}
	System.out.println("tempNote_info2v|"+tempNote_info2v);
	String workNo = (String)session.getAttribute("workNo");
	String tempArray[] = tempNote_info2v.split("\\|");
	String offerId = "";
	String retResultStr = "";
	for(int i=0;i<tempArray.length;i++){
		if(!tempArray[i].equals("")&&tempArray[i]!=null){
			offerId = tempArray[i];
			System.out.println("offerId|"+offerId);
			
%>

    <wtc:service name="sGetDetailCode" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerId%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCodeIn%>" />	
			<wtc:param value=" " />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />

<%
	System.out.println("<<------------result_t33.length----------->>"+result_t33.length);
		if(code.equals("000000") && result_t33.length > 0){
			for(int j=0;j<result_t33.length;j++){
				//retResultStr = retResultStr+" 二次批价代码："+result_t33[j][2];
				if(retResultStr+result_t33[j][3]!=null&&(!result_t33[j][3].equals("")))
				          retResultStr = retResultStr+result_t33[j][3];
				//retResultStr = retResultStr+" 到期后OfferId："+result_t33[j][4];
				//retResultStr = retResultStr+" 到期后二批代码："+result_t33[j][5];
				//retResultStr = retResultStr+" 到期后资费名称："+result_t33[j][6];
				//retResultStr = retResultStr+" 到期后资费描述："+result_t33[j][7];
			}
		}
	}
}
	System.out.println("--------------retResultStr|---------------"+retResultStr);
	retResultStr = retResultStr.replaceAll("\r","");
	retResultStr = retResultStr.replaceAll("\n","");
	retResultStr = retResultStr.replaceAll("\r\n"," ");
%>
var retResultStr = "<%=retResultStr%>";

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
retResultStr = codeChg(retResultStr);
var response = new AJAXPacket();
response.data.add("retResultStr",retResultStr);
core.ajax.receivePacket(response);
 