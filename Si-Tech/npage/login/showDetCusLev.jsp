<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-12 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
    String opName = "综合信息查询之客户经理信息";
  
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String idNo     = request.getParameter("idno");
	
	String work_no  = (String)session.getAttribute("workNo");
	String password  = (String)session.getAttribute("password");
	String phoneNo  = request.getParameter("phoneNo");
	String cust_name  = request.getParameter("custName");
	String custTypev     = request.getParameter("custTypev");
	System.out.println("----------custTypev---------------"+custTypev);
	
	
	String	sql_str = "select (a.service_no||'-->'||a.name) as sn,a.phone_no "
		+" from dbvipadm.dGrpManagermsg a,dbvipadm.dGrpBigUserMsg b " 
		+" where a.service_no=b.service_no and b.id_no =" + idNo;
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sql_str%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%	
	String bigCustAdmName = "未知";
	String bigCustAdmPhone = "未知";
	
	if(result!=null&&result.length>0){
		bigCustAdmName = result[0][0];
		bigCustAdmPhone = result[0][1];
	}

	sql_str="select a.service_no||'-->'||a.name,a.phone_no , b.unit_name, c.unit_id " +
				" from dbvipadm.dGrpManagermsg a ,dbvipadm.dGrpCustMsg b ,dbvipadm.dGrpMemberMsg c " +
				" where a.service_no=b.service_no " +
				" and b.unit_id=c.unit_id  and c.id_no = " + idNo;
				
	System.out.println("------sql_str----------"+sql_str);				
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=sql_str%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
	String groupCustAdmName = "未知";
	String groupCustAdmPhone = "未知";
	String groupId = "未知";
	String groupName = "未知";
	
	if(result1!=null&&result1.length>0){
		groupCustAdmName = result1[0][0];
		groupCustAdmPhone = result1[0][1];
		groupId = result1[0][2];
		groupName = result1[0][3];
	}
	
	 
	
	String currentCondition     = "";
	String currentConditionName = "";
	String cancelChannel        = ""; 
	String cancelChannelDate    = "";
	
	
%>
		<wtc:service name="s3066Query" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="" />	
			<wtc:param value="5556" />
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="0" />					
		</wtc:service>
		<wtc:array id="totalResult0" start="0" length="2" scope="end"/>
		<wtc:array id="totalResult"  start="2" length="5" scope="end"/>
		<wtc:array id="totalResult1"  start="7" length="1" scope="end"/>
<%

 
%>			
<HTML><HEAD><TITLE>客户经理信息</TITLE>
	
<script language="javascript">
	//add by hucw,添加短信发送功能
	function sendMsg(){
		var sendData = 'msg_content=您的客户级别:<%=custTypev%>\n集团经理:<%=groupCustAdmName%>\n集团电话:<%=groupCustAdmPhone%>\n'+
									'集团编号:<%=groupName%>\n集团名称:<%=groupId%>';
		
		sendData +="&user_phone=<%=phoneNo%>";
		$.ajax({
			url: '<%=request.getContextPath()%>/npage/callbosspage/K083/K083_msgSend_rpc4CallTrans.jsp',
			data: sendData,
			type:"POST", 
			dataType:"html",
			success: function(data){
				if(data.trim() =="1"){
					rdShowMessageDialog("发送成功！",2);
					//window.top.top.opener.similarMSNPop("发送成功！");
				}else{
					rdShowMessageDialog("发送失败！",0);
					//window.top.top.opener.similarMSNPop("发送失败！");
				}
			}
		});
	}
			
	function doProcess(packet){
		var retCode = packet.data.findValueByName("scucc_flag");
		if(retCode=="1"){
		 rdShowMessageDialog("发送成功！",2); 
		 document.getElementById('user_phone').value="";   
		}else if(retCode=="0"){
			rdShowMessageDialog("发送失败！");    
		}
	}
	</script>
</HEAD>
<body>

