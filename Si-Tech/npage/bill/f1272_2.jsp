<%
    /********************
     version v2.0
     开发商: si-tech
     *
		 *update:zhanghonga@2008-08-26 页面改造,修改样式
		 *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    /*
    * 吉林BOSS-套餐实现－可选资费变更  2003-10  
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

<%
	String opCode = "1272";
	String opName = "可选资费变更";
			
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String kf_workno = (String)session.getAttribute("workNo");//获得客服工号
	String kf_PhoneNo = (String)session.getAttribute("userPhoneNo");//获得客服手机号码
	String hdword_no = (String)session.getAttribute("workNo");//工号
	String workNo = (String)session.getAttribute("workNo");
	String phone = WtcUtil.repNull(request.getParameter("i1"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String loginNote = "";
	String sqlStr2 = "select back_char1 from snotecode where region_code='" + regionCode + "' and op_code='XXXX'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
<%
    for (int i = 0; i < result2.length; i++) {
        loginNote = (result2[i][0]).trim();
    }
    loginNote = loginNote.replaceAll("\"", "");
    loginNote = loginNote.replaceAll("\'", "");
    loginNote = loginNote.replaceAll("\r\n", "   ");
    loginNote = loginNote.replaceAll("\r", "   ");
    loginNote = loginNote.replaceAll("\n", "   ");
%>
<%
    String do_note = WtcUtil.repNull(request.getParameter("i222"));
    String work_no = hdword_no;                                    //获得工号信息
    String op = "1272";
    String ret_code = "";
    String ret_msg = "";
    String rowNum = "16";
    String thepassword = WtcUtil.repNull(request.getParameter("i2"));         //获得传来的加密密码
    String pw_favor = WtcUtil.repNull(request.getParameter("pw_favor"));             //密码优惠权限标志位1:有0:
    String getselect = WtcUtil.repNull(request.getParameter("select1"));
    String i1 = "";
    String i2 = "";
    String i3 = "";
    String i4 = "";
    String i5 = "";
    String i6 = "";
    String i7 = "";
    String i8 = "";
    String i9 = "";
    String i10 = "";
    String i11 = "";
    String i12 = "";
    String i13 = "";
    String i14 = "";
    String i15 = "";
    String i16 = "";
    String i17 = "";
    String i18 = "";
    String i19 = "";
    String i20 = "";
    String i21 = "";
    String i22 = "";
    String i23 = "";
    String i24 = "";
    String i25 = "";
    String i26 = "";
    String i27 = "";
    String i28 = "";
    String i29 = "";
    String i30 = "";
    String subi20 = "";
    String disCode = "";
    String ibig_cust_ls = "";
    
    String loginPswInput = (String)session.getAttribute("password");
%>
	<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=phone%>"  outnum="32" >
	<wtc:param value=""/>
  <wtc:param value="01"/>
  <wtc:param value="<%=op%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=loginPswInput%>"/>
	<wtc:param value="<%=phone%>"/>
	<wtc:param value="<%=thepassword%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    //retArray = callView.s1270GetMsgProcess(work_no, phone, op, thepassword).getList();
		if(result!=null&&result.length>0){
	    ret_code = result[0][0];          // 返回代码                                 
	    ret_msg = result[0][1];              // 提示信息  
	    //对返回信息的控制
	    if (ret_msg.equals("")) {
	        ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
	        if (ret_msg.equals("null")) {
	            ret_msg = "未知错误信息";
	        }
	    }
	    i2 = result[0][2];                  // 用户ID          						  
	    i3 = result[0][3];                  // 客户密码        						  
	    i4 = result[0][4];                  // 客户名称        						  
	    i5 = result[0][5];                  // 客户地址        						  
	    i6 = result[0][6];                  // 客户证件类型名称 						  
	    i7 = result[0][7];                  // 客户证件号码     						  
	    i8 = result[0][8];                  // 业务品牌        						  
	    i9 = result[0][9];                  // 业务品牌名称     						  
	    i10 = result[0][10];              // 用户运行状态     						  
	    i11 = result[0][11];              // 用户运行状态名称 						  
	    i12 = result[0][12];              // 总欠费          						  
	    i13 = result[0][13];              // 总预存款        						  
	    i14 = result[0][14];              // 第一欠费帐号     						  
	    i15 = result[0][15];              // 第一欠费        						  
	    i16 = result[0][16];              // 当前主套餐代码       					  
	    i17 = result[0][17];              // 当前主套餐名称     					  
	    i18 = result[0][18];              // 当前主套餐开通流水 					  
	    i19 = result[0][19];              // 手续费          						  
	    i20 = result[0][20];              // belong_code  							  
	    i21 = result[0][21];              //大客户类型								  
	    i22 = result[0][22];              //大客户类型名称							  
	    i23 = result[0][23];              // 手续费优惠代码        					  
	    i24 = result[0][24];              // 集团客户类别           				  
	    i25 = result[0][25];              // 集团客户类别名称 						  
	    i26 = result[0][26];              // 下月主资费            oNextMode       	  
	    i27 = result[0][27];              // 下月主资费名称        oNextModeName   	  
	    i28 = result[0][28];              // 下月主资费开通流水    oNextModeAccept 	
		}      
    ibig_cust_ls = i21 + " " + i22;   //大客户类型名称页面显示
    if(i20.length()>=3){
		    subi20 = i20.substring(0, 2);
		    disCode = i20.substring(2, 4);
    }
    System.out.println("#############here is right");
    /****得到打印流水****/
    String printAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="workno"  routerValue="<%=workNo%>" id="sLoginAccept"/>
<%
    printAccept = sLoginAccept;

