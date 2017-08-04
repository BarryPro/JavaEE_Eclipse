<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String opCode="";
  String opName="集团客户扩展信息";	
  String sqlStr="";  
%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">
	<input type="hidden" id=p_Action value="">
 <div class="title"><div id="title_zi">关键人信息 </div></div>
        <!--取流水 页面为新增时使用 页面若为更新,用传入数据覆盖-->
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
        <input type="hidden" id=p_CustomerNumber>
				<table>			
		     <tr>
	         <td>
	              人员角色
	         </td>
	         <td>
		            <select align="left" id="p_Role" width=50>
                    <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'Role' order by detail_order ";%>
			              <wtc:qoption name="sPubSelect" outnum="2">
			              <wtc:sql><%=sqlStr%></wtc:sql>
			              </wtc:qoption>   
                </select>
                <font class="orange">*</font>  
	         </td>
         	<td>
          	姓名
          </td>
          <td>
					  <input id="p_PartyName" type="string" size="20" maxlength="20" v_must="1">
					  <font class="orange">*</font>  
          </td>          
			 		</tr>          
			 		<tr>           
          	<td>         
            	性别       
            </td>        
            <td>         
		            <select align="left" id="p_Sex" width=50>
                    <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'Sex' order by detail_order ";%>
			              <wtc:qoption name="sPubSelect" outnum="2">
			              <wtc:sql><%=sqlStr%></wtc:sql>
			              </wtc:qoption>   
                </select>
                <font class="orange">*</font>  
            </td>        
          	<td>
            	联系电话
            </td>
            <td>
		          <input id="p_ContactPhone" type="string" size="20" 　v_must="1"　maxlength="20" >
		          <font class="orange">*</font>
            </td>
			 		</tr>
					<tr >
          	<td>
            	职务
            </td>
            <td>
		          <input id="p_Title" type="string" size="20" maxlength="20">
            </td>
          	<td>
            	昵称
            </td>
            <td>
		          <input id="p_Alias" type="string" size="20" maxlength="40">
            </td>
					</tr>
					<tr >
          	<td>
            	生日
            </td>
            <td>
		          <input id="p_Birthday" type="date" size="20" maxlength="20">
            </td>
          	<td>
            	纪念日
            </td>
            <td>
		          <input id="p_Memorial" type="string" size="20" maxlength="40">
            </td>
					</tr>
					<tr >
          	<td>
            	配偶姓名
            </td>
            <td>
		          <input id="p_Mate" type="string" size="20" maxlength="20">
            </td>						
          	<td>
            	秘书姓名
            </td>
            <td>
		          <input id="p_Secretary" type="string" size="20" maxlength="20">
            </td>
					</tr>		
					<tr >            
          	<td>
            	毕业院校
            </td>
            <td>
		          <input id="p_School" type="string" size="20" maxlength="40">
            </td>

          	<td>
            	同窗
            </td>
            <td>
		          <input id="p_ClassMates" type="string" size="20" maxlength="20">
            </td>
					</tr>		
					<tr >            
          	<td>
            	兴趣爱好
            </td>
            <td>
		          <input id="p_Hobby" type="string" size="20" maxlength="40">
            </td>
          	<td>
            	上级领导
            </td>
            <td>
		          <input id="p_Leader" type="string" size="20" maxlength="20">
            </td>
					</tr>		
					<tr >            
          	<td>
            	上级部门
            </td>
            <td>
		          <input id="p_LeaderDept" type="string" size="20" maxlength="40">
            </td>
          	<td>
            	下级部门
            </td>
            <td>
		          <input id="p_Vassal" type="string" size="20" maxlength="20">
            </td>
					</tr>	
					<tr >            
          	<td>
            	社交圈
            </td>
            <td colspan="3">
		          <input id="p_Intercourse" type="string" size="20" maxlength="40">
            </td>
					</tr>																										
				</table>
				<br>	
        <table>
          <tr>
            <td align="center" id="footer" colspan="4">
            	<input class="b_foot" id="confirm" type=button value="确认" onClick="">
              <input class="b_foot" id="closebtn" type=button value="关闭" onClick="window.close()">
            </td>
          </tr>  
        </table>
</div>
</div>
</BODY>
</HTML>
<script>
var keyPerson;

