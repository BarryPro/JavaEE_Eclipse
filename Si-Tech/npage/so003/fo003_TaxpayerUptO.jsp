<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 修改
　 * 版本: v1.0
　 * 日期: 2013/10/17
　 * 作者: wangjxc
　 * 版权: sitech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
	<%
		String opCode = request.getParameter("opCode");
		String UpCustId = request.getParameter("UpCustId");
		String queryStatus = request.getParameter("queryStatus");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
		String login_no = (String)session.getAttribute("workNo");
		String oAppIdeaOne = request.getParameter("oAppIdeaOne");
		String oAppIdeaTwo = request.getParameter("oAppIdeaTwo");
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&77queryStatus:"+queryStatus);
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&88oAppIdeaOne:"+oAppIdeaOne);
		System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&99oAppIdeaTwo:"+oAppIdeaTwo);
		
		String opName = "纳税人资质展示";
	%>
<wtc:service name="sQryTaxpay" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=UpCustId%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>	
<%	
	String acctchment_name="";
	String acctchment_list="";
	String file_name="";
	String source_file="";
	String taxpayer_type = retList[0][2];
	String bill_type = retList[0][3];

if(retList.length>0)
{
	System.out.println("retList.length========================"+retList.length);
	for(int i=0;i<retList.length;i++)
	{
		acctchment_name = retList[i][12];
		acctchment_list = retList[i][14];
		file_name=acctchment_name+"*"+acctchment_list;
		System.out.println("file_name========================"+file_name);
		if(i==0)
		{
   			source_file=file_name;
   			System.out.println("source_file11111111111========================"+source_file);
  		}
  		else
  		{
   			source_file=source_file+"|"+file_name;
   			System.out.println("source_file2222222========================"+source_file);
  		}
  		
	}
	
}				
%>		

	

<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	<title>纳税人资质信息展示</title>
	<script language="JavaScript">
		
		function ApproveCom()
		{
			if(!check(frmo003Upt))return false;
			var approveStaff = $("#approve_staff").val();
			var approveAdd = $("#approve_add").val();		
			var packet = new AJAXPacket("fo003_ajax_doTaxpayerUpto.jsp","请稍后...");
			packet.data.add("approveStaff",approveStaff);
			packet.data.add("approveAdd",approveAdd);
			packet.data.add("UpCustId",'<%=UpCustId%>');
			packet.data.add("LoginNo",'<%=login_no%>');
			core.ajax.sendPacket(packet,doUptTaxpayer,true);
	  		packet = null;
		}
		
		function doUptTaxpayer(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000")
			{
				rdShowMessageDialog("修改操作完成！",2);
				window.close();
				window.opener.doQueryApproveO();
			} 
			else
			{
				rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
			}
		}	
	
	</script>