/*****
    //在此对用户密码进行判断
    if (pw_favor.equals("0"))//"0"说明无密码优惠权限,需要输入密码,"1"有密码优惠权限则不判断
    {
        //out.println("无密码优惠权限");
        thepassword = Encrypt.encrypt(thepassword);                //在此对用户传来的密码进行加密
        //out.println(thepassword);
        if (0 == Encrypt.checkpwd2(i3.trim(), thepassword.trim())) {                //比较用户传来加密的密码和服务取出加密的密码是否相同
					//如果密码不正确.dosomething
        }
    }
*****/

    if (!ret_code.equals("000000")) {%>
				<script language='jscript'>
				    var ret_code = "<%=ret_code%>";
				    var ret_msg = "<%=ret_msg%>";
				    rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
				    parent.removeTab("<%=opCode%>");
				</script>
	<%
			return;
		}
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>可选资费变更</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<script language="javascript">
	<!--
		 /*****读取页面时*****/
			onload = function(){
			    for (var i = 1; i < document.all.checkId.length; i++){
			        if (document.all.R11[i].value == "b"){
			            rdShowMessageDialog("‘" + document.all.R0[i].value + "’因生效时间与历史时间冲突而不可申请导致此次操作失败！");
			        }
			    }
			}
	
		/*******打开可选套餐类别*******/
		function openwindow(theNo, p, q) {
			var token = "|";
	    //定义窗口参数
	    var h = 600;
	    var w = 720;
	    var t = screen.availHeight - h - 20;
	    var l = screen.availWidth / 2 - w / 2;
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
	    var belong_code = document.all.belong_code.value;
	    var maincash_no = document.all.maincash_no.value;
	    var cust_id = document.all.i2.value;
	    var minopen = "";// document.all.oMinOpen[theNo].value;
	    var maxopen = ""; //document.all.oMaxOpen[theNo].value;
	    if (typeof(document.all.oMinOpen.length) != "undefined") {
	        minopen = document.all.oMinOpen[theNo].value;
	        maxopen = document.all.oMaxOpen[theNo].value;
	    } else {
	        minopen = document.all.oMinOpen.value;
	        maxopen = document.all.oMaxOpen.value;
	    }
	    var ret_msg = window.showModalDialog("f1272_6.jsp?mode_type=" + p + "&belong_code=" + belong_code + "&maincash_no=" + codeChg(maincash_no) + "&cust_id=" + cust_id + "&mode_name=" + q + "&minopen=" + minopen + "&maxopen=" + maxopen, "", prop);
	    //var ret_code = "";
	    //window.open("f1272_6.jsp?mode_type=" + p + "&belong_code=" + belong_code + "&maincash_no=" + codeChg(maincash_no) + "&cust_id=" + cust_id + "&mode_name=" + q + "&minopen=" + minopen + "&maxopen=" + maxopen, "", prop);
	    var srcStr = ret_msg;
	
	    if (ret_msg == null) {
	        return false;
	    }
	    if (typeof(srcStr) != "undefined") {
	        tohidden(p);
	        getStr(srcStr, token);
	    }
	    return true;
	}	
	
	/***其他函数中要用到的过滤函数**/
	function codeChg(s)
	{
	  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
	  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
	  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
	  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
	  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23").replace(/\\/g, "%2C"); // , . # \
	  return str;
	}
	
		function tohidden(s)// s 表示 套餐类型，从openwindow 传入
	{
	    var tmpTr = "";
	    for (var a = document.all('tr').rows.length - 2; a > 0; a--) {//删除从tr1开始，为第三行
	        if (document.all.R8[a].value == s && document.all.R1[a].value == "N") {
	            if (document.all.R11[a].value.trim() == "0" || document.all.R11[a].value.trim() == "c") {//choice_flag0或c删除
	                document.all.tr.deleteRow(a + 1);
	            }
	        }
	    }
	    return true;
	}

	/***先获取数据,再动态插入数据**/
	function getStr(srcStr, token) {
    var field_num = 13;
    var i = 0;
    var inString = srcStr;
    var retInfo = "";
    var tmpPos = 0;
    var chPos;
    var valueStr;
    var retValue = "";

    var a0 = "";
    var a1 = "";
    var a2 = "";
    var a3 = "";
    var a4 = "";
    var a5 = "";
    var a6 = "";
    var a7 = "";
    var a8 = "";
    var a9 = "";
    var a10 = "";
    var a11 = "";
    var a12 = "";
    var a1Tmp = "";

    retInfo = inString;
    chPos = retInfo.indexOf(token);
    while (chPos > -1)
    {
        for (i = 0; i < field_num; i++)
        {
            valueStr = retInfo.substring(0, chPos);

            if (i == 0) a0 = valueStr;
            if (i == 1) a1 = valueStr;
            if (a1 == "Y")a1Tmp = "已开通";
            if (a1 == "N")a1Tmp = "未开通";
            if (i == 2) a2 = valueStr;
            if (i == 3) a3 = valueStr;
            if (i == 4) a4 = valueStr;
            if (i == 5) a5 = valueStr;
            if (i == 6) a6 = valueStr;
            if (i == 7) a7 = valueStr;
            if (i == 8) a8 = valueStr;
            if (i == 9) a9 = valueStr;
            if (i == 10) a10 = valueStr;
            if (i == 11) a11 = valueStr;
            if (i == 12) a12 = valueStr;
            retInfo = retInfo.substring(chPos + 1);
            chPos = retInfo.indexOf(token);
            if (!(chPos > -1)) break;
        }
        insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp);
    	}
		}

		/***动态插入表格***/
		var dynTbIndex = 0;
		var token = "|";
		function insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp)
		{
		    var tr1 = tr.insertRow();
		    tr1.id = "tr" + dynTbIndex;
		    var divid = "div"+ dynTbIndex;
			td1 = tr1.insertCell();
			td2 = tr1.insertCell();
			td3 = tr1.insertCell();
			td4 = tr1.insertCell();
			td5 = tr1.insertCell();
			td6 = tr1.insertCell();
			td7 = tr1.insertCell();
			td8 = tr1.insertCell();
			td2.id="div"+dynTbIndex;		    
		    td1.innerHTML = '<div align="center"><input type="checkbox" name="checkId" checked></input></div>';
		    td2.innerHTML = '<div align="center"><a Href="#"  onClick="openhref(' + "'" + a7 + "'" + ')"><font color="#0000FF">' + a0 + '</a><input id=R0 type=hidden value=' + a0 + ' class=button size=10 readonly></input></div>';
		    td3.innerHTML = '<div align="center">' + a1Tmp + '<input id=R1 type=hidden value=' + a1 + ' class=button size=10 readonly></input></div>';
		    td4.innerHTML = '<div align="center">' + a2 + '<input id=R2 type=hidden value=' + a2 + ' class=button size=18 readonly></input></div>';
		    td5.innerHTML = '<div align="center">' + a3 + '<input id=R3 type=hidden value=' + a3 + ' class=button size=10 readonly></input></div>';
		    td6.innerHTML = '<div align="center">' + a4 + '<input id=R4 type=hidden value=' + a4 + ' class=button size=10 readonly></input></div>';
		    td7.innerHTML = '<div align="center">' + a5 + '<input id=R5 type=hidden value=' + a5 + ' class=button size=10 readonly></input></div>';
		    td8.innerHTML = '<div align="center">' + a6 + '<input id=R6 type=hidden value=' + a6 + ' class=button size=10 readonly><input id=R7 type=hidden value=' + a7 + ' class=button size=10 readonly><input id=R8 type=hidden value=' + a8 + ' class=button size=10 readonly><input id=R9 type=hidden value=' + a9 + ' class=button size=10 readonly><input id=R10 type=hidden value=' + a10 + ' class=button size=10 readonly><input id=R11 type=hidden value=' + a11 + ' class=button size=10 readonly></input><input name=R12 id="R12'+dynTbIndex+'" type=hidden size=10 readonly></input></div>';
		    $("#R12"+dynTbIndex).val(a12);   //为了解决返回描述信息中的回车造成数据显示不全
		    getMidPrompt("10442",a7,divid);
		    dynTbIndex++;
		}
		
		/*******手续费校验*******/
		function checknum(obj1, obj2)
		{
		    var num2 = parseFloat(obj2.value);
		    var num1 = parseFloat(obj1.value);
		
		    if (num2 < num1)
		    {
		        var themsg = "'" + obj1.v_name + "'不得大于'" + obj2.value + "'请重新输入！";
		        rdShowMessageDialog(themsg);
		        obj1.focus();
		        return false;
		    }
		    return true;
		}
		
		
		/***********组织参数到下一页接受********/
		function senddata(){
		    var kx_code_bunch = "";                                     //可选资费代码串
		    var kx_habitus_bunch = "";                                   //可选自费状态串
		    var kx_operation_bunch = "";                                  //可选套餐的生效方式串
		    var kx_stream_bunch = "";                                     //可选套餐原开通流水串
		    var tempnm = "";												 //临时操作变量
		    var kx_want = "";											 //打印－申请操作
		    var kx_cancle = "";											 //打印－取消操作
		    var kx_explan_bunch = "";									//可选套餐描述
		    var kx_running = "";											 //打印－所有开通操作
		    var kx_want_chgrow = "0";								     //打印－申请操作,换行标志
		    var kx_cancle_chgrow = "0";									 //打印－取消操作,换行标志
		    var kx_running_chgrow = "0";									 //打印－所有开通操作,换行标志
		    var modestr = "";
		    for (var i = 0; i < document.all.checkId.length; i++)
		    {
		        if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y") {
		            //rdShowMessageDialog(document.all.R7[i].value);
		            //rdShowMessageDialog(document.all.R0[i].value);
		            modestr = modestr + document.all.R7[i].value + "(" + document.all.R0[i].value + ")，　";
		            document.all.modestr.value = modestr;
		        }
		        if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N" || //申请
		            document.all.checkId[i].checked == false && document.all.R1[i].value == "Y")//取消
		        {
		            kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //可选资费代码串
		            kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //可选资费状态串
		            kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //可选套餐的生效方式串
		            kx_stream_bunch = kx_stream_bunch + document.all.R10[i].value + "#";//可选套餐原开通流水串
		
		            //sunzx add @20071115
		            if (document.all.R12[i].value == "无描述信息") {
		                kx_explan_bunch = kx_explan_bunch;
							//可选套餐描述
							//alert("kx_explan_bunch="+kx_explan_bunch);
		            } else {
		                kx_explan_bunch = kx_explan_bunch + " " + document.all.R12[i].value;
		            }
								//sunzx add end
		
		            if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N") //所有开通情况
		            {
		                //kx_want = kx_want +  " " + document.all.R0[i].value ;  //申请串
		                kx_want = kx_want + " (" + document.all.R7[i].value + "、" + document.all.R0[i].value + "、" + document.all.R5[i].value + ")";  //申请串
		                kx_want_chgrow = 1 * kx_want_chgrow + 1;
										//if(kx_want_chgrow==2) kx_want+="|";
		            }
		            if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y")//取消情况
		            {
		                //kx_cancle = kx_cancle +  " " + document.all.R0[i].value ;              //取消串
		                kx_cancle = kx_cancle + " (" + document.all.R7[i].value + "、" + document.all.R0[i].value + "、" + document.all.R5[i].value + ")";  //取消串
		                kx_cancle_chgrow = 1 * kx_cancle_chgrow + 1;
									//if(kx_cancle_chgrow==2) kx_cancle+="|";
		            }
		
		        }
		        if (document.all.checkId[i].checked == true)
		        {
		            kx_running = kx_running + " " + document.all.R0[i].value;     //所有开通串
		            kx_running_chgrow = 1 * kx_running_chgrow + 1;
		            if (kx_running_chgrow == 3) kx_running += "|";
		        }
		    }
		
		    if (kx_want == "")kx_want = "无";
		    if (kx_cancle == "")kx_cancle = "无";
		    if (kx_running == "")kx_running = "无";
		    kx_want = "本次申请可选套餐：" + kx_want + "|";
		    kx_cancle = "本次取消可选套餐：" + kx_cancle + "|";
		    kx_running = "开通可选套餐：" + kx_running + "|";
		
		    if (kx_code_bunch == "") {
		        rdShowMessageDialog('请至少申请或取消一个可选套餐！');
		        return false;
		    }
		    if (kx_habitus_bunch == "") {
		        kx_habitus_bunch = " #";
		    }
		    if (kx_operation_bunch == "") {
		        kx_operation_bunch = " #";
		    }
		    if (kx_stream_bunch == "") {
		        kx_stream_bunch = " #";
		    }
		
		    document.all.kx_code_bunch.value = kx_code_bunch;                        //可选资费代码串
		    document.all.kx_habitus_bunch.value = kx_habitus_bunch;                  //可选资费状态串
		    document.all.kx_operation_bunch.value = kx_operation_bunch;            //可选套餐的生效方式串
		    document.all.kx_stream_bunch.value = kx_stream_bunch;                  //可选套餐的开通流水串
		    document.all.kx_explan_bunch.value = kx_explan_bunch;						//可选套餐描述
		    document.all.kx_want.value = kx_want;                                  //打印－所有申请操作-串
		    document.all.kx_cancle.value = kx_cancle;                              //打印－所有取消操作-串
		    document.all.kx_running.value = kx_running;                            //打印－所有开通的套餐-串
		    return true;
		}
		
		
		/*****************判断业务套餐是否可以操作*****************/
		function checksel(){
    	with (document.all){
        for (j = 0; j < oTypeName.length; j++)
        {
            if (oTypeName[j].value != "")
            {
                oDefaultFlag[j].value = "N";
                oDefaultOpen[j].value = "N";
                oActualOpen[j].value = "0";
            }
        }
        for (var i = 1; i < checkId.length; i++)
        {
            if (R11[i].value == "b")
            {
                rdShowMessageDialog("‘" + R0[i].value + "’因生效时间与历史时间冲突而不可申请导致此次操作失败！");
                return false;
            }
            for (var j = 0; j < oTypeName.length; j++)
            {
                if (oTypeValue[j].value == R8[i].value)
                {
                    if (checkId[i].checked == true)
                    {
                        oActualOpen[j].value = 1 * oActualOpen[j].value + 1;
                    }
                    if (R11[i].value == "1" || R11[i].value == "a")
                    {
                        oDefaultFlag[j].value = "Y";
                        if (checkId[i].checked == true) oDefaultOpen[j].value = "Y";
                    }
                    break;
                }
            }
        }
        for (j = 0; j < oTypeName.length; j++)
        {
            if (Math.round(oActualOpen[j].value) < Math.round(oMinOpen[j].value) || Math.round(oActualOpen[j].value) > Math.round(oMaxOpen[j].value))
            {
                rdShowMessageDialog("‘" + oTypeName[j].value + "’类套餐实际开通" + oActualOpen[j].value + "，应在" + oMinOpen[j].value + "到" + oMaxOpen[j].value + "之间");
                return false;
            }
            if (oDefaultFlag[j].value == "Y" && oDefaultOpen[j].value == "N")
            {
                rdShowMessageDialog("请确认‘" + oTypeName[j].value + "’类可选方式为‘默认’的套餐至少开通一个");
                return false;
            }
        }
        var tempflag = "0";
        var threeflag = "0";
        for (V = 0; V < R11.length; V++)
        {
            if (R11[V].value == "4")
            {
                tempflag = 1 * tempflag + 1;
            }//先统计有没有等于3的数据，如果有再做一下判断
        }
        if (tempflag > 0)
        {
            for (m = 0; m < R11.length; m++)
            {
                if (R11[m].value == "4" && checkId[m].checked == true)
                {
                    threeflag = 1 * threeflag + 1;
                }
            }
            if (threeflag < 1)
            {
                rdShowMessageDialog("所有'多组选一'套餐至少开通一个");
                return false;
            }
        }
    }
    return true;
}
	//-->
