<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-11 页面改造,修改样式
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ include file="/npage/common/serverip.jsp" %>
	<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	<%@ page import="java.text.*"%>

<%
	 String opCode = "m058";
	 String opName = "实名登记";	

  request.setCharacterEncoding("GBK");
	String retCode = "999999";
	String retMsg = "";
	 String ipAddr = realip; 
 
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	String cust_addr=WtcUtil.repNull(request.getParameter("cust_addr"));
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String user_id=WtcUtil.repNull(request.getParameter("user_id"));
	String new_cus_id=WtcUtil.repNull(request.getParameter("new_cus_id"));
	String ic_no=WtcUtil.repNull(request.getParameter("ic_no"));
	String is_sPwdAuthChk_sel=WtcUtil.repNull(request.getParameter("is_sPwdAuthChk_sel"));
	
	String printAddFlag = WtcUtil.repNull(request.getParameter("printAddFlag"));
	String backCode = WtcUtil.repNull(request.getParameter("backCode"));
	
	System.out.println("---------------is_sPwdAuthChk_sel------------------->"+is_sPwdAuthChk_sel);
 %>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
 <%
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "m058";
	String nopass = (String)session.getAttribute("password");
	
		/*责任人姓名*/
	String responsibleName = WtcUtil.repStr(request.getParameter("responsibleName"),"");
	/*责任人联系地址*/
	String responsibleAddr = WtcUtil.repStr(request.getParameter("responsibleAddr"),"");
	/*责任人证件类型*/
	String responsibleType = WtcUtil.repStr(request.getParameter("responsibleType"),"");
	System.out.println("---------------responsibleType------------------->"+responsibleType);
	responsibleType = responsibleType.substring(0,responsibleType.indexOf("|"));
	/*责任人证件号码*/
	String responsibleIccId = request.getParameter("responsibleIccId");
	
	/*文件名*/
	String serviceFileName = request.getParameter("serviceFileName");
	/*文件全路径*/
	String serviceFilePath = request.getParameter("serviceFilePath");
	
	
	String zerenrenstrss=responsibleType+"|"+responsibleIccId+"|"+responsibleName+"|"+responsibleAddr;		
	
	
	
	String paraStr[]=new String[57];	//20091201 fengry 将String[44]改为String[45]
	paraStr[0]=sLoginAccept;
 	paraStr[1]=op_code;
	paraStr[2]=work_no;
	paraStr[3]=nopass;
	paraStr[4]=org_code;
	paraStr[5]=user_id;
	paraStr[6]=new_cus_id; 

	paraStr[7] = request.getParameter("regionCode") + request.getParameter("districtCode") + "999";
	paraStr[8]= WtcUtil.repNull(request.getParameter("custName")); 
	String tmppwd = WtcUtil.repNull(request.getParameter("custPwd"));
	//paraStr[9]= WtcUtil.encrypt(tmppwd);
    paraStr[9]= Encrypt.encrypt(tmppwd);
	paraStr[10]=WtcUtil.repNull(request.getParameter("custStatus")); 
	paraStr[11]="00";//WtcUtil.repNull(request.getParameter("custGrade"));
	paraStr[12]=WtcUtil.repNull(request.getParameter("custAddr")); 	
	paraStr[13] = WtcUtil.repNull(request.getParameter("idType"));
	System.out.println("gaopeng============="+paraStr[13]);
	paraStr[13] = paraStr[13].substring(0,paraStr[13].indexOf("|"));    //证件类型：0-身份证
	paraStr[14]= WtcUtil.repNull(request.getParameter("idIccid")); 
	paraStr[15]=WtcUtil.repNull(request.getParameter("idAddr")); 
	paraStr[16]=WtcUtil.repNull(request.getParameter("idValidDate"));
	if(paraStr[16].compareTo("")==0)
	{	  
/*
	*闰年问题
	  int toy=Integer.parseInt(new SimpleDateFormat("yyyy", Locale.getDefault()).format(new Date())); 
      String tomd= new SimpleDateFormat("MMdd", Locale.getDefault()).format(new Date());  
	  paraStr[16]=String.valueOf(toy+10)+tomd;
*/
		Calendar cc = Calendar.getInstance();
		cc.setTime(new Date());
		cc.add(Calendar.YEAR, 10);
		Date _tempDate = cc.getTime();
		paraStr[16] = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	paraStr[17]=WtcUtil.repNull(request.getParameter("contactPerson")); 
	paraStr[18]=WtcUtil.repNull(request.getParameter("contactPhone"));
	paraStr[19]=WtcUtil.repNull(request.getParameter("contactAddr"));
	paraStr[20] = WtcUtil.repNull(request.getParameter("contactPost"));
	if(paraStr[20].compareTo("")==0)
	{	paraStr[20] = " ";	}
	paraStr[21] = WtcUtil.repNull(request.getParameter("contactMAddr")); 	
	paraStr[22] = WtcUtil.repNull(request.getParameter("contactFax")); 
	if(paraStr[22].compareTo("")==0)
	{	paraStr[22] = " ";	}	
    paraStr[23] = WtcUtil.repNull(request.getParameter("contactMail")); 
	if(paraStr[23].compareTo("")==0)
	{	paraStr[23] = " ";	}
	paraStr[24]  = WtcUtil.repNull(request.getParameter("custSex"));  	//客户性别
	paraStr[25]  = WtcUtil.repNull(request.getParameter("birthDay")); //出生日期
	if(paraStr[25] .compareTo("") == 0)
	{
 	  if(paraStr[14].trim().length()==15 && paraStr[13].equals("0")) 
		paraStr[25] ="19"+paraStr[14].substring(6,8)+paraStr[14].substring(8,12);
	  else if(paraStr[14].trim().length()==18 && paraStr[13].equals("0")) 
        paraStr[25]=paraStr[14].substring(6,10)+paraStr[14].substring(10,14);
	  else
        paraStr[25]="19491001";
	} 
	paraStr[26] = WtcUtil.repNull(request.getParameter("professionId")); 
	paraStr[27] = WtcUtil.repNull(request.getParameter("vudyXl")); //学历
	paraStr[28] = WtcUtil.repNull(request.getParameter("custAh")); //客户爱好 
	if(paraStr[28].length() == 0)
	{	paraStr[28] = "";	}
	paraStr[29] = WtcUtil.repNull(request.getParameter("custXg")); //客户习惯
	if(paraStr[29].compareTo("") == 0)
	{	paraStr[29] = "";	}

  paraStr[30]=WtcUtil.repNull(request.getParameter("oriHandFee"));
	paraStr[31]=WtcUtil.repNull(request.getParameter("t_handFee"));
  paraStr[32]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
  paraStr[33]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[34]=request.getRemoteAddr();
	paraStr[35]=WtcUtil.repNull(request.getParameter("assuName"));
	paraStr[36]=WtcUtil.repNull(request.getParameter("assuPhone"));
	paraStr[37]=WtcUtil.repNull(request.getParameter("assuIdType"));
	paraStr[38]=WtcUtil.repNull(request.getParameter("assuId"));
	paraStr[39]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
	paraStr[40]=WtcUtil.repNull(request.getParameter("assuAddr"));
	paraStr[41]=WtcUtil.repNull(request.getParameter("assuNote"));
	/* update “信誉度”内容不可见（包括已有老户和新建客户）,默认传0 for 关于哈分公司申请优化M058实名制登记信誉度清零问题的请示@2015/2/11 */
	//paraStr[42]=WtcUtil.repNull(request.getParameter("xinYiDu"));
	paraStr[42]= "0";
	paraStr[43]=WtcUtil.repNull(request.getParameter("print_query"));
	//20091201 begin 号码实名登记限制信息串:是否允许实名登记标志~允许实名登记时间
	String GoodPhone_List = "";
	//String GoodPhoneFlag=WtcUtil.repNull(request.getParameter("GoodPhoneFlag"));
	//String GoodPhoneDate=WtcUtil.repNull(request.getParameter("GoodPhoneDate"));	
	//GoodPhone_List = GoodPhoneFlag + "~" + GoodPhoneDate + "~";
	paraStr[44]=GoodPhone_List;
	paraStr[45]=WtcUtil.repNull(request.getParameter("card2flag"));
	paraStr[48]=WtcUtil.repNull(request.getParameter("isJSX"));
	
	/*20131216 gaopeng 2013/12/16 16:01:31 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 start*/
	/*经办人姓名*/
	String gestoresName = request.getParameter("gestoresName");
	/*经办人联系地址*/
	String gestoresAddr = request.getParameter("gestoresAddr");
	/*经办人证件类型*/
	String gestoresIdType = request.getParameter("gestoresIdType");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	/*经办人证件号码*/
	String gestoresIccId = request.getParameter("gestoresIccId");
	System.out.println("-----------gaopeng---------gestoresName------------------------------"+gestoresName);
	System.out.println("-----------gaopeng---------gestoresAddr------------------------------"+gestoresAddr);
	System.out.println("-----------gaopeng---------gestoresIdType------------------------------"+gestoresIdType);
	System.out.println("-----------gaopeng---------gestoresIccId------------------------------"+gestoresIccId);
	
	paraStr[49] = gestoresName;
	paraStr[50] = gestoresAddr;
	paraStr[51] = gestoresIdType;
	paraStr[52] = gestoresIccId;
	
	/*20131216 gaopeng 2013/12/16 16:01:31 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 end*/

	/*实际使用人姓名*/
	String realUserName = WtcUtil.repStr(request.getParameter("realUserName"),"");
	/*实际使用人地址*/
	String realUserAddr = WtcUtil.repStr(request.getParameter("realUserAddr"),"");
	/*实际使用人证件号码*/
	String realUserIccId = WtcUtil.repStr(request.getParameter("realUserIccId"),"");
	/*实际使用人证件号码*/
	String realUserIdType = WtcUtil.repStr(request.getParameter("realUserIdType"),"");

	paraStr[53] = realUserIdType;
	paraStr[54] = realUserIccId;
	paraStr[55] = realUserName;
	paraStr[56] = realUserAddr;




	//20091201 end
   for(int i = 0; i<paraStr.length; i++)
   	
		/*@service information
		 *@name                                         s1238Cfm
		 *@description                      实名登记
		 *@author                                       lixg
		 *@created                                      20031208 08:52:1
		 *@input parameter information
		 *@inparam0     loginAccept             流水    可以输入，如果不输入则在服务中取流水
		 *@inparam1     opCode                  功能代码
		 *@inparam2     loginNo                 操作工号
		 *@inparam3     loginPasswd             经过加密
		 *@inparam4     orgCode                 操作工号归属
		 *@inparam5     idNo                    用户ID
		 *@inparam6     newCustID               新客户ID-
		 *--------------------------------------------------------------*
		 *@inparam7     vNOrg                   新客户归属网点
		 *@inparam8     vNName                  新客户名称
		 *@inparam9     vNPwd                   新客户密码
		 *@inparam10    vNStatus                新客户状态
		 *@inparam11    vNGrade                 新客户级别
		 *@inparam12    vNHomeAddr              新客户地址
		 *@inparam13    vNIdType                新客户证件类型
		 *@inparam14    vNIdNum                 新客户证件号码
		 *@inparam16    vNIdDate                新客户证件有效期
		 *@inparam17    vNConName               新客户联系人姓名
		 *@inparam18    vNConTel                新客户联系人电话
		 *@inparam19    vNConAddr               新客户联系人地址
		 *@inparam20    vNConPostNum            新客户联系人邮编
		 *@inparam21    vNConPostAddr           新客户联系人通讯地址
		 *@inparam22    vNConFax                新客户联系人传真
		 *@inparam23    vNConEMail              新客户联系人电子信箱
		 *@inparam24    vNSex                   新客户性别
		 *@inparam25    vNBirth                 新客户出生日期
		 *@inparam26    vNWork                  新客户职业类型
		 *@inparam27    vNEduLevel              新客户学历
		 *@inparam28    vNLove                  新客户爱好
		 *@inparam29    vNHabit                 新客户习惯
		 *--------------------------------------------------------------*
		 *@inparam30    payFee                  应收
		 *@inparam31    realFee                 实收
		 *@inparam32    systemNote              系统备注
		 *@inparam33    opNote                  用户备注
		 *@inparam34    ipAddr                  IP地址
		 *--------------------------------------------------------------*
		 *@inparam35    cust_name               担保人姓名
		 *@inparam36    contact_phone   担保人联系电话
		 *@inparam37    id_type                 担保人证件类型
		 *@inparam38    id_iccid                担保人证件号码
		 *@inparam39    id_address              担保人证件地址
		 *@inparam40    contact_address 担保人联系地址
		 *@inparam41    notes                   担保备注
		 *@inparam43    是否允许查询详单
		 *@inparam44    号码实名登记限制信息串 20091201 add by fengry
		 *@inparam45    是否成功扫描
		 *--------------------------------------------------------------*
		
		 *@output parameter information
		 *@outparam     loginAccept             流水    返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO
		 */

    //SPubCallSvrImpl im1210=new SPubCallSvrImpl();
    //String[] fg=im1210.callService("s1238Cfm", paraStr,"2");
    
%>
		<wtc:service name="sm389Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="errCode" retmsg="errMsg" outnum="4" >
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/> 
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/> 
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>	
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/> 
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/> 
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/> 
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>	
		<wtc:param value="<%=paraStr[18]%>"/>
		<wtc:param value="<%=paraStr[19]%>"/> 
		<wtc:param value="<%=paraStr[20]%>"/>
		<wtc:param value="<%=paraStr[21]%>"/> 
		<wtc:param value="<%=paraStr[22]%>"/>
		<wtc:param value="<%=paraStr[23]%>"/>
		<wtc:param value="<%=paraStr[24]%>"/>
		<wtc:param value="<%=paraStr[25]%>"/> 
		<wtc:param value="<%=paraStr[26]%>"/>
		<wtc:param value="<%=paraStr[27]%>"/>	
		<wtc:param value="<%=paraStr[28]%>"/>
		<wtc:param value="<%=paraStr[29]%>"/>
		<wtc:param value="<%=paraStr[30]%>"/>
		<wtc:param value="<%=paraStr[31]%>"/> 
		<wtc:param value="<%=paraStr[32]%>"/>
		<wtc:param value="<%=paraStr[33]%>"/>
		<wtc:param value="<%=paraStr[34]%>"/>
		<wtc:param value="<%=paraStr[35]%>"/> 
		<wtc:param value="<%=paraStr[36]%>"/>
		<wtc:param value="<%=paraStr[37]%>"/>	
		<wtc:param value="<%=paraStr[38]%>"/>
		<wtc:param value="<%=paraStr[39]%>"/> 
		<wtc:param value="<%=paraStr[40]%>"/>
		<wtc:param value="<%=paraStr[41]%>"/> 
		<wtc:param value="<%=paraStr[42]%>"/>
		<wtc:param value="<%=paraStr[43]%>"/>
		<wtc:param value="<%=paraStr[44]%>"/>		<!-- 20091201 add by fengry -->						 	
		<wtc:param value="<%=paraStr[45]%>"/>		<!-- 20131021 add by zhangyan -->
		<%	
			  String loginacceptJTrc=WtcUtil.repNull(request.getParameter("loginacceptJT"));
		    String pinjiecanshu="";
          if(!"".equals(loginacceptJTrc)) {
          pinjiecanshu="1";
          }else {
          pinjiecanshu="";
        	}
        	
    /*当选择单位开户时,再传值*/
    	if(paraStr[48].equals("1")){
	    	//String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50];
	    	String inputStr11 = paraStr[49]+"|"+paraStr[51]+"|"+paraStr[52]+"|"+paraStr[50]+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|" +is_sPwdAuthChk_sel+"|"+zerenrenstrss+"|01|";
    %>
    
      <wtc:param value="<%=inputStr11%>"/>
    <%
    	}else{
    		String inputStr22 = ""+"|"+""+"|"+""+"|"+""+"|"+paraStr[53]+"|"+paraStr[54]+"|"+paraStr[55]+"|"+paraStr[56]+"|"+pinjiecanshu+"|"+is_sPwdAuthChk_sel+"|"+"|"+"|"+"|"+"|01|";
    %>	
    	<wtc:param value="<%=inputStr22%>"/>
    <%	
    	}
    %>				
    
		
		<wtc:param value="<%=serviceFileName%>"/>
		<wtc:param value="<%=serviceFilePath%>"/>
		<wtc:param value="<%=ipAddr%>"/>
						 	
		</wtc:service>
		<wtc:array id="result1" start="0" length="2" scope="end" />
		<wtc:array id="result2" start="2" length="2" scope="end" />
			
		<%
			/*
				transOUT = Add_Ret_Value(GPARM32_0,iPhoneNo);--办理手机号码
				transOUT = Add_Ret_Value(GPARM32_1,oRetMsg);--错误信息
				transOUT = Add_Ret_Value(GPARM32_2,tmp_buf);   成功条数
				transOUT=Add_Ret_Value(GPARM32_3,loginAccept);--操作流水
			
			
			*/
		
		%>
<%
System.out.println("=========================errCode================================   "+errCode);

if(errCode.equals("000000")){

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi">单位批量实名登记-操作结果</div>
	</div>
			<table>

			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>操作流水</td>
				<td><%=result2[0][1]%>&nbsp;&nbsp<font class="orange">此流水用于在m390结果查询  查询使用</font></td>
			</tr>

		</table>
		<table>
			<%if(errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">导入成功的号码个数：<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>手机号码</th>
				<th>失败原因</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>

		</table>
	<table cellspacing="0">
  <tr>
  	<td id="footer" colspan="3">
  		<input type="button" name="back" class="b_foot" value="关闭" onClick="removeCurrentTab()"  >
  	</td>
  </tr>
  </table>
	</div>
    <%@ include file="/npage/include/footer.jsp"%>
   </form>
</body>
<%
} else {
	%>
	<script language="javascript">
		rdShowMessageDialog("操作失败！错误代码<%=errCode%>,错误原因<%=errMsg%>.");
		removeCurrentTab();
	</script>
	<%
}
%>

