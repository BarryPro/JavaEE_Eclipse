<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String sm_code = request.getParameter("sm_code");
	String regCode = (String)session.getAttribute("regCode");
	//System.out.println("aaaaaaaaaaaaa="+sm_code);

	//String sqlStr = "select a.prod_direct,a.direct_name  from sProductDirect a,sProductCode b,sSmProduct c "+
		//							"where  a.prod_direct=b.direct_id and c.product_code=b.product_code "+	
			//						"and c.sm_code='"+sm_code+"' "+
				//					"group by a.prod_direct,a.direct_name";
									
	 String sqlStr = "select catalog_item_desc,catalog_item_name from catalog_item a,band b where "+
	                 " a.band_id = b.band_id "+
	                 "and b.sm_code ='"+sm_code+"' and catalog_item_type = 'V' ";							
									
 	 //String[] inParams = new String[2];
	 //inParams[0] =   " select a.prod_direct,a.direct_name  from sProductDirect a,sProductCode b,sSmProduct c "+
									//"where  a.prod_direct=b.direct_id and c.product_code=b.product_code "+	
									//"and c.sm_code=:sm_code"+
									//" group by a.prod_direct,a.direct_name";
    //inParams[1] = "sm_code="+sm_code;
		   
	//acceptList = callView.sPubSelect("2",sqlStr);
	
	System.out.println(sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
	
	String[][] colNameArr = result1;	

%>
<%
String strArray = WtcUtil.createArray("colNameArr",colNameArr.length);
System.out.println(strArray);
%>
<%=strArray%>
<%

for(int i = 0 ; i < colNameArr.length ; i ++){
      for(int j = 0 ; j < colNameArr[i].length; j ++){

				//System.out.println("bb="+colNameArr[i][j].trim());
				%>
				colNameArr[<%=i%>][<%=j%>] = "<%=colNameArr[i][j].trim()%>";
				<%
			}
}
%>
var response = new AJAXPacket();

response.data.add("retType","getProdDirect");
response.data.add("retCode","000000");
response.data.add("backString",colNameArr);

core.ajax.receivePacket(response);
