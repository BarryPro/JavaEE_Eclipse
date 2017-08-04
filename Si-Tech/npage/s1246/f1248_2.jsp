<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
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
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-开关机管理－HLR信息查询</TITLE>
</HEAD>
<body>
<%
    String opCode = "1248";
    String opName = "HLR信息查询";
%>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">HLR信息查询</div>
</div>
<%@ include file="head_1248.jsp"%>
<%
/*********************************处理前一页面传来变量值**************************************/
%>
<%      
    ArrayList retArray = new ArrayList();
	//ArrayList retArray_chinasim = new ArrayList();
    String[][] result = new String[][]{};
	//String[] result_1 = new String[2];
	String[][] result_chinasim = new String[][]{};
    //S1270View  callView = new S1270View();   
    
    String phoneNo = (String)request.getParameter("i1");
	String	chinasim = "";
	String  hlrcode = "";
	String PHONENO_HEAD = ReqUtil.get(request,"i1").substring(0,7);
	//String sqlStr = "select CHINASIM_FLAG,HLR_CODE from sHlrCode where PHONENO_HEAD = '"+PHONENO_HEAD+"' ";
	//retArray_chinasim = callView.spubqry32Process("2","",sqlStr).getList();
	
	String sqlStr = "select CHINASIM_FLAG,HLR_CODE from sHlrCode where PHONENO_HEAD = :PHONENO_HEAD ";
	String [] paraIn = new String[2];
    paraIn[0] = sqlStr;    
    paraIn[1]="PHONENO_HEAD="+PHONENO_HEAD;

%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="recordArr" scope="end"/>
<%

	//int recordNum = Integer.parseInt((String)retArray_chinasim.get(0));
	if(recordArr.length>0)
	{
		chinasim = recordArr[0][0];
		hlrcode = recordArr[0][1];
	}
%>
<%
/***********************************定义返回参数*********************************************/
String oret_code="";                                           //    错误代码               
String oret_msg="";											   //    错误信息
String oid_no="神州行用户";			                           // 0  用户id            
String osm_code="";				                               // 1  业务类型代码      
String osm_name="";			                                   // 2  业务类型名称      
String ocust_name="神州行用户";		                           // 3  客户名称          
String ouser_password="";			                           // 4  用户密码          
String orun_code="";				                           // 5  状态代码          
String orun_name="";			                               // 6  状态名称          
String oowner_grade="";			                               // 7  等级代码          
String ograde_name="";			                               // 8  等级名称          
String oowner_type="";				                           // 9  用户类型          
String oowner_typename="";				                       //10  用户类型名称      
String ocust_addr="";			                               //11  客户住址          
String oid_type="";		                                       //12  证件类型          
String oid_name="";			                                   //13  证件名称          
String oid_iccid="";			                               //14  证件号码          
String ocard_name="";		                                   //15  客户卡类型        
String ototal_owe="";			                               //16  当前欠费          
String ototal_prepay="";   	                                   //17  当前预存          
String ofirst_oweconno="";								       //18  第一个欠费帐号    
String ofirst_owefee="";				                       //19  第一个欠费帐号金额		 
String obak_field=""; 			                               //20  备份字段 
String ohlr_code = hlrcode;                                           //21  HLR代码
String ohlr_name="";                                           //22  HLR名称


/**********************************调用s1248Init入参数**********************************/
String iwork_no = hdword_no;                                 //操作工号
String iphone_no = ReqUtil.get(request,"i1");                //手机号码
String iop_code = "1248";                                    //op_code 
String iorg_code = hdorg_code;                               //org_code

