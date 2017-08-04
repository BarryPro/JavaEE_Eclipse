<%
/********************
* 功能: 主资费预约取消 127a || 主资费冲正 127b
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="getMaxAccept.jsp" %>
<%
/*
 * 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
 *		部分变量的命名依据对此变量使用的意义，或用途。
 */%>
<%
    String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	System.out.println("-------opCode="+opCode+",opName="+opName);


    //在此处读取session信息
    Logger logger = Logger.getLogger("f127a_2.jsp");
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String aftertrim = ((String)session.getAttribute("powerRight")).trim();
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String result222[][]=new String[][]{};
    String result111[][]=new String[][]{};
    String strArray="var arrMsg; ";  //must


	/*
	 ****得到生效方式
	 ****127a:主自费预约取消  127b：主自费冲正  1204:数据卡冲正  1206：哈尔滨畅听套餐冲正 126c:预存赠机冲正 126i:签约赠机冲正 1207:哈尔滨畅听套餐取消
	*/

	String  tbselect = "0 24小时之内生效";

	/****得到打印流水****/
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println("---------ly-----------");
	System.out.println("printAccept="+printAccept);

	/****得到生效时间,用于工单打印****/
	String exeDate="";
    exeDate = getExeDate(tbselect.substring(0,1),opCode);

    String[][] str1 = (String[][])arr.get(0);//读取登陆信息

	String goodbz="N";
	String bdbz = "N";
%>

<!----------------------------------页头显示区域----------------------------------------->

<%
	String work_no = (String)session.getAttribute("workNo");                                   //获得工号信息
	String phone = (String)request.getParameter("servno");                      //获得传来手机号码
	String iadd_str = ReqUtil.get(request,"iAddStr");
	String pw_favor = ReqUtil.get(request,"pw_favor");                //密码优惠权限标志位1:有0:无

	String ret_code = "";
	String ret_msg = "";

    String do_note = ReqUtil.get(request,"i222");
	String rowNum = "16";
	String getselect = ReqUtil.get(request,"select1");

	String[] paraAray1 = new String[4];
	String titleStr = "";

    String i1="";
    String i2="";
	String i3="";
    String i4="";
	String i5="";
	String i6="";
	String i7="";
	String i8="";
    String i9="";
	String i10="";
	String i11="";
	String i12="";
	String i13="";
    String i14="";
	String i15="";
	String i16="";
	String i17="";
	String i18="";
	String i19="";
	String i20="";
	String i21="";
	String i22="";
	String i23="";
	String i24="";
	String i25="";
	String i26="";
	String i27="";
	String i28="";
	String subi20="";
	String disCode="";
	String ibig_cust_ls="";
	String before_mode_code="",before_mode_code_name="";
	String ip="",iq="";
	String return_page="f1170Main.jsp";
	try
 	{
         paraAray1[0] = work_no;		/* 操作工号   */
         paraAray1[1] = phone; 	        /* 手机号码   */
         paraAray1[2] = opCode;
		 paraAray1[3] = "";	/* 密码   */

         //retArray = impl.callFXService("s127aInit", paraAray1, "31","phone", phone);
%>
        <wtc:service name="s127aInit" routerKey="phone" routerValue="<%=phone%>" outnum="32" retcode="s1270GetMsgCode" retmsg="s1270GetMsgMsg">
            <wtc:param value="<%=paraAray1[0]%>"/>
            <wtc:param value="<%=paraAray1[1]%>"/>
            <wtc:param value="<%=paraAray1[2]%>"/>
            <wtc:param value="<%=paraAray1[3]%>"/>
    	</wtc:service>
    	<wtc:array id="retS127aInitArr"  scope="end"/>
<%
        String errCode = s1270GetMsgCode;
        String errMsg = s1270GetMsgMsg;
        if(errCode.equals("000000"))
        {
            ret_code = "000000";          // 返回代码
        }else
        {
            ret_code = errCode;
        }
        ret_msg = errMsg;			  // 提示信息

        //对返回信息的控制
        if(ret_msg.equals(""))
        {
            ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
            if( ret_msg.equals("null")){ret_msg ="未知错误信息";}
        }
        if(errCode.equals("000000"))
        {
            i2 = retS127aInitArr[0][2];				  // 用户ID
            i3 = retS127aInitArr[0][3];				  // 客户密码
            i4 = retS127aInitArr[0][4];				  // 客户名称
            i5 = retS127aInitArr[0][5];				  // 客户地址
            i6 = retS127aInitArr[0][6];				  // 客户证件类型名称
            i7 = retS127aInitArr[0][7];				  // 客户证件号码
            i8 = retS127aInitArr[0][8];				  // 业务品牌
            i9 = retS127aInitArr[0][9];				  // 业务品牌名称
            i10 = retS127aInitArr[0][10];			  // 用户运行状态
            i11 = retS127aInitArr[0][11];			  // 用户运行状态名称
            i12 = retS127aInitArr[0][12];			  // 总欠费
            i13 = retS127aInitArr[0][13];			  // 总预存款
            i14 = retS127aInitArr[0][14];			  // 第一欠费帐号
            i15 = retS127aInitArr[0][15];			  // 第一欠费
            i16 = retS127aInitArr[0][16];			  // 当前主套餐代码
            i17 = retS127aInitArr[0][17];			  // 当前主套餐名称
            i18 = retS127aInitArr[0][18];			  // 当前主套餐开通流水
            i19 = retS127aInitArr[0][19];			  // 手续费
            i20 = retS127aInitArr[0][20];              // belong_code
            i21 = retS127aInitArr[0][21];              // 大客户类型
            i22 = retS127aInitArr[0][22];              // 大客户类型名称
            i23 = retS127aInitArr[0][23];              // 手续费优惠代码
            i24 = retS127aInitArr[0][24];              // 集团客户类别
            i25 = retS127aInitArr[0][25];              // 集团客户类别名称
            i26 = retS127aInitArr[0][26];              // 下月主资费            oNextMode
            i27 = retS127aInitArr[0][27];    		  // 下月主资费名称        oNextModeName
            i28 = retS127aInitArr[0][28];			  // 下月主资费开通流水    oNextModeAccept
            before_mode_code = retS127aInitArr[0][29];	// 上个主套餐代码
            before_mode_code_name = retS127aInitArr[0][30];	// 上个主套餐代码名称
        }

        if(opCode.equals("127a"))
        {
        	System.out.println("------------------");
            titleStr = "主资费预约取消";
            return_page = "f1170Main.jsp";

            ip = i16;
            iq = i17;
            System.out.println("ip="+ip+",iq="+iq);
            System.out.println("------------------");
        }else if(opCode.equals("127b"))
        {
            titleStr = "主资费冲正";
            return_page = "s127b_1.jsp";
            ip = before_mode_code;
            iq = before_mode_code_name;
        }

        ibig_cust_ls = i21 + " " + i22;   //大客户类型名称页面显示
        subi20 = i20.substring(0,2);
        disCode = i20.substring(2,4);

        //String[][] allNewSmInfo=(String[][])arr.get(5);
      //  sNewSmName=WtcUtil.getNewSm(((String[][])arr.get(0))[0][16].substring(0,2),i8,allNewSmInfo,"1");
        //System.out.println("----------ly--------"+allNewSmInfo);
    }
    catch(Exception e)
    {
        System.out.println("页面发生错误，如下：");
        e.printStackTrace();
    }
    String sNewSmName=i8;