<FORM method=post name="f1500_dCustDocInAdd">
	<%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">客户经理信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;客户名称:<%=cust_name%></div>
		</div>
	    <TABLE cellSpacing="0">
	      <TBODY>
	        <TR>
	          <TD class="blue">服务号码</TD>
	          <td>
	          	<input class="InputGrey" value="<%=phoneNo%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">客户级别</TD>
	          <td>
	          	<input class="InputGrey"  maxlength="25" size=25 value="<%=custTypev%>" readonly>
	          </TD>
	        </TR>                
	        <TR>
	          <TD class="blue">大客户经理</TD>
	          <TD>
	          	<input class="InputGrey" value="<%=bigCustAdmName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">联系电话</TD>
	          <td>
	          	<input class="InputGrey" value="<%=bigCustAdmPhone%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        
	        <!--luxc20070320 add -->
	        <TR>
	          <TD class="blue">集团客户经理</td>
	          <td>
	          	<input class="InputGrey" value="<%=groupCustAdmName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">联系电话</td>
	          <td>
	          	<input class="InputGrey"  value="<%=groupCustAdmPhone%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        <!--luxc20070320 end -->
	        
	        <TR>
	          <TD class="blue">集团编号</td>
	          <td>
	          	<input class="InputGrey" id="orgCode" value="<%=groupName%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">集团名称</td>
	          <td>
	          	<input class="InputGrey" id="orgName" value="<%=groupId%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
			<!--
	        <TR>
	          <TD class="blue">当前状态</td>
	          <td>
	          	<input class="InputGrey" id="currentCondition" value="<%=currentCondition%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">当前状态名称</td>
	          <td>
	          	<input class="InputGrey" id="currentConditionName" value="<%=currentConditionName%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        
	         <TR>
	          <TD class="blue">开通/取消渠道</td>
	          <td>
	          	<input class="InputGrey" id="cancelChannel " value="<%=cancelChannel%>" maxlength="25" size=25 readonly>
	          </TD>
	          <TD class="blue">开通/取消时间</td>
	          <td>
	          	<input class="InputGrey" id="cancelChannelDate" value="<%=cancelChannelDate%>" maxlength="25" size=25 readonly>
	          </TD>
	        </TR>
	        -->
	        
	      </TBODY>
	    </TABLE>
	    <div class="title">
			<div id="title_zi">彩铃信息</div>
		</div>
   <table cellspacing="0">
      <tr align="center"> 
        <th>彩铃类型</th>
				<th>彩铃套餐</th>
				<th>当前是否有效</th>
				<th>彩铃产品开始时间</th>
				<th>彩铃产品结束时间</th>
			 </tr>
<%
		int iretCode=Integer.parseInt(retCode1);
        String test[][] = totalResult;

        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
	if (iretCode != 0 && iretCode != 306602) {
 
	}else{ 
			if( iretCode == 306602) 
			{
				totalResult = new String [1][8];
				totalResult[0][2] = "彩铃信息";
				totalResult[0][3] = "该用户不是彩铃用户";
				totalResult[0][4] = "";
				totalResult[0][5] = "";
				totalResult[0][6] = "";
				totalResult[0][7] = "0";
			}
            			
					      for (int i=0;i<totalResult.length; i++) {
					      	if(totalResult[i][0]!=null&&(!"".equals(totalResult[i][0]))){
					  %>
                <tr> 
                  <td width="20%" nowrap><%=totalResult[i][0]%>&nbsp;</td>
		  						<td width="20%" nowrap><%=totalResult[i][1]%>&nbsp;</td>
		  						<td width="20%" nowrap>
					  <%
					  	  if("Y".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("当前有效");
					  	  }
					  	  else if("N".equals(totalResult[i][2]))
					  	  {
					  	  	out.print("预约生效");
					  	  }
					  %>
					  			&nbsp;
                 </td>
					  		 <td width="20%" nowrap><%=totalResult[i][3]%>&nbsp;</td>
					  		 <td width="20%" nowrap><%=totalResult[i][4]%>&nbsp;</td>
					  	</tr>
					  <% }} %>
					    <tr>
					    	<td>彩铃秀信息</td>
					    	<td colspan="4" nowrap>
					  <%
					  	  if("0".equals(totalResult1[0][0])){
					  	  	out.print("该用户不是彩铃秀用户");
					  	  }else if("1".equals(totalResult1[0][0])){
					  	  	out.print("该用户是彩铃秀用户");
					  	  }
					  %>
                &nbsp;
                </td>
					    </tr>
           </table>
<% } %>




      <table cellspacing=0>
          <tr> 
      	    <td id="footer">
      	    	&nbsp; <input class="b_foot" name="back" onClick="sendMsg()" type="button" value="短信发送">
      	    	&nbsp;&nbsp;&nbsp&nbsp;
	    	      &nbsp; <input class="b_foot" name="back" onClick="window.close()" type="button" value=关闭>
	    	      &nbsp; 
	    	    </td>
          </tr>
      </table>
      <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>
