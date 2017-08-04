
<%request.setCharacterEncoding("GB2312");%>
   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "申请延长有效期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>

<%
//在此处读取session信息
String[][] favInfo = (String[][])session.getAttribute("favInfo");//读取优惠资费代码

%>


<HTML>
<HEAD>
<TITLE>黑龙江BOSS-申请有效期延长</TITLE>
</HEAD>

<%  
String[][] result = new String[][]{};
String [] result_1 = new String [2];
String regionCode = (String)session.getAttribute("regCode");
%>

<%
String do_note = ReqUtil.get(request,"i222");
String work_no = (String)session.getAttribute("workNo");                                   //获得工号信息
String phone = ReqUtil.get(request,"i1");                      //获得传来手机号码
String org_code = (String)session.getAttribute("orgCode");					                 //org_code 
String op = "1584";
String ret_code = "";
String ret_msg = "";
String rowNum = "16";
String thepassword = ReqUtil.get(request,"i2");                //获得传来的加密密码
String pw_favor = ReqUtil.get(request,"pw_favor");			       //密码优惠权限标志位1:有0:无
String getselect = ReqUtil.get(request,"select1");
String pw_flag = ReqUtil.get(request,"pw_flag");
				
				String i0="";
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
				
				String expire="";
				String old_expire="";
				
				
try
{
		//retArray = callView.s1258InitProcess(work_no,phone,op,org_code).getList();
%>

    <wtc:service name="s1258Init" outnum="25" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=phone%>" />	
			<wtc:param value="<%=op%>" />
			<wtc:param value="<%=org_code%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%


   			ret_code = code1;
        ret_msg  =msg1;
        String errMsg_h="查询用户业务品牌时出错";
        if(ret_msg.equals(""))
        ret_msg = errMsg_h;
    if(result_t.length>0&&code1.equals("000000"))
    {
        result_t = result_t;    //取出结果集
				i0 = result_t[0][0];					  //客户id             
				i1 = result_t[0][1];				  	//业务类型代码       
				i2 = result_t[0][2];				  	//业务类型名称       
				i3 = result_t[0][3];				  	//客户名称           
			  i4 = result_t[0][4];				  	//用户密码           
				i5 = result_t[0][5];				  	//状态代码           
				i6 = result_t[0][6];				  	//状态名称           
				i7 = result_t[0][7];				  	//等级代码           
				i8 = result_t[0][8];				  	//等级名称           
				i9 = result_t[0][9];				  	//用户类型           
				i10 = result_t[0][10];			  	//用户类型名称       
				i11 = result_t[0][11];			  	//客户住址           
				i12 = result_t[0][12];			  	//证件类型           
				i13 = result_t[0][13];			  	//证件名称           
				i14 = result_t[0][14];			  	//证件号码           
				i15 = result_t[0][15];			  	//客户卡类型         
				i16 = result_t[0][16];			  	//当前欠费           
				i17 = result_t[0][17];			  	//当前预存           
				i18 = result_t[0][18];			  	//第一个欠费帐号     
				i19 = result_t[0][19];			  	//第一个欠费帐号金额 
				i20 = result_t[0][20];          //备份字段
				i21 = result_t[0][21];          //系统时间
				i22 = result_t[0][22];          //延长时间 
				i23 = result_t[0][23];          //手续费 
				i24 = result_t[0][24];          //优惠代码 
				
     
	

 
}
}
catch(Exception e){
	ret_code = "999999";
  ret_msg  ="Call services is Failed!";
  System.out.println("Call services is Failed!"+e);
}
     	
