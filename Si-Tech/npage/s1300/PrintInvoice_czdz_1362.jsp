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
	String s_loginaccept =  WtcUtil.repNull(request.getParameter("s_loginaccept"));
	String s_opCode =  WtcUtil.repNull(request.getParameter("s_opCode"));
	String s_old_ret_code="";
	String s_old_number = "";
	String s_old_code = "";
	String s_old_accept = "";
	//String s_qry_flag=WtcUtil.repNull(request.getParameter("s_qry_flag"));;//for yanpx 1=不用查询 2=需要调用接口查询
	s_old_number= WtcUtil.repNull(request.getParameter("s_old_number"));
	s_old_code= WtcUtil.repNull(request.getParameter("s_old_code"));
	s_old_accept= WtcUtil.repNull(request.getParameter("s_old_accept"));
	String total_date = WtcUtil.repNull(request.getParameter("total_date"));
	
	//查询pay_note begin
	String[] inParas = new String[4];
	inParas[0] = workNo;
    inParas[1] = contractno;
    inParas[2] = total_date;
    inParas[3] = payaccept;
	String s_pay_note="";
	%>
	<wtc:service name="s1300Print" routerKey="phone" routerValue="<%=phone_no%>" outnum="33" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<%
	if(result!=null&&result.length>0)
	{
		s_pay_note=result[0][11]+result[0][12]+result[0][13];
	}
	//end of pay_note

	System.out.println("eeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffffff s_old_number is "+s_old_number+" and s_old_code is "+s_old_code+" and s_old_accept is "+s_old_accept);
	String file_name="testtes1";//写死的
	inPara_sj[0]=payaccept;
	inPara_sj[1]="01";
	inPara_sj[2]=op_code;
	inPara_sj[3]=workNo;
	inPara_sj[4]=nopass;
	inPara_sj[5]=phone_no;
	inPara_sj[6]="";
	inPara_sj[7]=s_pay_note;
	inPara_sj[8]="";//操作时间
	inPara_sj[9]=id_no;
	inPara_sj[10]=sm_code;
	inPara_sj[11]="e";
	inPara_sj[12]=s_old_code;
	inPara_sj[13]=s_old_number;
	inPara_sj[14]=s_xmmc;
	inPara_sj[15]=xmdw;
	inPara_sj[16]=s_ggxh;
	inPara_sj[17]=xmsl;
	inPara_sj[18]=hsbz;
	inPara_sj[19]=s_xmdj;
	inPara_sj[20]=s_sl;
	inPara_sj[21]=s_se;//税率 税额 啥的得等hanfeng确认
	inPara_sj[22]=chbz;
	//inPara_sj[22]="0";
	inPara_sj[23]=old_accept;
	inPara_sj[24]=old_ym;
	inPara_sj[25]=contractno;
	inPara_sj[26]=kphjje;
	inPara_sj[27]=hjbhsje;//税率 税额得确认
	inPara_sj[28]=hjse;
	
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
		<wtc:param value="<%=org_code%>"/>
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
			System.out.println("ffffffffffffffaaaaaaaaaaaaaaaaaaaaaaaa test here add s_e_accept is "+s_e_accept+" and s_dz_fphm is "+s_dz_fphm+" and s_dz_fpdm is "+s_dz_fpdm);
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
									rdShowMessageDialog("电子发票开具成功");
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

 
 

	
 
