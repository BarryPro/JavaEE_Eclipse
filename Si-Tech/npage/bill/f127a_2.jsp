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
<%
/*
 * 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
 *		部分变量的命名依据对此变量使用的意义，或用途。
 */%>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    //在此处读取session信息
    Logger logger = Logger.getLogger("f127a_2.jsp");
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String aftertrim = ((String)session.getAttribute("powerRight")).trim();
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String result222[][]=new String[][]{};
    String result111[][]=new String[][]{};
    String strArray="var arrMsg; ";  //must 
%>
<%      
	//S1100View callView1 = new S1100View();
	//ArrayList retArray = new ArrayList();
    //ArrayList retArray_select = new ArrayList();
    //String[][] result = new String[][]{};
    //String[][] result_select = new String[][]{};
 	//S1270View  callView = new S1270View();  
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
%>

<!----------------------------------页头显示区域----------------------------------------->

<%			
	String work_no = (String)session.getAttribute("workNo");                                   //获得工号信息
	String phone = ReqUtil.get(request,"i1");                      //获得传来手机号码
	String op_code = ReqUtil.get(request,"iOpCode");
	String iadd_str = ReqUtil.get(request,"iAddStr");	
	String pw_favor = ReqUtil.get(request,"pw_favor");                //密码优惠权限标志位1:有0:无	
	String sNewSmName="";
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
	String return_page="";
	try
 	{  
         paraAray1[0] = work_no;		/* 操作工号   */ 
         paraAray1[1] = phone; 	        /* 手机号码   */
         paraAray1[2] = op_code;	    /* 操作代码   */
		 paraAray1[3] = "";	/* 密码   */
 
         //retArray = impl.callFXService("s1270GetMsg", paraAray1, "31","phone",phone);
         String loginPswInput = (String)session.getAttribute("password");
%>
        <wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=phone%>" outnum="32" retcode="s1270GetMsgCode" retmsg="s1270GetMsgMsg">
            <wtc:param value=""/>
            <wtc:param value="01"/>
            <wtc:param value="<%=paraAray1[2]%>"/>
            <wtc:param value="<%=paraAray1[0]%>"/>
            <wtc:param value="<%=loginPswInput%>"/> 
            <wtc:param value="<%=paraAray1[1]%>"/>
            <wtc:param value="<%=paraAray1[3]%>"/>
    	</wtc:service>
    	<wtc:array id="retS1270GetMsgArr"  scope="end"/>
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
            i2 = retS1270GetMsgArr[0][2];				  // 用户ID          
            i3 = retS1270GetMsgArr[0][3];				  // 客户密码        
            i4 = retS1270GetMsgArr[0][4];				  // 客户名称        
            i5 = retS1270GetMsgArr[0][5];				  // 客户地址        
            i6 = retS1270GetMsgArr[0][6];				  // 客户证件类型名称 
            i7 = retS1270GetMsgArr[0][7];				  // 客户证件号码     
            i8 = retS1270GetMsgArr[0][8];				  // 业务品牌        
            i9 = retS1270GetMsgArr[0][9];				  // 业务品牌名称     
            i10 = retS1270GetMsgArr[0][10];			  // 用户运行状态     
            i11 = retS1270GetMsgArr[0][11];			  // 用户运行状态名称 
            i12 = retS1270GetMsgArr[0][12];			  // 总欠费          
            i13 = retS1270GetMsgArr[0][13];			  // 总预存款        
            i14 = retS1270GetMsgArr[0][14];			  // 第一欠费帐号     
            i15 = retS1270GetMsgArr[0][15];			  // 第一欠费        
            i16 = retS1270GetMsgArr[0][16];			  // 当前主套餐代码        
            i17 = retS1270GetMsgArr[0][17];			  // 当前主套餐名称     
            i18 = retS1270GetMsgArr[0][18];			  // 当前主套餐开通流水 
            i19 = retS1270GetMsgArr[0][19];			  // 手续费          
            i20 = retS1270GetMsgArr[0][20];              // belong_code  
            i21 = retS1270GetMsgArr[0][21];              // 大客户类型
            i22 = retS1270GetMsgArr[0][22];              // 大客户类型名称
            i23 = retS1270GetMsgArr[0][23];              // 手续费优惠代码 
            i24 = retS1270GetMsgArr[0][24];              // 集团客户类别           
            i25 = retS1270GetMsgArr[0][25];              // 集团客户类别名称      
            i26 = retS1270GetMsgArr[0][26];              // 下月主资费            oNextMode       
            i27 = retS1270GetMsgArr[0][27];    		  // 下月主资费名称        oNextModeName   
            i28 = retS1270GetMsgArr[0][28];			  // 下月主资费开通流水    oNextModeAccept 
            before_mode_code = retS1270GetMsgArr[0][29];	// 上个主套餐代码
            before_mode_code_name = retS1270GetMsgArr[0][30];	// 上个主套餐代码名称
        }
        
        if(op_code.equals("127a"))
        {
            titleStr = "主资费预约取消";
            return_page = "s127a_1.jsp";
            
            ip = i16;
            iq = i17;
        }else if(op_code.equals("127b"))
        {
            titleStr = "主资费冲正";
            return_page = "s127b_1.jsp";
            ip = before_mode_code;
            iq = before_mode_code_name;
        }
        
        ibig_cust_ls = i21 + " " + i22;   //大客户类型名称页面显示
        subi20 = i20.substring(0,2);
        disCode = i20.substring(2,4);
        String[][] allNewSmInfo=(String[][])arr.get(5);
        sNewSmName=WtcUtil.getNewSm(((String[][])arr.get(0))[0][16].substring(0,2),i8,allNewSmInfo,"1");
    }
    catch(Exception e)
    {
        System.out.println("页面发生错误，如下：");
        e.printStackTrace();
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
            <%if(op_code.equals("127a")){%>
                document.location.replace("<%=request.getContextPath()%>/npage/bill/f127a_1.jsp?activePhone=<%=phone%>");
            <%}else if(op_code.equals("127b")){%>
                document.location.replace("<%=request.getContextPath()%>/npage/bill/f127b_1.jsp?activePhone=<%=phone%>");
            <%}%>
        </script>
<%  }%>