%>
  <%
  	if(!ret_code.equals("000000")){
  %>
	  <script language='jscript'>
	  var ret_code = "<%=ret_code%>";
      var ret_msg = "<%=ret_msg%>";
      rdShowMessageDialog("查询错误！<br>错误代码'<%=ret_code%>'。<br>错误信息'<%=ret_msg%>'。",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=phone%>");
      </script>
	<%}	
	if(pw_favor.equals("0")){//"0"说明无密码优惠权限,需要输入密码,"1"有密码优惠权限则不判断
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans);
	   if(i3==""){
  %>
	   	 <script language='jscript'>
	    	rdShowMessageDialog("用户<%=phone%>未找到，请确定您输入的手机号码为可用！");
	    	history.go(-1);
	   	 </script>
  <%
	   }
		 else if(0 == Encrypt.checkpwd2(i4,passFromPage)){
  %>
			  <script language='jscript'>
			  rdShowMessageDialog("用户 <%=i3%> 密码错误！",0);
			  document.location.replace("<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=phone%>");
			  </script>
	<%}}
		//有效期延长95天
		 if(i22.equals("")){
		 	System.out.println("i22=null");
		 	%>
			  <script language='javascript'>
			    rdShowMessageDialog("未找到用户<%=phone%>的有效期信息，不能申请有效期延长！");
			    history.go(-1);
	   	  </script>
	   	  <%}
		 else{
		 	  System.out.println("i22OK:"+i22);
		 	  old_expire=i22.substring(0,8);
				expire=i22.substring(0,8);				
				Date expireJ=new Date();
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
	      expireJ=df.parse(expire);
				GregorianCalendar cal=new GregorianCalendar();
			  cal.setTime(expireJ);     
			  cal.add(GregorianCalendar.DAY_OF_YEAR,95);
				expire=df.format(cal.getTime());
			}
	
  //验证密码,不输出页面下方结果
	if(pw_flag.equals("0")){
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans); 
	   if(1 == Encrypt.checkpwd2(i4,passFromPage)){
	%>
		 	 <script language='jscript'>
			 rdShowMessageDialog("用户 <%=i3%> 密码正确！",0);
			 history.go(-1);
			 </script>
  <%}}%>
	

<BODY>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">申请延长有效期</div>
	</div>


         <TABLE cellpadding="0">  
            <TR > 
				      <TD  class="blue">服务号码</TD>
				      <TD ><input  name="i1" value="<%=phone%>" size="20" maxlength=11 v_must=1 v_type=mobphone v_name=移动号码 readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">客户ID</TD>
				      <TD >
				      <input  name="icust_id" size="20"  value="<%=i0%>" maxlength=30  readonly  Class="InputGrey">
				      </TD>
            </TR>
	   		    <TR > 
				      <TD   class="blue">客户名称</TD>
				      <TD >
				      <input  name="iname" size="20" maxlength=30 value="<%=i3%>" readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">客户地址</TD>
				      <TD >
				      <input  name="iaddr" size="30" maxlength=30 value="<%=i11%>" readonly Class="InputGrey">
				      </TD>
            </TR>
			      <TR > 
				      <TD   class="blue">证件类型名称</TD>
				      <TD ><input  name="icard_type" size="20" maxlength=30 value="<%=i13%>" readonly Class="InputGrey">
				      <TD   class="blue">证件号码</TD>
				      <TD >
				      <input  name="icard_no" size="20" maxlength=30 value="<%=i14%>" readonly Class="InputGrey">
				      </TD>
            </TR>
			      <TR > 
				      <TD   class="blue">系统时间</TD>
				      <TD >
				      <input  name="sysdate" size="20" maxlength=30 value="<%=i21%>" readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">到期时间</TD>
				      <TD >
				      <input  name="expire_time1" size="30" maxlength=30 value="<%=old_expire%>" v_must=1 v_name=到期时间 v_type=string  maxlength=16 readonly Class="InputGrey">
				      </TD>
            </TR>
            
	            <%
			        String favorcode = i24;
		          int m =0;
		        	for(int p = 0;p< favInfo.length;p++){//优惠资费代码
			        	for(int q = 0;q< favInfo[p].length;q++)
			        	{
			       	  	//out.println("优惠资费代码["+ favInfo[p][q]+"]");
			      	  	if(favInfo[p][q].trim().equals(favorcode))
			      	    {
				      	  	// out.println("wwww");
				      	  	++m;
				        	}
			          }
              }
	           	System.out.println("favorcode:"+favorcode);
	     	    	//out.println("m="+m);
              %>
			
			      <TR > 
				     <%if(m != 0){%>		 
				     <TD   class="blue">手续费</TD>
				     <TD colspan="3">
				     <input  name="i19" size="20" maxlength=20 value="<%=i23%>" v_must=1 v_name=手续费 v_type=float >
				     <input  type="hidden" name="i20" size="20"maxlength=20 value="<%=i23%>" readonly  Class="InputGrey" v_name=最高手续费>
				     </TD>
		         <%}else{%>
				     <TD   class="blue" >手续费</TD>
				     <TD  colspan="3">
				     <input  name="i19" size="20" maxlength=20 value="<%=i23%>" v_must=1 v_name=手续费 v_type=float readonly  Class="InputGrey" >
				     <input  type="hidden" name="i20" size="20"maxlength=20 value="<%=i23%>" readonly  Class="InputGrey"  v_name=最高手续费>
			    	 </TD>
		         <%}%>
		       </TR>
           <TR >
			       <TD   class="blue">系统备注</TD>
			       <TD colspan="3">
			       <input  name="sysnote" size="60" value="用户<%=phone%>有效期延长95天,有效期延长至<%=expire%>"　readonly  Class="InputGrey" >
			       <input  name="tonote" size="60" value="<%=ReqUtil.get(request,"do_note")%>" type="hidden">
			       </TD>
		       </TR>

		     </TABLE>
		     <TABLE cellpadding="0">  
           <tr > 
			        <td colspan="4" >
			         	<div align="center">
			         		<input  type="hidden" name="expire_time" size="30" maxlength=30 value="<%=expire%>" v_must=1 v_name=到期时间 v_type=string  maxlength=16 readonly  Class="InputGrey" >
				          <input  name=next type="button"   onclick="if(check(document.all.form1)) if(checktime()) showPrtDlg();" value=打印&确认 class="b_foot_long">&nbsp;
			            <input  name=1111    type=reset  onClick="" value=清除 class="b_foot">&nbsp;
                  <input  name=back  onClick="history.go(-1)" type="button"  class="b_foot"  value=返回>&nbsp;
			            <input  name=close  onClick="removeCurrentTab()" type="button"  value=关闭 class="b_foot">&nbsp;
				        </div>
              </td>
             </tr>
         </TABLE>  