</script>

</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>
		<table cellspacing="0">
		    <tr>
		        <td class="blue" width="15%">服务号码
		        <td width="35%">
		        	<input name="i1" value="<%=phone%>" size="20" class="InputGrey" readonly>
		        </td>
		        <td class="blue" width="15%">客户ID</td>
		        <td>
		            <input name="i2" size="20" value="<%=i2%>" maxlength=30 class="InputGrey"  readonly>
		        </td>
		    </tr>
<tr>
    <td class="blue" width="15%">客户名称</td>
    <td width="35%">
        <input name="i4" size="20" maxlength=30 value="<%=i4%>" class="InputGrey"  readonly>
    </td>
    <td class="blue">证件类型名称</td>
    <td>
    	<input name="i6" size="20" maxlength=30 value="<%=i6%>" class="InputGrey"  readonly>
    </td>
</tr>
<tr style="display:none">
    <td class="blue" width="15%">&nbsp;</td>
    <td>
        <input name="i5" size="40" type="hidden" maxlength=30 value="<%=i5%>" class="InputGrey"  readonly>
    </td>
    <td class="blue">&nbsp;</td>
    <td>
        <input name="i7" size="20" type="hidden" maxlength=30 value="<%=i7%>" class="InputGrey"  readonly>
    </td>
