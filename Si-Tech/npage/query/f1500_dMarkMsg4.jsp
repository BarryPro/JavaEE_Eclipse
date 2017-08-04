<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%        

	String opCode = "1500";
  String opName = "综合信息查询之用户积分查询";
	
	String regionCode =  (String)session.getAttribute("regCode");
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	//phoneNo="13836190009";//"13936181264"; 13503637388 13936200254
	String cust_name  = request.getParameter("custName");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	String btime=request.getParameter("btime");
	String etime=request.getParameter("etime");
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
%>

        	
     <wtc:service name="sMarkAddQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="9">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=btime%>"/>
        <wtc:param value="<%=etime%>"/>
       </wtc:service>
	<wtc:array id="result" scope="end"  start="0"  length="2"/>
	<wtc:array id="resultyhsc" scope="end" start="2"  length="7"/>
	
	



<HTML><HEAD><TITLE>生成积分查询</TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">积分发放查询(6个月内发放记录)</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>发放积分类型名称</th>
	        <th>发放时间</th>
	        <th>发放积分值</th>
			<th>生效开始日</th>
	        <th>到期日</th>
	        <th>备注</th>  
	      </tr>
		<%
		if(retCode2.equals("000000")) {
			String ffsj  = ""; 
			String sxksr = "";
			String dqr   = "";
		if(resultyhsc.length>0) {
			String tbClass="";
			for(int y=0;y<resultyhsc.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
				sxksr=resultyhsc[y][3];
				if(sxksr!=null &&(!sxksr.equals("")))
				{
					sxksr=sxksr.substring(0,4)+"-"+sxksr.substring(4,6)+"-"+sxksr.substring(6,8);
				}
				dqr=resultyhsc[y][4];
				if(dqr!=null &&(!dqr.equals("")))
				{
					dqr=dqr.substring(0,4)+"-"+dqr.substring(4,6)+"-"+dqr.substring(6,8);
				}
				ffsj=resultyhsc[y][0];
				if(ffsj!=null &&(!ffsj.equals("")))
				{
					ffsj=ffsj.substring(0,4)+"-"+ffsj.substring(4,6)+"-"+ffsj.substring(6,8);
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=resultyhsc[y][6]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=ffsj%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=sxksr%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=dqr%>&nbsp;</td> 
					<td class="<%=tbClass%>"><%=resultyhsc[y][5]%>&nbsp;</td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'><%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

