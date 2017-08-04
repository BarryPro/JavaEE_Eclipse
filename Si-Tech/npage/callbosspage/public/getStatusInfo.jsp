<%
	/*
	 * 功能: 获得状态栏的数据信息
	 * 版本: 1.0
	 * 日期: 2009/2/20
	 * 作者: fangyuan
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);  
  String workNo=request.getParameter("workNo"); 
  String tableName;
  String tableNameEnd = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
  //String sql="select round(sum((t.end_date-t.begin_date)*24*60*60)/count(t.contact_id)) from dcallcall"+tableNameEnd+" t where t.accept_kf_login_no ='"+workNo+"'" +
  //						" and t.begin_date>= to_date(to_char(sysdate,'YYYY-mm-dd')||' 00:00:00','yyyy-mm-dd hh24:mi:ss') "+
 	//						" and t.end_date<= to_date(to_char(sysdate,'YYYY-mm-dd')||' 23:59:59','yyyy-mm-dd hh24:mi:ss') and acceptid  in ('0','13')";
  
  String sql="select to_char(round(sum((t.end_date-t.begin_date)*24*60*60)/(count(t.contact_id) + sum(t.checkpsnum)))) from dcallcall"+tableNameEnd+" t where t.accept_kf_login_no =:workNo " + 
  						" and t.begin_date>= to_date(to_char(sysdate,'YYYY-mm-dd')||' 00:00:00','yyyy-mm-dd hh24:mi:ss') "+
 							" and t.end_date<= to_date(to_char(sysdate,'YYYY-mm-dd')||' 23:59:59','yyyy-mm-dd hh24:mi:ss') and acceptid  in ('0','13')"; 
  myParams="workNo="+workNo;
%>

<wtc:service  name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>	
</wtc:service>
<wtc:array id="rows" scope="end" />
<%
	String seconds="0";
	if(rows.length>0){
		//有数据
		retCode="000000";
		seconds = rows[0][0];
		out.print(rows[0][0]);
	}else{
		//无数据
		retCode="000001";
		out.print("0");
	}
%>




	