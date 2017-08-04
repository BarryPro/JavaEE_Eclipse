<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	  String workno=(String)session.getAttribute("workNo");   
	  String opCode = "zg51";
    String opName = "测试卡限额设定";
	  String phoneNo = request.getParameter("phoneNo");
	 // String phone_no = request.getParameter("phone_no");
		String[] inParam = new String[2];
		inParam[0]="select to_char(REMIND_INSTANCE_ID),to_char(USER_ID),to_char(EFF_DATE,'YYYYMMDD hh24:mi:ss'),to_char(EXP_DATE,'YYYYMMDD hh24:mi:ss'),to_char(CTRL_VALUE/1024/1024),FEE_VALUE from REMIND_PRODUCT_INSTANCE  where  USER_ID=:phoneNo and EXP_DATE>sysdate order by EFF_DATE";
		inParam[1]="phoneNo="+phoneNo;
		

%>
	<wtc:service name="TlsPubSelBoss"  outnum="6" >
	<wtc:param value="<%=inParam[0]%>"/>
	<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="resultArr" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>测试卡限额设定</TITLE>
</HEAD>
<script language="JavaScript">
	function  doinsert(){
		//插入新增配置
		var phoneNo = document.getElementById("phoneno").value;
		var ctrl_value=document.frm3.ctrl_value.value;
		var fee_value=document.frm3.fee_value.value;
		if(ctrl_value==""){
			alert("请输入流量上限！");
		}else if(fee_value==""){
			alert("请输入金额上限！");
		}else{
			document.frm3.action="zg51_3.jsp?configtype=0&phoneNo="+document.getElementById("phoneno").value;
			document.frm3.submit();
		}

		
		
	}
	function doupdate1(){
	//修改配置
		var ctrl_value=document.frm1.ctrl_value_new.value;
		var fee_value=document.frm1.fee_value_new.value;
		var changeType=document.frm1.changeType.value;
		if(changeType==""){
			alert("请输入生效类型！");
		}else if(ctrl_value==""){
			alert("请输入流量上限！");
		}else if(fee_value==""){
			alert("请输入金额上限！");
		}else{
			document.frm1.action="zg51_3.jsp?configtype=1&phoneNo="+document.getElementById("phoneno").value;
			document.frm1.submit();
		}	
	}
	
	function doupdate2(){
	//修改配置
		var changeType=document.frm2.changeType.value;
		var ctrl_value=document.frm2.ctrl_value_new.value;
		var fee_value=document.frm2.fee_value_new.value;
		if(changeType==""){
			alert("请输入生效类型！");
		}else if(ctrl_value==""){
			alert("请输入修改后流量上限！");
		}else if(fee_value==""){
			alert("请输入修改后金额上限！");
		}else{
			document.frm2.action="zg51_3.jsp?configtype=2&phoneNo="+document.getElementById("phoneno").value;
			document.frm2.submit();
		}	
	}
