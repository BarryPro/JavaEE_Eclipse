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

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
	String opCode = "1270";
	String opName = "主资费变更";
	String aftertrim = (String)session.getAttribute("powerRight");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
%>
<%!
  //splitString()用于截取字符串，因jdk老版本没有String.split()函数
  public Vector splitString(String sign, String sourceString) 
   {
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length()==0) {return splitArrays;}
        while (i <= sourceString.length()) {
               j = sourceString.indexOf(sign, i);
               if (j < 0) {j = sourceString.length();}
               splitArrays.addElement(sourceString.substring(i, j));
               i = j + 1;
        }
        return splitArrays;
  }
%>

<!----------------------------------页头显示区域----------------------------------------->

<%    
                                //获得工号信息
  String phone = WtcUtil.repNull(request.getParameter("i1"));
  if(phone==null||phone.length()==0){
  	phone = request.getParameter("activePhone");
  }
  String op_code = WtcUtil.repNull(request.getParameter("iOpCode"));
  String iadd_str = WtcUtil.repNull(request.getParameter("iAddStr"));
	String thepassword = WtcUtil.repNull(request.getParameter("ipassword"));  
  String ret_code = "";
  String ret_msg = "";

  String rowNum = "16";    
  String getselect = WtcUtil.repNull(request.getParameter("select1"));    
	String do_note = WtcUtil.repNull(request.getParameter("i222"));

	String sNewSmName="";
		
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
	String i31="";
	String subi20="";
	String disCode="";
	String ibig_cust_ls="";
	String old_mode_type="",twoPhoneFlag="",highFlag="";
	String strCurrentPoint = "";//用户当前积分/M值

/*******芦学琛20060301add,查询开户时间 *****  begin******/
	String[] inParas1 =new String[]{""};
	String showopentime = "";
	inParas1[0]="select to_char(a.open_time,'YYYY-MM-DD HH24:MI:SS') from dcustinnet a,dCustMsg b where a.id_no=b.id_no and substr(b.run_code,2,1)<'a' and b.phone_no='"+phone+"'";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=phone%>" outnum="1">
		<wtc:sql><%=inParas1[0]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
	if(result==null||result.length==0)
		showopentime ="未查到";
	else if(result.length==1)
		showopentime = result[0][0];
	else
		showopentime ="查出多个开户时间";
 /*****芦学琛20060301add,查询开户时间 ***** end******/	
 /*****刘春梅20080715增加，查询用户的黑白名单信息********/
 String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
 String [] paraIn1 = new String[4];
 String liststr="";
	paraIn1[0] = "region";
	paraIn1[1] = regionCode;
	paraIn1[2] = sqlB;
	paraIn1[3] = "phone="+phone;
%>
	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=phone%>" outnum="1" >
	<wtc:param value="<%=paraIn1[0]%>"/>
	<wtc:param value="<%=paraIn1[1]%>"/>
	<wtc:param value="<%=paraIn1[2]%>"/>
	<wtc:param value="<%=paraIn1[3]%>"/>
	</wtc:service>
	<wtc:array id="offnodataArray" scope="end"/>
