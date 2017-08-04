<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%/*
* 黑龙江BOSS-开关机管理－HLR信息查询  2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
    String opCode = "1248";
    String opName = "HLR信息查询";
    String phoneNo = (String)request.getParameter("i1");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-开关机管理－HLR信息查询</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>
<%@ include file="head_1248.jsp"%>

<TABLE cellSpacing=0>
<% 
    //S1270View  callView = new S1270View();
    /*
    System.out.println("result_1[0]=["+result_1[0]+"]");
    System.out.println("oret_code=["+oret_code+"]");
    System.out.println(retArray.size());
    */
%>
    <TR> 
        <TD class="blue">服务号码</TD>
        <TD colspan="3">
            <input class="InputGrey" name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20"  readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">客户名称</TD>
        <TD>
            <input class="InputGrey" name="ocust_name" size="20"  value="<%=ReqUtil.get(request,"ocust_name")%>" readonly >
        </TD>
        <TD class="blue">客户住址</TD>
        <TD>
            <input class="InputGrey" name="ocust_addr" size="20"  value="<%=ReqUtil.get(request,"ocust_addr")%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">证件类型</TD>
        <TD>
            <input class="InputGrey" name="oid_type" value="<%=ReqUtil.get(request,"oid_type")%>" size="20" readonly>
        </TD>
        <TD class="blue">证件号码</TD>
        <TD>
            <input class="InputGrey" name="oid_iccid" size="20"  value="<%=ReqUtil.get(request,"oid_iccid")%>"   readonly >
        </TD>
    </TR>
    <TR> 
        <TD class="blue">状态代码</TD>
        <TD>
            <input class="InputGrey" name="orun_code" size="20"  value="<%=ReqUtil.get(request,"orun_code")%>" readonly>
        </TD>
        <TD class="blue">状态名称</TD>
        <TD>
            <input class="InputGrey" name="orun_name" size="20"  value="<%=ReqUtil.get(request,"orun_name")%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">HLR代码</TD>
        <TD>
            <input class="InputGrey" name="ohlr_code" value="<%=ReqUtil.get(request,"ohlr_code")%>" size="20" readonly>
        </TD>
        <TD class="blue">HLR信息</TD>
        <TD>
            <input class="InputGrey" name="ohlr_name" size="20"  value="<%=ReqUtil.get(request,"ohlr_name")%>"   readonly >
        </TD>
    </TR>

<%
        //ArrayList  retArray_favor = new ArrayList();
        //String[][] result_favor = new String[][]{};
    String strsql = "";
    String favor_code = "";
    String hand_fee = "";
    try{
        strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1248'";
            //retArray_favor = callView.spubqry32Process("2","",strsql).getList();
%>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2">
        <wtc:sql><%=strsql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result_favor" scope="end"/>
<%

            //result_favor = (String[][])retArray_favor.get(1);
	if(result_favor.length > 0)
       {
          hand_fee = result_favor[0][0];
          favor_code = result_favor[0][1];
       }
    }
    catch(Exception e)
    {
        e.printStackTrace() ;
        System.out.println("Call services is Failed!");
    }

%>
<%
        //out.println(favorcode);
    int m =0;
    for(int p = 0;p< favInfo.length;p++){//优惠资费代码
        for(int q = 0;q< favInfo[p].length;q++)
        {
                //out.println("优惠资费代码：["+ favInfo[p][q]+"]");
            if(favInfo[p][q].trim().equals(favor_code.trim()))
            {
                    // out.println("wwww");
                ++m;
            }
        }
    }
        //out.println("m="+m);
%>
    <TR>
        <%if(m != 0){%>		 
        
            <TD colspan="4">
                <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" v_must=1 v_type=float >
                <input type="hidden" name="ishould_fee" size="20"maxlength=20 value="<%=hand_fee%>" readonly>
            </TD>
            <script language="jscript">
                document.all.ohand_cash.focus();
            </script>
        <%}else{%>
        
            <TD width="34%" colspan="4">
                <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
                <input type="hidden" name="ishould_fee" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
            </TD>
        <%}%>
    </TR>
    <TR>
        <TD class="blue" colspan=4>HLR信息详情</TD>
    </TR>
<!--------------------------------------------调用HLR信息查询服务------------------------------------->
<%      
    //ArrayList retArray = new ArrayList();
	//ArrayList getList = new ArrayList();
//    String[][] result = new String[][]{};
	//String [] result_1 = new String [2];
