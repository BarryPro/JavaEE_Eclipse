<%
  /*
   * 功能:对骚扰电话用户进行批量关闭语音功能
   * 版本: 1.0
   * 日期: 2010/07/13
   * 作者: sungq
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "g273";
	String opName = "二码合一投诉号码录入";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
	// xl add 每月最后一天不可以办理
	String date_end="select to_char(last_day(sysdate),'YYYYMMDD') from dual";
	String date_now="select to_char(sysdate,'YYYYMMDD') from dual";
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - 流水："+sysAccept);
%>

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=date_end%>"/>
	</wtc:service>
<wtc:array id="ret_val_dt" scope="end" />

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=date_now%>"/>
	</wtc:service>
<wtc:array id="ret_val_now" scope="end" />

<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-二码合一投诉号码录入</TITLE>
		<script language="JavaScript">
			function sel1() {
 		window.location.href='g273_1.jsp';
			 }

			 function sel2(){
				window.location.href='g273_2.jsp';
			 }

			
			<!--
			function form_load()
			{
				//init();
				}
				function dosubmit() {
				var new_date = document.all.beginDate.value;
				var phone_new = document.all.phones.value;
				//alert("phone_new is "+phone_new);
				var dt_end="<%=ret_val_dt[0][0]%>";
				var dt_now="<%=ret_val_now[0][0]%>";
				//var dt_now="20121130";
				//alert("test dt_end is "+dt_end+" and dt_now is "+dt_now);
				if(dt_end==dt_now)
				{
					rdShowMessageDialog("每个月最后一天不能做录入操作！");
					return false;
				}
				
				if(new_date=="")
				{
					rdShowMessageDialog("请选择日期！");
					return false;
				}
				else if(phone_new=="")
				{
					rdShowMessageDialog("请输入手机号码！");
					return false;
				}	
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					
					document.form.action="g273_cfm2.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&phones="+phone_new+"&beginDate="+new_date+"&sSaveName=0";
					document.form.submit();
					 
					return true;
				}
			}
			function setOpNote()
			{
				if(document.all.remark.value=="")
				{
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了二码合一投诉号码前台批量信息录入"; 
				}
				return true;
			}	
			
			//-->
		 
		
		function init()
		{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>举报处理</option><option value='02'>省内监控</option>");
		}
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="g273_cfm2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量信息导入---二码合一投诉号码批量信息录入</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			             <tr> 
        <td class="blue" width="15%" align=center>录入方式</td>
        <td colspan="4"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >文件上传 
         
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> 页面录入 
          
				</td>
     </tr>
					<!--
					  <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="60%">
					                    <input type="text" size="40" class="InputGrey" readonly value="二码合一投诉号码批量信息前台录入"> 选择日期 <input name="beginDate" type="text" id="bdate"  readonly onclick="selectDateNew(beginDate)" > 
								</td>
		              	</tr>
					--><input type="hidden"  name="beginDate" value="20120807">
						
						<tr>
							 <td class="blue" align=center width="20%">请输入手机号码，多个手机号码以|分割。录入的号码为2012年8月7日之前（不包括8月7日）激活的二码合一号码。</td>
							<td><textarea name="phones" rows="12" cols="68"></textarea></td>
						</tr>
						 
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
					  <!--
		              	 <TR id="bltys"  > 
						          <TD class="blue" align=center width="20%">数据来源</TD>
					              <TD >
					                 <select id="seled"  style="width:100px;">
														</select>
					
						          </TD>
						          </TR> 
						-->
			              <tr> 
				                <td class="blue" align=center width="20%">操作备注</td>
				                <td width="60%"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			                
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=确定 onClick="dosubmit()">
				                  &nbsp;
				                 		                  
				                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		  
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   <!--xl add for 页面录入时  上传框值为0-->
		   <input type="hidden" name="sSaveName" value="0">
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