<%
    //ArrayList offonArr = callViewn.callFXService("sPubSelectNew",paraIn1,"1");
    if(offnodataArray!=null&&offnodataArray.length>0){
	    if(!offnodataArray[0][0].equals("0"))
	    {
	    	liststr="此客户在黑名单库中!";
	    }else{
	 		String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
	 				+" and op_Type='0' and op_code='0' and list_type='W' ";
	  		System.out.println("sqloffon====="+sqloffon);
	    	String [] paraIn2 = new String[4];
	    	paraIn2[0] = "region";
	    	paraIn2[1] = regionCode;
	    	paraIn2[2] = sqloffon;
	    	paraIn2[3] = "phone="+phone;  
	%>
				<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=phone%>" outnum="1" >
				<wtc:param value="<%=paraIn2[0]%>"/>
				<wtc:param value="<%=paraIn2[1]%>"/>
				<wtc:param value="<%=paraIn2[2]%>"/>
				<wtc:param value="<%=paraIn2[3]%>"/>
				</wtc:service>
				<wtc:array id="offnodataArray" scope="end"/>
	<%
	    	//offonArr = callViewn.callFXService("sPubSelectNew",paraIn2,"1");
				if(offnodataArray!=null&&offnodataArray.length>0){
		    	if(offnodataArray[0][0].equals("0")){
		    		liststr="此客户不在白名单库中!";
		    	}
	    	}
	    }
  	}
 
 /**************liucm end **************/	
 
 /*******白雪峰 20080505 add,资费变更时的提示信息 *****  begin******/
	
	String showchgmsg = " ";
	inParas1[0]="select trim(msg_text) from sbillchgnote  where region_code='"+regionCode+"'";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=phone%>" outnum="1">
		<wtc:sql><%=inParas1[0]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
	if(result==null||result.length==0)
		showchgmsg ="(未查到任何数据)";
	if (result.length==1)
		showchgmsg = result[0][0];
	
 /******白雪峰 20080505 add,资费变更时的提示信息  ***** end******/		
    
	    //retArray = callView.s1270GetMsgProcess(work_no,phone,op_code,thepassword).getList();//s1270GetMsg@R1270Msg.cp
      String loginPswInput = (String)session.getAttribute("password");
%>
				<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=phone%>" outnum="32" >
				<wtc:param value=""/>
        <wtc:param value="01"/>
        <wtc:param value="<%=op_code%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=loginPswInput%>"/>
				<wtc:param value="<%=phone%>"/>
				<wtc:param value="<%=thepassword%>"/>
				</wtc:service>
				<wtc:array id="result" scope="end"/>	