/*--------------------------------组织s1246Cfm的传入参数-------------------------------*/
    String ilogin_accept = ReqUtil.get(request,"stream");             //系统流水
    String iop_Code ="1248";                                          //操作代码					 
    String iwork_no = (String)session.getAttribute("workNo");         //操作工号                  
    String iwork_pwd = (String)session.getAttribute("password");      //工号密码						 
    String iorg_code = (String)session.getAttribute("orgCode");       //org_code 
    String icust_id = ReqUtil.get(request,"cust_id");                 //客户ID
    String ihlr_code = ReqUtil.get(request,"hlr_code");               //HLR代码
    String ishould_fee = ReqUtil.get(request,"ishould_fee");          //应交手续费
    String ireal_fee = ReqUtil.get(request,"ohand_cash");             //实际手续费
    String isys_note = ReqUtil.get(request,"sysnote");                //系统备注					 
    String ido_note = ReqUtil.get(request,"donote");                  //操作备注
    String ithe_ip = (String)session.getAttribute("ipAddr");          //登陆IP		
    String iphone_no = ReqUtil.get(request,"i1");					  //手机号码
    String ret_code = "";
    String ret_msg = "";
    String login_accept="";                                           //流水
    String str_hlr_code="";                                           //HLR代码串

    if(ireal_fee.equals(""))
        ireal_fee = "0";
    if(ishould_fee.equals(""))
        ishould_fee = "0";
    float handcash = Float.parseFloat(ireal_fee);                    //手续费单精度
/*--------------------------------开始调用s1248Cfm--------------------------------*/			                        
try{
    /*
    retArray = callView.s1248CfmProcess(ilogin_accept,iop_Code,
                                        iwork_no,iwork_pwd,
                                        iorg_code,icust_id,
                                        ihlr_code,ishould_fee,
                                        ireal_fee,isys_note,
                                        ido_note,ithe_ip,iphone_no).getList();
     */
%>
    <wtc:service name="s1248Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1248CfmCode" retmsg="s1248CfmMsg" outnum="2" >
    	<wtc:param value="<%=ilogin_accept%>"/>
    	<wtc:param value="<%=iop_Code%>"/> 
        <wtc:param value="<%=iwork_no%>"/>
        <wtc:param value="<%=iwork_pwd%>"/>
        <wtc:param value="<%=iorg_code%>"/>
        
        <wtc:param value="<%=icust_id%>"/>
        <wtc:param value="<%=ihlr_code%>"/>
        <wtc:param value="<%=ishould_fee%>"/>
        <wtc:param value="<%=ireal_fee%>"/>
        <wtc:param value="<%=isys_note%>"/>
        
        <wtc:param value="<%=ido_note%>"/>
        <wtc:param value="<%=ithe_ip%>"/>
        <wtc:param value="<%=iphone_no%>"/>
    </wtc:service>
    <wtc:array id="s1248CfmArr" scope="end"/>
<%

    ret_code = s1248CfmCode;
    ret_msg  = s1248CfmMsg;
    if(s1248CfmArr.length > 0 && s1248CfmCode.equals("000000"))
    {

      String[][]  result = s1248CfmArr;   //取出结果集

    }
        
}
catch(Exception e){
      e.printStackTrace() ;
	  //System.err.println("***********call service is failed****************"+e.getMessage());

}

				

if(ret_msg.equals(""))
{
    ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
    if( ret_msg.equals("null"))
	{
	    ret_msg ="未知错误信息";
	}
}
	/*System.out.println("in page ret_code="+ret_code);
    System.out.println("in page ret_msg="+ret_msg);  
    //response.data.add("str_hlr_code",'<%=str_hlr_code
	System.out.println("str_hlr_code="+str_hlr_code);
	int hlrlength = str_hlr_code.length();
	*/