<%
    //******************得到二次批假代码串***************************//
    //comImpl co=new comImpl();
    //资费代码 
    String sqlFlagCode  = "";  
    sqlFlagCode  = "select a.flag_code,  a.rate_code from sRateFlagCode a, sBillModeDetail b where a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='"+ subi20 + "' and b.mode_code='" + ip + "' order by a.flag_code" ;
    System.out.println("sqlFlagCode==" + sqlFlagCode);
    //ArrayList flagCodeArr  = co.spubqry32("2",sqlFlagCode );
%>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="2" retcode="retCode1" retmsg="retMsg1">
        <wtc:sql><%=sqlFlagCode%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retPubSelectArr1"  scope="end"/>
<%
    //String[][] flagCodeStr  = (String[][])flagCodeArr.get(0);
    String[][] flagCodeStr  = retPubSelectArr1;
    String iAddRateStr = "",tempStr="";
    for(int i=0;i<flagCodeStr.length;i++)
    {
        tempStr = flagCodeStr[i][0] + "$" + flagCodeStr[i][1] + "&";
        iAddRateStr = iAddRateStr + tempStr;
    }
    iAddRateStr = "$";//冲正和预约取消不需要传这个参数，所以屏蔽
%>

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
                <input class="InputGrey" name="i1" value="<%=phone%>" size="20" maxlength=11 v_must=1 v_type=0_9 readonly>
            </TD>
            <TD class="blue">客户ID</TD>
            <TD>  
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
            <td nowrap ><input class="InputGrey" type=text name="sNewSmName" value="<%=sNewSmName%>" maxlength="15"/> </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <TR> 
            <TD class="blue">业务类型</TD>
            <TD>
                <%String add = i8+" "+i9;%>
                <input class="InputGrey" name="i8" size="20" maxlength=20 value="<%=add%>" readonly>
                <input type="hidden" name="i9" size="13" maxlength=20  readonly>
            </TD>
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
                <%String add2 = i16+" "+i17;%>
                <input class="InputGrey" name="i16" size="30"maxlength=20 value="<%=add2%>" readonly>
                <input type="hidden" name="maincash" size="20"maxlength=20 value="<%=i16%>" readonly>
            </TD>
            <TD class="blue">下月主套餐</TD>
            <TD>
                <input class="InputGrey" name="i18" size="30"maxlength=20 value="<%=i26%> <%=i27%>" readonly>
            </TD>
        </TR>	
        <TR style="display:none"> 
            <TD nowrap class="blue">业务品牌</TD>
            <TD nowrap colspan="3"> 
                <select align="left" name=newSmCode width=50 index="1" onChange="chgNewSm()">	
                    <%
                        //得到大的业务品牌
                        try
                        {
                            String sqlStr = "select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='"+regionCode+"'order by bsm_code";
                            //retArray = callView1.view_spubqry32("2",sqlStr);
                    %>
                            <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="2" retcode="retCode2" retmsg="retMsg2">
                            <wtc:sql><%=sqlStr%></wtc:sql>
                            </wtc:pubselect>
                            <wtc:array id="retPubSelectArr2"  scope="end"/>
                    <%
                            //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                            //System.out.println("retPubSelectArr[0][0]="+retPubSelectArr[0][0]);
                            //System.out.println("retPubSelectArr[0][1]="+retPubSelectArr[0][1]);
                            //result222 = (String[][])retArray.get(0);
                            result222 = retPubSelectArr2;
                            //System.out.println("result222[0][0]="+result222[0][0]);
                            //System.out.println("result222[0][1]="+result222[0][1]);
                            int recordNum = result222.length;      		
                            for(int i=0;i<recordNum;i++){
                                out.println("<option class='button' value='" + result222[i][0] + "'>" + result222[i][1] + "</option>");
                            }
                            sqlStr = "select distinct a.BSM_CODE ,a.sm_code ,b.sm_name from snewsmcode a,ssmcode b where a.sm_code=b.sm_code";
                            //retArray = callView1.view_spubqry32("3",sqlStr);
                    %>
                            <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="3" retcode="retCode3" retmsg="retMsg3">
                            <wtc:sql><%=sqlStr%></wtc:sql>
                            </wtc:pubselect>
                            <wtc:array id="retPubSelectArr3"  scope="end"/>
                    <%
                            //result222 = (String[][])retArray.get(0);
                            result222 = retPubSelectArr3;
                            strArray = CreatePlanerArray.createArray("arrMsg",result222.length);
                        }catch(Exception e){
                            logger.error("Call sunView is Failed!");
                        }          
                    %>
                </select>
            </TD>
        </TR>
         
        <TR style="display:none"> 
            <TD class="blue">业务类型</TD>
            <TD>
                <select name="s_city" id="s_city" onchange="tochange()" ></select>		
            </TD>
            <TD class="blue"> 套餐类别</TD>
                <input type="hidden"  name="subi20" value="<%=subi20%>" >
            <TD>
                <select name="s_spot" id="s_spot" onChange="controlFlagCodeTdView()">
                <%
                
                //得到输入参数
                try
                {		
                    String sqlStr ="select MODE_TYPE,MODE_TYPE||'-->'||TYPE_NAME from sbillmodetype where REGION_CODE = '"+subi20+"' and MODE_FLAG='0' and sm_code='cb'";  
                    //retArray = callView1.view_spubqry32("2",sqlStr);
                %>
                    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="2" retcode="retCode4" retmsg="retMsg4">
                    <wtc:sql><%=sqlStr%></wtc:sql>
                    </wtc:pubselect>
                    <wtc:array id="retPubSelectArr4"  scope="end"/>
                <%
                    //result111 = (String[][])retArray.get(0);
                    result111 = retPubSelectArr4;
                    int recordNum = result111.length; 
                    
                    for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='"+result111[i][0]+"'>" + result111[i][1] + "</option>");
                    }
                }
                catch(Exception e){
                    e.printStackTrace() ;
                    //System.out.println("Call services is Failed!");
                }          
                %>
                
                </select>
            </TD>
        </TR>
        <TR> 
            <TD class="blue">申请主套餐</TD>
            <TD id="ipTd">
                <!------------------------------------------------------------------->
                <input type="hidden" class="button" name="ip1" size="8" maxlength="8">
                <input type="hidden" class="button" name="iq1" size="8" maxlength="8">
                <!--------------------------------------------------------------------->
                <input class="InputGrey" type="text" class="button" name="ip" size="8" maxlength="8" v_must=1  onclick="" value="<%=ip%>" readonly>
                <input class="InputGrey" type="text" class="button" name="iq" size="18" v_must=0 v_type=string onclick="" value="<%=iq%>" readonly>&nbsp;&nbsp;
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
<input type="hidden" name="iOpCode" value="<%=op_code%>">
<input type="hidden" name="iAddRateStr" value="<%=iAddRateStr%>">
<input type="hidden" name="beforeOpCode" value="1270"><!--冲正时传送对应申请业务的opCode-->
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<!-------------------------------------------------------------->
			 
        
        <tr>
            <td nowrap colspan="4" id="footer">
                <div align="center"> 
                    <input class="b_foot" name=next type=button  onclick="if(check(form1))
                        if(thelength()) pageSubmit(2)"value=下一步>
                    <input class="b_foot" name=1111   type=button  onClick="toclean()" value=清除>
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
<%/*------------------------javascript区----------------------------*/%>
<script language="javascript">
<%=strArray%>
<%
    for(int i = 0 ; i < result222.length ; i++){
        for(int j = 0 ; j < result222[i].length ; j++){
    
    if(result222[i][j].trim().equals("") || result222[i][j] == null){
        result222[i][j] = "";
    }
    //System.out.println("||---------" + result222[i][j].trim() + "-------------||");
%>

arrMsg[<%=i%>][<%=j%>] = "<%=result222[i][j].trim()%>";
<%
        }
    }