<%
		if(result==null||result.length==0){
%>
		<script language="javascript">
			rdShowMessageDialog("没有此服务号码的相关信息!");
			parent.removeTab("<%=opCode%>");
		</script>
<%
			return;
		}
		
		ret_code = result[0][0];          // 返回代码        
		ret_msg = result[0][1];			  // 提示信息
		
		if(ret_msg.equals(""))
		{
		  ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
			if( ret_msg.equals("null"))
			{
				ret_msg ="未知错误信息";
			}
		}

	if(!ret_code.equals("000000")){
%>
	<script language='jscript'>
	   var ret_code = "<%=ret_code%>";
       var ret_msg = "<%=ret_msg%>";
       rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。");
       parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
		i2 = result[0][2];				  // 用户ID          
		i3 = result[0][3];				  // 客户密码        
		i4 = result[0][4];				  // 客户名称        
		i5 = result[0][5];				  // 客户地址        
		i6 = result[0][6];				  // 客户证件类型名称 
		i7 = result[0][7];				  // 客户证件号码     
		i8 = result[0][8];				  // 业务品牌        
		i9 = result[0][9];				  // 业务品牌名称     
		System.out.println("***************i9="+i9);
		i10 = result[0][10];			  // 用户运行状态     
		i11 = result[0][11];			  // 用户运行状态名称 
		i12 = result[0][12];			  // 总欠费          
		i13 = result[0][13];			  // 总预存款        
		i14 = result[0][14];			  // 第一欠费帐号     
		i15 = result[0][15];			  // 第一欠费        
		i16 = result[0][16];			  // 当前主套餐代码        
		i17 = result[0][17];			  // 当前主套餐名称     
		i18 = result[0][18];			  // 当前主套餐开通流水 
		i19 = result[0][19];			  // 手续费          
		i20 = result[0][20];              // belong_code  
		i21 = result[0][21];              // 大客户类型
		i22 = result[0][22];              // 大客户类型名称
		i23 = result[0][23];              // 手续费优惠代码 
    i24 = result[0][24];              // 集团客户类别           
    i25 = result[0][25];              // 集团客户类别名称      
    i26 = result[0][26];              // 下月主资费            oNextMode       
    i27 = result[0][27];    		  // 下月主资费名称        oNextModeName   
		i28 = result[0][28];			  // 下月主资费开通流水    oNextModeAccept 
		i31 = result[0][31];			  // 相关信息     当前套餐类型代码|一卡双号标志|
%>		

<%
    ibig_cust_ls = i21 + " " + i22;   //大客户类型名称页面显示
		subi20 = i20.substring(0,2);
		disCode = i20.substring(2,4);
		/***
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] allNewSmInfo=(String[][])arr.get(5);
		sNewSmName=Pub_lxd.getNewSm(regionCode,(String)result[0][8],allNewSmInfo,"1");
		***/
    sNewSmName=(String)result[0][9];
		System.out.println("&&&&&&&sNewSmName="+sNewSmName);
    Vector vec = new Vector();
		vec = splitString("|",i31);
		old_mode_type = (String)vec.get(0);//当前主套餐类型
		twoPhoneFlag = (String)vec.get(1);//一卡双号标志
		highFlag = (String)vec.get(2);//中高端用户标志
		strCurrentPoint = (String)vec.get(3);//用户当前积分/M值
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>主资费变更</TITLE>
</HEAD>
<body>
<form action="" method=post name="form1"> 
	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>
       <table cellspacing="0">
         <tr> 
				  <td class="blue" width="15%">服务号码</td>
				  <td>
				    <input name="i1" value="<%=phone%>" size="20" maxlength=11  v_name=移动号码 class="InputGrey" readonly>
				  </td>
				  <td class="blue" width="15%">客户ID</td>
				  <td>
				    <input name="i2" size="20"  value="<%=result[0][2]%>" maxlength=30 class="InputGrey" readonly>
				  </td>
        </tr>
	    </table>

      <table cellspacing="0">		
			 <tr> 
				  <td class="blue" width="15%">客户名称</td>
				  <td>
				    <input name="i4" size="20" maxlength=30 value="<%=result[0][4]%>" class="InputGrey" readonly>
				  </td>
				  <td class="blue" width="15%">客户地址</td>
				  <td>
				    <input name="i5" size="30" maxlength=30 value="<%=result[0][5]%>" class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr> 
				  <td class="blue">证件类型名称</td>
				  <td>
				    <input name="i6" size="20" maxlength=30 value="<%=result[0][6]%>" class="InputGrey" readonly>
				  <td class="blue">证件号码</td>
				  <td>
				    <input name="i7" size="20" maxlength=30 value="<%=result[0][7]%>" class="InputGrey" readonly>
				  </td>
       </tr>
       <tr>
          <td class="blue">业务品牌</td>
          <td>
          	<!-- added by Hanfa 20070117 begin-->
          	<input type="hidden" name="old_smcode" value="<%=result[0][8]%>">
          	<!-- added by hanfa 20070117 end-->
		    		<input type=text name="sNewSmName" value="<%=sNewSmName%>" maxlength="15" class="InputGrey" readonly>
				  </td>
				  <td class="blue">开户时间</td><!-- 芦学琛20060301add---begin -->
				  <td>
				  <input type="text" class="InputGrey" readonly name="showopentime" value="<%=showopentime%>" size="20" maxlength="20">
				  </td>       <!-- 芦学琛20060301add---end -->
       </tr>
			 <tr> 
				  <td class="blue">业务类型</td>
				  <td>
				    <%String add = result[0][8]+" "+result[0][9];%>
				    <input name="i8" size="20" maxlength=20 value="<%=add%>" class="InputGrey" readonly>
				    <input type="hidden" name="i9" size="13" maxlength=20  class="InputGrey" readonly>
				  </td>
				  <td class="blue">运行状态</td>
				  <td>
				    <%String add1 = result[0][10]+" "+result[0][11];%>
				    <input name="i10" size="20" maxlength=2 value="<%=add1%>" class="InputGrey" readonly>
				    <input type="hidden" name="i11" size="20" maxlength=20  class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr> 
				  <td class="blue">未出帐话费</td>
				  <td>
				    <input name="i12" size="20" maxlength=2 value="<%=result[0][12]%>" class="InputGrey" readonly>
				  </td>
				  <td class="blue">可用预存</td>
				  <td>
				    <input name="i13" size="20"maxlength=20 value="<%=result[0][13]%>" class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr>  
			    <td class="blue">集团客户类别</td>
				  <td>
				    <input name="group_type" size="20" value="<%=result[0][24]%> <%=result[0][25]%>" class="InputGrey" readonly>
				  </td>
		      <td class="blue">大客户类别</td>
				  <td>
				    <input name="ibig_cust" size="20" value="<%=ibig_cust_ls%>"  class="InputGrey" readonly>
				    <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly>
            <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly>
 			    </td>  
			  </tr>
				<tr> 
				  <td class="blue">当前主套餐</td>
				  <td>
				    <%String add2 = result[0][16]+" "+result[0][17];%>
				    <input name="i16" size="30" maxlength=20 value="<%=add2%>" class="InputGrey" readonly>
				    <input type="hidden" name="maincash" size="20" value="<%=result[0][16]%>" class="InputGrey" readonly>
				  </td>
          <td class="blue">下月主套餐</td>
				  <td>
				    <input name="i18" size="30" maxlength=20 value="<%=result[0][26]%> <%=result[0][27]%>" class="InputGrey" readonly>
				  </td>
		   	</tr>	
	   	
			 <tr>  
			    <td class="blue">当前积分/M值</td>
				  <td colspan="3">
				    <input name="current_point" size="20" value="<%=strCurrentPoint%> " class="InputGrey" readonly>
				  </td>  
			 </tr>
			</table>
			</div>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">业务办理</div>
			</div>
			<table cellspacing="0">
        <tr> 
  	      <td class="blue" width="15%">业务品牌</td>
  	      <td colspan="3"> 
            <select align="left" name="newSmCode" width=50 index="1" onChange="chgNewSm()">
            	<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='<%=regionCode%>'order by bsm_code</wtc:sql>
							</wtc:qoption>	
    <%
             			String sqlStr = "select distinct a.BSM_CODE ,a.sm_code ,b.sm_name from snewsmcode a,ssmcode b where a.sm_code=b.sm_code";
		%>
									<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="3">
									<wtc:sql><%=sqlStr%></wtc:sql>
									</wtc:pubselect>
									<wtc:array id="result222" scope="end" />
		<%
  		            int xDimension = result222.length;
  		            String strArray = "var arrMsg = new Array(";
					        int flag = 1;
					        for(int i=0;i<xDimension;i++){
					            if(flag==1){
					                strArray = strArray + "new Array()";
					                flag = 0;
					                continue;
					            }
					            if(flag==0){
					                strArray = strArray + ",new Array()";
					            }
					        }
					        strArray = strArray + ");";
      %>
           </select>
						<font class="orange">*</font>
          </td>
	      </tr>
				<tr> 
				  <td class="blue">业务类型</td>
				  <td>
				     <select name="s_city" id="s_city" onchange="tochange()"></select>	
					 	<font class="orange">*</font>
          </td>
          <td class="blue">套餐类别</td>
			      <input type="hidden"  name="subi20" value="<%=subi20%>" >
          <td>
				    <select name="s_spot" id="s_spot" onChange="controlFlagCodeTdView()"></select>
				   	<font class="orange">*</font>
				  </td>
		    </tr>
				<tr> 
        <td class="blue">申请主套餐</td>
			   <td colspan="3" id="ipTd">
            <input type="text" name="ip" id="mainModeCode" size="8" maxlength="8" v_must=1 onChange="changeRateCode()" onclick="" >
			      <input type="text" name="iq" size="18" v_must=1 v_name=申请主资费名称>&nbsp;&nbsp;
				  	<font class="orange">*</font>
			      <input name="bankCodeQuery" type="button" class="b_text" style="cursor:hand" onClick='getBankCode();' value=查询>&nbsp;&nbsp;
			      <!--input name="sBillModeCodeNoteQuery" id="sBillModeCodeNoteQuery" type="button" class="b_text" style="cursor:hand"  value="资费描述"-->
        		
        		<!------------------------------------------------------------------->
      			<input type="hidden" name="ip1" size="8" maxlength="8">
            <input type="hidden" name="iq1" size="8" maxlength="8">
            <input type="hidden" name="modecodetmp" size="8" maxlength="8">
            <input type="hidden" name="modecodetmp1" size="8" maxlength="8">
            <input type="hidden" name="sBillModeCodeNote" id="sBillModeCodeNote" value="">
			      <!--------------------------------------------------------------------->
         </td>
        </tr>
        <tr>
         <td id = "flagCodeTextTd" class="blue" style="display:none">小区代码</td>
			   <td id = "flagCodeTd" colspan="3" style="display:none">
			      <!--------------------------------------------------------------------->
            <input type="text" name="flag_code" size="8" maxlength="10" v_must=1  >
			      <input type="text" name="flag_code_name" size="18" v_must=0 v_name="关联代码名称" v_type="string" readonly>&nbsp;&nbsp;
            <input type="hidden" name="rate_code">
			      <input type="hidden" name="iAddRateStr">
			      <input name=flagCodeQuery type=button class="b_text" style="cursor:hand" onClick="getFlagCode()" value=查询>
         </td>         
		   </tr>
		   
			<!------------------------------------------------------------------>
      <input type="hidden" name="maincash_no" value="<%=result[0][16]%>">
      <input type="hidden" name="belong_code" value="<%=i20%>">
      <input type="hidden" name="strCurrentPoint" value="">
      <input type="hidden" name="do_string_add">
			<input type="hidden" name="addcash_string">
      <input type="hidden" name="toprintdata">
		  <input type="hidden" name="i19" size="20" maxlength=20 value="<%=result[0][19]%>">
		  <input type="hidden" name="i20" size="20" maxlength=20 value="<%=result[0][19]%>">
      <input type="hidden" name="favorcode" size="20" maxlength=20 value="<%=result[0][23]%>">
		  <input type="hidden" name="imain_stream" size="20" maxlength=20 value="<%=result[0][18]%>" class="InputGrey" readonly>
		  <input type="hidden" name="next_main_stream" value="<%=result[0][28]%>">
		  <input type="hidden" name="ipassword" value="<%=thepassword%>">
		  <!------------------huhx add for 其他产品的个性化信息--------->
		  <input type="hidden" name="iAddStr" value="<%=iadd_str%>">
		  <input type="hidden" name="iOpCode" value="<%=op_code%>">
    	<!-------------------------------------------------------------->
		</table>
        <table cellSpacing="0">
          <tbody>
            <tr> 
              <td id="footer">  
	              <!--            
				  <input name=next type=button  onclick="if(check(form1))
				  if(thelength()) pageSubmit(2)"value=下一步>
				  -->			  
				  <!-- modified by hanfa 20070117-->			  
				  <input class="b_foot" name=next type=button  onclick="submitNext()"value=下一步>
				  <input class="b_foot" name=1111   type=button  onClick="toclean()" value=清除>
				  <input class="b_foot" name="goback"  onClick="history.go(-1)" type=button value="返回">				  
				  <input class="b_foot" name=close  onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
	            	<!--<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>-->
              </td>
            </tr>
          </tbody>
        </table>
			<%@ include file="/npage/include/footer.jsp" %>
  </form>
</body>
</html>
<%/*------------------------javascript区----------------------------*/%>
<script language="javascript">
<%=strArray%>
<%
  for(int i = 0 ; i < result222.length ; i++){
      for(int j = 0 ; j < result222[i].length ; j++){
        if(result222[i][j].trim().equals("") || result222[i][j] == null)
		{
          result222[i][j] = "";
    }
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
/**查询主套餐**/
function getBankCode()
{ 
  	//调用公共js得到银行代码
  	//调用公共js得到银行代码
    var pageTitle = "资费代码查询";
    var fieldName = "资费代码|资费名称|生效方式|开户立即-------生效天数|资费描述|";//弹出窗口显示的列、列名
	document.form1.rate_code.value = "";
	document.form1.flag_code.value="";
	document.form1.modecodetmp1.value = document.form1.ip.value;
	document.form1.ip.value="";
	/*
	var sqlStr ="select a.new_mode,b.mode_name,decode(a.SEND_FLAG,'0','0 24小时之内生效','1','1 一般预约 ','2','2 个性预约'),a.open_days||'天',b.note ";
    sqlStr=sqlStr+" from cBillBBChg a,sBillModeCode b where a.region_code='<%=subi20%>' and a.district_code in ('<%=disCode%>','99')";
    sqlStr=sqlStr+" and a.op_code='<%=op_code%>' and a.OLD_MODE ='<%=java.net.URLEncoder.encode(result[0][16])%>' and a.new_mode like '";
    sqlStr=sqlStr+codeChg("%"+(document.all.modecodetmp1.value)+"%").trim()+"' and b.mode_name like '%"+(document.all.iq.value).trim();
    sqlStr=sqlStr+"%' and b.region_code=a.region_code and b.mode_code=a.new_mode and a.POWER_RIGHT <= <%=aftertrim%> and b.POWER_RIGHT <= <%=aftertrim%>  and b.SM_CODE ='";
    sqlStr=sqlStr+ document.all.s_city.options[document.all.s_city.selectedIndex].value.substring(0,2);
    sqlStr=sqlStr + "' and b.MODE_TYPE ='" + document.all.s_spot.value+"'";
    sqlStr=sqlStr + " and b.start_time<=sysdate and b.stop_time>sysdate and select_flag='0'";
	sqlStr=sqlStr + " order by a.new_mode";
	*/
	var sqlStr =" select a.offer_z_id, b.offer_name, decode(a.effect_type,'0', '0 24小时之内生效','2', '2 一般预约 ','3', '3 个性预约','1', '1 第二天生效'),1, b.offer_comments ";
		sqlStr=sqlStr+" from product_offer_relation a, product_offer b where a.op_code = '<%=op_code%>'  and a.offer_z_id = b.offer_id ";
		sqlStr=sqlStr+" and a.offer_z_id like '%"+codeChg(document.all.modecodetmp1.value).trim()+"%' and b.offer_name like '%"+(document.all.iq.value).trim()+"%' and a.offer_a_id = <%=java.net.URLEncoder.encode(result[0][16])%> and a.right_limit <= <%=aftertrim%> ";
		sqlStr=sqlStr+" and sysdate between b.eff_date and b.exp_date";
		sqlStr=sqlStr+" order by a.offer_z_id ";	
	//alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";//返回字段
    var retToField = "ip|iq|";//返回赋值的域
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if (document.form1.iq.value != "");
    	document.form1.modecodetmp.value = document.form1.ip.value;
    getMidPrompt("10442",codeChg(document.getElementById("mainModeCode").value),"ipTd");
}

function changeRateCode()
{
    document.form1.flag_code.value="";
	document.form1.flag_code_name.value="";
	document.form1.rate_code.value="";
}

/**查询关联代码**/
function getFlagCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "关联代码查询";
    var fieldName = "关联代码|关联代码名称|二次批价代码|";//弹出窗口显示的列、列名
    //var sqlStr ="select a.flag_code, a.flag_code_name, a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='<%=subi20%>' and b.mode_code='" + codeChg(document.form1.ip.value) + "' and a.flag_code like '"+codeChg("%"+(document.all.flag_code.value).trim()+"%")+"' order by a.flag_code" ;
    var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '<%=subi20%>' and a.offer_id =" + codeChg(document.form1.ip.value) +" and a.flag_code like '"+codeChg("%"+(document.all.flag_code.value).trim()+"%")+"' order by a.flag_code";
	//alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";//返回字段
    var retToField = "flag_code|flag_code_name|rate_code|";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if (document.form1.flag_code_name.value != "")
    	document.form1.flag_code.readOnly=true;
    else
    	document.form1.flag_code.readOnly=false;
    getMidPrompt("10702",codeChg(document.all.flag_code.value),"flagCodeTextTd");
}
function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=1270";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
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

 onload=function(){
 		if("<%=liststr%>"!=""){
 			rdShowMessageDialog("<%=liststr%>");
 		}
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
	 myPacket=null;
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
}

/*** 提交时增加品牌转换的提示信息 added by hanfa 20070117 begin ***/
function submitNext()
{
	if(document.all.ip.value.trim().len()==0){
		rdShowMessageDialog("主套餐不能为空,请选择!");
		return false;	
	}
	
	//added and modified by hanfa 20070116
	var sm = document.all.s_city[document.all.s_city.selectedIndex].value.substring(0,2);
	if(document.all.old_smcode.value == "zn" && sm == "gn")
	{
		//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
	}
	else
	{
		if(sm != document.all.old_smcode.value)
			rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分（或M值）将于资费生效的次月初清零，请您及时兑换");
	}

  //if(thelength())
  //{
  	 pageSubmit(2);
  //}
}	
/*** 提交时增加品牌转换的提示信息 added by hanfa 20070117 end ***/


/*-------------------------页面提交跳转函数----------------------------*/
function pageSubmit(flag){
	var maincash = document.all.maincash.value;//当前主套餐
	var i18 = document.all.i18.value.substring(0,8);//下月主套餐
	var ip = document.all.ip.value; //申请主套餐
	
	if((document.form1.s_spot.value=='Yn20')||(document.form1.s_spot.value=="Yn40"))
	{
	  if(document.form1.flag_code.value=="")
	  {
	    rdShowMessageDialog("请点<查询>按钮选择 '"+document.all.flagCodeTextTd.innerText+"'");
	    document.form1.flag_code.focus();
	    return false;
	  }
	  //alert("document.form1.flag_code_name.value="+document.form1.flag_code_name.value);
	  if(document.form1.flag_code_name.value=="")
	  {
	    rdShowMessageDialog("请点<查询>按钮选择 '"+document.all.flagCodeTextTd.innerText+"'");
	    document.form1.flag_code_name.focus();
	    return false;
	  }
	}
	document.form1.iAddRateStr.value = document.form1.rate_code.value + "$" + document.form1.flag_code.value;
	
	if( document.form1.ip.value != document.form1.modecodetmp.value)
	{
	  rdShowMessageDialog('请用“查询”得到新资费代码!');
	  document.all.ip.focus();
	  return false;
	}
	if( ip==i18  || ip==maincash)
	{
	  rdShowMessageDialog('申请主套餐不能与当前主套餐或下月主套餐相同!');
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
	    rdShowMessageDialog('用户总预存款-总欠费<30,不能变更成长白行用户!');
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
    var length = document.all.ip.value.trim().len();
    if(length<8)
	{
		 rdShowMessageDialog('申请主套餐代码长度应该为8位！');
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
/*崔东睿新增为动感地带选择小区代码20061106*/
function controlFlagCodeTdView()
{
  var mode_type = document.form1.s_spot.value;
  if(mode_type=="Yn20")
  {
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "集团代码:";
  }else if(mode_type=="Yn40")
  {
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "小区代码:";
/*
  }else if(mode_type=="YnA0")
  {
		document.all.ipTd.colSpan = "1";
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "小区代码";
*/
  }else
  {
    document.all.flagCodeTextTd.style.display = "none";
    document.all.flagCodeTd.style.display = "none";
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
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>
<script language="JavaScript">
  <%if((old_mode_type.trim()).equals("Yns0")){%>
    rdShowMessageDialog('提示: 请注意,该用户为商务公话用户！');
  <%}%>
  <%if((twoPhoneFlag.trim()).equals("Y")){%>
    rdShowMessageDialog('提示: 请注意,该用户为一卡双号用户！');highFlag
  <%}%>
  <%if((highFlag.trim()).equals("Y")){%>
    rdShowMessageDialog('提示: 请注意,该用户为中高端用户！');
  <%}%>
</script>