%>
<%
	//处理特殊号码
	String sqlStrgood = "select mode_dxpay "+
					 "from dgoodphoneres a, sGoodBillCfg b "+
					 "where a.bill_code = b.mode_code "+
					 " and b.region_code = '"+regionCode+"'"+
					 " and a.phone_no = '"+phone+
					 "' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";

	System.out.println(sqlStrgood);

%>

<wtc:pubselect name="sPubSelect"  retcode="retCodeNo2" retmsg="retMsgNo2" outnum="1">
 <wtc:sql><%=sqlStrgood%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="retarr" scope="end"/>
<%
	String modedxpay = "0";
	if(retarr.length!=0)
	{
		goodbz="Y";
		modedxpay = retarr[0][0];
		System.out.println("----ly----modedxpay="+modedxpay);
	}
	else
	{
		goodbz="N";
		modedxpay = "0";
	}

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=titleStr%></TITLE>
</HEAD>
<%
    if(!ret_code.equals("000000")){%>
        <script language='jscript'>
            var ret_code = "<%=ret_code%>";
            var ret_msg = "<%=ret_msg%>";
            rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
            <%if(opCode.equals("127a")){%>
                //document.location.replace("f1170Main.jsp");
                removeCurrentTab();
            <%}else if(opCode.equals("127b")){%>
                document.location.replace("<%=request.getContextPath()%>/npage/bill/f127b_1.jsp?activePhone=<%=phone%>");
            <%}%>
        </script>
<%  }%>

<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
   <div id="title_zi">用户登录</div>
</div>

