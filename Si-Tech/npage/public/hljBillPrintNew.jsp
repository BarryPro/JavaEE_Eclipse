<%
/********************
 *开发商: si-tech
 *铁通发票
 *create by ningtn @ 20111026
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
System.out.println("===================== ningtn hljBillPrintNew.jsp ====");
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		//liujian 2012-8-17 13:51:18 增加发票编号
		String sql_select_bill = "select to_char(S_INVOICE_NUMBER) ,flag from WLOGININVOICE where LOGIN_NO = :workNo";
		String srv_params_bill = "workNo=" + work_no_bill;
		
		String bill_number = "";
		String printLogoFlag = "";
		
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_bill%>"  
			retcode="retBillNumCode" retmsg="retBillNumMsg" outnum="2">
		<wtc:param value="<%=sql_select_bill%>"/>
		<wtc:param value="<%=srv_params_bill%>"/>
	</wtc:service>
	<wtc:array id="billNumRst" scope="end" />
<%
	if(billNumRst.length>0) {
		bill_number = billNumRst[0][0];
		printLogoFlag = billNumRst[0][1];
%>
		<script>
			var wlHref = window.location.href;
			wlHref = wlHref.replace('hljBillPrintNew.jsp','hljBillPrintNew2.jsp');
			if(rdShowConfirmDialog('发票号码是<%=billNumRst[0][0]%>，是否打印收据？')==1){
				location = wlHref + '&bill_number=<%=bill_number%>&printLogoFlag=<%=printLogoFlag%>' ;
			}else {
				if(parent.g_activateTab == undefined){
					var l_activateTab = "";
					var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
					for(var i=0; i<lis.length; i++){
						if(lis[i].className == "current"){
							l_activateTab = lis[i].id;
							break;		        
						} 
					}
					parent.removeTab(l_activateTab);
			     }else{
					parent.removeTab(parent.g_activateTab); 
			     }
			}
			
			
			
		</script>
<%			
	}else {
%>
		<script>
			alert("获取发票号码失败！");
			if(parent.g_activateTab == undefined){
				var l_activateTab = "";
				var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
				for(var i=0; i<lis.length; i++){
					if(lis[i].className == "current"){
						l_activateTab = lis[i].id;
						break;		        
					} 
				}
				parent.removeTab(l_activateTab);
		     }else{
				parent.removeTab(parent.g_activateTab); 
		     }
		</script>
<%
	}
%>	