</tr>
<tr>
    <td class="blue">业务品牌</td>
    <td>
        <%String add = i8 + " " + i9;%>
        <input name="i8" size="20" maxlength=20 value="<%=add%>" class="InputGrey" readonly>
        <input type="hidden" name="i9" size="13" maxlength=20 readonly>
        <input type="hidden" name="cust_info">
        <input type="hidden" name="opr_info">
        <input type="hidden" name="note_info1">
        <input type="hidden" name="note_info2">
        <input type="hidden" name="note_info3">
        <input type="hidden" name="note_info4">
        <input type="hidden" name="printcount">
    </td>
    <td class="blue">运行状态</td>
    <td>
        <%String add1 = i10 + " " + i11;%>
        <input name="i10" size="20" maxlength=2 value="<%=add1%>" class="InputGrey" readonly>
        <input type="hidden" name="i11" size="20" maxlength=20 readonly>
    </td>
</tr>
<tr>
    <td class="blue">总欠费</td>
    <td>
        <input name="i12" size="20" maxlength=2 value="<%=i12%>" class="InputGrey" readonly>
    </td>
    <td class="blue">总预存款</td>
    <td>
        <input name="i13" size="20" maxlength=20 value="<%=i13%>" class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">当前主套餐</td>
    <td>
        <%String add2 = i16+" "+i17;%>
        <input name="i16" size="30" maxlength=20 value="<%=add2%>" class="InputGrey" readonly>
        <input type="hidden" name="maincash" size="20" maxlength=20 value="<%=i16%>" readonly>
    <td class="blue">下月主套餐</td>
    <td>
        <input name="i18" size="30" maxlength=20 value="<%=i26%> <%=i27%>" class="InputGrey" readonly>
    </td>
    </td>