if(!chinasim.equals("1"))//非神州行用户
	{
try
 	{
        //retArray = callView.s1248InitProcess(iwork_no,iphone_no,iop_code,iorg_code).getList();
%>
<wtc:service name="s1248Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1248InitCode" retmsg="s1248InitMsg" outnum="23" >
	<wtc:param value="<%=iwork_no%>"/>
	<wtc:param value="<%=iphone_no%>"/> 
    <wtc:param value="<%=iop_code%>"/>
    <wtc:param value="<%=iorg_code%>"/>
</wtc:service>
<wtc:array id="s1248InitArr" scope="end"/>

<%
String[] result_1 = new String[]{s1248InitCode,s1248InitMsg};
              if(s1248InitArr.length > 0 && s1248InitCode.equals("000000"))
              {
                result = s1248InitArr;   //取出结果集
              }
              
				     oid_no  = result[0][0];                  // 0 用户id                            
				   osm_code  = result[0][1];			      // 1 业务类型代码       
				    osm_name = result[0][2];				  // 2 业务类型名称       
				  ocust_name = result[0][3];				  // 3 客户名称           
			  ouser_password = result[0][4];				  // 4 用户密码           
				   orun_code = result[0][5];				  // 5 状态代码           
				   orun_name = result[0][6];				  // 6 状态名称           
				oowner_grade = result[0][7];				  // 7 等级代码           
				 ograde_name = result[0][8];				  // 8 等级名称           
				 oowner_type = result[0][9];				  // 9 用户类型           
			 oowner_typename = result[0][10];				  //10 用户类型名称       
				  ocust_addr = result[0][11];				  //11 客户住址           
				    oid_type = result[0][12];				  //12 证件类型           
				    oid_name = result[0][13];				  //13 证件名称           
				   oid_iccid = result[0][14];				  //14 证件号码           
				  ocard_name = result[0][15];				  //15 客户卡类型         
				  ototal_owe = result[0][16];				  //16 当前欠费           
			   ototal_prepay = result[0][17];				  //17 当前预存           
			ofirst_oweconno	 = result[0][18];				  //18 第一个欠费帐号     
		       ofirst_owefee = result[0][19];				  //19 第一个欠费帐号金额	
				  obak_field = result[0][20];                 //20 备份字段
				  ohlr_code  = result[0][21];                 //21 HLR代码
                  ohlr_name  = result[0][22];				  //22 HLR名称
				  oret_code =  result_1[0];                   //   错误代码
			       oret_msg  = result_1[1];	                  //   错误信息
				   if(oret_msg.equals(""))
					{
    					oret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(oret_code));
    					if( oret_msg.equals("null"))
						{
						    oret_msg ="未知错误信息";
						}
					}
   }
		catch(Exception e){
       		//System.out.println("Call services is Failed!");
     	}
%>
<%
     if(!oret_code.equals("000000")){%>
	  <script language='jscript'>
	  var ret_code = "<%=oret_code%>";
      var ret_msg = "<%=oret_msg%>";
      rdShowMessageDialog("查询错误！<br>错误代码：'<%=oret_code%>'。<br>错误信息：'<%=oret_msg%>'。",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s1246/f1248_1.jsp?activePhone=<%=phoneNo%>");</script>
	  <%}
	%>
<%}%>
      <TABLE cellSpacing=0>
<% 
   /*
   System.out.println("result_1[0]=["+result_1[0]+"]");
   System.out.println("oret_code=["+oret_code+"]");
   System.out.println(retArray.size());
   */
