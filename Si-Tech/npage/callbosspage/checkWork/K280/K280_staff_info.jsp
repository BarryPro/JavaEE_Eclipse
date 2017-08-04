<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /**
   * 功能: 质检权限管理->质检计划管理->弹出式提示尚待质检条数
　 * 版本: 1.0.0
　 * 日期: 2009/3/15
　 * 作者: jiangbing
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K280";
	//String opName = "员工信息";
	String work_no   = WtcUtil.repNull(request.getParameter("work_no"));
 /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>员工信息</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>


</head>
<body>



<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>员工信息：</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <%
				if(!"".equals(work_no)){
						String sqlStr = "select login_no,login_name,group_name,class_name,agentskills from dloginmsgstaffskill where kf_login_no = :work_no";
						myParams = "work_no="+work_no ;
			%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
				<wtc:param value="<%=sqlStr%>"/>
				<wtc:param value="<%=myParams%>"/>	
			</wtc:service>
			<wtc:array id="resultList" start="0" length="5" >
			<%			
						if(resultList.length>0){
						%>
			<tr>
         <td width=100% colspan=2>工号<%=work_no%>对应的信息：  </td>
      </tr> 
      <tr>
         <td width=40%>姓名：  </td>
         <td ><%=resultList[0][1]%></td>
      </tr> 
      <tr>
         <td width=40%>boss工号：  </td>
         <td ><%=resultList[0][0]%></td>
      </tr> 
      <tr>
         <td width=40%>组织机构：  </td>
         <td ><%=resultList[0][2]%></td>
      </tr> 
      <tr>
         <td width=40%>班组：  </td>
         <td ><%=resultList[0][3]%> </td>
      </tr> 
      <tr>
         <td width=40%>技能队列：  </td>
         <td width=40%>
						<%
						 String skill_str = "";
						 if(resultList[0][4]!=null&&!resultList[0][4].equals("")){
								String[] skills = resultList[0][4].split(";");
								for(int i =0;i<skills.length;i++){
										if(skills[i]!=null&&!skills[i].trim().equals("")){
												skill_str = skill_str + ",'" +skills[i]+"'";
										}
								}
								if(skill_str.startsWith(",")){
										skill_str = skill_str.substring(1);
								}
								if(skill_str.indexOf(",")!=-1){
								    skill_str = "select skill_queud_name from dagskillqueue where skill_queue_id in ("+skill_str+")";
										%>
						<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
							<wtc:param value="<%=skill_str%>"/>
						</wtc:service>
						<wtc:array id="resultList2" start="0" length="1" >
<%
for(int i=0;i<resultList2.length;i++){
%>
&nbsp;<%=resultList2[i][0]%><br>
<%
}
%>
</wtc:array>
										<%
								}
						 }%>
						 &nbsp;</td>
						<%
					  }else{
						%>
			<tr>
         <td width=100% colspan=2>无工号<%=work_no%>的信息!  </td>
      </tr> 
						<%
						}
						%>
			</wtc:array>
						<%
				}else{
			%>
      <tr>
         <td width=100% colspan=2>无工号!  </td>
      </tr>      
			<%				
				}
			%>

      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>


</body>
</html>

<script>
function grpClose(){
window.opener = null;
window.close();
}
</script>