</tr>
<tr>
    <td class="blue">集团客户类别</td>
    <td>
        <input name="group_type" size="20" value="<%=i24%> <%=i25%>" class="InputGrey" readonly>
    </td>
    <td class="blue">&nbsp;</td>
    <td>
    		<!--<input class="InputGrey" name="ibig_cust" size="20" value="<%=ibig_cust_ls%>" readonly>-->
        <font class="orange">&nbsp;</font>
        <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly>
        <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly>
    </td>
</tr>
<%
    String favorcode = i23;
    int m = 0;
    for (int p = 0; p < favInfo.length; p++) {//优惠资费代码
        for (int q = 0; q < favInfo[p].length; q++) {
            if (favInfo[p][q].trim().equals(favorcode)) {
                ++m;
            }
        }
    }
%>

<tr>
    <%if (m != 0) {%>
    <td class="blue">手续费</td>
    <td colspan="3">
        <input name="i19" size="20" maxlength=20 value="<%=i19%>" v_must=1 v_name=手续费 v_type=float>
        <input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>" readonly v_name=最高手续费>
    </td>

    <%} else {%>
    <td class="blue">手续费</td>
    <td colspan="3">
        <input name="i19" size="20" maxlength=20 value="<%=i19%>" v_must=1 v_name=手续费 v_type=float  class="InputGrey" readonly>
        <input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>" readonly v_name=最高手续费>
    </td>
    <%}%>
</tr>
</table>
<table cellspacing="0">
<tr>
    <td class="blue" width="15%">可选套餐类别</td>
    <td>
        <input type=hidden name=oActualOpen value="">
        <input type=hidden name=oDefaultFlag value="">
        <input type=hidden name=oDefaultOpen value="">
        <input type=hidden name=oTypeValue value="">
        <input type=hidden name=oTypeName value="">
        <input type=hidden name=oMinOpen value="0">
        <input type=hidden name=oMaxOpen value="100">
        <%
		            String sm_code = i8;
		            String sqlStr = "";
		            
                sqlStr = "select a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN  from sbillmodetype a,cBillBaDepend b,sBillModeCode c where a.region_code=b.region_code and a.region_code=c.region_code and b.region_code='" + i20.substring(0, 2) + "' and b.MODE_CODE='" + i16 + "' and b.add_mode=c.MODE_CODE and c.mode_type=a.mode_type and a.mode_flag='2'";
                if (sm_code.equals("gn") || sm_code.equals("hn") || sm_code.equals("dn") || sm_code.equals("d0") || sm_code.equals("cb") || sm_code.equals("z0")) {
                    sqlStr += " and a.sm_code in('gn','dn','zn')";
                }
                if (sm_code.equals("ip") || sm_code.equals("ww")) {
                    sqlStr += " and a.sm_code in('ip','ww')";
                }
                sqlStr += " and a.mode_type not in(select distinct mode_type from sAddModeType where active_flag='Y')";
                sqlStr += " group by a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN";
                System.out.println("sqlStr===" + sqlStr);
				%>
								<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>"  outnum="4">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_select" scope="end" />
				<%  
								int recordNum = result_select.length;
                for (int i = 0; i < recordNum; i++) {
                    out.println("<a Href='#' onClick='openwindow("
                            + i + "," + '"' + result_select[i][0] + '"' + "," + '"' + result_select[i][1] + '"' + ")'>" + result_select[i][0] + " " + result_select[i][1] + "</a>");
                    out.println("<input type=hidden name=oActualOpen value='0'>");    //实际开通的数 
                    out.println("<input type=hidden name=oDefaultFlag value='N'>");   //是否有默认申请的配置
                    out.println("<input type=hidden name=oDefaultOpen value='N'>");   //是否默认申请是否存在一个申请
                    out.println("<input type=hidden name=oTypeValue value=" + result_select[i][0] + ">");
                    out.println("<input type=hidden name=oTypeName value=" + result_select[i][1] + ">");
                    out.println("<input type=hidden name=oMinOpen  value=" + result_select[i][2].trim() + ">");
                    out.println("<input type=hidden name=oMaxOpen  value=" + result_select[i][3].trim() + ">");
                }
        %>
    </td>

