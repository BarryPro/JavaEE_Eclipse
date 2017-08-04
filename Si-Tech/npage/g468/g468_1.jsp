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
	String opCode = "g468";
	String opName = "终端刷码/二码拆包不认可充值";   
	String regionCode = (String)session.getAttribute("regCode");       
	System.out.println("--------------------regionCode-------------------"+regionCode);
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  

	String sysAccept = "";
	//时间查询
	String time_sql="select to_char(sysdate,'hh24') from dual";
	String time_now="";
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode0" retmsg="retMsg0" outnum="1">
			<wtc:param value="<%=time_sql%>"/>
	</wtc:service>
	<wtc:array id="ret_time" scope="end" />
<%
	if(ret_time.length>0)
	{
		time_now=ret_time[0][0];
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询当前时间出错");
				return false;
			</script>
		<%
	}
%>	
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - 流水："+sysAccept);
%>

 

<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-终端刷码/二码拆包不认可充值</TITLE>
		<script language="JavaScript">
			function sel1() {
 				window.location.href='g468_1.jsp';
			 }

			 function sel2(){
				window.location.href='g468_2.jsp';
			 }
			 function sel3(){
				window.location.href='g468show.jsp';
			 }
			
			<!--
			function form_load()
			{
				//init();
				}
				function dosubmit() {
					getAfterPrompt();
				//xl add for 18:00-0:00不允许录入
				//alert("time_now is "+"<%=time_now%>");
				if("<%=time_now%>">=18 && "<%=time_now%>"<=24)
				//if("<%=time_now%>">=09 && "<%=time_now%>"<=10)
				{
					rdShowMessageDialog("每天18:00-0:00不允许录入！");
					return false;
				}

				if(form.feefile.value.length<1)
				{
					rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
					document.form.feefile.focus();
					return false;
				}
				 
				else 
				{
					setOpNote();
					//alert(document.all.remark.value);
					 
					document.form.action="g468_cfm1.jsp?remark="+document.form.remark.value+"&regCode="+"<%=regionCode%>"+"&sysAccept="+"<%=sysAccept%>"+"&phones=0" ;
					document.form.submit();
					document.form.sure.disabled=true;
					document.form.reset.disabled=true;
					return true;
				}
			}
			function setOpNote()
			{
				if(document.all.remark.value=="")
				{
				  document.all.remark.value = "操作员："+document.all.loginNo.value+"进行了二码合一返费"; 
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
		<FORM action="g273_cfm1.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量信息导入---终端刷码/二码拆包不认可充值</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			             <tr> 
        <td class="blue" width="15%" align=center>录入方式</td>
        <td colspan="4"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>文件上传 
          <!--
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> 页面录入 
          -->
		  &nbsp;&nbsp;
		  <input name="busyType1" id="busyType3" type="radio" onClick="sel3()" value="3" >处理情况查询
				</td>
     </tr>
						  
						  <tr> 
				                <td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" size="30" class="InputGrey" readonly value="二码合一返费">
				                </td>				               		              
			                <td class="blue" align=center width="20%">数据文件</td>
			                <td width="30%" colspan="2"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
						 
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
					  <!--
		              	 <tr>
							<td width="30%">
					                    <input type="text" size="40" class="InputGrey" readonly value="二码合一投诉号码批量导入">
							</td>
							<td width="30%">
					                     入表日期：<input name="beginDate" type="text" id="bdate"  readonly onclick="selectDateNew(beginDate)" > (若激活日期和选择日期为同一天，也不入表.)
							</td>		
						</tr>
						-->
						<input type="hidden"  name="beginDate" value="20120807">
			              <tr> 
				                <td class="blue" align=center width="20%">操作备注</td>
				                <td colspan="2"> 
				                  	<input name=remark size=60 maxlength="60" >
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">说明：<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">数据文件为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">每天18:00-0:00不允许录入</font>：<br>
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 文件内容为:手机号码|返费金额|业务代码|返费年月(YYYYMM格式)|备注  回车 如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004678912|100|e232|201302|哈分<br> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15004678918|100|e232|201302|黑分<br> 
				                </td>
			              </tr>   
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=文件上传 onClick="dosubmit()">
				                  &nbsp;
				                  		                  
				                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		   <!--
		   <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="button" type="text" name="cxrq" >查询日期(YYYYMM)
				                  <input class="b_foot" name=sure type=button value=处理情况查询 onClick="doquery()">
				                  &nbsp;		                  
				                  
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>
		   -->
		   <input type="hidden" name="regCode" value="01" >
		   <input type="hidden" name="sysAccept" value="1234" >  
		   <input type="hidden" name="loginNo" value="<%=workno%>">
		   <input type="hidden" name="op_code" value="<%=opCode%>">
		   <input type="hidden" name="inputFile" value="">
		   <!--xl add for 文件录入时 文本域值为0-->
		   <input type="hidden" name="phones" value="0">
		   
		    <%@ include file="/npage/include/footer.jsp" %>     	
	</FORM>
	</BODY>
</HTML>

<script language="javascript">
	function doquery()
	{
		//alert("123");
	  if(document.all.cxrq.value=="")
	  {
		 rdShowMessageDialog("请输入查询日期!");
		 document.all.cxrq.focus();
		 return false;
	  }
	  else
	  {
		  document.all.action="g468_show.jsp";//?cxrq="+document.all.cxrq.value;
		  document.all.submit();
	  }	
	}
</script>