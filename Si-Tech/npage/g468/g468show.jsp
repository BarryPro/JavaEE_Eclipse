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
	// xl add 每月最后一天不可以办理
	 
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%   
    sysAccept = sLoginAccept;
    System.out.println("#           - 流水："+sysAccept);
%>
 

<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-二码合一返费</TITLE>
		<script language="JavaScript">
			function doChg()
			{
				var selectOp = document.all.selectOp[document.all.selectOp.selectedIndex].value;
				if(selectOp==0)
				{
					rdShowMessageDialog("请选择查询方式！");
					return false;
				}
				else if(selectOp==1)
				{
					document.getElementById("div1").style.display="block";
					document.getElementById("div2").style.display="none";
				}
				else
				{
					document.getElementById("div1").style.display="none";
					document.getElementById("div2").style.display="block";
				}
				
				//alert(" test "+selectOp);
			}

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
				document.getElementById("div1").style.display="none";
				document.getElementById("div2").style.display="none";
			}
				function dosubmit() {
				var new_date = document.all.cxrq.value;
				var end_date = document.all.cxrqjs.value;
				var gjz =   document.all.gjz.value;

				//选出单选框的value selectOp
				/*
				document.all.FirstClass.value == 0 
				var ThirdClass_new = document.all.ThirdClass[document.all.ThirdClass.selectedIndex].value;
				*/
				var select_value = document.all.selectOp[document.all.selectOp.selectedIndex].value;
				if(select_value==0)
				{
					rdShowMessageDialog("请选择查询方式！");
					return false;
				}
				else
				{
					 
					if(select_value==1)
					{
						if(document.all.sjhm.value=="")
						{
							rdShowMessageDialog("请输入查询手机号码！");
							return false;
						}
						else 
						{
							//q_flag=0 查询手机号码
							document.form.action="g468_show_cfm.jsp?beginDate="+new_date+"&gjz="+gjz+"&sjhm="+document.all.sjhm.value+"&q_flag=0";
							document.form.submit();
							return true;
						}
					}
					else if(select_value==2)
					{
						if(document.all.cxrq.value=="" && document.all.gjz.value=="" && document.all.cxrqjs.value=="" )
						{
							rdShowMessageDialog("请输入查询时间段和查询关键字！");
							return false;
						}
						//if(((document.all.cxrq.value=="" && document.all.cxrqjs.value!="") || (document.all.cxrq.value!="" && document.all.cxrqjs.value=="")) && document.all.gjz.value=="")
						if((document.all.cxrq.value=="" && document.all.cxrqjs.value!="") || (document.all.cxrq.value!="" && document.all.cxrqjs.value==""))
						{
							rdShowMessageDialog("请输入查询时间段！");
							return false;
						}
						else 
						{
							//q_flag=1 查询日期+关键字查询
							document.form.action="g468_show_cfm.jsp?beginDate="+new_date+"&gjz="+gjz+"&sjhm="+document.all.sjhm.value+"&q_flag=1"+"&end_dt="+end_date;;
							document.form.submit();
							return true;
						}
					}
					
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
				<div id="title_zi">批量信息导入---二码合一返费</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			             <tr> 
        <td class="blue" width="15%" align=center>查询方式</td>
        <td colspan="5"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >文件上传 
         
          <input name="busyType3" type="radio" onClick="sel3()" value="3" checked> 处理情况查询 
          
				</td>
     </tr>
					 <tr>
						<td>
							<select name="selectOp" onchange="doChg()">
								<option value="0">请选择</option>
								<option value="1">手机号码</option>
								<option value="2">时间段+备注关键字</option>
							</select>
						</td>
					 </tr>	


						<tr id="div1">
							<td>
								  
							</td>
							<td>
								手机号码： 
						 
								 <input class="button"type="text" name="sjhm" size="11" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" > 
							</td>
						</tr>
						<tr id="div2">
							<td>
								  
							</td>
							<td>
								查询开始日期： <input class="button"type="text" name="cxrq" size="8" maxlength="8"  onclick="selectDateNew(cxrq)" onKeyPress="return isKeyNumberdot(0)" >(YYYYMMDD)
							 &nbsp;&nbsp;&nbsp;&nbsp;
							 查询结束日期： <input class="button"type="text" name="cxrqjs" size="8" maxlength="8" onclick="selectDateNew(cxrqjs)" onKeyPress="return isKeyNumberdot(0)" >(YYYYMMDD)
							 &nbsp;&nbsp;&nbsp;&nbsp;
								备注关键字： 
						 
								 <input class="button"type="text" name="gjz"    > 
							</td>
						</tr>
						 
		        </tbody> 
	    		</table>
		       
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=查询 onClick="dosubmit()">
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

