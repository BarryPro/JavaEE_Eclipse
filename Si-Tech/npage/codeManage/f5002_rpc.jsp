<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String errorMsg = "";
	String errorCode = "0000";
	String regionCode = request.getParameter("regionCode");
	String districtCode = request.getParameter("disCode"); 
	String townCode = request.getParameter("townCode"); 
	String typecode = request.getParameter("typecode");
	String townCodeStrs[]=null;
	String townNameStrs[]=null;
	String townMsgStrs[]=null;
	String sql = "";
	//comImpl co=new comImpl();	
	if(typecode == null || "".equals(typecode))
	{
		errorCode = "1000";
		errorMsg = "获取类型代码为空！";
		
	}
	else if(regionCode == null || "".equals(regionCode))
	{
		errorCode = "2000";
		errorMsg = "区域代码为空！";
		
	}
	else if(districtCode == null || "".equals(districtCode))
	{
		errorCode = "3000";
		errorMsg = "区县代码为空！";
	}
	else
	{
		if( "getTown".equals(typecode) )
		{
			sql = "select trim(town_code),trim(town_code)||'-->'||trim(town_name) from sTownCode where region_code='"+regionCode+"' and district_code = '"+districtCode+"' order by town_code";
			//List al = null;
		%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="al" scope="end" />
		<%
			//al = co.spubqry32("2",sql);
			if(al != null)
			{
				String townCodeData[][] = al;
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
				errorMsg = "数据错误！";
			}
		}
		else if( "getTownMsg".equals(typecode) )
		{
			if(townCode == null || "".equals(townCode))
			{
				errorCode = "5000";
				errorMsg = "代销点代码为空！";
			}
			else
			{
				sql = "select trim(a.town_name),a.innet_type,nvl(trim(a.doc_flag),'1'),nvl(trim(a.fee_type),'1'),"+
					"a.login_town,a.TOWN_ADDRESS,a.TOWN_PHONE,a.CONTACT_PERSON,a.CONTACT_PHONE,a.CONTACT_ID,"+
					"b.first_class_code,b.class_code from sTownCode a,dchngroupmsg b"+
					" where a.region_code='"+regionCode+
					"' and a.group_id = b.group_id and a.district_code='"+districtCode+
					"' and a.town_code = '"+townCode+"'";

				//List all = null;
				//all = co.spubqry32("12",sql);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="12">
					<wtc:sql><%=sql%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="all" scope="end" />
			<%
				if(all != null)
				{
					//String townCodeMsg[][] = (String[][])all.get(0);
					String townCodeMsg[][] = all;
					if(townCodeMsg.length == 1)
					{
						townMsgStrs = new String[townCodeMsg[0].length];
						for(int i=0; i< townCodeMsg[0].length; i++)
						{
							townMsgStrs[i] = townCodeMsg[0][i];
						}
					}
					else
					{
						errorCode = "4002";
						errorMsg = "无法获取代码详细数据！";
					}	
				}
				else
				{
					errorCode = "4001";
					errorMsg = "数据错误！";
				}
			}
		}
	}
	System.out.println("================================================");
%>

var response = new AJAXPacket();
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorCode","<%=errorCode%>");
response.data.add("typecode","<%=typecode%>");
<%
if("0000".equals(errorCode))
{
	if( "getTown".equals(typecode) )
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
	else if( "getTownMsg".equals(typecode) )
	{
%>
		var values = Array();
<%		
		for(int i=0; i< townMsgStrs.length; i++)
		{
%>
			values[<%=i%>] = "<%=townMsgStrs[i]%>";
<%
		}
%>
		response.data.add("values",values);
<%
	}
}	
%>
core.ajax.receivePacket(response);