<!--------------------------------在此欠套第二层表格------------------------------------>
    <TABLE border=0>
        <TR>
            <TD class="blue">移动号码
            <TD >
            	<input type="hidden" name="phone" value="<%=phone%>">
                <input class="InputGrey" name="i1" value="<%=phone%>" size="20" maxlength=11 v_must=1 v_type=0_9 readonly>
            </TD>
            <TD class="blue">客户ID</TD>
            <TD>
            	<input type="hidden" name="id_no"  value="<%=i2%>" >
                <input class="InputGrey" name="i2" size="20"  value="<%=i2%>" maxlength=30  readonly >
            </TD>
        </TR>
        <TR>
            <TD class="blue">客户名称</TD>
            <TD>
                <input class="InputGrey" name="i4" size="20" maxlength=30 value="<%=i4%>" readonly>
            </TD>
            <TD class="blue">客户地址</TD>
            <TD>
                <input class="InputGrey" name="i5" size="30" maxlength=30 value="<%=i5%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">证件类型名称</TD>
            <TD>
                <input class="InputGrey" name="i6" size="20" maxlength=30 value="<%=i6%>" readonly>
            </TD>
            <TD class="blue">证件号码</TD>
            <TD>
                <input class="InputGrey" name="i7" size="20" maxlength=30 value="<%=i7%>" readonly>
            </TD>
        </TR>
        <tr>
            <td nowrap class="blue">业务品牌</td>
            <td nowrap >
            	<%String add = i8+" "+i9;
            	  sNewSmName = add;	%>
            	<input class="InputGrey" type=text name="sNewSmName" value="<%=sNewSmName%>"
            	maxlength="15"/> </td>
           <!--
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <TR>
            <TD class="blue">业务类型</TD>
            <TD>

                <input class="InputGrey" name="i8" size="20" maxlength=20 value="<%=add%>" readonly>
                <input type="hidden" name="i9" size="13" maxlength=20  readonly>
            </TD> -->
            <TD class="blue">运行状态</TD>
            <TD>
                <%String add1 = i10+" "+i11;%>
                <input class="InputGrey" name="i10" size="20" maxlength=2 value="<%=add1%>" readonly>
                <input type="hidden" name="i11" size="20" maxlength=20  readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">未出帐话费</TD>
            <TD>
                <input class="InputGrey" name="i12" size="20" maxlength=2 value="<%=i12%>" readonly>
            </TD>
            <TD class="blue">可用预存</TD>
            <TD>
                <input class="InputGrey" name="i13" size="20"maxlength=20 value="<%=i13%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">集团客户类别</TD>
            <TD>
                <input class="InputGrey" name="group_type" size="20" value="<%=i24%> <%=i25%>" readonly>
            </TD>
            <TD class="blue">大客户类别</TD>
            <TD>
                <input class="InputGrey" class="text_redFat" name="ibig_cust" size="20" value="<%=ibig_cust_ls%>"  maxlength=20  v_must=1 v_type=string readonly>
                <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly >
                <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly >
            </TD>
        </TR>
        <TR>
            <TD class="blue">当前主套餐</TD>
            <TD>
                <%String newModeCode = i16+" "+i17;%>
                <input class="InputGrey" name="i16" size="30" maxlength=20 value="<%=newModeCode%>" readonly>
                <input type="hidden" name="maincash" size="20"maxlength=20 value="<%=i16%>" readonly>
                <input type="hidden" name="newModeCode" value="<%=newModeCode%>">
            </TD>
            <TD class="blue">下月主套餐</TD>
            <TD>
            	<%String nextModeCode = i26+" "+i27;%>
            	<input type="hidden" name="nextModeCode" value="<%=nextModeCode%>">
                <input class="InputGrey" name="i18" size="30"maxlength=20 value="<%=nextModeCode%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">申请主套餐</TD>
            <TD id="ipTd">  <input class="InputGrey" name="i160" size="30" maxlength=20 value="<%=newModeCode%>" readonly>
           <!--     <input class="InputGrey" type="text" class="button" name="ip" size="8" value="<%=ip%>" readonly>
                <input class="InputGrey" type="text" class="button" name="iq" size="18" value="<%=iq%>" readonly>&nbsp;&nbsp;
			-->
                <!------------------------------------------------------------------->
                <input type="hidden" class="button" name="ip1" size="8" maxlength="8">
                <input type="hidden" class="button" name="iq1" size="8" maxlength="8">
                <input type="hidden" class="button" name="ip" size="8" maxlength="8" value="<%=ip%>">
                <input type="hidden" class="button" name="iq" size="8" maxlength="8"  value="<%=iq%>">
                <!--------------------------------------------------------------------->

            </TD>
            <td>&nbsp;</td>
            <td>&nbsp;</td>

        </TR>

