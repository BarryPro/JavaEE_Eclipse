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
	String paynote = request.getParameter("paynote");
	String paySeq = request.getParameter("paySeq");
	String phoneno = request.getParameter("phoneno");
	String kphjje= request.getParameter("kphjje");
	String s_hjbhsje = request.getParameter("s_hjbhsje");
	String hjse = request.getParameter("hjse");
	String s_xmmc = request.getParameter("s_xmmc");
	String op_code = request.getParameter("opCode");

	String nopass = (String)session.getAttribute("password");
	String workNo = (String)session.getAttribute("workNo");
  
    String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	String id_no=WtcUtil.repNull(request.getParameter("id_no"));
	String sm_code = WtcUtil.repNull(request.getParameter("sm_code"));
	String xmdw = WtcUtil.repNull(request.getParameter("xmdw"));
	String ggxh = WtcUtil.repNull(request.getParameter("ggxh"));
	String xmsl = WtcUtil.repNull(request.getParameter("xmsl"));
	String xmdj = WtcUtil.repNull(request.getParameter("xmdj"));
	String hsbz = WtcUtil.repNull(request.getParameter("hsbz"));
	String sl = WtcUtil.repNull(request.getParameter("sl"));
	String se = WtcUtil.repNull(request.getParameter("se"));
	String chbz = WtcUtil.repNull(request.getParameter("chbz"));
	String old_accept = WtcUtil.repNull(request.getParameter("old_accept"));
	String old_ym = WtcUtil.repNull(request.getParameter("old_ym"));
	String contractno = WtcUtil.repNull(request.getParameter("contractno"));

	String returnPage =request.getParameter("returnPage");

 
    //路由
	String regionCode = org_code.substring(0,2);
	
	 

  
	String[] inPara_sj = new String[29];
	inPara_sj[0]=paySeq;
	inPara_sj[1]="01";
	inPara_sj[2]=op_code;
	inPara_sj[3]=workNo;
	inPara_sj[4]=nopass;
	inPara_sj[5]=phoneno;
	inPara_sj[6]="";
	inPara_sj[7]=paynote;
	inPara_sj[8]="";//操作时间
	inPara_sj[9]=id_no;
	inPara_sj[10]=sm_code;
	inPara_sj[11]="0";
	inPara_sj[12]="";
	inPara_sj[13]="";
	inPara_sj[14]=s_xmmc;
	inPara_sj[15]=xmdw;
	inPara_sj[16]=ggxh;
	inPara_sj[17]=xmsl;
	inPara_sj[18]=hsbz;
	inPara_sj[19]=xmdj;
	inPara_sj[20]=sl;
	inPara_sj[21]=se;//税率 税额 啥的得等hanfeng确认
	inPara_sj[22]=chbz;
	inPara_sj[23]=old_accept;
	inPara_sj[24]=old_ym;
	inPara_sj[25]=contractno;
	inPara_sj[26]=kphjje;//总金额
	inPara_sj[27]=s_hjbhsje;//税率 税额得确认
	inPara_sj[28]=hjse;
%>
<!--xl add 调用qidx取消发票预占的接口 因为打印收据也会预占一条记录 begin-->
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
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa bill_cancel is "+bill_cancel+" and bill_cancel.length is "+bill_cancel.length);
		//s_code=bill_cancel[0][1];//sql通过
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("取消打印成功");
					//alert("<%=returnPage%>");
					document.location.href="<%=returnPage%>";
				</script>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("取消打印失败!错误代码:"+"<%=sCodes%>"+",错误原因:"+"<%=sMsgs%>");
					document.location.href="<%=returnPage%>";
				</script>
			<%
		}	
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("服务调用异常！");
				document.location.href"<%=returnPage%>";
			</script>
		<%
	}
	%> 
 

	
 
