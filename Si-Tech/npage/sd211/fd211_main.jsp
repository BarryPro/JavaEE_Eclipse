<%
  /*
   * 功能: 添加智能网vpmn闭合群资费详细配置
   * 版本: 1.8.2
   * 日期: 2011/03/01
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>


<%
  String opCode = "d211";
  String opName = request.getParameter("opName");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%



	//读取用户session信息
	String region_code = request.getParameter("regionCode");
	String work_no = (String)session.getAttribute("workNo");
  String closeFee_code = request.getParameter("closeFeeCode");
   if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
  //String regionNameSql="  select region_name from sregioncode where region_code = '"+region_code+"'";
  //String closeFeeNameSql = "  select trim(feeindex_name) from sclosefeeindex where region_code = '"+region_code+"' and feeindex ='"+closeFee_code+"'";
  String colseFeeDetail="select nvl(start_year,''),nvl(end_year,''),nvl(start_month,' '),nvl(end_month,' '),nvl(start_day,' '),nvl(end_day,' '),nvl(start_hours,' '),nvl(end_hours,' '), nvl (start_minute ,' ' ) , nvl ( end_minute , ' ')  ,fee_id,trim(c.region_name),trim(b.offer_name) from sCloseFeeIndexConfig a,product_offer b,sregioncode c where a.region_code='"+region_code+"' and a.fee_index='"+closeFee_code+"' and a.fee_index=b.offer_id and a.region_code=c.region_code order by fee_id";

 System.out.println("colseFeeDetail="+colseFeeDetail);

  String region_name = "";
  String colseFee_name = "";
  String colseFee_detail[][] = new String[][]{};
%>



<html>
<head>
<base target="_self">
<title>智能网vpmn闭合群资费配置详细情况</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
	function addConfig(){
		var regionCode = <%=region_code%>;
		var closeFeeCode = <%=closeFee_code%>;
		window.open("fd211_add.jsp?regionCode="+regionCode+"&closeFeeCode="+closeFeeCode,"","width="+(screen.availWidth*1-500)+",height="+(screen.availHeight*1-540) +",left=350,top=200,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
	function deleteConfig(p){
		var code = p;
		var closeFee_code = <%=closeFee_code%>;
		var region_code = <%=region_code%>;

		window.open("fd211_delete.jsp?closeFee_id="+code+"&region_code="+region_code+"&closeFee_code="+closeFee_code,"","width="+(screen.availWidth*1-500)+",height="+(screen.availHeight*1-540) +",left=350,top=200,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");


	}
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}

</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post">


   <DIV id="Operation_Table">


	<div class="title">
		<div id="title_zi">智能网vpmn闭合群资费配置详细信息</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">
							<TD width="" class="blue">&nbsp;&nbsp;&nbsp;序号</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;地市</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;资费配置名称</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;开始年</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;结束年</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;开始月</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;结束月</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;开始天</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;结束天</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;开始时</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;结束时</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;开始分</TD> <%//diling add@2011/10/2 增加开始分，结束分展示%>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;结束分</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;操作</TD>
				  </tr>
	  <wtc:pubselect name="sPubSelect" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=colseFeeDetail%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_colseFee_detail" scope="end"/>
				  <%
				  		if(code.equals("000000")&&result_colseFee_detail.length>0){
				  			colseFee_detail = result_colseFee_detail;
				  			for(int i=0;i<colseFee_detail.length;i++){
				  			%>
								  <tr  height="22">
								  <TD align="center" class="blue"><%=i+1%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][11]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][12]%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][0]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][1]%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][2]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][3]%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][4]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][5]%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][6]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][7]%>&nbsp;</TD>
								  <TD align="center"><%=colseFee_detail[i][8]%>&nbsp;</TD>	<TD align="center"><%=colseFee_detail[i][9]%>&nbsp;</TD> <%//diling add %>
								  <TD align="center">
								  	<input  style="cursor:hand" type="button" value="删除" class="b_text"  onclick="deleteConfig('<%=colseFee_detail[i][10]%>')"/><%//diling update %>
								  	</TD>
								  </tr>
							  <%
				  			}
				  		}else{%>

				  			<tr  height="22">
				  			<TD align="center" colspan="14">该资费没有配置信息!&nbsp;</TD>
				  			</tr>
				  			<%
				  			}
				  %>
				  <tr  height="22">
				  		<TD align="right" colspan="14">
				  			<input  style="cursor:hand" type="button" value="添加配置" class="b_text" onclick="addConfig()"/>
				  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  			</TD>
				  </tr>

				</table>

				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="iframeClose()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>


	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 </div>
</body>
</html>

