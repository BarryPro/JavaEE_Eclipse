<%
   /*
   * 功能: 查询用户信息
　 * 版本: v1.0
　 * 日期: 2008/03/30
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
  String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
    
  String bugid=request.getParameter("bugid");   //错误ID
  
	String subjcet      ="";// 标题                         
	String content      ="";// 内容                         
	String op_time      ="";// 发起时间                     
	String buglevel     ="";// 级别                         
	String status       ="";// 状态                         
	String login_no     ="";// 工号                         
	String parent_id    ="";// 回复的时候记录回复问题的bugid
%>
<wtc:service name="sBugSinSel" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=bugid%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
	
	if(result.length>0){
	       bugid     =result[0][0];
	       subjcet   =result[0][1];
	       content   =result[0][2];
	       op_time   =result[0][3];
	       buglevel  =result[0][4];
	       status    =result[0][5];
	       login_no  =result[0][6];         
	       parent_id =result[0][7];   
	    }  
 %>	
			详细问题反馈

<form id="layer2_form" method="post" action="">
	<table width=90% >
		<tr>
    	<td>问题标题</td>
      <td>
		    <input name=bugsubject   type="text"  maxlength="15"  v_type="String" v_must=1 value="<%=subjcet%>">
      </td>
	  </tr>
		<tr>
    	<td>发起时间</td>
      <td>
		    <input name=op_time   type="text"  maxlength="15"  v_type="String" v_must=1 value="<%=op_time%>">
      </td>
	  </tr>
		<tr>
    	<td>问题级别</td>
      <td>
			  <select name="buglevel"  disabled>
			    <option  <% if(buglevel.equals("L"))out.println("selected"); %> value='L'>低</option>	
			    <option  <% if(buglevel.equals("M"))out.println("selected"); %> value='M' >中</option>	
			    <option  <% if(buglevel.equals("H"))out.println("selected"); %> value='H'>高</option>	
				</select>
      </td>
	  </tr>
		<tr>
    	<td>问题状态</td>
      <td>
			  <select name="status" disabled>
			    <option  <% if(status.equals("Y"))out.println("selected"); %> value='Y' >已回复</option>	
			    <option  <% if(status.equals("N"))out.println("selected"); %> value='N' >未回复</option>	
				</select>
      </td>
		</tr>
		<tr>
    	<td>问题内容</td>
      <td>
		  	<textarea name="bugContent"   rows=10 cols= 20  ><%=content%></textarea>
      </td>
		</tr>
		<tr>
			<td align=center colspan=2>
				<input type="button" id=close  onclick="window.close()"   name="submit" value="关闭" >
			</td>
		</tr>
	</table>
</form>
<%    
}
%>