</tr>
</TBODY>
</table>
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">套餐信息</div>
</div>
<table id=tr cellspacing="0" style="display=''">
<tr align="center">
    <th>选择</th>
    <th>可选套餐名称</th>
    <th>状态</th>
    <th>开始时间</th>
    <th>结束时间</th>
    <th>套餐类别</th>
    <th>生效方式</th>
    <th>可选方式</th>
</tr>
<tr id="tr0" style="display:none" align="center">
    <td><input type="checkbox" name="checkId" id="checkId"></td>
    <td><input type="text" name="R0" value=""></td>
    <td><input type="text" name="R1" value=""></td>
    <td><input type="text" name="R2" value=""></td>
    <td><input type="text" name="R3" value=""></td>
    <td><input type="text" name="R4" value=""></td>
    <td><input type="text" name="R5" value=""></td>
    <td><input type="text" name="R6" value=""></td>
    <td>
  	  <input type="text" name="R7" value="">
      <input type="text" name="R8" value="">
      <input type="text" name="R9" value="">
      <input type="text" name="R10" value="">
      <input type="text" name="R11" value="">
      <input type="text" name="R12" value="">
    </td>
</tr>
<%
    if (ret_code.equals("000000")) {
        /******************************准备调用s1272Must服务生成循环列表******************************/
        //定义返回结果集
        String ret_code1 = "";
        String ret_msg1 = "";
        String icust_id = i2;                                                  //客户ID
        String iold_m_code = i16;                                    //现主套餐代码（老）  
        String ibelong_code = i20;                                             //belong_code
        String iop_code = "1272";
%>
				<wtc:service name="s1272Must" routerKey="phone" routerValue="<%=phone%>"  outnum="14" >
				<wtc:param value="<%=icust_id%>"/>
				<wtc:param value="<%=iold_m_code%>"/>
				<wtc:param value="<%=ibelong_code%>"/>
				<wtc:param value="<%=iop_code%>"/>
				</wtc:service>
				<wtc:array id="result_must" start="0" length="2" scope="end"/>
				<wtc:array id="dataArr" start="2" length="12" scope="end"/>
<%
        //getList_must = callView.s1272MustProcess(icust_id, iold_m_code,ibelong_code, iop_code).getList();
				if(result_must!=null&&result_must.length>0){
		        ret_code1 = result_must[0][0];
		        ret_msg1 = result_must[0][1];
        }
        //对返回信息的控制
        if (ret_msg1.equals("")) {
            ret_msg1 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code1));
            if (ret_msg1.equals("null")) {
                ret_msg1 = "未知错误信息";
            }
        }
        
    if (!ret_code1.equals("000000")) {
 %>
			<script language='jscript'>
			    rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code1%>'。<br>错误信息：'<%=ret_msg1%>'。");
			    parent.removeTab("<%=opCode%>");
			</script>
<%
		}
%>
<%
    		String[][] data = new String[][]{};
        data = dataArr;
        for (int y = 0; y < data.length; y++) {
            String addstr = data[y][0] + "#" + data[y][1] + "#" + y;
%>
<tr id="tr<%=y+1%>" align="center">
    <%if (data[y][data[0].length - 1].equals("0") || data[y][data[0].length - 1].equals("1") || data[y][data[0].length - 1].equals("4")) {//默认申请%>
    <td><input type="checkbox" name="checkId" checked></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("2")) {//绑定申请
    %>
    <td><input type="checkbox" name="checkId" checked
               onclick="if(document.all.checkId[<%=y%>+1].checked==false){
									 document.all.checkId[<%=y%>+1].checked=true;}
									 rdShowMessageDialog('绑定申请！');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("a")) {//默认申请下因生效时间与历史时间冲突而不可申请
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('默认申请下因生效时间与历史时间冲突而不可申请！');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("b")) {//强制申请下因生效时间与历史时间冲突而不可申请
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('强制申请下因生效时间与历史时间冲突而不可申请！');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("d")) {//强制取消
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('强制取消不能申请！');return false;"></td>
    <%
        }
        if (data[y][data[0].length - 1].equals("9")) {//不可取消
    %>
    <td><input type="checkbox" name="checkId" checked
               onclick="if(document.all.checkId[<%=y%>+1].checked==false){
									 document.all.checkId[<%=y%>+1].checked=true;}
									 rdShowMessageDialog('特殊可选资费，请到单独业务界面办理！');return false;"></td>
    <%}%>
    <%
        for (int j = 0; j < data[0].length; j++) {
            String tbstr = "";

            if (j == 0) {
                tbstr = "<td><a Href='#' onClick='openhref(" + '"' + data[y][7].trim() + '"' + ")'>" +
                        data[y][j].trim() + "</a><input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            } else if (j == 1) {
                String habitus = "";
                if (data[y][j].trim().equals("Y")) habitus = "已开通";
                if (data[y][j].trim().equals("N")) habitus = "未开通";
                tbstr = "<td>" + habitus + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            } else if (j > 6) {
                tbstr = "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>";
            } else {
                tbstr = "<td>" + data[y][j].trim() + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            }
            out.println(tbstr);
    %>


    <%
        }
        ///R12
        out.println("<input type='hidden' id='R12' name='R12' class='button' value='' readonly>");
    %>
</tr>
<%
       }
    }