%>
<%
if(!ret_code.equals("000000")){%>

<script language="javascript">
	 var ret_code = "<%=ret_code%>";
      var ret_msg = "<%=ret_msg%>";
      rdShowMessageDialog("查询错误！<br>错误代码："+ret_code+"。<br>错误信息："+ret_msg+"。",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s1246/f1248_1.jsp?activePhone=<%=iphone_no%>");
</script>

<%}
String phone_no = "";
String imsi="";
String otoll = "";
String oroam = "";
String ono_out = "";
String ono_in = "";
String oconfine_out = "";
String oconfine_in = "";
String omsm_send = "";
String omsm_receive = "";
String odiversion = "";
String obusy_div = "";
String ono_con_ans = "";
String ocan_no_ans = "";
String ocall_bide = "";
String ocall_keep = "";
String othird_call = "";
String ofax = "";
String odata_comm = "";
String ophone_dis = "";
String omain_hidden = "";
String ogprs = "";
String ovisa = "";


if(ret_code.equals("000000")&&str_hlr_code.length()>0){
    phone_no = str_hlr_code.substring(0,11);//截取前11位得到---手机号码
    str_hlr_code = str_hlr_code.substring(11);
    imsi = str_hlr_code.substring(0,15);//截取从第12位到第26位---imsi号码
    str_hlr_code = str_hlr_code.substring(15);
    otoll = str_hlr_code.substring(0,1);//截取第27位---长途方式
    if(otoll.equals("1"))otoll="国际";
    if(otoll.equals("2"))otoll="国内";
    oroam = str_hlr_code.substring(1,2);//截取第28位---漫游方式
    if(oroam.equals("1"))oroam="国际";
    if(oroam.equals("2"))oroam="国内";
    if(oroam.equals("3"))oroam="省内";
    if(oroam.equals("4"))oroam="地区";
    if(oroam.equals("5"))oroam="城市";
    ono_out = str_hlr_code.substring(2,3);//截取第29位---欠费禁止呼出
    if(ono_out.equals("y"))ono_out="是";
    if(ono_out.equals("n"))ono_out="否";
    ono_in = str_hlr_code.substring(3,4);//截取第30位---欠费禁止呼入
    if(ono_in.equals("y"))ono_in="是";
    if(ono_in.equals("n"))ono_in="否";
    oconfine_out = str_hlr_code.substring(4,5);//截取第31位---呼出限制
    if(oconfine_out.equals("y"))oconfine_out="是";
    if(oconfine_out.equals("n"))oconfine_out="否";
    oconfine_in = str_hlr_code.substring(5,6);//截取第32位---呼入限制
    if(oconfine_in.equals("y"))oconfine_in="是";
    if(oconfine_in.equals("n"))oconfine_in="否";
    omsm_send = str_hlr_code.substring(6,7);//截取第33位---短信发送
    if(omsm_send.equals("y"))omsm_send="是";
    if(omsm_send.equals("n"))omsm_send="否";
    omsm_receive = str_hlr_code.substring(7,8);//截取第34位---短信接收
    if(omsm_receive.equals("y"))omsm_receive="是";
    if(omsm_receive.equals("n"))omsm_receive="否";
    odiversion = str_hlr_code.substring(8,9);//截取第35位---无条件呼转
    if(odiversion.equals("y"))odiversion="是";
    if(odiversion.equals("n"))odiversion="否";
    obusy_div = str_hlr_code.substring(9,10);//截取第36位---遇忙转移
    if(obusy_div.equals("y"))obusy_div="是";
    if(obusy_div.equals("n"))obusy_div="否";
    ono_con_ans = str_hlr_code.substring(10,11);//截取第37位---无应答转移
    if(ono_con_ans.equals("y"))ono_con_ans="是";
    if(ono_con_ans.equals("n"))ono_con_ans="否";
    
    ocan_no_ans = str_hlr_code.substring(11,12);//截取第38位---不可及转移
    if(ocan_no_ans.equals("y"))ocan_no_ans="是";
    if(ocan_no_ans.equals("n"))ocan_no_ans="否";
    
    ocall_bide = str_hlr_code.substring(12,13);//截取第39位---呼叫等待
    if(ocall_bide.equals("y"))ocall_bide="是";
    if(ocall_bide.equals("n"))ocall_bide="否";
    ocall_keep = str_hlr_code.substring(13,14);//截取第40位---呼叫保持
    if(ocall_keep.equals("y"))ocall_keep="是";
    if(ocall_keep.equals("n"))ocall_keep="否";
    othird_call = str_hlr_code.substring(14,15);//截取第41位---三方通话
    if(othird_call.equals("y"))othird_call="是";
    if(othird_call.equals("n"))othird_call="否";
    ofax = str_hlr_code.substring(15,16);//截取第42位---传真
    if(ofax.equals("y"))ofax="是";
    if(ofax.equals("n"))ofax="否";
    odata_comm = str_hlr_code.substring(16,17);//截取第43位---数据通信
    if(odata_comm.equals("y"))odata_comm="是";
    if(odata_comm.equals("n"))odata_comm="否";
    ophone_dis = str_hlr_code.substring(17,18);//截取第44位---来电显示
    if(ophone_dis.equals("y"))ophone_dis="是";
    if(ophone_dis.equals("n"))ophone_dis="否";
    omain_hidden = str_hlr_code.substring(18,19);//截取第45位---主叫隐藏
    if(omain_hidden.equals("y"))omain_hidden="是";
    if(omain_hidden.equals("n"))omain_hidden="否";
    ogprs = str_hlr_code.substring(19,20);//截取第46位---gprs
    if(ogprs.equals("y"))ogprs="是";
    if(ogprs.equals("n"))ogprs="否";
    ovisa = str_hlr_code.substring(20,21);//截取第47位---签约用户
    if(ovisa.equals("y"))ovisa="是";
    if(ovisa.equals("n"))ovisa="否";
}
%>
    <TR> 
        <TD class="blue">手机号码</TD>
        <TD>
            <input class="InputGrey" name="ophone_no" size="20"  value="<%=phone_no%>" readonly>
        </TD>
        <TD class="blue">imis号</TD>
        <TD>
            <input class="InputGrey" name="oimis_no" size="20"  value="<%=imsi%>" readonly>
        </TD>
    </TR>
    <TR>
        <TD class="blue">长途方式</TD>
        <TD>
            <input class="InputGrey" name="otoll" size="20"  value="<%=otoll%>" readonly>
        </TD>
        <TD class="blue">漫游方式</TD>
        <TD>
            <input class="InputGrey" name="oroam" size="20"  value="<%=oroam%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">欠费禁止呼出</TD>
        <TD>
            <input class="InputGrey" name="ono_out" size="20"  value="<%=ono_out%>" readonly>
        </TD>
        <TD class="blue">欠费禁止呼入</TD>
        <TD>
            <input class="InputGrey" name="ono_in" size="20"  value="<%=ono_in%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">呼出限制</TD>
        <TD>
            <input class="InputGrey" name="oconfine_out" size="20"  value="<%=oconfine_out%>" readonly>
        </TD>
        <TD class="blue">呼入限制</TD>
        <TD>
            <input class="InputGrey" name="oconfine_in" size="20"  value="<%=oconfine_in%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">短信发送</TD>
        <TD>
            <input class="InputGrey" name="omsm_send" size="20"  value="<%=omsm_send%>" readonly>
        </TD>
        <TD class="blue">短信接收</TD>
        <TD>
            <input class="InputGrey" name="omsm_receive" size="20"  value="<%=omsm_receive%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">无条件呼转</TD>
        <TD>
            <input class="InputGrey" name="odiversion" size="20"  value="<%=odiversion%>" readonly>
        </TD>
        <TD class="blue">遇忙转移</TD>
        <TD>
            <input class="InputGrey" name="obusy_div" size="20"  value="<%=obusy_div%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">无应答转移</TD>
        <TD>
            <input class="InputGrey" name="ono_con_ans" size="20"  value="<%=ono_con_ans%>" readonly>
        </TD>
        <TD class="blue">不可及转移</TD>
        <TD>
            <input class="InputGrey" name="ocan_no_ans" size="20"  value="<%=ocan_no_ans%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">呼叫等待</TD>
        <TD>
            <input class="InputGrey" name="ocall_bide" size="20"  value="<%=ocall_bide%>" readonly>
        </TD>
        <TD class="blue">呼叫保持</TD>
        <TD>
            <input class="InputGrey" name="ocall_keep" size="20"  value="<%=ocall_keep%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">三方通话</TD>
        <TD>
            <input class="InputGrey" name="othird_call" size="20"  value="<%=othird_call%>" readonly>
        </TD>
        <TD  class="blue">传真</TD>
        <TD>
            <input class="InputGrey" name="ofax" size="20"  value="<%=ofax%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">数据通信</TD>
        <TD>
            <input class="InputGrey" name="odata_comm" size="20"  value="<%=odata_comm%>" readonly>
        </TD>
        <TD class="blue">来电显示</TD>
        <TD>
            <input class="InputGrey" name="ophone_dis" size="20"  value="<%=ophone_dis%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD  class="blue">主叫隐藏</TD>
        <TD >
            <input class="InputGrey" name="omain_hidden" size="20"  value="<%=omain_hidden%>" readonly>
        </TD>
        <TD class="blue">GPRS</TD>
        <TD>
            <input class="InputGrey" name="ogprs" size="20"  value="<%=ogprs%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">是否签约用户</TD>
        <TD colspan="3">
            <input class="InputGrey" name="ovisa" size="20"  value="<%=ovisa%>" readonly>
        </TD>
    </TR>
    <TR id="footer"> 
        <TD colspan=4>
            <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>	  
</FORM>
</BODY>
</HTML>
  
 