<!------------------------------------------------------------------>
<input type="hidden" name="maincash_no" value="<%=i16%>">
<input type="hidden" name="belong_code" value="<%=i20%>">
<input type="hidden" name="do_string_add">
<input type="hidden" name="addcash_string">
<input type="hidden" name="toprintdata">
<input type="hidden" name="i19" size="20" maxlength=20 value="<%=i19%>">
<input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>">
<input type="hidden" name="favorcode" size="20" maxlength=20 value="<%=i23%>">
<input class="button" type="hidden" name="imain_stream" size="20" maxlength=20 value="<%=i18%>" readonly>
<input type="hidden" name="next_main_stream" value="<%=i28%>">
<!------------------huhx add for 其他产品的个性化信息--------->
<input type="hidden" name="iAddStr" value="<%=iadd_str%>">
<input type="hidden" name="iOpCode" value="<%=opCode%>">
<input type="hidden" name="beforeOpCode" value="1270"><!--冲正时传送对应申请业务的opCode-->
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="modestr">
<!-------------------------------------------------------------->
        <tr>
            <td nowrap colspan="4" id="footer">
                <div align="center">
                    <input class="b_foot" name=next type=button  onclick="printCommit()" value=冲正确认>
                    <input class="b_foot" name=close  onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
                    <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
                </div>
            </td>
        </tr>
    </TABLE>
<!---------------------------结束第一层表格欠套------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script language="javascript">

/*-------------------------页面提交跳转函数----------------------------*/
function pageSubmit(flag){

    var maincash = document.all.maincash.value;//当前主套餐
    var i18 = document.all.i18.value.substring(0,8);//下月主套餐
    var ip = document.all.ip.value; //申请主套餐
    if(i18 == ip && ip == maincash)
    {
        rdShowMessageDialog('申请主套餐不能与当前主套餐,下月主套餐相同!',0);
        document.all.ip.focus();
        return false;
    }
    if(i18 == ip && ip != maincash)
    {
        rdShowMessageDialog('申请主套餐不能与下月主套餐相同!',0);
        document.all.ip.focus();
        return false;
    }
 	if(flag==1){
    	document.form1.action="f1270_1.jsp";
        form1.submit();
	}
	if(flag==2)
	{
	    document.form1.action="f127a_3.jsp";
      form1.submit();
	}
	if(flag==3)
	{
	    document.form1.action="f1270_2.jsp";
      form1.submit();
	}
}

/****************************判断文本域的长度是否符合要求**************************/
function thelength()
{
    var length = document.all.ip.value.length;
    /*
    if(length<8)
    {
        //alert("申请主套餐代码长度应该为8位！");
        rdShowMessageDialog('申请主套餐代码长度应该为8位！',0);
        document.all.ip.focus();//返回焦点
        return false;
    }
    else
    {
        return true;
    }*/
	/* 20100101 要考虑放开
	if(length<=0)
    {
        //alert("申请主套餐代码长度应该为8位！");
        rdShowMessageDialog('申请主套餐代码长度不应该为0！',0);
        document.all.ip.focus();//返回焦点
        return false;
    }
    else
    {
        return true;
    }*/
    return true;
}
//主资费预约取消
function printInfo127a()
{
	  //得到该业务工单需要的参数
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";
	  /********基本信息类**********/
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="用户品牌: "+"<%=sNewSmName%>" + "  *"+ "办理业务:主资费预约取消"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
       <%}else{%>
       opr_info+="操作流水: "+"<%=printAccept%>" +"|";
       <%}%>
      opr_info+="当前主资费："+"<%=newModeCode%>" +"|";
      opr_info+="预约主资费："+"<%=nextModeCode%>"+"|";
      note_info1+="说明：用户办理主资费预约取消后，预约的主资费将不会生效，当前主资费继续执行。"+"|";

	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      	  note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
     	  note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	  <%}%>
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo127a(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null;

	var sysAccept = "<%=printAccept%>";

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}
function printCommit()
{
	//document.all.sure.disabled=true;
	//document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//系统备注

	var ret=showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	var iReturn=0;
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm")){
			iReturn=showEvalConfirmDialog("确认电子免填单吗?");
	        pageSubmit(2);
      	}
    }
	if(ret=="continueSub")
	{
		iReturn=showEvalConfirmDialog("确认要提交信息吗?");
		pageSubmit(2);
		return true;
   }
}

</script>