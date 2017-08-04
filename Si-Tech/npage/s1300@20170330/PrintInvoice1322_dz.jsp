<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-19 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String printNote = "0";
	String groupId = (String)session.getAttribute("groupId");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
	int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }
    //路由
	String regionCode = org_code.substring(0,2);
	 String s_kpxm = request.getParameter("s_kpxm");
	String s_ghmfc  = request.getParameter("s_ghmfc");
	String s_jsheje  = request.getParameter("s_jsheje");
 
 
	String s_hsbz = request.getParameter("s_hsbz");
 
	String s_xmje  = request.getParameter("s_xmje");
 
    System.out.println("ffffffffffffffffffffffffffff test dzfp s_kpxm is "+s_kpxm);
	String payaccept = WtcUtil.repNull(request.getParameter("payaccept"));
	String op_code= WtcUtil.repNull(request.getParameter("op_code"));
	String phone_no= WtcUtil.repNull(request.getParameter("phone_no"));
	String pay_note= WtcUtil.repNull(request.getParameter("pay_note"));
	String id_no= WtcUtil.repNull(request.getParameter("id_no"));
	String sm_code= WtcUtil.repNull(request.getParameter("sm_code"));
	String s_xmmc= WtcUtil.repNull(request.getParameter("s_xmmc"));
	String xmdw= WtcUtil.repNull(request.getParameter("xmdw"));
	String s_ggxh= WtcUtil.repNull(request.getParameter("s_ggxh"));
	String xmsl= WtcUtil.repNull(request.getParameter("xmsl"));
	String hsbz= WtcUtil.repNull(request.getParameter("s_hsbz"));
	String s_xmdj= WtcUtil.repNull(request.getParameter("s_xmdj"));
	String s_sl= WtcUtil.repNull(request.getParameter("s_sl"));
	String s_se= WtcUtil.repNull(request.getParameter("s_se"));
	String chbz= WtcUtil.repNull(request.getParameter("chbz"));
	String old_accept= WtcUtil.repNull(request.getParameter("old_accept"));
	String old_ym= WtcUtil.repNull(request.getParameter("old_ym"));
	String contract_no= WtcUtil.repNull(request.getParameter("contract_no"));
	String kphjje= WtcUtil.repNull(request.getParameter("kphjje"));
	String hjbhsje= WtcUtil.repNull(request.getParameter("hjbhsje"));
	String hjse= WtcUtil.repNull(request.getParameter("hjse"));
	String contractno =  WtcUtil.repNull(request.getParameter("contractno"));
	String returnPage = WtcUtil.repNull(request.getParameter("returnPage"));
	System.out.println("returnPage=="+returnPage);
	String[] inPara_sj = new String[29];

	String s_e_accept="";
	String s_dz_fphm="";
	String s_dz_fpdm="";

	String file_name="testtes1";//写死的
	inPara_sj[0]=payaccept;
	inPara_sj[1]="01";
	inPara_sj[2]=op_code;
	inPara_sj[3]=workNo;
	inPara_sj[4]=nopass;
	inPara_sj[5]=phone_no;
	inPara_sj[6]="";
	inPara_sj[7]=pay_note;
	inPara_sj[8]="";//操作时间
	inPara_sj[9]=id_no;
	inPara_sj[10]=sm_code;
	inPara_sj[11]="e";
	inPara_sj[12]="";
	inPara_sj[13]="";
	inPara_sj[14]=s_xmmc;
	inPara_sj[15]=xmdw;
	inPara_sj[16]=s_ggxh;
	inPara_sj[17]=xmsl;
	inPara_sj[18]=hsbz;
	inPara_sj[19]=s_xmdj;
	inPara_sj[20]=s_sl;
	inPara_sj[21]=s_se;//税率 税额 啥的得等hanfeng确认
	inPara_sj[22]=chbz;
	inPara_sj[23]=old_accept;
	inPara_sj[24]=old_ym;
	inPara_sj[25]=contractno;
	inPara_sj[26]=kphjje;
	inPara_sj[27]=hjbhsje;//税率 税额得确认
	inPara_sj[28]=hjse;
	
	String grp_phone_nos[]=request.getParameterValues("grp_phone_no_new"); 
	String grp_contract_nos[]=request.getParameterValues("grp_contract_no"); 
	String s_moneys[]=request.getParameterValues("s_money"); 
	
	String u_id = request.getParameter("u_id");
	String u_name = request.getParameter("u_name");
	String invoice_number = request.getParameter("invoice_number");
	String invoice_code = request.getParameter("invoice_code");
	String work_no = (String)session.getAttribute("workNo");
	 
	String grp_phone_no="";
	String grp_contract_no="";
	String s_money="";
	String s_sum1 = request.getParameter("s_sum1");
	String items = request.getParameter("items");

	String login_accept = request.getParameter("payaccept");
	String begin_ym = request.getParameter("begin_ym");
	String end_ym = request.getParameter("end_ym");
	//xl add 数组取流水
	String invoice_accept_Arrays[]=request.getParameterValues("s_accepts"); 
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa invoice_accept_Arrays is "+invoice_accept_Arrays);
	String s_invoice_accept="";
	for(int i =0;i<grp_phone_nos.length;i++)
	{
		grp_phone_no+=grp_phone_nos[i];
		grp_contract_no+=grp_contract_nos[i];
		s_money+=s_moneys[i];
		s_invoice_accept+=invoice_accept_Arrays[i];
	}