%>
             <TR> 
				  <TD class=blue>服务号码</TD>
				  <TD colspan="3">
				    <input class="InputGrey" name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20"  readonly>
				  </TD>
             </TR>
			 <TR> 
			      <TD class=blue>客户名称</TD>
				  <TD>
				  <input class="InputGrey" name="ocust_name" size="20"  value="<%=ocust_name%>" readonly >
				  </TD>
				  <TD class=blue>客户住址</TD>
				  <TD>
				  <input class="InputGrey" name="ocust_addr" size="20"  value="<%=ocust_addr%>" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>证件类型</TD>
				  <TD >
				    <input class="InputGrey" name="oid_type" value="<%=oid_type%>" size="20" readonly>
				  </TD>
				  <TD class=blue>证件号码</TD>
				  <TD>
				  <input class="InputGrey" name="oid_iccid" size="20"  value="<%=oid_iccid%>"   readonly >
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>状态代码</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="<%=orun_code%>" readonly>
				  </TD>
				  <TD class=blue>状态名称</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="<%=orun_name%>" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>HLR代码</TD>
				  <TD>
				    <input class="InputGrey" name="ohlr_code" value="<%=ohlr_code%>" size="20" readonly>
				  </TD>
				  <TD class=blue>HLR信息</TD>
				  <TD>
				  <input class="InputGrey" name="ohlr_name" size="20"  value="<%=ohlr_name%>"   readonly >
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
				  hand_fee = result_favor[0][0];
				  favor_code = result_favor[0][1];
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
				 <input type="hidden" name="ishould_fee" size="20"maxlength=20 value="<%=hand_fee%>" readonly >
				 </TD>
		         <%}else{%>
				 <TD colspan="4">
				 <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
				 <input type="hidden" name="ishould_fee" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
				 </TD>
		         <%}%>
             </TR>
			 <TR>
			 <TD class=blue colspan=4>HLR信息详情</TD>
			 </TR>
			 <TR> 
				  <TD class=blue>手机号码</TD>
				  <TD>
				  <input class="InputGrey" name="ophone_no" size="20"  value="" readonly>
				  </TD>
				  
      <TD class=blue>IMSI号</TD>
				  <TD>
				  <input class="InputGrey" name="oimis_no" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>长途方式</TD>
				  <TD>
				  <input class="InputGrey" name="otoll" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>呼入限制</TD>
				  <TD>
				  <input class="InputGrey" name="oroam" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>欠费禁止呼出</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>欠费禁止呼入</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>呼出限制</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>呼入限制</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>短信发送</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>短信接收</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>无条件呼转</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>遇忙转移</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>无应答转移</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>不可及转移</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>呼叫等待</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>呼叫保持</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>三方通话</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>传真</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>数据通信</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>来电显示</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>主叫隐藏</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>GPRS</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>是否签约用户</TD>
				  <TD colspan="3">
				  <input class="InputGrey" name="ovisa" size="20"  value="" readonly>
				  </TD>
             </TR>
           <TR>
			   <TD class=blue>备注</TD>
			   <TD colspan="3">
			   <input class="InputGrey" name="sysnote" size="60" readonly>
			   </TD>
		   </TR>
		    <TR style="display:none"> 
				<TD class=blue>操作备注</TD>
				<TD colspan=3>  
				<input name="donote" size="60" value="" >
				</TD>
		   </TR>

            <TR id="footer"> 
              <TD colspan=4>
              <input class="b_foot" name=sure onClick="document.all.sysnote.value=document.all.i1.value + document.all.ohlr_name.value ;if(check(form1)) pageSubmit('s1246/f1248_3.jsp');" type=button value=查询>
			  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=返回>
              </TD>
            </TR>
       </TABLE>
	   <!-----------------------------------设置隐藏域----------------------------------------------->
	   <input type="hidden" name="stream" value="0">	                                                               
       <input type="hidden" name="work_no" value="<%=hdword_no%>">       
	   <input type="hidden" name="work_pwd" value="<%=hdwork_pwd%>">     
	   <input type="hidden" name="org_code" value="<%=hdorg_code%>"> 	 
	   <input type="hidden" name="cust_id" value="<%=oid_no%>">			 
	   <input type="hidden" name="hlr_code" value="<%=ohlr_code%>">			
	   <input type="hidden" name="ip_address" value="<%=hdthe_ip%>">									
	   <!-------------------------------------------------------------------------------------------->
	   <%@ include file="/npage/include/footer.jsp" %>
	   </FORM>
     </BODY>
   </HTML>
  
  <script language="javascript">
/*-----------------------------页面跳转函数-----------------------------------------------*/
function pageSubmit(page)
{
    document.form1.action="<%=request.getContextPath()%>/npage/"+page;
	form1.submit();
}

</script>