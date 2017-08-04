<%
  /*
   * 功能: 集团产品信息分时图
　 * 版本: v1.0
　 * 日期: 2011年05月10日
　 * 作者: zhoujf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	String sqlStr1="";
	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="集团产品信息";
  String sqlStr="select b.id_no, c.sm_name,b.op_time,d.run_name,b.id_no from dgrpcustmsg a,dgrpusermsg b,ssmcode c,sruncode d where a.cust_id=b.cust_id and c.sm_code=b.sm_code and b.region_code=c.region_code and b.run_code=d.run_code and b.region_code=d.region_code and a.unit_id='"+unit_id+"'";
  String  sqls = "SELECT cust_id FROM dGrpCustMsg WHERE unit_id='"+unit_id+"'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<%
			System.out.println("result=====1023 begin=============\n"+sqlStr);
		System.out.println("result=================="+result.length);
		String[] memNO=new String[result.length];
		for(int ii=0;ii<result.length;ii++){
				 sqlStr1="SELECT COUNT(1) FROM DCUSTMSGADD T WHERE T.FIELD_CODE = '1004' AND T.FIELD_VALUE = '"+result[ii][4]+"'";
		%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
		
	
		<%
		memNO[ii]=result1[0][0];
		System.out.println("result======zhoujs======1023  END======\n"+memNO[ii]);
		}
		
		System.out.println("result======zhoujs======1023  END======\n");
		%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqls%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="resultB" scope="end" />
		
	<wtc:service name="q_GrpCustOew"   retcode="retCodett" retmsg="retMsgtt" outnum="10" >
   <wtc:param value="<%=resultB[0][0]%>"/>
  </wtc:service>
    	<wtc:array id="resulta" scope="end"/>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>

<script type=text/javascript>
		
	function grp(id_no){
			var url = "grp_pro_mem.jsp?id_no="+id_no;
    	window.open(url,"","width=800,height=600,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
</script>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">集团产品基本信息</div></div>
<table cellSpacing=0>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>集团产品号码</th>
				<th>集团产品名称</th>
				<th>集团产品开通时间</th>
				<th>集团产品状态</th>
				<th>成员数</th>
				<th>操作</th>
			</tr>
		<%	
		for(int i = 0; i < result.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=memNO[i].trim()%>&nbsp;</td>
				<td nowrap align='center'>
				<input name="queryAcBtn" class="b_foot"  type="button"  value="查看成员" onClick="grp(<%=result[i][0].trim()%>);" <%if("0".equals(memNO[i].trim())){%>disabled<%}%>>
				</td>
			</tr>
		<%
		}
		%>				
</table>

<br>
	
		<div class="title"><div id="title_zi">集团产品消费信息</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
				<tr align='center'>				
					<th>帐户号</th>
					<th>集团产品计费月</th>
					<th>集团产品费项名称</th>
					<th>集团产品费项金额</th>
					
				</tr>
			<%	
			for(int i = 0; i < resulta.length; i++)
			{		  
			%>			
				<tr>				
					<td nowrap align='center'><%=resulta[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resulta[i][1].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resulta[i][2].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resulta[i][3].trim()%>&nbsp;</td>
					
					
				</tr>
			<%
			}
			%>				
	</table>
	<br>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>


