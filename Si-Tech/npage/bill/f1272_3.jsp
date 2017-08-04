<%
    /********************
     version v2.0
     开发商: si-tech
     *
		 *update:zhanghonga@2008-08-27 页面改造,修改样式
		 *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    /*
    * 吉林BOSS-套餐实现－主资费变更  2003-10  
    * @author  ghostlin
    * @version 1.0
    * @since   JDK 1.4
    * Copyright (c) 2002-2003 si-tech All rights reserved.
    */
%>
<%
    /*
    * 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
            部分变量的命名依据对此变量使用的意义，或用途。
    */
%>
<HTML>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%
/*--------------------------------组织s1272Cfm的传入参数-------------------------------*/
    String thework_no = (String) session.getAttribute("workNo");                         //操作工号                  
    String psw = (String) session.getAttribute("password");                              //工号密码						 
    String theop_code = "1272";                                                          //操作代码					 
    String themob = WtcUtil.repNull(request.getParameter("i1"));                         //手机号码					 
    String do_string = WtcUtil.repNull(request.getParameter("kx_code_bunch"));           //操作命令串  1:申请 2:取消
    String addcash_string = WtcUtil.repNull(request.getParameter("kx_habitus_bunch"));   //可选套餐的代码串
    String ip = (String) session.getAttribute("ipAddr");                                 //登陆IP					 
    String favour = "a017";                                                              //优惠代码					 
    String realcash = WtcUtil.repNull(request.getParameter("i19"));                      //实际手续费				 
    String fircash = WtcUtil.repNull(request.getParameter("i20"));                       //固定手续费				 
    String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));                   //系统备注					 
    String donote = WtcUtil.repNull(request.getParameter("tonote"));                     //操作备注
    String stream = WtcUtil.repNull(request.getParameter("stream"));                     //系统流水
    String flag_string = WtcUtil.repNull(request.getParameter("kx_operation_bunch"));    //附加资费生效标志串
    String add_stream_str = WtcUtil.repNull(request.getParameter("kx_stream_bunch"));    //可选套餐的开通流水串
    float handcash = Float.parseFloat(realcash);                                         //手续费单精度
/*--------------------------------开始调用s1272Cfm--------------------------------*/
    String strHasEval = WtcUtil.repNull(request.getParameter("haseval"));                //是否有用户满意度评价 
    String strEvalCode = WtcUtil.repNull(request.getParameter("evalcode"));              //用户满意度评价代码 

    System.out.println("strHasEval=" + strHasEval);
    System.out.println("strEvalCode=" + strEvalCode);

%>
<%
		/************************************************************************
			@wt 服务名称：s1272Cfm
			@wt 编码时间：2003/11/24
			@wt 编码人员：wangtao
			@wt 功能描述：可选套餐变更的确认
			@wt 输入参数：
			@wt          0  操作工号            iLoginNo
			@wt          1  工号密码            iLoginPwd
			@wt          2  op_code             iOpCode
			@wt          3  移动号码            iPhoneNo
			@wt          4  可选套餐的代码串    iAddModeStr
			@wt          5  可选套餐的状态串    iAddChgStr
			@wt          6  可选套餐变更生效串    iAddSendStr
			@wt          7  优惠代码            iFavourCde
			@wt          8  实交手续费          iRealFee
			@wt          9  应交手续费          iShouldFee
			@wt          10 系统日志            iSysNote
			@wt          11 操作日志            iOpNote
			@wt          12 打印流水            iLoginAccept 
			@wt          13 登录IP              iIpAddr
			@wt          14 可选套餐的开通流水  iModeAcceptStr
			@wt 输出参数：0 返回代码
			@wt           1 返回信息
		************************************************************************/
    //retArray = callView.s1272CfmProcess(thework_no, psw, theop_code, themob,do_string, addcash_string,flag_string, favour, realcash,fircash, sysnote, donote, stream, ip, add_stream_str).getList();
%>

	<wtc:service name="s1272Cfm" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
	<wtc:param value="<%=thework_no%>"/>
	<wtc:param value="<%=psw%>"/>
	<wtc:param value="<%=theop_code%>"/>
	<wtc:param value="<%=themob%>"/>
	<wtc:param value="<%=do_string%>"/>
	<wtc:param value="<%=addcash_string%>"/>	
	<wtc:param value="<%=flag_string%>"/>
	<wtc:param value="<%=favour%>"/>
	<wtc:param value="<%=realcash%>"/>
	<wtc:param value="<%=fircash%>"/>
	<wtc:param value="<%=sysnote%>"/>
	<wtc:param value="<%=donote%>"/>
	<wtc:param value="<%=stream%>"/>
	<wtc:param value="<%=ip%>"/>
	<wtc:param value="<%=add_stream_str%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>		
