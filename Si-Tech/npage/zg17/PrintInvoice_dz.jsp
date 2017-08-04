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
	String dyzq = request.getParameter("dyzq");
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
	
	//调用 zg17Cfm beign
	String s_time= request.getParameter("s_time");
	String print_begin= request.getParameter("print_begin");//账务年月
	String invoice_money= request.getParameter("invoice_money");//发票打印金额
	String hytcf = request.getParameter("hytcf"); //合约套餐费
	String paraAray[] = new String[17]; 
	paraAray[0] = payaccept;
	paraAray[1] = "01";
	paraAray[2] = "zg17";
	paraAray[3] = workNo;
	paraAray[4] = nopass;
	paraAray[5] = phone_no;
	paraAray[6] = "";
	paraAray[7] = "月结账单打印";
	paraAray[8] = s_time;  
	paraAray[9] = print_begin;  
	paraAray[10] = invoice_money;  
	paraAray[11] = ""; 
	paraAray[12] = ""; 
    paraAray[13] = ""; 
	paraAray[14] = ""; 
	paraAray[15] = hytcf;
	paraAray[16] = "e";//新增的状态
	//end of zg17cfm
	
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
	inPara_sj[18]=hsbz;//duo
	inPara_sj[19]=s_xmdj;//多组
	inPara_sj[20]=s_sl;//duo
	inPara_sj[21]=s_se;//duo 税率 税额 啥的得等hanfeng确认
	inPara_sj[22]=chbz;
	inPara_sj[23]=old_accept;
	inPara_sj[24]=old_ym;
	inPara_sj[25]=contractno;
	inPara_sj[26]=kphjje;
	inPara_sj[27]=hjbhsje;//税率 税额得确认
	inPara_sj[28]=hjse;
	System.out.println("fffffffffffffffffffffffffffffffffffffffffffffffffff test inPara_sj[14] is "+inPara_sj[14]);
	//1.bs_sEInvIssue 成功后调用bs_sEInvCancel
	//2.bs_sEInvCancel 成功后调用bs_zg17Cfm
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
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			s_e_accept=bill_cancel[0][3];
			s_dz_fphm=bill_cancel[0][5];
			s_dz_fpdm=bill_cancel[0][4];
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
					<wtc:param value="<%=s_dz_fpdm%>"/>
					<wtc:param value="<%=s_dz_fphm%>"/>
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
				if(qx_cancel[0][0]=="000000" ||qx_cancel[0][0].equals("000000"))
				{
					%>
					<wtc:service name="bs_zg17Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode2" retmsg="sMsg2" outnum="2" >
						<wtc:param value="<%=paraAray[0]%>"/>
						<wtc:param value="<%=paraAray[1]%>"/> 
						<wtc:param value="<%=paraAray[2]%>"/>
						<wtc:param value="<%=paraAray[3]%>"/>
						<wtc:param value="<%=paraAray[4]%>"/>
						<wtc:param value="<%=paraAray[5]%>"/>
						<wtc:param value="<%=paraAray[6]%>"/>
						<wtc:param value="<%=paraAray[7]%>"/>
						<wtc:param value="<%=paraAray[8]%>"/>
						<wtc:param value="<%=paraAray[9]%>"/>
						<wtc:param value="<%=paraAray[10]%>"/>
						<wtc:param value="<%=s_dz_fphm%>"/>
						<wtc:param value="<%=s_dz_fpdm%>"/>
						<wtc:param value="<%=paraAray[13]%>"/>
						<wtc:param value="<%=paraAray[14]%>"/>
						<wtc:param value="<%=paraAray[15]%>"/>
						<wtc:param value="e"/><!--xl add for xuxz 增加入参 1=纸质 e=电子-->
					</wtc:service>
					<wtc:array id="sArr" scope="end"/>
					<%
					String retCode2= sCode2;
					String retMsg2 = sMsg2;
					String return_code=sCode2;
					if (return_code.equals("000000")||return_code=="000000")
					{
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
					else
					{
						%>
							<script language="javascript">
								rdShowMessageDialog("电子发票打印失败!错误代码:"+"<%=return_code%>"+",错误原因:"+"<%=retMsg2%>");
								document.location.replace("<%=returnPage%>");
								
							</script>
						<%
					}	
				}
				else
				{
					%>
						<script language="javascript">
							rdShowMessageDialog("电子发票取消调用失败!错误代码:"+"<%=qx_cancel[0][0]%>");
							document.location.replace("<%=returnPage%>");
						</script>
					<%
					//qx !000000 
				}
		}
		else
		{
			//bill_cancel !000000 bs_sEInvIssue
			%>
				<script language="javascript">
					rdShowMessageDialog("bs_sEInvIssue接口调用失败!错误代码:"+"<%=bill_cancel[0][0]%>");
					document.location.replace("<%=returnPage%>");
				</script>
			<%
		}
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("bs_sEInvIssue接口调用异常!");
				document.location.replace("<%=returnPage%>");
			</script>
		<%
	}
%>






 



 
 

	
 