function KeyPersonAddConfirm(){
	
  if($("#p_PartyName").val()=="")
  {
  			rdShowMessageDialog("姓名不能为空!");	
    		return;
  }
  if($("#p_ContactPhone").val()=="")
  {
  			rdShowMessageDialog("联系电话不能为空!");	
    		return;
  }
　
  keyPerson[0] = $("#p_Role").val();
  keyPerson[1] = $("#p_PartyName").val();
  keyPerson[2] = $("#p_Sex").val();
  keyPerson[3] = $("#p_ContactPhone").val();
  keyPerson[4] = $("#p_Title").val();
  keyPerson[5] = $("#p_Alias").val();
  keyPerson[6] = $("#p_Birthday").val();
  keyPerson[7] = $("#p_Memorial").val();
  keyPerson[8] = $("#p_Mate").val();
  keyPerson[9] = $("#p_Secretary").val();
  keyPerson[10]= $("#p_School").val();
  keyPerson[11]= $("#p_ClassMates").val();
  keyPerson[12]= $("#p_Hobby").val();
  keyPerson[13]= $("#p_Leader").val();
  keyPerson[14]= $("#p_LeaderDept").val();
  keyPerson[15]= $("#p_Vassal").val();
  keyPerson[16]= $("#p_Intercourse").val();
  keyPerson[17]= $("#p_CustomerNumber").val();
  window.returnValue = "Y";
  window.close();
}

$(document).ready(function(){
	keyPerson=window.dialogArguments;	
  $("#p_Role").val(keyPerson[0]);
  $("#p_PartyName").val(keyPerson[1]);
  $("#p_Sex").val(keyPerson[2]);
  $("#p_ContactPhone").val(keyPerson[3]);
  $("#p_Title").val(keyPerson[4]);
  $("#p_Alias").val(keyPerson[5]);
  $("#p_Birthday").val(keyPerson[6]);
  $("#p_Memorial").val(keyPerson[7]);
  $("#p_Mate").val(keyPerson[8]);
  $("#p_Secretary").val(keyPerson[9]);
  $("#p_School").val(keyPerson[10]);
  $("#p_ClassMates").val(keyPerson[11]);
  $("#p_Hobby").val(keyPerson[12]);
  $("#p_Leader").val(keyPerson[13]);
  $("#p_LeaderDept").val(keyPerson[14]);
  $("#p_Vassal").val(keyPerson[15]);
  $("#p_Intercourse").val(keyPerson[16]);  
  $("#p_CustomerNumber").val(keyPerson[17]);
  $("#p_Action").val(keyPerson[18]);
  
  if($("#p_Action").val()=="2")
  {
  	/*2014/12/25 10:24:26 gaopeng 类型为修改时，也可以改了。原来都是 true 目前全改为 false */
  	document.all.p_Role.disabled=false;
  	document.all.p_PartyName.readOnly=false;
  	document.all.p_Sex.disabled=false;
  	document.all.p_Title.readOnly=false;
  	document.all.p_Alias.readOnly=false;
  	document.all.p_Birthday.readOnly=false;
  	document.all.p_Memorial.readOnly=false;
  	document.all.p_Mate.readOnly=false;
  	document.all.p_Secretary.readOnly=false;
  	document.all.p_School.readOnly=false;
  	document.all.p_ClassMates.readOnly=false;
  	document.all.p_Hobby.readOnly=false;
  	document.all.p_Leader.readOnly=false;
  	document.all.p_LeaderDept.readOnly=false;
  	document.all.p_Vassal.readOnly=false;
  	document.all.p_Intercourse.readOnly=false;
  	
  	
  }
  if($("#p_Action").val()=="1")
  {
  	document.all.p_Role.disabled=false;
  	document.all.p_PartyName.readOnly=false;
  	document.all.p_Sex.disabled=false;
  	document.all.p_Title.readOnly=false;
  	document.all.p_Alias.readOnly=false;
  	document.all.p_Birthday.readOnly=false;
  	document.all.p_Memorial.readOnly=false;
  	document.all.p_Mate.readOnly=false;
  	document.all.p_School.readOnly=false;
  	document.all.p_Secretary.readOnly=false;
  	document.all.p_ClassMates.readOnly=false;
  	document.all.p_Hobby.readOnly=false;
  	document.all.p_Leader.readOnly=false;
  	document.all.p_LeaderDept.readOnly=false;
  	document.all.p_Vassal.readOnly=false;
  	document.all.p_Intercourse.readOnly=false;
  	
  }
  if($("#p_Action").val()=="3")
  {
  	document.all.p_Role.disabled=true;
  	document.all.p_PartyName.readOnly=true;
  	document.all.p_Sex.disabled=true;
  	document.all.p_Title.readOnly=true;
  	document.all.p_Alias.readOnly=true;
  	document.all.p_Birthday.readOnly=true;
  	document.all.p_Memorial.readOnly=true;
  	document.all.p_Mate.readOnly=true;
  	document.all.p_Secretary.readOnly=true;
  	document.all.p_School.readOnly=true;
  	document.all.p_ClassMates.readOnly=true;
  	document.all.p_Hobby.readOnly=true;
  	document.all.p_Leader.readOnly=true;
  	document.all.p_LeaderDept.readOnly=true;
  	document.all.p_Vassal.readOnly=true;
  	document.all.p_Intercourse.readOnly=true;
  	document.all.p_Role.disabled=true;
  	document.all.p_ContactPhone.disabled=true; 	
  }  
  
  //注册确认
  $('#confirm').click(function(){
	     KeyPersonAddConfirm();
	 });                                        
}                                       
)                                       
</script>                                     
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
  
