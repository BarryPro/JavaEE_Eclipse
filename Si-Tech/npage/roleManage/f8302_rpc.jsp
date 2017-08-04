<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String errorMsg = "";
	String errorCode = "0000";
	/*String regionCode = request.getParameter("regionCode");*/
	String regionCode= (String)session.getAttribute("regCode");
	String districtCode = request.getParameter("disGroup"); 
	/*String townCode = request.getParameter("townCode"); */
	String typecode = request.getParameter("typecode");
	String townCodeStrs[]=null;
	String townNameStrs[]=null;
	String townMsgStrs[]=null;
	String sql = "";

	if( "getTown".equals(typecode) )
		{
			String login_no=request.getParameter("loginno");
			sql = "select a.group_id,group_name  from dChnGroupMsg a,dbresadm.dChnGroupInfo b ,srolelogintown c "+
					" where a.group_id=b.group_id  and b.parent_group_id='"+ districtCode+"' and a.group_id=c.group_id and c.login_no='"+login_no+"'"+
					"  and c.op_code='8176' Order By a.group_id ";
			System.out.println("sql="+sql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
			if(result1 != null)
			{
					String townCodeData[][] = result1;
					townCodeStrs = new String[townCodeData.length];
					townNameStrs = new String[townCodeData.length];                                
					for(int i=0; i< townCodeData.length; i++)
					{
						townCodeStrs[i] = townCodeData[i][0];
						townNameStrs[i] = townCodeData[i][1];
					}
			}       
			else
			{
					errorCode = "4000";
					errorMsg = "取营业厅数据错误！";
			}
			
		}
	if( "getLogin".equals(typecode) )
		{
			
			sql = "select login_no,login_no||'-->'||login_name  from dloginmsg "+
					" where group_id='"+districtCode+"' and vilid_flag='1' "+
					"  Order By login_no ";
			System.out.println("sql="+sql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end"/>
<%
			if(result2 != null)
			{
					String townCodeData1[][] = result2;
					townCodeStrs = new String[townCodeData1.length];
					townNameStrs = new String[townCodeData1.length];                                
					for(int i=0; i< townCodeData1.length; i++)
					{
						townCodeStrs[i] = townCodeData1[i][0];
						townNameStrs[i] = townCodeData1[i][1];
					}
			}       
			else
			{
					errorCode = "5000";
					errorMsg = "取工号数据错误！";
			}
			
		}
	
%>
var response = new AJAXPacket();
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("typecode","<%=typecode%>");
<%
if("0000".equals(errorCode))
{
	if( "getTown".equals(typecode) || "getLogin".equals(typecode) )
	{
%>
		var values = Array();
		var names = Array();
<%
		for(int i=0; i< townCodeStrs.length ;i++)
		{
%>
			values[<%=i%>] = "<%=townCodeStrs[i]%>";
			names[<%=i%>] = "<%=townNameStrs[i]%>";
<%
		}
%>
		response.data.add("values",values);
		response.data.add("names",names);
<%
	}
	
	
}	
%>
core.ajax.receivePacket(response);

