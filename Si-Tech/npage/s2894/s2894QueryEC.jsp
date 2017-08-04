<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<script language="javascript">
//core.loadUnit("debug");
//core.loadUnit("rpccore");
window.onload=function()
{
	//core.rpc.onreceive = doProcess;
	initAd();
}
</script>

<%
	Logger logger = Logger.getLogger("s2894QueryEC.jsp");
	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String implRegion = regionCode;

	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	String bizCode = request.getParameter("bizCode")==null?"":request.getParameter("bizCode");   
	String spCode = request.getParameter("spCode")==null?"":request.getParameter("spCode"); 
	String bizType = request.getParameter("bizType")==null?"":request.getParameter("bizType");   

/******** chendx 20091216 将sSiBusiProdRela表替换成busi_offer_relation表  ***/	
	if(!(bizCode.equals("")))
	{
	    whereSql = whereSql + " AND B.BIZCODEADD LIKE '"+bizCode+"%' ";
	}
	if(!(spCode.equals(""))&& bizType.equals("0"))
	{
	     whereSql = whereSql + " AND B.ENTERPRICE_CODE LIKE'"+spCode+"%' ";
	}
  if(!(spCode.equals(""))&& bizType.equals("1"))
	{
	    whereSql = whereSql + " AND e.unit_id ='"+spCode+ "' ";
	}
	if(bizType.equals("0"))
	{
	     whereSql = whereSql + " ORDER BY  B.ENTERPRICE_CODE,B.BIZCODEadd";
	}
  if( bizType.equals("1"))
	{
	     whereSql = whereSql + " ORDER BY  e.unit_id,B.BIZCODEadd";
	}
	
  if(bizType.equals("0"))
	{
	/*sqlStmt =" SELECT b.ecsiid,e.parter_name,B.BIZCODE,B.BIZNAME,C.OFFER_ID,C.OFFER_NAME,C.OFFER_COMMENTS, "
					+"  CASE WHEN A.EXP_DATE >= SYSDATE THEN 1 ELSE 0 END , B.oper_id"
   				+" 	FROM BUSI_OFFER_RELATION A, dBaseEcSIBusi B,dpartermsg e ,PRODUCT_OFFER C ,REGION D,SREGIONCODE F "
          +"   WHERE TRIM(A.EXTERNAL_CODE) = b.oper_id"
          +"    and b.ecsiid=e.parter_id"
          +"   AND D.GROUP_ID = F.GROUP_ID(+)"
          +"   AND D.OFFER_ID = C.OFFER_ID"
          +"   AND A.OFFER_ID = C.OFFER_ID "
          +"   AND C.OFFER_ATTR_TYPE = 'JT'"
          +"   AND (C.OFFER_TYPE = '10' OR D.GROUP_ID = '10014')";*/
     sqlStmt = "SELECT b.enterprice_code, "
			       +" e.parter_name, "
			       +" B.BIZCODEadd, "
			       +" B.BIZNAME, "
			       +" C.OFFER_ID, "
			       +" C.OFFER_NAME, "
			       +" C.OFFER_COMMENTS, "
			       +" CASE WHEN A.EXP_DATE >= SYSDATE THEN 1 ELSE 0 END, "
			       +" B.PRODUCT_CODE "
			  +" FROM BUSI_OFFER_RELATION A, "
			       +" sbillspcode       B, "
			       +" dpartermsg          e, "
			       +" PRODUCT_OFFER       C, "
			       +" REGION              D, "
			       +" SREGIONCODE         F "
			 +" WHERE A.EXTERNAL_CODE = b.PRODUCT_CODE "
			   +" and trim(b.ENTERPRICE_CODE) = e.parter_id "
			   +" AND D.GROUP_ID = F.GROUP_ID(+) "
			   +" AND D.OFFER_ID = C.OFFER_ID "
			   +" AND A.OFFER_ID = C.OFFER_ID "
			   +" AND C.OFFER_ATTR_TYPE = 'JT' "
			   +" AND (C.OFFER_TYPE = '10' OR D.GROUP_ID = '10014')"; 
  }
  else if(bizType.equals("1")){        	
  /*sqlStmt ="SELECT to_char(b.unit_id),e.unit_name,B.BIZCODE,B.BIZNAME,C.OFFER_ID,C.OFFER_NAME,C.OFFER_COMMENTS, "
 						+" CASE WHEN A.EXP_DATE >= SYSDATE THEN 1 ELSE 0 END , B.oper_id"
   					+" 	FROM BUSI_OFFER_RELATION A, dBaseEcSIBusi B,dgrpcustmsg e ,PRODUCT_OFFER C ,REGION D,SREGIONCODE F "
            +" WHERE TRIM(A.EXTERNAL_CODE) = b.oper_id"
            +"  and b.unit_id=e.unit_id"
            +" AND D.GROUP_ID = F.GROUP_ID(+)"
            +" AND D.OFFER_ID = C.OFFER_ID"
            +" AND A.OFFER_ID = C.OFFER_ID "
            +" AND C.OFFER_ATTR_TYPE = 'JT'"
            +" AND (C.OFFER_TYPE = '10' OR D.GROUP_ID = '10014')";*/
  /*sqlStmt = "SELECT to_char(e.unit_id), "
			      +" e.unit_name, "
			      +" B.BIZCODEadd, "
			      +" B.BIZNAME, "
			      +" C.OFFER_ID, "
			      +" C.OFFER_NAME, "
			      +" C.OFFER_COMMENTS, "
			      +" CASE WHEN A.EXP_DATE >= SYSDATE THEN  1 ELSE 0 END, "
			      +" B.PRODUCT_CODE "
			 +" FROM BUSI_OFFER_RELATION A, "
			      +" sbillspcode       B, "
			      +" dgrpcustmsg         e, "
			      +" PRODUCT_OFFER       C, "
			      +" REGION              D, "
			      +" SREGIONCODE         F, "
			      +" dbvipadm.dgrpcustmsgadd g "
			+" WHERE A.EXTERNAL_CODE = b.PRODUCT_CODE "
			  +" and g.cust_id = e.cust_id "
			  +" AND D.GROUP_ID = F.GROUP_ID(+) "
			  +" AND D.OFFER_ID = C.OFFER_ID "
			  +" AND A.OFFER_ID = C.OFFER_ID "
			  +" AND C.OFFER_ATTR_TYPE = 'JT' "
			  +" AND (C.OFFER_TYPE = '10' OR D.GROUP_ID = '10014') "
			  +" and g.field_code = 'HYWG0' "
			  +" and g.field_value = trim(b.ENTERPRICE_CODE) ";
			  */
		sqlStmt = " SELECT to_char(e.unit_id), "
			       +" e.unit_name, "
			       +" B.BIZCODEadd, "
			       +" B.BIZNAME, "
			       +" C.OFFER_ID, "
			       +" C.OFFER_NAME, "
			       +" C.OFFER_COMMENTS, "
			       +" CASE WHEN A.EXP_DATE >= SYSDATE THEN  1 ELSE 0 END, "
			       +" B.PRODUCT_CODE "
			 +" FROM BUSI_OFFER_RELATION A, "
			      +" sbillspcode       B, "
			      +" dgrpcustmsg         e, "
			      +" PRODUCT_OFFER       C, "
			      +" REGION              D, "
			      +" SREGIONCODE         F "
			+" WHERE A.EXTERNAL_CODE = b.PRODUCT_CODE "
			  +" AND D.GROUP_ID = F.GROUP_ID(+) "
			  +" AND D.OFFER_ID = C.OFFER_ID "
			  +" AND A.OFFER_ID = C.OFFER_ID "
			  +" AND C.OFFER_ATTR_TYPE = 'JT' "
			  +" AND (C.OFFER_TYPE = '10' OR D.GROUP_ID = '10014') "
			  +" and to_char(e.unit_id) = trim(b.ENTERPRICE_CODE) ";
     }

	sqlStmt = sqlStmt + whereSql ;
	

	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
		
	ArrayList retList = new ArrayList(); 
    ArrayList retList1 = new ArrayList(); 
    
    //查询总记录数
    sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
        
    //查询内容        
    sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //查询指定条数的记录
	System.out.println("sqlStr1:"+sqlStr1);
	String[][] allNumStr = new String[][]{};
	String[][] result1 = new String[][]{};
	
	try {

		
		%>
            <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
            	<wtc:sql><%=sqlStr%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="retArr1" scope="end"/>
        <%
    		allNumStr = retArr1;
		
        %>
            <wtc:pubselect name="sPubSelect" retcode="retCode2" retmsg="retMsg2" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
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
	
	if(result1 == null || result1.length == 0)
	{
%>        
		<script language='jscript'>
			rdShowMessageDialog("没有查到相关记录！",0);
			//parent.location="f7185_1.jsp";				
		</script>
<%            
	}
%>	
</head>
<script type="text/javascript">
function doProcess(myPacket)
{
	var errCode    = myPacket.data.findValueByName("errCode");
	var retMessage = myPacket.data.findValueByName("errMsg");
	var retFlag    = myPacket.data.findValueByName("retFlag");
	
	if (errCode==000000)
	{  
		if(retFlag=="queryMod")
		{			
			rdShowMessageDialog("操作成功！",2);
			location.reload();
		}
	}

	if(errCode!=000000)
	{
		rdShowMessageDialog(retMessage,0);	
	}
}
		
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
function queryMod(vBizCodeAdd,vProductCode)
{

	var myPacket = new AJAXPacket("f2894End.jsp","正在执行终止操作,请稍候......");
	
	myPacket.data.add("vBizCodeAdd",vBizCodeAdd);
	myPacket.data.add("vProductCode",vProductCode);
	
	core.ajax.sendPacket(myPacket);
	
	myPacket = null;
	
	
}
</script>

<body>
<form name="form1" method="post" action="">	
	<div id="Operation_Table">
		<table width="100%" id="tabList" cellspacing=0>			
			<tr>				
				<th>企业代码</th>
				<th>企业名称</th>
				<th>业务代码</th>
				<th>业务名称</th>
				<th>产品代码</th>
				<th>产品名称</th>
				<th>产品描述</th>
				<th>操作</th>
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
				<td class='<%=tdClass%>'><%=result1[i][6].trim()%></td>
				<td class='<%=tdClass%>'>
					<%if("1".equals(result1[i][7])){%>
					<input name="operator<%=i+1%>"  style="cursor:hand" type="button" value="终止" class="b_text"  
					onclick="queryMod('<%=result1[i][8].trim()%>','<%=result1[i][4].trim()%>')">
					<%}else{%>
					已终止
					<%}%>
				</td>

			</tr>
	<%
		}
	%>		
			<tr>	
				<td colspan="8" align="center">
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


