<%
   /*
   * 功能: 查询营业员基本信息
　 * 版本: v1.0
　 * 日期: 2008年4月14日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 
		 Date date=new Date();
		 SimpleDateFormat myFmt=new SimpleDateFormat("yyyy-MM-dd");        
     String myDate=myFmt.format(date);
   
     String Login_name     ="";            // 营业员姓名        
     String group_name     ="";            // 营业员归属        
     String pass_time      ="";            // 营业员密码到期时间
     String op_time        ="";            // 营业员上次登录日期
     String contract_phone ="";            // 营业员手机号码    
     String sex_name       ="";            // 营业员性别        
     String birthday       ="";            // 营业员出生日期    
     String age            ="";            // 营业员年龄        
     String festival       ="";            // 营业员节日提醒    
     String email          ="";            // 营业员邮件        
%>                

<wtc:service name="sIndexloginMsg" outnum="10" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(retCode.equals("000000")){
       if(result.length>0){
              Login_name      ="".equals(result[0][0])?"不详":result[0][0];
              group_name      ="".equals(result[0][1])?"不详":result[0][1];
              pass_time       ="".equals(result[0][2])?"不详":result[0][2];
              op_time         ="".equals(result[0][3])?"不详":result[0][3];
              contract_phone  ="".equals(result[0][4])?"不详":result[0][4];
              sex_name        ="".equals(result[0][5])?"不详":result[0][5];
              birthday        ="".equals(result[0][6])?"不详":result[0][6];     
              age             ="".equals(result[0][7])?"不详":result[0][7];     
              festival        ="".equals(result[0][8])?"不详":result[0][8];          
              email           ="".equals(result[0][9])?"不详":result[0][9];      
       }  
}
%>
<!--
<div id="blueBG">
    <div id="Info_table">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
            <tr>
                <th>工号： </th>
                <td ><%=workNo.trim()%></td>
                <th>密码到期时间： </th>
                <td><%=pass_time.trim()%><%if(myDate.equals(pass_time))out.print("<img src='../../../nresources/default/images/shine.gif' > <span class='orange'>激活密码</span>");%></td>
                <th>节日提醒：</th>
                <td id="festival"></td>
            </tr>
        </table>
    </div>
</div>
-->
<div class="user_info">
	<span>工号：<%=workNo.trim()%></span>
	<span>密码到期时间：<%=pass_time.trim()%><%if(myDate.equals(pass_time))out.print("<img src='../../../nresources/default/images/shine.gif' > <span class='orange'>激活密码</span>");%></span>
	<span>节日提醒：<span id="festival"></span></span>
</div>

<script>
	   $("#wait0").hide();	
	   $("#festival").html(showDetail());
</script>