%>
document.all.ip.focus();
/*------------------------- 调用公共查询界面得到结果---------------------------*/
function chgNewSm(){
    temp_select_value=document.all.newSmCode.value;
    document.all.s_city.length=0;
    for(temp_i=0;temp_i<arrMsg.length;temp_i++){
        if(arrMsg[temp_i][0]==temp_select_value){
            var newItem=document.createElement("OPTION");
            newItem.text=arrMsg[temp_i][1]+"-->"+arrMsg[temp_i][2];
            newItem.value=arrMsg[temp_i][1];
            document.all.s_city.options.add(newItem);
        }
    }
    tochange();
}
function getBankCode()
{ 
    //调用公共js得到银行代码
    var pageTitle = "资费代码查询";
    var fieldName = "资费代码|资费名称|生效日期|";
    var sqlStr ="select a.new_mode,b.mode_name,decode(a.SEND_FLAG,'0','0 24小时之内生效','1','1 一般预约 ','2','2 个性预约')";
    sqlStr=sqlStr+" from cBillBBChg a,sBillModeCode b where a.region_code='<%=subi20%>' and a.district_code in ('<%=disCode%>','99')";
    sqlStr=sqlStr+" and a.op_code=<%=op_code%> and a.OLD_MODE ='<%=java.net.URLEncoder.encode(i16)%>' and a.new_mode like '%";
    sqlStr=sqlStr+jtrim(document.all.ip.value)+"%' and b.mode_name like '%"+jtrim(document.all.iq.value);
    sqlStr=sqlStr+"%' and b.region_code=a.region_code and b.mode_code=a.new_mode and a.POWER_RIGHT <= <%=aftertrim%>  and b.SM_CODE ='";
    sqlStr=sqlStr+ document.all.s_city.options[document.all.s_city.selectedIndex].value.substring(0,2);
    sqlStr=sqlStr + "' and b.MODE_TYPE ='" + document.all.s_spot.value+"'";
    sqlStr=sqlStr + " and b.start_time<=sysdate and b.stop_time>sysdate and select_flag='0' ";
    sqlStr=sqlStr + " order by ORDER_FAV"
    /*sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  */
    //alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "ip|iq|";
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function getFlagCode()
{ 
    //调用公共js得到银行代码
    var pageTitle = "关联代码查询";
    var fieldName = "关联代码|关联代码名称|二次批价代码|";
    var sqlStr ="select a.flag_code, a.flag_code_name, a.rate_code from sRateFlagCode a, sBillModeDetail b where a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='<%=subi20%>' and b.mode_code='" + document.form1.ip.value + "' order by a.flag_code" ;
    //alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";
    var retToField = "flag_code|flag_code_name|rate_code|";
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/*----------------------------调用RPC处理连动问题------------------------------------------*/

    //core.loadUnit("debug");
    //core.loadUnit("rpccore"); 
    onload=function(){
        //core.rpc.onreceive = doProcess;
        chgNewSm();
    }
function tochange()
{
    var subi20 = document.all.subi20.value;
    var sm = document.all.s_city[document.all.s_city.selectedIndex].value.substring(0,2);
    var myPacket = new AJAXPacket("f1270_5.jsp","正在获得资费类别信息，请稍候......");
    myPacket.data.add("subi20",subi20);
    myPacket.data.add("sm",sm);
    core.ajax.sendPacket(myPacket);
    myPacket = null;
}

/*-----------------------------RPC处理函数------------------------------------------------*/
function doProcess(packet)
{
    var rpc_page=packet.data.findValueByName("rpc_page");
    
    
    var triListData = packet.data.findValueByName("tri_list"); 
    
    var triList=new Array(triListData.length);
    triList[0]="s_spot";
    
    document.all("s_spot").length=0;
    document.all("s_spot").options.length=triListData.length;//triListData[i].length;
    for(j=0;j<triListData.length;j++)
    {
        document.all("s_spot").options[j].text=triListData[j][1];
        document.all("s_spot").options[j].value=triListData[j][0];
    }
    //}

}


/*-------------------------页面提交跳转函数----------------------------*/
function pageSubmit(flag){

    var maincash = document.all.maincash.value;//当前主套餐
    var i18 = document.all.i18.value.substring(0,8);//下月主套餐
    var ip = document.all.ip.value; //申请主套餐
    //if((document.form1.s_spot.value=='Yn20')||(document.form1.s_spot.value=="Yn40"))
    //{
    //  if(document.form1.flag_code.value=="")
    //  {
    //    rdShowMessageDialog("请输入关联代码!");
    //    document.form1.flag_code.focus();
    //   return false;
    // }
    //}
    //document.form1.iAddRateStr.value = document.form1.rate_code.value + "^" + document.form1.flag_code.value;
    //alert(document.form1.iAddRateStr.value);
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
    	document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_1.jsp";  
        form1.submit();
	}
	if(flag==2)
	{
        if(document.all.i13.value-document.all.i12.value<30 
            && document.all.i8.value.substring(0,2)!=document.all.s_city.value.substring(0,2) 
            && document.all.s_city.value.substring(0,2)=='cb')
        {
            rdShowMessageDialog('用户总预存款-总欠费<30,不能变更成长白行用户!',0);
            document.all.ip.focus();
            return false;
        }
	    document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_3.jsp";
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
    }
}
   /********************************清空文本域**********************/
function toclean()
{
    document.form1.ip.value="";
    document.form1.iq.value=""; 
}
/*由套餐类别动态改变小区代码列的可见性、文本信息*/
function controlFlagCodeTdView()
{
    var mode_type = document.form1.s_spot.value;
    if(mode_type=="Yn20")
    {
        document.all.ipTd.colSpan = "1";
        document.all.flagCodeTextTd.style.display = "";
        document.all.flagCodeTd.style.display = "";
        document.all.flagCodeTextTd.innerText = "集团代码";
    }else if(mode_type=="Yn40")
    {
        document.all.ipTd.colSpan = "1";
        document.all.flagCodeTextTd.style.display = "";
        document.all.flagCodeTd.style.display = "";
        document.all.flagCodeTextTd.innerText = "小区代码";
    }else
    {
        document.all.ipTd.colSpan = "3";
        document.all.flagCodeTextTd.style.display = "none";
        document.all.flagCodeTd.style.display = "none";
    }
    return true;
}
</script>
