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
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "综合信息查询之换卡记录查询";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String phone_no  = request.getParameter("phoneNo");
	String simNo  = request.getParameter("simNo");
	
	String getIdnoSql = "select id_no from dcustmsg where phone_no='"+phone_no+"'";
%>			
 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=getIdnoSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 	
<%
String id_no = "";

if(code.equals("000000")&&result_t.length>0){
	id_no = result_t[0][0];
}

	String sql_str="select sim_no,switch_no,update_login,function_name,to_char(update_time,'yyyymmdd hh24 mi ss'),update_accept from dCustSimHis a,sFuncCode b where a.update_code=b.function_code and a.id_no="+id_no;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("查询结果为空,换卡记录信息不存在!");
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>换卡历史信息</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dCustSimHis">
<div id="Main">
   <DIV id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">换卡记录信息</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center"> 
          <th>SIM卡号</th>
          <th>IMSI号</th>
          <th>操作工号</th>
          <th>操作模块</th>
          <th>操作时间</th>
          <th>操作流水</th>
        </TR>
<%            
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%    	    
				for(int j=0;j<result[0].length;j++){
%>
	       <td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%              
				}
%>
          </tr>
<%            
			}
%>
        </TBODY>
	    </TABLE>
	    
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg98" retcode="code98" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="98" />	
		</wtc:service>
		<wtc:array id="result_t98" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code99" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="99" />	
		</wtc:service>
		<wtc:array id="result_t99" scope="end" />
			
			<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code96" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="96" />	
		</wtc:service>
		<wtc:array id="result_t96" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code97" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="97" />	
		</wtc:service>
		<wtc:array id="result_t97" scope="end" />	    
<%
		String simPubN1 = "";
		String simPubN2 = "";
		String simPinN1 = "";
		String simPinN2 = "";
		
		if(code98.equals("000000")&&result_t98.length>0){
			  simPubN1 = result_t98[0][1];
		}
		
		if(code99.equals("000000")&&result_t99.length>0){
			  simPubN2 = result_t99[0][1];
		}
		
		if(code96.equals("000000")&&result_t96.length>0){
			  simPinN1 = result_t96[0][1];
		}
		if(code97.equals("000000")&&result_t97.length>0){
			  simPinN2 = result_t97[0][1];
		}
%>			
	    <div class="title">
			<div id="title_zi">sim卡详细信息</div>
		</div>
         <table cellspacing="0">
         				<tr>
         					<td class="blue">SIM 卡号</td>
         					<td colspan="3"><%=simNo%></td>
         				</tr>
         				<tr>
  							<td class="blue">PUK1 码</td>
  							<td><%=simPubN1%></td>
  							
  							<td class="blue">PUK2 码</td>
  							<td><%=simPubN2%></td>	
  						</tr>
  						
         				<tr>
  							<td class="blue">PIN1 码</td>
  							<td><%=simPinN1%></td>
  							
  							<td class="blue">PIN2 码</td>
  							<td><%=simPinN2%></td>	
  						</tr>
  						
  						
  						
  						
        </table> 
          
       
		<%@ include file="/npage/include/footer_pop.jsp" %>
		</FORM>
	</BODY>
</HTML>