<%
		String ret_code = "999999";
		String ret_msg  = "s1272Cfm服务未能成功";
		if(result!=null&&result.length>0){
		    ret_code = result[0][0];
    		ret_msg = result[0][1];
		}
		
		
		System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String cnttLoginAccept = stream;
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1272&retCodeForCntt="+ret_code+"&opName=可选资费变更&workNo="+thework_no+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+themob+"&opBeginTime="+opBeginTime+"&contactId="+themob+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%		
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
		
//对返回信息的控制
    if (ret_msg.equals("")) {
        ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
        if (ret_msg.equals("null")) {
            ret_msg = "未知错误信息";
        }
    }

//王良 2008年1月3日 修改增加用户满意度评价设置
    String[] ret = new String[]{};
    if (ret_code.equals("000000") && strHasEval.equals("1")) {
        String strParaAray[] = new String[6];
        strParaAray[0] = thework_no;     			//0  操作工号                iLoginNo  thework_no
        strParaAray[1] = theop_code;    	 		//1  操作代码                iOpCode   theop_code
        strParaAray[2] = themob;              //2  移动号码                iPhoneNo  themob                         
        strParaAray[3] = strEvalCode; 				//3  评价代码
        strParaAray[4] = stream;              //5  操作流水
        strParaAray[5] = "0";

        //ret = impl.callService("sCommEvalCfm", strParaAray, "2", "phone", themob);
%>

				<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=themob%>" outnum="2" >
				<wtc:param value="<%=strParaAray[0]%>"/>
				<wtc:param value="<%=strParaAray[1]%>"/>
				<wtc:param value="<%=strParaAray[2]%>"/>
				<wtc:param value="<%=strParaAray[3]%>"/>
				<wtc:param value="<%=strParaAray[4]%>"/>
				<wtc:param value="<%=strParaAray[5]%>"/>
				</wtc:service>
				<wtc:array id="result3" start="0" length="2" scope="end"/>		
				<wtc:array id="mainResultArr" start="2" length="13" scope="end"/>
<%
				int iReturnCode = 999999;
				if(retCode!=""){
					iReturnCode = Integer.parseInt(retCode);
				}
        String strReturnMsg = retMsg;

        System.out.println("iReturnCode=" + iReturnCode);
        System.out.println("strReturnMsg=" + strReturnMsg);
    }
    
    /*************************************获得打印发票的参数****************************************/
    String cardno = WtcUtil.repNull(request.getParameter("i7"));                        //身份证号码
    String name = WtcUtil.repNull(request.getParameter("i4"));                          //用户名称
    String address = WtcUtil.repNull(request.getParameter("i5"));                       //用户地址
		/***********************************************************************************************/
%>
<script language="jscript">
    function printBill() {
        var infoStr = "";
        infoStr += '<%=cardno%>' + "|";//身份证号码                                                  
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";//日期
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=themob%>' + "|";//移动号码                                                   
        infoStr += "" + "|";//合同号码                                                          
        infoStr += '<%=name%>' + "|";//用户名称                                                
        infoStr += '<%=address%>' + "|";//用户地址
        infoStr += "现金" + "|";
        infoStr += '<%=handcash%>' + "|";
        infoStr += "可选资费变更。*手续费：" + '<%=realcash%>' + "*流水号：" + '<%=stream%>' + "|";
        location = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=f1272_1.jsp&activePhone=<%=themob%>";
    }
</script>


<%if (ret_code.equals("000000") && handcash > 0.0) {%>
		<script language="jscript">
		    rdShowMessageDialog('可选资费变更操作成功！打印发票.......',2);
		    printBill();
		</script>
<%}%>

<%if (ret_code.equals("000000")) {%>
		<script language='jscript'>
		    rdShowMessageDialog('可选资费变更操作成功！',2);
		    history.go(-2);
		</script>
<%}%>


<%if (!ret_code.equals("000000")) {%>
<script language='jscript'>
    var ret_code = "<%=ret_code%>";
    var ret_msg = "<%=ret_msg%>";
    rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
    history.go(-1);
</script>
<%}%>