%>
<wtc:service name="s1322InDB" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes1" retmsg="sMsgs1" outnum="3" >
    <wtc:param value="<%=u_id%>"/>
    <wtc:param value="<%=u_name%>"/> 
	<wtc:param value="<%=work_no%>"/> 
	<wtc:param value="<%=grp_phone_no%>"/> 
	<wtc:param value="<%=grp_contract_no%>"/>
	<wtc:param value="<%=s_money%>"/>
	<wtc:param value="1322"/>
	<wtc:param value="0"/>
	<wtc:param value="0"/>
	<wtc:param value="<%=items%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=begin_ym%>"/>
	<wtc:param value="<%=end_ym%>"/>
	<wtc:param value="<%=s_invoice_accept%>"/>
	<wtc:param value="<%=s_sum1%>"/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=login_accept%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="e"/>
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode1= sCodes1;
	String retMsg1 = sMsgs1;
    if ( sCodes1.equals("000000")  )
	{
		%>
		<wtc:service name="bs_sEInvIssue" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes" retmsg="sMsgs" outnum="6"  >
		<wtc:param value="<%=inPara_sj[0]%>"/>
		<wtc:param value="<%=inPara_sj[1]%>"/>
		<wtc:param value="<%=inPara_sj[2]%>"/>
		<wtc:param value="<%=inPara_sj[3]%>"/>
		<wtc:param value="<%=inPara_sj[4]%>"/>
		<wtc:param value="<%=inPara_sj[5]%>"/>
		<wtc:param value="<%=inPara_sj[6]%>"/>
		<wtc:param value="<%=inPara_sj[7]%>"/>
		<wtc:param value="<%=inPara_sj[8]%>"/>
		<wtc:param value="<%=inPara_sj[9]%>"/>
		<wtc:param value="<%=inPara_sj[10]%>"/>
		<wtc:param value="<%=inPara_sj[11]%>"/>
		<wtc:param value="<%=inPara_sj[12]%>"/>
		<wtc:param value="<%=inPara_sj[13]%>"/>
		<wtc:param value="<%=inPara_sj[14]%>"/>
		<wtc:param value="<%=inPara_sj[15]%>"/>
		<wtc:param value="<%=inPara_sj[16]%>"/>
		<wtc:param value="<%=inPara_sj[17]%>"/>
		<wtc:param value="<%=inPara_sj[18]%>"/>
		<wtc:param value="<%=inPara_sj[19]%>"/>
		<wtc:param value="<%=inPara_sj[20]%>"/>
		<wtc:param value="<%=inPara_sj[21]%>"/>
		<wtc:param value="<%=inPara_sj[22]%>"/>
		<wtc:param value="<%=inPara_sj[23]%>"/>
		<wtc:param value="<%=inPara_sj[24]%>"/>
		<wtc:param value="<%=inPara_sj[25]%>"/>
		<wtc:param value="<%=inPara_sj[26]%>"/>
		<wtc:param value="<%=inPara_sj[27]%>"/>
		<wtc:param value="<%=inPara_sj[28]%>"/>
		<wtc:param value="<%=regionCode%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
<%
	//bill_cancel[0][0]="000000";
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			s_e_accept=bill_cancel[0][3];
			s_dz_fphm=bill_cancel[0][5];
			s_dz_fpdm=bill_cancel[0][4];
			//返回特殊retcode 或者000000 再调用取消的接口 都成功 才认为是成功 状态传e
			%>
			<wtc:service name="bs_sEInvCancel" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes" retmsg="sMsgs" outnum="2" >
				<wtc:param value="<%=inPara_sj[0]%>"/>
				<wtc:param value="<%=inPara_sj[1]%>"/>
				<wtc:param value="<%=inPara_sj[2]%>"/>
				<wtc:param value="<%=inPara_sj[3]%>"/>
				<wtc:param value="<%=inPara_sj[4]%>"/>
				<wtc:param value="<%=inPara_sj[5]%>"/>
				<wtc:param value="<%=inPara_sj[6]%>"/>
				<wtc:param value="<%=inPara_sj[7]%>"/>
				<wtc:param value="<%=inPara_sj[8]%>"/>
				<wtc:param value="<%=inPara_sj[9]%>"/>
				<wtc:param value="<%=inPara_sj[10]%>"/>
				<wtc:param value="<%=inPara_sj[11]%>"/>
				<wtc:param value="<%=s_dz_fphm%>"/>
				<wtc:param value="<%=s_dz_fpdm%>"/>
				<wtc:param value="<%=inPara_sj[14]%>"/>
				<wtc:param value="<%=inPara_sj[15]%>"/>
				<wtc:param value="<%=inPara_sj[16]%>"/>
				<wtc:param value="<%=inPara_sj[17]%>"/>
				<wtc:param value="<%=inPara_sj[18]%>"/>
				<wtc:param value="<%=inPara_sj[19]%>"/>
				<wtc:param value="<%=inPara_sj[20]%>"/>
				<wtc:param value="<%=inPara_sj[21]%>"/>
				<wtc:param value="<%=inPara_sj[22]%>"/>
				<wtc:param value="<%=inPara_sj[23]%>"/>
				<wtc:param value="<%=inPara_sj[24]%>"/>
				<wtc:param value="<%=inPara_sj[25]%>"/>
				<wtc:param value="<%=inPara_sj[26]%>"/>
				<wtc:param value="<%=inPara_sj[27]%>"/>
				<wtc:param value="<%=inPara_sj[28]%>"/>
				<wtc:param value="<%=s_e_accept%>"/>
			</wtc:service>
			<wtc:array id="qx_cancel" scope="end"/>
			<%
				if(qx_cancel!=null&&qx_cancel.length>0)
				{
					if(qx_cancel[0][0]=="000000" ||qx_cancel[0][0].equals("000000"))
					{
						//add for yanpx
						//returnPage="";
						if(returnPage.equals("")||returnPage.equals("null"))
						{
							%>	
								<script language="javascript">
									rdShowMessageDialog("电子发票开具成功11");
									removeCurrentTab();
								</script> 
							<%
						}
						else
						{
							%>	
								<script language="javascript">
									rdShowMessageDialog("电子发票开具成功22");
									document.location.replace("<%=returnPage%>");
								</script> 
							<%
						}
						
					}
				}
				else
				{
					%>	
						<script language="javascript">
							rdShowMessageDialog("电子发票取消调用失败!");
							document.location.replace("<%=returnPage%>");
						</script> 
					<%
				}
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("电子发票打印失败!错误代码:"+"<%=sCodes%>"+",错误原因:"+"<%=sMsgs%>");
					document.location.replace("<%=returnPage%>");
				</script>
			<%
		}	
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("服务调用异常！");
				document.location.replace("<%=returnPage%>");
			</script>
		<%
	}
%>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("1322服务调用异常！错误代码:"+"<%=sCodes1%>,错误原因:"+"<%=sMsgs1%>");
				document.location.replace("<%=returnPage%>");
			</script>
		<%
	}
%>
 

 
 

	
 
