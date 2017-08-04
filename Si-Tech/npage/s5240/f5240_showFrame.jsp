   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
	String regionCode= (String)session.getAttribute("regCode");
	
	//获取从上页得到的信息
	String login_accept = request.getParameter("login_accept");
	String sm_code = request.getParameter("sm_code");
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
	System.out.println("#############mode_code="+mode_code);	
	String[][] retListString1 = new String[][]{};
	//获取所有的优惠信息
	String sqlStr1="";

 	sqlStr1 ="SELECT detail_code,a.detail_type,fav_order,mode_time,time_flag,time_cycle,time_unit,note,to_char(sysdate,'yyyymmdd'),'20500101',b.type_name,a.region_code FROM sBillModedetail a ,sbilldetname b WHERE a.detail_type=b.detail_type and a.region_code='"+region_code+"' and a.mode_code='"+mode_code+"' order by a.detail_code asc";
 	//retList1 = impl.sPubSelect("12",sqlStr1,"region",regionCode);
 	
 	System.out.println("---------------------------------------------------");
%>

		<wtc:pubselect name="sPubSelect" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<% 	
	if(result_t2.length>0&&code.equals("000000"))
 	retListString1 = result_t2;

%>
<html>
<head>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script>
	
function showDetailCode(apply_flag,detail_type,detail_code,note,typeButtonNum,region_code)
{
	var apply_flag =apply_flag;
	var detail_type =detail_type;
	var detail_code =detail_code;
	var note =note;
	var typeButtonNum=typeButtonNum;
	var region_code=region_code;
	if(detail_type=='0')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showRateCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		window.open(url,'','height=600,width=1900,left=60,top=60,scrollbars=yes');                                     
	}                                                             
	else if(detail_type=='1'||detail_type=='9')                                     
	{                                                             
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showMonthCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code;
		window.open(url,'','height=600,width=900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='2'||detail_type=='b')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showTotCode.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&totCode=0";
		window.open(url,'','height=600,width=1900,left=60,top=60,scrollbars=yes');
	}
	else if(detail_type=='4')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showFuncFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		window.open(url,'','height=600,width=1900,left=60,top=60,scrollbars=yes');
	}else if(detail_type=='3')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showBillFav.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		escape(url);
		window.open(url,'','height=600,width=1900,left=60,top=60,scrollbars=yes');
	}	
	else if(detail_type=='a')
	{
		var url = "<%=request.getContextPath()%>/npage/s5238/f5238_showFuncBind.jsp?login_accept=<%=login_accept%>&detail_code="+detail_code+"&note="+note+"&typeButtonNum="+typeButtonNum+"&region_code="+region_code+"&sm_code=<%=sm_code%>";
		window.open(url,'','height=600,width=1900,left=60,top=60,scrollbars=yes');
	}	
}
</script>
</head>
<body>
<form target="middle" action="" method="post" name="form2">
 <%@ include file="/npage/include/header.jsp" %>                         

      		<table  id="mainThree"  cellspacing="0">
	  			<%  
	  				for(int i=0;i < retListString1.length;i ++)
					{
	  			%>
	  					<tr  height="22" >
	  						<TD width="89" align="center"><%=retListString1[i][0]%></TD>
	  						<TD width="92" align="center"><%=retListString1[i][10]%></TD>
	  						<TD width="89" align="center"><%=retListString1[i][8]%></TD>
	  						<TD width="89" align="center"><%=retListString1[i][9]%></TD>
	  						<TD width="269"><input type="text" value="<%=retListString1[i][7]%>" size="40" readonly></input></TD>
	  						<TD width="97"><input type="button" name="typeButton<%=i%>" value="资费信息" class="b_text" onclick="showDetailCode('<%=retListString1[i][10]%>','<%=retListString1[i][1]%>','<%=retListString1[i][0]%>','<%=retListString1[i][7]%>','<%=i%>','<%=retListString1[i][11]%>')"></TD>
	  					</tr>
	  			<%
	  				}
	  			%>         	
      		</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>	
</body>
</html>  
