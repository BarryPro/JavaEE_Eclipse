<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	request.setCharacterEncoding("ISO-8859-1"); 
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	Logger logger = Logger.getLogger("f3052QueryList1.jsp");
	 
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String implRegion = regionCode;

	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	String bizCode= request.getParameter("bizCode")==null?"":request.getParameter("bizCode");//业务代码
	String spCode = request.getParameter("spCode")== null?"":request.getParameter("spCode"); //企业代码
	String bizType = request.getParameter("bizType")==null?"":request.getParameter("bizType"); 
	
	if(!(bizCode.equals("")))
	{
	    whereSql = whereSql + " AND c.BIZCODEadd LIKE '"+bizCode+"%' ";
	}
	if(!(spCode.equals(""))&& bizType.equals("0"))
	{
	      whereSql = whereSql + " and c.ENTERPRICE_CODE like '"+spCode+"%' ";
	}
  if(!(spCode.equals(""))&& bizType.equals("1"))
	{
	    //whereSql = whereSql + " and g.unit_id = '"+spCode+"'";
	    whereSql = whereSql + " and c.ENTERPRICE_CODE = '"+spCode+"' ";
	}
	
	if(bizType.equals("0"))
	{
	    whereSql = whereSql + " ORDER BY F.REGION_CODE, C.ENTERPRICE_CODE, A.FIELD_CODE1, A.FIELD_CODE3 ";
	}
  if( bizType.equals("1"))
	{
	     //whereSql = whereSql + " ORDER BY F.REGION_CODE, g.unit_id, A.FIELD_CODE1, A.FIELD_CODE3 ";
	     whereSql = whereSql + " ORDER BY F.REGION_CODE, c.ENTERPRICE_CODE, A.FIELD_CODE1, A.FIELD_CODE3 ";
	}
	if(bizType.equals("0"))
	{
	/*sqlStmt ="SELECT F.REGION_CODE,C.ecsiid, A.FIELD_CODE1, C.bizname,A.FIELD_CODE3,B.OFFER_NAME "
	+" FROM DBVIPADM.SCOMMONCODE A,PRODUCT_OFFER   B,dBaseEcSIBusi  C,REGION  D,SREGIONCODE  F "
  +" WHERE A.COMMON_CODE = '1001'  AND A.FIELD_CODE3 = TO_CHAR(B.OFFER_ID) AND TRIM(C.BIZCODE) = A.FIELD_CODE1 " 
  +" AND B.OFFER_ID = D.OFFER_ID  AND D.GROUP_ID = F.GROUP_ID(+) AND F.REGION_CODE = A.FIELD_CODE2 "
  +" AND B.OFFER_ATTR_TYPE <> 'JT'  AND SUBSTR(B.USER_RANGE, 1, 1) = ANY('1', '4')  "
  +" AND (B.OFFER_TYPE = 40  OR D.GROUP_ID = '10014') AND B.EFF_DATE < SYSDATE  AND B.EXP_DATE > SYSDATE ";*/
	sqlStmt = "SELECT F.REGION_CODE, "
			      +" C.ENTERPRICE_CODE, "
			      +" A.FIELD_CODE1, "
			      +" C.BIZNAME, "
			      +" A.FIELD_CODE3, "
			      +" B.OFFER_NAME "
			 +" FROM DBVIPADM.SCOMMONCODE A, "
			      +" PRODUCT_OFFER        B, "
			      +" sbillspcode               C, "
			      +" REGION               D, "
			      +" SREGIONCODE          F "
			+" WHERE A.COMMON_CODE = '1001' "
			  +" AND A.FIELD_CODE3 = TO_CHAR(B.OFFER_ID) "
			  +" AND TRIM(C.BIZCODEADD) = A.FIELD_CODE1 "
			  +" AND B.OFFER_ID = D.OFFER_ID "
			  +" AND D.GROUP_ID = F.GROUP_ID(+) "
			  +" AND F.REGION_CODE = A.FIELD_CODE2 "
			  +" AND B.OFFER_ATTR_TYPE <> 'JT' "
			  +" AND SUBSTR(B.USER_RANGE, 1, 1) = ANY('1', '4') "
			  +" AND (B.OFFER_TYPE = 40 OR D.GROUP_ID = '10014') "
			  +" AND B.EFF_DATE < SYSDATE "
			  +" AND B.EXP_DATE > SYSDATE ";
  }
  else if(bizType.equals("1")){        	
  /*sqlStmt ="SELECT F.REGION_CODE,C.unit_id, A.FIELD_CODE1, C.bizname,A.FIELD_CODE3,B.OFFER_NAME" 
	+" FROM DBVIPADM.SCOMMONCODE A,PRODUCT_OFFER   B,dBaseEcSIBusi  C,REGION  D,SREGIONCODE  F "
  +" WHERE A.COMMON_CODE = '1001'  AND A.FIELD_CODE3 = TO_CHAR(B.OFFER_ID) AND TRIM(C.BIZCODE) = A.FIELD_CODE1 " 
  +" AND B.OFFER_ID = D.OFFER_ID  AND D.GROUP_ID = F.GROUP_ID(+) AND F.REGION_CODE = A.FIELD_CODE2 "
  +" AND B.OFFER_ATTR_TYPE <> 'JT'  AND SUBSTR(B.USER_RANGE, 1, 1) = ANY('1', '4')  AND (B.OFFER_TYPE = 40  "
  +" OR D.GROUP_ID = '10014') AND B.EFF_DATE < SYSDATE  AND B.EXP_DATE > SYSDATE ";*/
  	/*
  	sqlStmt = "SELECT F.REGION_CODE, "
			       +"g.unit_id, "
			       +"A.FIELD_CODE1, "
			       +"C.bizname, "
			       +"A.FIELD_CODE3, "
			       +"B.OFFER_NAME "
			  +"FROM DBVIPADM.SCOMMONCODE A, "
			       +"PRODUCT_OFFER        B, "
			       +"sbillspcode        C, "
			       +"REGION               D, "
			       +"SREGIONCODE          F, "
			       +"dgrpcustmsg                      g, "
			       +"dbvipadm.dgrpcustmsgadd h "
			 +"WHERE A.COMMON_CODE = '1001' "
			   +"AND A.FIELD_CODE3 = TO_CHAR(B.OFFER_ID) "
			   +"AND TRIM(C.BIZCODEADD) = A.FIELD_CODE1 "
			   +"AND B.OFFER_ID = D.OFFER_ID "
			   +"AND D.GROUP_ID = F.GROUP_ID(+) "
			   +"AND F.REGION_CODE = A.FIELD_CODE2 "
			   +"AND B.OFFER_ATTR_TYPE <> 'JT' "
			   +"AND SUBSTR(B.USER_RANGE, 1, 1) = ANY('1', '4') "
			   +"AND (B.OFFER_TYPE = 40 OR D.GROUP_ID = '10014') "
			   +"AND B.EFF_DATE < SYSDATE "
			   +"AND B.EXP_DATE > SYSDATE "
			   +"and trim(c.ENTERPRICE_CODE) = h.field_value "
			   +"and h.field_code  = 'HYWG0' "
			   +"and h.cust_id = g.cust_id ";
			   */
			 sqlStmt = " SELECT F.REGION_CODE, "
					      +" c.ENTERPRICE_CODE, "
					      +" A.FIELD_CODE1, "
					      +" C.bizname, "
					      +" A.FIELD_CODE3, "
					      +" B.OFFER_NAME "
					 +" FROM DBVIPADM.SCOMMONCODE A, "
					      +" PRODUCT_OFFER        B, "
					      +" sbillspcode        C, "
					      +" REGION               D, "
					      +" SREGIONCODE          F "
					+" WHERE A.COMMON_CODE = '1001' "
					  +" AND A.FIELD_CODE3 = TO_CHAR(B.OFFER_ID) "
					  +" AND TRIM(C.BIZCODEADD) = A.FIELD_CODE1 "
					  +" AND B.OFFER_ID = D.OFFER_ID "
					  +" AND D.GROUP_ID = F.GROUP_ID(+) "
					  +" AND F.REGION_CODE = A.FIELD_CODE2 "
					  +" AND B.OFFER_ATTR_TYPE <> 'JT' "
					  +" AND SUBSTR(B.USER_RANGE, 1, 1) = ANY('1', '4') "
					  +" AND (B.OFFER_TYPE = 40 OR D.GROUP_ID = '10014') "
					  +" AND B.EFF_DATE < SYSDATE "
					  +" AND B.EXP_DATE > SYSDATE ";  
     }
	sqlStmt = sqlStmt + whereSql ;
	

	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
		
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList(); 
	ArrayList retList1= new ArrayList(); 

	
	//查询总记录数
	sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
		        
	//查询内容        
	sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //查询指定条数的记录
	System.out.println("sqlStr1:"+sqlStr1);
	
	String[][] allNumStr = new String[][]{};
	String[][] result1   = new String[][]{};
	
	try 
	{
		//retList = impl.sPubSelect("1",sqlStr , "region", implRegion);
		//retList1= impl.sPubSelect("6",sqlStr1, "region", implRegion);
		
		%>
            <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
            	<wtc:sql><%=sqlStr%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr1" scope="end"/>
        <%
    		allNumStr = retArr1;
        %>
            <wtc:pubselect name="sPubSelect" retcode="retCode2" retmsg="retMsg2" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
            	<wtc:sql><%=sqlStr1%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr2" scope="end"/>
        <%
            result1 = retArr2;
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}

	
	System.out.println("allNumStr = " + allNumStr[0][0]);
	
	if(result1 == null || result1.length == 0)
	{
	%>
		<script language='jscript'>
			rdShowMessageDialog("没有查到相关记录！",0);
			//parent.location="f3052_1.jsp";				
		</script>      
	<%            
	}
	%>	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<script type=text/javascript>
		
	//控制窗体的移动
	function initAd() 
	{		
		document.all.page0.style.posLeft = -200;
		document.all.page0.style.visibility = 'visible'
		MoveLayer('page0');
	}
	
	function MoveLayer(layerName) 
	{
		var x = 10;
		var x = document.body.scrollLeft + x;		
		eval("document.all." + layerName + ".style.posLeft = x");
		setTimeout("MoveLayer('page0');", 20);
	}
	
</script>

<body onload="initAd()">

<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
<table cellspacing=0>		
	<tr>				
		<th>地市代码</th>
		<th>企业代码</th>
		<th>业务代码</th>
		<th>业务名称</th>
		<th>资费代码</th>
		<th>资费名称</th>
	</tr>
		<%	
		for(int i = 0; i < result1.length; i++)
		{		
		    String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }  
		%>			
			<tr>				
				<td class='<%=tdClass%>'><%=result1[i][0].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][1].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][2].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][3].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][4].trim()%></td>
				<td class='<%=tdClass%>'><%=result1[i][5].trim()%></td>
			</tr>
		<%
		}
		%>		
			<tr>	
				<td colspan="6" align="center">
					<div id="page0" style="position:relative;font-size:12px;">
					<%	
					    //实现分页
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>				
			</tr>
		</table>
	</div>   
</form>
</body>
</html>
