<%
   /*
   * 功能: 账单历史查询_结果显示页面
　 * 版本: v1.0
　 * 日期: 2009年6月25日
　 * 作者: zhanghonga,wangyia,libina
　 * 版权: sitech
   * 修改历史
 　*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%
	System.out.println("=========s1351Cfm_kf.jsp======Begin==========");
	String workNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String opCode = "1351";
  String opName = "账单历史查询";  
	String phone_no = request.getParameter("phone_no");
	String qry_begin_date = request.getParameter("qry_begin_date");
	String qry_end_date   = request.getParameter("qry_end_date");
	
	String beginYear = "";
	String beginMonth = "";
	String endYear = "";
	String endMonth = "";
	String contract_no = "";
	
	if(qry_begin_date!=null&&!qry_begin_date.equals("")){
		beginYear = qry_begin_date.substring(0,4);
		beginMonth = qry_begin_date.substring(4,6);
	}
	
	if(qry_end_date!=null&&!qry_end_date.equals("")){
		endYear = qry_end_date.substring(0,4);
		endMonth = qry_end_date.substring(4,6);
	}

	String strSQL = "select to_char(a.contract_no),to_char(a.ids),to_char(a.cust_id),to_char(a.id_no) from dCustMsg a,dConUserMsg b where a.id_no = b.id_no and a.contract_no = b.contract_no and substr(a.run_code,2,1) < 'a'";	
	String param2 = "";
	if(phone_no == null||phone_no.equals("")){}else{
		strSQL = strSQL + " and a.phone_no = :phone_no ";
		param2 = "phone_no = "+phone_no.trim();
	}

  
	System.out.println("======================strSQL:"+strSQL);	
	System.out.println("======================param2:"+param2);
%>	
	<wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" outnum="4">
	<wtc:param value="<%=strSQL%>" />
	<wtc:param value="<%=param2%>" />
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String ids="0";
	String id_no="";
	String cust_id="";

	if(result.length>0){
		contract_no=result[0][0];
		ids=result[0][1];
		cust_id=result[0][2];
		id_no=result[0][3];
	}

	if(contract_no==null||contract_no.equals(""))
	{
%>
		<script language="javascript">
			rdShowMessageDialog("该号码不存在，或者号码状态不正常！",0);
			history.go(-1);
		</script>
<%	
		return;
	}		
%>

<wtc:service name="sHW1310PntCom32" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=beginYear%>"/>
	<wtc:param value="<%=beginMonth%>"/>
	<wtc:param value="<%=endYear%>"/>
	<wtc:param value="<%=endMonth%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="flagResult" start="0" length="1" scope="end" />
<wtc:array id="impResult"  start="1" length="1" scope="end" />

<html>
	<head>
		<title>山西BOSS-账单历史查询 </title>
		<script language="JavaScript">
			<!--
				function doClose(){
					if(typeof(parent.removeTab)=="function"){
						parent.removeTab("1351");	
					}else{
						window.close();	
					}	
				}
			-->
		</script>
	</head>
<body>
<form>
<%@ include file="/npage/include/header.jsp" %>
	<%		
		if(retCode.equals("000000")){
			if(flagResult!=null&&flagResult.length>0){
				for(int i=0;i<flagResult.length;i++){
					for(int j=0;j<flagResult[i].length;j++){
						if("1".equals(flagResult[i][j])){
								out.println("<table cellspacing='0'><div class='title'>"+impResult[i+6][j].trim().substring(6,20)+"账单</div>");	
								i = i + 2 ;				
						}
						if("10".equals(flagResult[i][j])){					
								i = i + 2 ;				
						}
						if ( impResult[i][j]==null){							
							out.print("&nbsp;");
							continue;
						}
						if(i%2==0){
							out.println("<tr><td align='center' class='Grey'>"+impResult[i][j].replaceAll(" ","&nbsp;")+"</td></tr>");
					  }else{
					  	out.println("<tr><td align='center'>"+impResult[i][j].replaceAll(" ","&nbsp;")+"</td></tr>");
						}
						
					}
				}
			}
		}		
	%>
<table cellspacing='0'>   
 <tr> 
   <td id="footer"> 
       <input type="button" name="return1" class="b_foot" value="返回" onClick="history.go(-1);">
       &nbsp; 
       <input type="button" name="close1"  class="b_foot" value="关闭" onClick="doClose()">
   </td>
 </tr> 
</table>
	<%@ include file="/npage/include/footer.jsp"%>
</form> 
</body>
</html>