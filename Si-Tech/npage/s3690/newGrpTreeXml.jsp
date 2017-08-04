<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode	=org_code.substring(0,2);
		
		String ProdType=WtcUtil.repNull(request.getParameter("ProdType"));
		String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));
		String prod_direct=WtcUtil.repNull(request.getParameter("prod_direct"));
		String biz_code=WtcUtil.repNull(request.getParameter("biz_code"));
		
		String strArray="var arrMsg;";                    
%>
<wtc:service name="sQGroupCatalog" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
		<wtc:param   value="S" />
		<wtc:param   value="<%=ProdType%>"/>
		<wtc:param   value="T"/>
		<wtc:param   value="<%=sm_code%>"/>
		<wtc:param   value="V"/>
		<wtc:param   value="<%=prod_direct%>"/>
		<wtc:param   value="W"/>
		<wtc:param   value="<%=biz_code%>"/>
</wtc:service>
<wtc:array id="rows1" start="0" length="2" scope="end"/>
<wtc:array id="rows" start="2" length="6" scope="end"/>
<%
	if(retCode.equals("000000"))
	{
		int retValNum = rows.length;
		strArray = WtcUtil.createArray("arrMsg",retValNum);
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<retValNum;i++)
		 {
			int n = 0;
			for(int j=0;j<6;j++)
			{
        System.out.println("rows["+i+"]["+j+"]=="+rows[i][j]);
				if(j==0||j==2||j==3||j==5)
				{
					String temp =rows[i][j]; 
					if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
	%>
					arrMsg[<%=i%>][<%=n%>] = "<%=temp.trim().replaceAll("\\n"," ")%>";
	<%
					n++;
				}
			}		
		}	
	}else{
		%>
		arrMsg=null;
		<%
		}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
response.data.add("backArrMsg",arrMsg);
core.ajax.receivePacket(response);