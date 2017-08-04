<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    //一键退费begin
	String tfhm = request.getParameter("tfhm"); 
	String ywsysjArrays= request.getParameter("ywsysjArrays");
	String ywmcArrays= request.getParameter("ywmcArrays");
	String ywdmArrays= request.getParameter("ywdmArrays");
	String fwtgsArrays= request.getParameter("fwtgsArrays");
	String qydmArrays= request.getParameter("qydmArrays");
	String fylxArrays= request.getParameter("fylxArrays");
	String fyArrays= request.getParameter("fyArrays");
	//首页选择的下拉框的值传进来 作为退费三级原因
	String s_tf_type = request.getParameter("s_tf_type");//退费三级原因
	String tsdzls = request.getParameter("tsdzls");//投诉电子流水

	//  退费流水号     补充退费业务名称
	String bctfywmc= request.getParameter("searchType1");
	String bctfyybz= request.getParameter("otherReason");
	String btje = request.getParameter("btje");
	String stze = request.getParameter("stze");//实退总额
	String s_ds_flag= request.getParameter("s_ds_flag");
	String tfzl= request.getParameter("tfzl");
	String hjlx= request.getParameter("hjlx");
	String jflx = request.getParameter("jflx");
	String hjsj = request.getParameter("hjsj");
	String tfnote = request.getParameter("tfnote");
	System.out.println("fffffaaaaaaaaasssssssssssssfffffffffffffffsssssssssssssssss ywmcArrays is "+ywmcArrays+" and fyArrays is "+fyArrays+" and s_ds_flag is "+s_ds_flag+" and tfzl is "+tfzl+" and hjlx is "+hjlx+" and tfnote is "+tfnote+" and bctfywmc is "+bctfywmc+" and bctfyybz is "+bctfyybz);
	if(btje=="" ||btje.equals(""))
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa 不用补充退费");
	}
	else
	{
		System.out.println("bbbbbbbbbbbbbbbbbbbbb 用补充退费");
	}
	String checkds = request.getParameter("checkds");//单双倍
	//end of 一键退费

	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zgaj";              //操作代码
	
	String work_no = (String)session.getAttribute("workNo"); 
	
	//work_no="800195";

	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[25];
	paraAray[0] = ywsysjArrays;  		    //业务使用时间
	paraAray[1] = ywmcArrays;  				//bizname
	paraAray[2] = ywdmArrays; 				//bizcode
	paraAray[3] = fwtgsArrays; 			    //spname
	paraAray[4] = qydmArrays;			    //spcode
	paraAray[5] = fyArrays; 			    //费用 单笔退费的金额 不用乘以单双倍啥的
	paraAray[6] = tfhm;			    //退费号码
	paraAray[7] = tsdzls;             //投诉电子流水
	paraAray[8] = tfzl;        //退费种类=退预存
	paraAray[9] = "1003";           //退费一级原因code 这个到底可不可以空 我感觉可以空 因为后续的查询都是用新配置表查询三级原因即可了
	paraAray[10] = "1006";          //退费二级原因code
	paraAray[11] = s_tf_type;           //退费三级原因code 配置到SREFUNDCheckType
	paraAray[12] = stze;	    //赔偿金额 即退费总金额 SYSTEM_PRICE
	paraAray[13] = tfnote;             //备注
	paraAray[14] = regionCode;  //地市代码
	paraAray[15] = org_Code;   //归属代码
	paraAray[16] = hjlx; 
	paraAray[17] = jflx; 
	paraAray[18] = hjsj; 
	paraAray[19] = s_ds_flag;//单倍双倍
	paraAray[20] = btje;	//补充退费 只输入补充退费金额和 选择补充退费业务名称就行了 
	paraAray[21] = bctfywmc;
	paraAray[22] = bctfyybz;//原因选择“其他”时 输入的值
	paraAray[23] = work_no;
	paraAray[24] = pass;
	//xl add for 单价 数量
	
	
	
%>
<wtc:service name="szgajCfm" routerKey="phone" routerValue="<%=tfhm%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
    <wtc:param value="<%=paraAray[11]%>"/>
    <wtc:param value="<%=paraAray[12]%>"/>
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>	
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=paraAray[17]%>"/>
    <wtc:param value="<%=paraAray[18]%>"/>
    <wtc:param value="<%=paraAray[19]%>"/>
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
	<wtc:param value="<%=paraAray[23]%>"/>
	<wtc:param value="<%=paraAray[24]%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("投诉退费业务处理成功！",2);
	window.location="zgaj_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("投诉退费业务处理失败: <%=retMsg%>,<%=retCode%>",0);
	window.location="zgaj_1.jsp";
	</script>
<%}
%>
		 