%>
</table>
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">备注信息</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" width="15%">系统备注</td>
        <TD colspan="3">
            <input name="sysnote" size="100" maxlength="60" value="用户<%=phone%>可选资费变更">
        </td>
    </tr>
    <tr style='display:none'>
        <td class="blue" width="15%">用户备注</td>
        <td>
            <input name="tonote" size="100" value="<%=WtcUtil.repNull(request.getParameter("do_note"))%>">
        </td>
    </tr>
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <tr>
            <td id="footer">
                <input name=sure class="b_foot" type=button value="确认&打印" onclick="if(checknum(i19,i20)) if(senddata()) if(checksel()) if(check(form1)) printCommit();">
                <input name=close class="b_foot" onClick="removeCurrentTab()" type=button value=关闭>
                <input name=back class="b_foot" onClick="history.go(-1)" type=button value=返回>
            </td>
        </tr>
    </TBODY>
</table>
<!--设置为隐藏  客户ID ，客户地址，证件类型名称，证件号码，belong_code,-->
<input type="hidden" name="flag_string">
<input type="hidden" name="stream" value="<%=printAccept%>">
<input type="hidden" name="handcash" value="<%=WtcUtil.repNull(request.getParameter("i19"))%>">
<input type="hidden" name="maincash_no" value="<%=i16%>">
<input type="hidden" name="belong_code" value="<%=i20%>">
<input type="hidden" name="do_string_add">
<input type="hidden" name="modestr">
<input type="hidden" name="addcash_string">
<input type="hidden" name="toprintdata">
<input type="hidden" name="add_stream_str">
<input type="hidden" name="kx_code_bunch"><!--可选资费代码串-->
<input type="hidden" name="kx_habitus_bunch"><!--可选资费状态串-->
<input type="hidden" name="kx_operation_bunch"><!--可选套餐的生效方式串-->
<input type="hidden" name="kx_stream_bunch"><!--原可选套餐的开通流水串-->
<input type="hidden" name="kx_want"><!--打印－所有申请操作--->
<input type="hidden" name="kx_cancle"><!--打印－所有取消操作--->
<input type="hidden" name="kx_running"><!--打印－所有开通的套餐--->
<input type="hidden" name="kx_explan_bunch"><!--可选套餐说明-->
<input type="hidden" name="haseval">
<input type="hidden" name="evalcode">
<!----------------------------------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %> 
</FORM>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
<noframes></noframes>
</BODY>
</HTML>