<!---------------------------在from1内设置隐藏域----------------------------------------->
 <input type="hidden" name="stream" value="0">
<!---------------------------结束第一层表格欠套------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*------------------------javascript区----------------------------*/%>
<script language="javascript">
	
/*-------------------------页面提交跳转函数----------------------------*/

function checktime()
	{
		with(document.form1)
			{   
				if(expire_time.value<=sysdate.value)
					{
						rdShowMessageDialog("'到期时间'必须大于'系统时间'！");
						return false;
					}
				
			}
		return true;		
	}
	
/*---------------------进行打印确认流程--------------------------------*/

function showPrtDlg()
{
	getAfterPrompt();
	if((document.all.tonote.value).trim().length==0)
   {
	 document.all.tonote.value="操作员<%=work_no%>"+"对用户"+document.all.i1.value+"进行延长有效期"
   }
   /*弹出模式对话筐，并对用户操作进行处理*/
   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("是否打印电子免填单？");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //点击认可
        {
            conf();                          
        }
        else if(ret==0)                 //点击取消,问是否提交
        {    
            crmsubmit();                     
        }
    }
}

/*-------------------------打印流程提交处理函数-------------------*/

function conf()
{ 
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

   var phone = document.all.i1.value;								        //用户手机号码
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", 						Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// 系统日期
   var name = document.all.iname.value;								      //用户姓名
   var address = document.all.iaddr.value;						    	//用户地址
   var cardno = document.all.icard_no.value;					    	//证件号码
   var stream = document.all.stream.value;						    	//打印流水
   var work_no = '<%=work_no%>';                         //得到工号
   var toprintdata = "有效期延长至:"+document.all.expire_time.value+"|";  //操作内容
   var sysnote = "申请延长有效期"+document.all.i1.value;        //得到打印的系统日志
   

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret_value=window.showModalDialog("<%=request.getContextPath()%>/npage/change/f1276_print.jsp?phone="+phone+"&date="+date+"&name="+name+"&address="+address+"&cardno="+cardno+"&stream="+stream+"&sysnote="+sysnote+"&work_no="+work_no+"&toprintdata="+toprintdata,"",prop); //点击确认，调用打印页面
  	var ifretvalue = ret_value.substring(0,4);
   
   if(ifretvalue == "true")
	 {
	   document.all.stream.value = ret_value.substring(4);   //设置所取到的流水，并赋值，此笔业务的流水将一直是这个
	   crmsubmit()                                           //调用提交确认服务
   }  
}

function crmsubmit()
{
 if(rdShowConfirmDialog("是否提交此次操作？")==1)
		 {
           form1.action="f1584_3.jsp";
           form1.submit();
	     }
 else
	 {
	
	 }
 
}

</script>
