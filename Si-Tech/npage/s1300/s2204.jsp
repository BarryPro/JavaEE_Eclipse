 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>

<%
	String opCode = "2204";	
	String opName = "批量费用补收";	//header.jsp需要的参数   
	String regionCode = (String)session.getAttribute("regCode");       
	
	String workno=(String)session.getAttribute("workNo");    //工号 
	String workname =(String)session.getAttribute("workName");//工号名称  	        
	String orgcode = (String)session.getAttribute("orgCode");  
	
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
	String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	
	Date date = new Date();
  DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	
	    		/* 操作时间 requestTime节点 */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* 获取敏感数据和敏感操作 */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* 资源ID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* 资源名称 */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* 场景ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* 测试用场景ID，上线删掉 by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* 场景名称 sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}
	
%>
 
	
<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量费用补收</TITLE>
		<script language="JavaScript">
			<!--
			function form_load()
				{
				//form.sure.disabled=true;
				}
				function dosubmit() {
					getAfterPrompt();
					var billym=document.form.bill_month.value;
					//alert("billym is "+billym);
					var SBillItem=document.form.SBillItem.value;
					if (billym==""){
					rdShowMessageDialog("信息费年月错误，请重新输入。");
					document.form.bill_month.focus();
					return false;
				}
				/*else if( billym.substring(0,4)<"1990"||billym.substring(0,4)>"2010") {
					rdShowMessageDialog("\输入的年份错误，请重新输入 !!")
					document.form.bill_month.focus();
					return false;
				}*/
				else if( billym.substring(4)<"01"||billym.substring(4)>"12") {
					rdShowMessageDialog("\输入的月份错误，请重新输入 !!")
					document.form.bill_month.focus();
					return false;
				}
				else if(form.feefile.value.length<1)
				{rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
					document.form.feefile.focus();
					return false;
					}
				else {
					var billym=document.form.bill_month.value;
				var SBillItem=document.form.SBillItem.value;
				document.form.action="s2204_2.jsp?billym="+billym+"&SBillItem="+SBillItem+"&remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
	      
					}
				}