<script language="javascript">

	function conf(){
    var h = 200;
    var w = 300;
    var t = screen.availHeight - h - 20;
    var l = screen.availWidth / 2 - w / 2;

    /***********************打印所需的参数**********************************/
    var phone = document.all.i1.value;								//用户手机号码
    var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// 系统日期
    var name = document.all.i4.value;								//用户姓名
    var address = document.all.i5.value;								//用户地址
    var cardno = document.all.i7.value;								//证件号码
    var stream = document.all.stream.value;							//打印流水
    var kx_want = document.all.kx_want.value;				        //打印－所有申请操作-串
    var kx_cancle = document.all.kx_cancle.value;                    //打印－所有取消操作-串
    var kx_running = document.all.kx_running.value;                  //打印－所有开通的套餐-串
    var work_no = '<%=workNo%>';                                 //得到工号
    var sysnote = "用户<%=phone%>可选资费变更";                                   //得到打印的系统日志
    var tonote = document.all.tonote.value;							//得到打印的操作日志
    /**********************打印所需的参数组织完毕****************************/

    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
    var ret_value = window.showModalDialog("f1270_print.jsp?phone=" + phone + "&date=" + date + "&name=" + name + "&address=" + address + "&cardno=" + cardno + "&stream=" + stream + "&sysnote=" + sysnote + "&work_no=" + work_no + "&kx_want=" + kx_want + "&kx_cancle=" + kx_cancle + "&kx_running=" + kx_running + "&tonote=" + tonote, "", prop);                                //点击确认，调用打印页面
    ifretvalue = ret_value.substring(0, 4);
    if (ifretvalue == "true")
    {
        document.all.stream.value = ret_value.substring(4);//设置所取到的流水，并赋值，此笔业务的流水将一直是这个
        crmsubmit()                                        //调用提交确认服务
    }
	}
		function crmsubmit()
		{
		    if (rdShowConfirmDialog("是否提交此次操作？") == 1)
		    {
		        form1.action = "f1272_3.jsp";
		        form1.submit();
		    }
		    else
		    {
		        canc()
		    }
		
		}

		function canc(){
		   document.all.sure.disabled = false;
		}
		
	/***********提交打印函数*************/
	function printCommit() {
	getAfterPrompt();
    document.all.sure.disabled = true;
    var len = document.all('tr').rows.length;
    if (len == 2) {
        rdShowMessageDialog('请选择可选套餐！');
        return false;
    }
    
    if(document.all.tonote.value.trim().len()==0){
    	document.all.tonote.value=document.all.sysnote.value.trim();
   	}
	
    var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
    var iReturn = 0;
    if (typeof(ret) != "undefined") {
        if ((ret == "confirm")) {
            iReturn = showEvalConfirmDialog('确认电子免填单吗？');
            if (iReturn == 1 || 2 == iReturn) {
                if (2 == iReturn) {
                    var vEvalValue = GetEvalReq(1);
                    document.all.haseval.value = "1";
                    document.all.evalcode.value = vEvalValue;
                } else {
                    document.all.haseval.value = "0";
                    document.all.evalcode.value = "0";
                }

                document.all.printcount.value = "1";
                frmCfm();

            }
        }

        if (ret == "continueSub") {
            iReturn = showEvalConfirmDialog('确认要提交信息吗？');
            if (iReturn == 1 || 2 == iReturn) {
                if (2 == iReturn) {
                    var vEvalValue = GetEvalReq(1);
                    document.all.haseval.value = "1";
                    document.all.evalcode.value = vEvalValue;
                } else {
                    document.all.haseval.value = "0";
                    document.all.evalcode.value = "0";
                }
                document.all.printcount.value = "0";
                frmCfm();
            }
        }
    } else {
        iRetrun = showEvalConfirmDialog('确认要提交信息吗？');
        if (iRetrun == 1 || 2 == iReturn) {
            if (2 == iReturn) {
                var vEvalValue = GetEvalReq(1);
                document.all.haseval.value = "1";
                document.all.evalcode.value = vEvalValue;
            } else {
                document.all.haseval.value = "0";
                document.all.evalcode.value = "0";
            }
            document.all.printcount.value = "0";
            frmCfm();
        }
    }

    document.all.sure.disabled = false;
    return true;
	}


	/*********最终提交函数*********/
	function frmCfm() {
	    document.form1.action = "f1272_3.jsp";
	    form1.submit();
	    return true;
	}


	/*********免填单打印函数*********/
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //显示打印对话框 
	    var h = 210;
	    var w = 400;
	    var t = screen.availHeight / 2 - h / 2;
	    var l = screen.availWidth / 2 - w / 2;
	
	
	 var pType="subprint";              
	 var billType="1";              
	 var sysAccept="<%=printAccept.trim()%>";               
	 //var printStr = printInfo(printType); 
	 var kx_code="";
	for (var i = 0; i < document.all.checkId.length; i++){
		if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N"){
			kx_code = kx_code + document.all.R7[i].value + "~";
		}
	}
	 //alert(kx_code);
	 var mode_code=codeChg(kx_code);  
	 //alert(mode_code);            
	 var fav_code=null;                 
	 var area_code=null;             
     	 var opCode="1272";                   
     	 var phoneNo=document.form1.i1.value;                  


	    var printStr = printInfo();
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm;
	    path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	    var ret = window.showModalDialog(path, printStr, prop);
	    return ret;
	}

	/*********免填单打印函数调用的打印函数*********/
	function printInfo(){
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    cust_info += "客户姓名：" + document.form1.i4.value + "|";
    cust_info += "手机号码：" + document.form1.i1.value + "|";
    /*cust_info += "客户地址：" + document.form1.i5.value + "|";
    cust_info += "证件号码：" + document.form1.i7.value + "|";*/

    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "用户品牌：" + "<%=i9.trim()%>" + "|";
    if (document.all.kx_want.value == "本次申请可选套餐：15元IP优惠礼包|")
    {
        opr_info += "业务类型:可选套餐节日17951 IP长途优惠礼包（15）申请" + "  " + "流水:" + "<%=printAccept.trim()%>" + "|";
    } else if (document.all.kx_cancle.value == "本次取消可选套餐： 15元IP优惠礼包|")
    {
        opr_info += "业务类型:可选套餐节日17951 IP长途优惠礼包（15）取消" + "  " + "流水:" + "<%=printAccept.trim()%>" + "|";
    } else
    {
        opr_info += "业务类型:可选资费变更" + "  " + "流水:" + "<%=printAccept.trim()%>" + "|";
    }


    if ((document.all.kx_want.value == "本次申请可选套餐： 15元IP优惠礼包|") || (document.all.kx_cancle.value == "本次取消可选套餐： 15元IP优惠礼包|"))
    {
        note_info1 += "IP节日优惠礼包包月使用费15元，订购后可以享受当月赠送168分钟" + "|";
        note_info1 += "的17951国内长途IP通话费，超过部分，费用正常收取。" + "|";
        note_info1 += "下半月（16日起）申请的用户，包月费用收取7.5元，赠送84分钟的" + "|";
        note_info1 += "17951国内长途IP通话费，超过部分，费用正常收取。" + "|";
        note_info1 += "该业务当日申请，次日生效；取消，下月生效。" + "|";
        note_info1 += "在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。" + "|";

    } else {
        opr_info += "" + codeChg(document.all.kx_want.value);//申请资费
        opr_info += "" + codeChg(document.all.kx_cancle.value);//取消资费
    }
    note_info2 += " " + "|";
    note_info2 += "备注:" + document.all.tonote.value + "|";
	  
	  //sunzx add @ 20071115
    if (document.all.kx_explan_bunch.value.trim().len() == 0) {

    } else {
        note_info3 += " " + "|";
        note_info3 += "可选资费描述：" + "|";
        note_info3 += codeChg(document.all.kx_explan_bunch.value) + "|";
    }
  	  //sunzx add end


    // if(document.all.modestr.value.length>0){
    // retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
    // }else{

    //}
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
    retInfo = document.all.cust_info.value + " " + "|" + "---------------------------------------------" + "|" + " " + "|" + document.all.opr_info.value + " " + "|" + " " + "|" + document.all.note_info1.value + document.all.note_info2.value + document.all.note_info3.value + document.all.note_info4.value + " " + "|" + " " + "|" + " " + "|" + " " + "|" + "<%=loginNote.trim()%>" + "#";
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
	}
	/***************************MengQK add end*****************************/

	/***************判断是否有生效时间与历史时间冲突而不可申请的错误数据************/
	function openhref(p)
	{
	    var h = 600;
	    var w = 550;
	    var t = screen.availHeight - h - 20;
	    var l = screen.availWidth / 2 - w / 2;
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
	    var region_code = '<%=subi20%>';
	    var ret_code = window.showModalDialog("f1270m_detail.jsp?mode_code=" + p + "&region_code=" + region_code, "", prop);
	}
</script>