</script> 
<body>



			<%			
				if(resultArr!=null&&resultArr.length==1){//一条数据，说明是新增但是没有修改过。可以修改，预约下月生效；
			%>
		<FORM method=post name="frm1">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">测试卡限额设定</div>
			</div>
			<div id="Operation_Table">
      <table cellspacing="0" id = "titles">
      	<tr>
      	  <td class="blue"> 服务号码</td>
       	 <td colspan=5>
            <input type="text" name="phoneno"  id="phoneno" readonly maxlength="11" class="InputGrey" value="<%=phoneNo%>">
        </td>
    	</tr>
        <tr> 		 
				  <th>开始时间</th>
				  <th>结束时间</th> 
				  <th>流量上限(单位/G)</th>
				  <th>金额上限(单位/元)</th>
			</tr>
				<tr>
							<td>
								<input type="text" name="eff_date" size="20" maxlength="30"  readonly   
								value="<%=resultArr[0][2]%>"></td>
							<td>
								<input type="text" name="exp_date" size="20" maxlength="30" readonly  
								value="<%=resultArr[0][3]%>"></td>
							<td>
								<input type="text" name="ctrl_value" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[0][4]%>></td>
							<td>
								<input type="text" name="fee_value" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[0][5]%>></td>						
								<input type="hidden" name="remind_instance_id"  value=<%=resultArr[0][0]%>>
								<input type="hidden" name="user_id"  value=<%=resultArr[0][1]%>>

						</tr>
						<tr>
							<td class="blue">生效类型</td>
							<td colspan=5>     
								 <select id="changeType" name="changeType" >
									<option value="" selected>--请选择</option>
									<option value="1" >立即生效</option>
									<option value="2" >预约生效</option>
								</select>  
							</td>				
						</tr>
						<div id=newdiv1 >
							<tr>
									<td class="blue">修改后流量上限(单位/G)</td>
									<td>
										<input type="text" name="ctrl_value_new" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value="">
									</td>
				  				<td class="blue">修改后金额上限(单位/元)</td>
				  				<td>
										<input type="text" name="fee_value_new" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value="">
									</td>
							</tr>
						</div>
			</div>			
         
          <tr id="footer"> 
      	    <td colspan="15">
      	    <input class="b_foot" name=update onClick="doupdate1()" type=button value=修改>
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=返回>
			 
			  
    	    </td>
          </tr>
      </table>
      <tr id="footer">       	   
      </tr>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
			<%			
				}else if(resultArr!=null&&resultArr.length==2){
					//两条数据（本月有效配置及预约未生效的配置），说明是新增并且修改过。那么只能修改下月及以后的配置，本月无法更改				
			%>
			
			<FORM method=post name="frm2">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">测试卡限额设定</div>
			</div>
			<div id="Operation_Table">
      <table cellspacing="0" id = "titles">
      	<tr>
      	  <td class="blue"> 服务号码</td>
       	 <td colspan=5>
            <input type="text" name="phoneno" id="phoneno"  readonly maxlength="11" class="InputGrey" value="<%=phoneNo%>">
        </td>
    	</tr>
        <tr> 			 
				  <th>开始时间</th>
				  <th>结束时间</th> 
				  <th>流量上限(单位/G)</th>
				  <th>金额上限(单位/元)</th>

			</tr>
						<tr>
						<td>
								<input type="text" name="eff_date0" size="20" maxlength="30"  readonly
								value="<%=resultArr[0][2]%>"></td>
							<td>
								<input type="text" name="exp_date0" size="20" maxlength="30" readonly
								value="<%=resultArr[0][3]%>"></td>
							<td>
								<input type="text" name="ctrl_value0" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[0][4]%>></td>
							<td>
								<input type="text" name="fee_value0" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[0][5]%>></td>					
							<td>       
							</td>			
								<input type="hidden" name="remind_instance_id0"  value=<%=resultArr[0][0]%>>
								<input type="hidden" name="user_id0"  value=<%=resultArr[0][1]%>>
						</tr>
						
						<tr>
						<td>
								<input type="text" name="eff_date" size="20" maxlength="30"  readonly  onKeyPress="return isKeyNumberdot(0)"
								value="<%=resultArr[1][2]%>"></td>
							<td>
								<input type="text" name="exp_date" size="20" maxlength="30"  readonly onKeyPress="return isKeyNumberdot(0)"
								value="<%=resultArr[1][3]%>"></td>
							<td>
								<input type="text" name="ctrl_value" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[1][4]%>></td>
							<td>
								<input type="text" name="fee_value" size="20" maxlength="15" readonly onKeyPress="return isKeyNumberdot(0)"
								value=<%=resultArr[1][5]%>></td>												
								<input type="hidden" name="remind_instance_id"  value=<%=resultArr[1][0]%>>
								<input type="hidden" name="user_id"  value=<%=resultArr[1][1]%>>
						</tr>
						
						<tr>
							<td class="blue">生效类型</td>
							<td colspan=5>     
								 <select id="changeType" name="changeType"  >
									<option value="" selected>--请选择</option>
									<option value="1" >立即生效</option>
									<option value="2" >预约生效</option>
								</select> 
							</td>				
						</tr>
						<div id=newdiv2 >
							<tr>
									<td class="blue">修改后流量上限(单位/G)</td>
									<td>
										<input type="text" name="ctrl_value_new" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value="">
									</td>
				  				<td class="blue">修改后金额上限(单位/元)</td>
				  				<td>
										<input type="text" name="fee_value_new" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value="">
									</td>
							</tr>
						</div>
			</div>			
         
          	<tr id="footer"> 
      	    <td colspan="15">
      	    <input class="b_foot" name=update onClick="doupdate2()" type=button value=修改>
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=返回>
			 
			  
    	    </td>
          </tr>
      </table>
      <tr id="footer">     	   
      </tr>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
			<%
					
				}else{//无数据说明没有配置过
					String now =new java.util.Date().toLocaleString();
					System.out.println("---------------------now--------------------------------"+now);
			%>
			<FORM method=post name="frm3">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">测试卡限额设定</div>
			</div>
			<div id="Operation_Table">
      <table cellspacing="0" id = "titles">
      	<tr>
      	  <td class="blue"> 服务号码</td>
       	 <td colspan=5>
            <input type="text" name="phoneno" id="phoneno" readonly maxlength="11" class="InputGrey" value="<%=phoneNo%>">
        </td>
    	</tr>
        <tr> 		 
				  <th>开始时间</th>
				  <th>结束时间</th> 
				  <th>流量上限(单位/G)</th>
				  <th>金额上限(单位/元)</th>
			</tr>
						<tr>
							<td>
								<input type="text" name="eff_date"  readonly onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="17"  value="<%=now%>"></td>
							<td>
								<input type="text" name="exp_date"  readonly onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="17" value="2099-1-1 00:00:00"></td>
							<td>
								<input type="text" name="ctrl_value" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value=""></td>
							<td>
								<input type="text" name="fee_value" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="15" value=""></td>
						</tr>
			</div>			
         
          <tr id="footer"> 
      	    <td colspan="15">
      	    <input class="b_foot" name=insert onClick="doinsert()" type=button value=新增>
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=返回>
			 
			  
    	    </td>
          </tr>
      </table>
      <tr id="footer"> 
      	   
          </tr>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
			
			<%
				}	
			%>
<!--/div>			
         
          <tr id="footer"> 
      	    <td colspan="15">
      	    <input class="b_foot" name=back onClick="doSubmit()" type=button value=确认>
      	    <input class="b_foot" name=reset onClick="doclear()" type=button value=重置>
    	      <input class="b_foot" name=back onClick="window.location = 'zg51_1.jsp' " type=button value=返回>
			 
			  
    	    </td>
          </tr-->
          

</BODY></HTML>  
    
<script language="javascript">
	function doclear() {
 		frm51_2.reset();
 	}
 
	function deletes(region_code,opcode)
	{
		var prtFlag=0;
		prtFlag=rdShowConfirmDialog("是否确认删除?");
		if (prtFlag==1)
		{
			
			//alert(opcode);
			//alert(region_code);
 			document.frm51_2.action="zg51_3.jsp?s_flag="+"1"+"&s_region_code="+region_code+"&opcode="+opcode;
			document.frm51_2.submit();
		}
		else
		{
			//alert("不删除 "+region_code);
			return false;
		}
		
	}
</script>



