<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-26 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//读取用户session信息
	String regionCode =  (String)session.getAttribute("regCode");	
	
	String groupId   = request.getParameter("groupId");
	String accType   = request.getParameter("accType");
	String loginBegin = "";
	String loginEnd = "";
	String loginRegion = "";
	//comImpl comim=new comImpl();
	int    iNum = 0;
	System.out.println("+++++accType:"+accType);
	if(accType.equals("3") || accType.equals("0"))
	{
			String strSqla = "select b.login_region from dbresadm.dChnGroupInfo a, sRegionCode b "
					   + " where a.parent_group_id = b.group_id "
					   + " and a.group_id = '" + groupId + "' ";		
		
		%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=strSqla%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="strLoginRegion1" scope="end" />
		<%
		
			//ArrayList arrLoginRegion = comim.spubqry32("1",strSqla);
			
			System.out.println("++++++++"+strSqla+"++++++++");			
			
			String[][] strLoginRegion = strLoginRegion1;
			
			if(strLoginRegion.length > 0)
			{
				loginRegion = strLoginRegion[0][0]+"2";
				loginBegin = "0000";
				loginEnd = "9999";
				iNum = 4;
			}
			else
			{
				loginRegion = "2";
				loginBegin = "00000";
				loginEnd = "99999";
				iNum = 5;
			}
		
		System.out.println("+++++loginRegion:"+loginRegion);
	}
	else
	{
		loginRegion = "";
		loginBegin = "800000";
		loginEnd = "999999";
	}
	
	String strSqlb = "select func_getMinLogin('"+ loginBegin + "', '" + loginEnd + "', '" + loginRegion + "') "
				   + " from dual ";
	
	String loginNo = "";
	System.out.println("++++++++"+strSqlb+"++++++++");
	
	//ArrayList arrLoginNo = comim.spubqry32("1",strSqlb);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=strSqlb%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arrLoginNo" scope="end" />
<%
	
	System.out.println("++++++++++++++++");
	String[][] strLoginNo = arrLoginNo;	
	
	loginNo = strLoginNo[0][0];
	System.out.println("3333333333="+loginNo+"=222");
	System.out.println("======"+loginNo+"======");
	
%>

var info=new Array();
var response = new AJAXPacket();
info[0] =new  Array();
info[0][0] = "<%=loginNo%>";
response.data.add("backString",info);
response.data.add("flag","6");
core.ajax.receivePacket(response);