function doFileInput(packet){
			var result = packet.data.findValueByName("result");
			result="1";
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**调用成功 */
				//alert("调用成功");
				var billym=document.form.bill_month.value;
				var SBillItem=document.form.SBillItem.value;
				document.form.action="s2204_2.jsp?billym="+billym+"&SBillItem="+SBillItem+"&remark="+document.form.remark.value;
				document.form.submit();
				document.form.sure.disabled=true;
				document.form.reset.disabled=true;
				return true;
			}else{
				/**调用失败 */
				//alert("调用失败");
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
				return false;
			}
}
				
				function isKeyNumberdot(ifdot) 
				{       
				    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
					if(ifdot==0)
						if(s_keycode>=48 && s_keycode<=57)
							return true;
						else 
							return false;
				    else
				    {
						if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
						{
						      return true;
						}
						else if(s_keycode==45)
						{
						    rdShowMessageDialog('不允许输入负值,请重新输入!');
						    return false;
						}
						else
							  return false;
				    }       
				}
				
			 	//  add liuxmc
				function getTKDate(){
					
					var time = document.form.reuturn_time.value;
					if(time == "" || time.length==0){
						alert("日期不能为空！");
						return false;
					}
					
					if(time.length != 8){
						alert("对不起，您输入的日期格式不对，请按照正确的格式(YYYYMMDD)填写!");
						return false;
					}
			
			    if(time.length!=0){    
			       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
			       var r = time.match(reg);     
			       if(r==null){
			         alert("对不起，您输入的日期格式不正确，请按照正确的格式(YYYYMMDD)填写!");
			         return false;
			       }
			     }
			     
					var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
					window.showModelessDialog(path);
				}	
				
				//  end  
			//-->
		</script>
	</HEAD>
	<BODY  onLoad="form_load();">
		<FORM action="s2204_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量费用补收</div>
			</div> 
			<table cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" width="20%">操作类型</td>
				                <td width="30%">
					                  <select name = "SOprType" size = "1" >
					                    	<option value = "1" selected> 批量费用补收</option>
					                  </select>
				                </td>				                
				                <td class="blue" width="10%">部门</td>
				                <td width="40%"><%=orgcode%></td>
			              </tr>
		              </tbody> 
	            	</table>
	            	<table id=tbs9  cellspacing="0">
	            	<tbody> 
		             	 <tr> 
		                	<td class="blue" width="20%">帐务年月</td>
			                <td width="30%"> 
			                  <input type="text" class="InputGrey" readonly value="<%=mon%>" name="bill_month" maxlength="6"  onKeyPress="return isKeyNumberdot(1)">
			                </td>
		                	<td class="blue" width="10%">费用名称</td>
		                	<td width="40%"> 
				               <select name="SBillItem">
							<% 	try{
									ArrayList retArray = new ArrayList();
							      		//String [][] result_dyn = new String[][]{};
							      	    	//ScallSvrViewBean viewBean = new ScallSvrViewBean();
							            	//CallRemoteResultValue callRemoteResultValue = null;
							            	String[] inParas = new String[]{""};
							            	inParas[0] = "select fee_code||'|'||detail_code,fee_code||'-'||detail_code||'-'||detail_name from sFeeCodeDetail where fee_code !='*' order by fee_code,detail_code";
							           	//callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas);
							           	//result_dyn = callRemoteResultValue.getData();
							  	%>
							           	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
										<wtc:sql><%=inParas[0]%></wtc:sql>
									</wtc:pubselect>
									<wtc:array id="result_dyn" scope="end" />									
							         <%
							           	System.out.println("result_dyn========================="+result_dyn.length);
							           	System.out.println("retCode1========================="+retCode1);
							           	System.out.println("retMsg1========================="+retMsg1);
							            	for(int i=0;i<result_dyn.length;i++){
							        		out.print("<option value='" + result_dyn[i][0] + "'>" + result_dyn[i][1] + "</option>");
							      		}
							     	}catch(Exception e){
							       		System.out.println("=========================调用服务失败！");
							     	}          
							%>
				                  </select>
		                	</td>
		   		</tr>
		  <!--  add liuxmc-->
		   		<tr>
						<td class="blue">退预存款信息查询：</td>
						<td class="blue" colspan="3">			
							日期：<input type="text" class="button" name="reuturn_time" value="<%=now%>">格式：YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input class="b_text"  type=button value="查 询" onClick="getTKDate();">
						</td>
					</tr>		
			<!-- end -->
		              	<tr> 
			                <td class="blue">数据文件</td>
			                <td  colspan="4"> 
			                  <input type="file" name="feefile">
			                </td>
		              	</tr>
		        </tbody> 
	    		</table>
		       <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td class="blue" width="20%">操作备注</td>
				                <td colspan="2"> 
				                  	<input class="InputGrey" name=remark size=60 maxlength="60"  class="InputGrey">
				                </td>
			              </tr>
			              <tr> 
				                <td colspan="3">说明：<br>
				                  &nbsp;&nbsp;&nbsp;1、数据文件的文件格式为：<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;服务号码 空格 帐号 空格 费用 空格 送费类型 空格 送费明细<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果补收到默认帐号，则帐号可以输入为零<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345679 0 5.01 a 0001<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13612345679 0 24.04 b 0002<br>
				                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13712345679 0 125.83 b 0003
				                </td>
			              </tr>
		              </tbody> 
		      </table>
		      <table  cellspacing="0">
		              <tbody> 
			              <tr> 
				                <td id="footer" > 
				                  <input class="b_foot" name=sure type=button value=确认 onClick="dosubmit()">
				                  &nbsp;
				                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
				                  &nbsp; 
				                 </td>
			              </tr>
		              </tbody> 	            
		   </table>	
		    <%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY>
</HTML>