<body>
<form id="frmg645" name="frmo003Upt" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">纳税人资质信息展示</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">纳税人识别号：</td>
			<td>
					<input type=text name="taxpayer_id" value="<%=retList[0][1]%>" id="taxpayer_id" v_must="1" class="isLengthOf" v_maxlength="255" disabled/>
					<font class=orange>*</font>
			</td>
			<td class="blue">资质类型：</td>
			<td>
				<%
				    if("1".equals(taxpayer_type)){
				%>
				   <input  type=text name="taxpayer_type" id="taxpayer_type" value="增值税一般纳税人" disabled/>
				<%
				    }else if("2".equals(taxpayer_type)){
				%>
					<input  type=text name="taxpayer_type" id="taxpayer_type" value="增值税小规模纳税人" disabled/>
				<%   	
				    }else if("3".equals(taxpayer_type)){
				%>
					<input  type=text name="taxpayer_type" id="taxpayer_type" value="非增值税纳税人" disabled/>
				<%   	
				    }
				%>
				<font class=orange>*</font>
			</td>
        </tr>
        <tr>
			<td class="blue">发票类型：</td>
			<td>
				<%
				    if("1".equals(bill_type)){
				%>
				   <input  type=text name="bill_type" id="bill_type" value="预存发票" disabled/>
				<%
				    }else if("2".equals(bill_type)){
				%>
					<input  type=text name="bill_type" id="bill_type" value="月结发票" disabled/>
				<%   	
				    }
				%>
				<font class=orange>*</font> 
			</td>
			<td class="blue">联系电话：</td>
			<td>
					<input type=text name="phone_no" value="<%=retList[0][6]%>" id="phone_no" v_must="1" class="isLengthOf" v_maxlength="255" disabled/>
					<font class=orange>*</font>
			</td>
        </tr>
        <tr>
			<td class="blue">主开户银行：</td>
			<td>
					<input type=text name="bank_name" value="<%=retList[0][7]%>" id="bank_name" v_must="1" class="isLengthOf" v_maxlength="255" disabled/>
					<font class=orange>*</font>
			</td>
			<td class="blue">主银行帐号：</td>
			<td>
					<input type=text name="bank_account" value="<%=retList[0][8]%>" id="bank_account" v_must="1" class="isLengthOf" v_maxlength="255" disabled/>
					<font class=orange>*</font>
			</td>
        </tr>
        <tr id="bank_name" name="bank_name" >
							<td class="blue">开户银行：</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_name_list" value="" style="width:80%" disabled ><%=retList[0][15]%></textarea>
	  			<font class=orange>*</font>
	  		</td>
	  	</tr>
	  	<tr id="bank_num" name="bank_num" >
	  		<td class="blue">银行帐号：</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_num_list" value="" style="width:80%" disabled><%=retList[0][16]%></textarea>
	  			<font class=orange>*</font>
	  		</td>
		</tr>
        <tr>
			<td class="blue">营业执照生效时间：</td>
			<td>
				<input type="text" name="valid_date" id="valid_date" v_must="1" class="Wdate"  v_type="date" value="<%=retList[0][9]%>" disabled/>
				<font class=orange>*</font>
			</td>
			<td class="blue">营业执照失效时间：</td>
			<td>
				<input type="text" name="expire_date" id="expire_date"  v_must="1" class="Wdate"  v_type="date" value="<%=retList[0][10]%>" disabled/>
				<font class=orange>*</font>
			</td>
		</tr>		
		<tr>
			<td class="blue">
			单位名称：
			</td>
			<td colspan="3">
				<input type="text" id="unit_name" v_must="1" name="unit_name" value="<%=retList[0][4]%>" size="80" class="required isLengthOf" v_maxlength="255" disabled/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">
			单位地址：
			</td>
			<td  colspan="3">
				<input type="text" id="unit_address" name="unit_address" v_must="1" value="<%=retList[0][5]%>" size="80" class="required isLengthOf" v_maxlength="255" maxlength="255" disabled/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">备注:</td>
			<td colspan="3">
				<input type=text name="remark" id="remark" v_must="1" size="80" value="<%=retList[0][11]%>" class="isLengthOf" v_maxlength="128" disabled/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
		<wtc:service name="sApproveQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
				<wtc:param value="o005"/>
				<wtc:param value="<%=login_no%>"/>
		</wtc:service>
		<wtc:array id="retList"  scope="end"/>
		<wtc:service name="sApproveQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
				<wtc:param value="o004"/>
				<wtc:param value="<%=login_no%>"/>
		</wtc:service>
		<wtc:array id="retListone"  scope="end"/>
		<td class="blue">上级主管审批人员：</td>
		<td>
			<select v_must="1" id="approve_staff" <%if("03".equals(queryStatus)||"05".equals(queryStatus)){%>disabled="disabled"<%}%>>
				    <%
			           if(retListone.length>0){
			           for(int i=0;i<retListone.length;i++){
		           %>
		               <option value="<%=retListone[i][0]%>" <%if(oAppIdeaOne.equals(retListone[i][0])){%>selected<%}%>><%=retListone[i][0]%>---><%=retListone[i][1]%></option>
		           <%	
				       }
			       %>	
				
		           <% }%>
			</select>
			<font class=red>*</font> 
		</td>
		<td class="blue">财务审批人员：</td>
		<td>
			<select v_must="1" id="approve_add" >
				
				 <%
			           if(retList.length>0){
			           for(int i=0;i<retList.length;i++){
				              
		           %>
		               <option value="<%=retList[i][0]%>" <%if(oAppIdeaTwo.equals(retList[i][0])){%>selected<%}%>><%=retList[i][0]%>---><%=retList[i][1]%></option>
		           <%	
				          }
			         %>	
				
		           <% }%>
			</select>
			<font class=red>*</font> 
		</td>
	</tr>
    </table>
    <div id="operation_button">
    	<input type="button" class="b_foot" value="修改" onclick="ApproveCom()" />
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
