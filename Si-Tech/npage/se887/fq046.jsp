<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
   /*
   * 功能: 营业收费
　 * 版本: v1.0
　 * 日期: 2009-01-13 14:37
　 * 作者: wanglj
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String opName =  request.getParameter("opName");
	String opCode =  request.getParameter("opCode");

%>
<%
	long totalBegin = System.currentTimeMillis();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=opName%></title>
</head>
<body>
	<%---%%%%%%%%%%%add by liubo@2008-01-10,因为此页面加载较慢,加个过渡实现层%%%%%%%%%%%%%--%>
		<style type="text/css">
				#addContainer{ 
				    position: absolute;
				    top: 50%;
				    left: 50%;
				    margin: -150px 0 0 -320px;
						text-align: center;
						width: 640px;
						padding: 20px 0 20px 0;
						border: 1px solid #339;
						background: #EEE;
						white-space: nowrap;
				}
				#addContainer img, #addContainer p{
						display: inline; 
						vertical-align: middle; 
						font: bold 12px "宋体", serif; 
				}
		</style>
		<script type="text/javascript">
			<!--
			     function loader(){
							var oDiv = document.createElement("div");
							oDiv.noWrap = true;
							oDiv.innerHTML = "<div id='addContainer'><nobr><img src='/nresources/default/images/blue-loading.gif'><p class='orange'>&nbsp;&nbsp;&nbsp;&nbsp;正在进行统一缴费处理，请请候……如果长时间没有加载完毕请刷新！</p></nobr></div>"
							document.body.insertBefore(oDiv,document.body.firstChild);
							if(document.all){
								window.attachEvent("onload",function(){ oDiv.parentNode.removeChild(oDiv);});
							}else{
								window.addEventListener("load",function(){ oDiv.parentNode.removeChild(oDiv);},false);
							}
					 }
			//-->
		</script>
		<script>loader();</script>
	<%---%%%%%%%%%%%%%%%%%%%%%%%%%%%%%结束add by liubo@2010-01-10%%%%%%%%%%%%%%%%%%%%%%%%%%%%--%>
<%
	long beginTime1 = System.currentTimeMillis();
%>

<%@ include file="/npage/common/qcommon/print_includeq046.jsp" %>

<%
	long endTime1 = System.currentTimeMillis();
	System.out.println("...................加载打印头文件的时间为:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
%>

<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
		 opName = "一次性费用缴费";
		 String servPhoneNo = "";
		 String  servOrder  = "";
		 String errCode = "";
		 String errMsg  = "";
		 String gCustId =  request.getParameter("gCustId");		//客户ID
     String pathFlag = request.getParameter("pathFlag");	
		 String orgCode =(String)session.getAttribute("orgCode");
		 String regionCode = orgCode.substring(0,2);
		 String gCustName = "";
		 String idNo =  request.getParameter("offerSrvId"); 	//用户ID
		 String custOrderId =  request.getParameter("custOrderId");	//客户订单号		 
		 String prtFlag = request.getParameter("prtFlag");		//打印标识,用于免填单打印,Y合打  N分打
		 String loginNo = (String) session.getAttribute("workNo");	//操作工号		 
		 String selStr = "";	//收款方式用的字符串
		 String selStrCdma = "<option selected value='1'>前台营业收取</option><option selected value='4'>系统自动补缴预存</option>";//对于C网用户,只有前台营业收取		 
		 String siteId  = (String)session.getAttribute("objectId"); //wuln add
		 String siteName = (String)session.getAttribute("siteName");//处理点,用于发票打印
		 System.out.println(siteName+"046 siteId list==========================="+siteId);		 
		 //String printinfo   =  WtcUtil.repNull(request.getParameter("printinfo"));  //打印使用内容串
		 String opcodeadd   =  WtcUtil.repNull(request.getParameter("opcodeadd"));  //打印使用内容串
		 String oldMSISDN   =  WtcUtil.repNull(request.getParameter("oldMSISDN"));  //4100原手机号 查询使用
		 
		 System.out.println("lijy add @20110517");
		 String isMmtel=WtcUtil.repNull(request.getParameter("isMmtel")); //是否是mmtel用户的标志，1表示是mmtel用户，0表示不是
		 System.out.println("------------------------isMmtel----------------"+isMmtel);
		 System.out.println("lijy add end@20110517");
		 System.out.println("mylog------------------opcodeadd-------------------"+opcodeadd);
		 System.out.println("mylog------------------oldMSISDN-------------------"+oldMSISDN);
		 String offeridkd = WtcUtil.repNull(request.getParameter("offeridkd"));
		 //System.out.println("打印使用内容串打印使用内容串打印使用内容串打印使用内容串 siteId list==========================="+printinfo);		 
		 Map parametersMap = request.getParameterMap();
		 /*StringBuffer sb = new StringBuffer(80);
		 for(Iterator iterator = parametersMap.keySet().iterator(); iterator.hasNext(); sb.append("&"))
        {
            String key = (String)iterator.next();
            System.out.println("key========" + key);
            System.out.println("parametersMap.get(key)========" + parametersMap.get(key));
            Object values[] = (Object[])parametersMap.get(key);
            Object value = values == null ? "" : values[0];
            System.out.println("value========" + value);
            sb.append(key);
            sb.append("=");
            sb.append(value);
        }
        System.out.println("sb=============="+sb.toString()); //后来添加了过滤器,导致缴费失败,这个注释掉的程序可以用来检查获取参数*/ 
		 beginTime1 =  System.currentTimeMillis();
		 
		 	/** tianyang add for pos start **/
			String groupId = (String)session.getAttribute("groupId");
			/** tianyang add for pos end **/
			/* ningtn 根据用户优惠权限信息，设置可修改金额 */
			String[][] favInfo = (String[][])session.getAttribute("favInfo");
			String[] feeFav = new String[3];
			feeFav[0] = "";
			feeFav[1] = "";
			feeFav[2] = "";
			String tempStr = "";
			for(int feefavi = 0; feefavi< favInfo.length; feefavi++){
				tempStr = (favInfo[feefavi][0]).trim();
				System.out.println("-------- fav -- " + tempStr);
				if(tempStr.compareTo("a002") == 0){
				/*开户入网费优惠 可以修改开户预存、开户预存款、开户预存费*/
					feeFav[0] = favInfo[feefavi][0];
				}else if(tempStr.compareTo("a003") == 0){
					/*开户SIM卡费优惠 可以修改SIM卡费用*/
					feeFav[1] = favInfo[feefavi][0];
				}else if(tempStr.compareTo("a004") == 0){
					/*开户选号费优惠 可以修改开户选号费*/
					feeFav[2] = favInfo[feefavi][0];
				}
			}
			for(int feei = 0; feei < feeFav.length; feei++){
				System.out.println("======= fav feefav ===== " + feeFav[feei]);
			}
			
			
			
		String work_no = (String)session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
    String ip = (String)session.getAttribute("ipAddr");
    String ssss = "通过custId[" + gCustId + "]查询";
%>

  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
  <wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opcodeadd%>"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value="<%=gCustId%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="result">
	<%
	    gCustName = result[0][5];
	    
	    //System.out.println("  zhouby + fq046 se887 " + opcodeadd);
	%>
	</wtc:array>

	<%
	String sql_rft = "select receive_fee_type,receive_fee_name from sServReceiveFeeType where receive_fee_type in ('1')";
	%>
	<!--查询收取方式,拼成<select>,存入selStr  jsp变量中,在处理订单信息的时候用=====BEGIN-->
	<wtc:pubselect  name="sPubSelect"  outnum="2">
       <wtc:sql><%=sql_rft%></wtc:sql>													 
    </wtc:pubselect> 
     <wtc:iter id="IdRows" indexId="i">
		<%
				if("1".equals(IdRows[0])){
					selStr += "<option selected value="+IdRows[0]+">"+IdRows[1]+"</option>";
				}else{
					selStr += "<option  value="+IdRows[0]+">"+IdRows[1]+"</option>";	
				}
		%>
  	</wtc:iter>
  	<%
  		endTime1 = System.currentTimeMillis();
	 	System.out.println("...................查询收取方式的时间为:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
  		selStrCdma = selStr;
  		beginTime1 =  System.currentTimeMillis();
  	%>
  	<!--查询收取方式,拼成<select>,存入selStr  jsp变量中,在处理订单信息的时候用=====END-->
  	
  	<!--调用sOrderItemShow服务,返回客户订单custOrderId下的所有订单子项,服务订单,和费用科目,并进行处理=====BEGIN-->
  	
<%String regionCode_sOrderItemShow = (String)session.getAttribute("regCode");%>
	 <wtc:utype name="sOrderItemShow" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sOrderItemShow%>">
			<wtc:uparam value="<%=custOrderId%>" type="STRING"/>  
			<wtc:uparam value="<%=loginNo%>" type="STRING"/>      
			<wtc:uparam value="<%=opCode%>" type="STRING"/>  
     </wtc:utype>
   	
  	<%
  		 	endTime1 = System.currentTimeMillis();
	 		System.out.println("...................调用费用查询的时间为:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
	 		beginTime1 =  System.currentTimeMillis();
     	    String retCode_046 = retVal.getValue(0);
     	    System.out.println("------------------retCode_046---------------------"+retCode_046);
     		String retMsg_046 = retVal.getValue(1);
     		System.out.println("------------------retMsg_046---------------------"+retMsg_046);
     		StringBuffer logBuffer046 = new StringBuffer(80);
			WtcUtil.recursivePrint(retVal,1,"2",logBuffer046);		
			System.out.println(logBuffer046.toString());
			System.out.println(retCode_046+"......................"+retMsg_046);
     		String arrayOrders = "";
     		String servOrders = "";
     		float totalOpFee = 0;	
     		String feeFlag = "0";	//收费标志,在获取费用科目的时候修改为1,最后结果为0,则直接转入缴费界面
 %>
 <script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
 <script>
 <%
				out.println("var arrayOrder = new Array();");  //订单子项数组,用于拼订单子项列表
				out.println("var servOrder = new Array();");	//服务定单数组,用于拼服务定单列表
				out.println("var allFeeArray = new Array();"); //费用科目数组,用于拼费用科目列表 ,压入feeOrder数组
				
				out.println("var servOrderNoArray = new Array();"); //服务定单号数组,用于发票打印
				
				out.println("var totalFee1 = '';");		//应收费用
				out.println("var totalFee2 = '';");		//优惠费用
				out.println("var totalFee3 = '';");		//实收费用
				
				Set prtFlagSet = new HashSet();	//通过订单子项和流水号来做发票打印,该set用于存储 订单子项~流水号 串
				out.println("var prtFlagSet = new Array();");	
				
     		if(retCode_046.equals("0")){
     			int num = retVal.getSize("2");	//取得订单子项个数
     			for(int i = 0 ;i < num;i++){
     			
     				//显示订单子项列表
     				
     				UType arrayOrderUtype = retVal.getUtype("2."+i+".0");	//取订单子项UTYPE
     				String arrayOrderNo046 = arrayOrderUtype.getValue(1);	//取订单子项编号
     				String arrayOrderName = arrayOrderUtype.getValue(3);	//订单名字
     				String isComp = arrayOrderUtype.getValue(7);	//是否组合产品标识
     				String isPrtFeeDetail = arrayOrderUtype.getValue(8);	//是否打印收据
     				
     				System.out.println("------------------isPrtFeeDetail---------------------------"+isPrtFeeDetail);
     				
     				arrayOrders = arrayOrders + arrayOrderNo046 + "|" ;
     				
     				for(int j = 0 ; j < arrayOrderUtype.getSize()-2;j++){
     						String tmp = arrayOrderUtype.getValue(j);
     						if(j == 2){					//翻译	业务对象类型
     						  if("100".equals(tmp)){
     								out.println("arrayOrder.push('新装');");
     						  }else{
     						  	out.println("arrayOrder.push('客户服务');");	
     						  }
	     					}else{
	     						out.println("arrayOrder.push('" + tmp + "');");
	     					}
     			  }
     			  	
     			  int servNum = retVal.getSize("2."+i+".1");			//取该订单子项下的服务订单个数
     			  System.out.println("..................servNum="+servNum);
     			  
     			  for(int j = 0 ; j < servNum ; j++){
     			  
     			   	//显示服务定单列表
     			   	
     			   	UType servOrderUtype = retVal.getUtype("2."+i+".1."+j+".0");	//取服务订单UTYPE
     			   	out.println("servOrderNoArray.push('"+ servOrderUtype.getValue(0) +"');");	//将服务订单编号放入servOrderNoArray JS数组中
     			   	servOrders = servOrders + arrayOrderUtype.getValue(1) + "~" + servOrderUtype.getValue(0) + "|" ;	//子项订单编号~服务订单编号  串,用于缴费提交
     			   	String serv_bus_id = servOrderUtype.getValue(6);	//取serv_bus_id,调用下面的sql查询,得到主题服务类型master_serv_type,如果master_serv_type是0 ,就是C网业务,C网业务只能收取方式有限制
     			   	String master_serv_type = "";
     			   	
%>

						<wtc:pubselect  name="sPubSelect"  outnum="1">
					       <wtc:sql>select c.master_serv_type from product a , service_offer b ,master_server c where a.product_id =b.product_id and a.master_serv_id = c.master_serv_id and b.service_offer_id='?'</wtc:sql>													 
					       <wtc:param value="<%=serv_bus_id%>"/>
					    </wtc:pubselect> 
					   <wtc:iter id="IdRows" indexId="ii">
					    
					<%
							 master_serv_type = IdRows[0];
							 System.out.println("..................master_serv_type="+master_serv_type);
							 

					%>
					</wtc:iter>
					
<%     			   	
     			  	for(int m = 0 ; m < servOrderUtype.getSize()-2;m++){
     			  		String tmp = servOrderUtype.getValue(m);
     			  		if(m == 0){
     			  			String phoneNum = "";
     			  			String prePayFee = "";
     			  			String jifen = "";
     			  			String phoneFeeStr  = "";
     			  			if("TRUE".equals(isPrtFeeDetail) || "true".equals(isPrtFeeDetail)){
     			  				UType phoneUtype = new UType();
     			  				servPhoneNo = servOrderUtype.getValue(2);
     			  				//if("0".equals(servPhoneNo))	continue;
     			  				System.out.println(".................servPhoneNo == " + servPhoneNo);
     			  				phoneUtype.setUe("STRING", servPhoneNo);    
     			  				System.out.println("--------------------------------------phoneUtype----------------------"+phoneUtype);			  				
     			  				%>
                 <%String regionCode_sShowNumInfo = (String)session.getAttribute("regCode");%>
     			  					<wtc:utype name="sShowNumInfo" id="retVal2"  scope="end"  routerKey="region" routerValue="<%=regionCode_sShowNumInfo%>">
								          <wtc:uparam value="<%=phoneUtype%>" type="UTYPE"/>      
								      </wtc:utype>
     			  				<%
     			  				
     			  				 errCode  = retVal2.getValue(0);
     			  				 errMsg  = retVal2.getValue(1);
     			  				System.out.println("--------------sShowNumInfo---------------retVal2.getValue(0)------------------------"+retVal2.getValue(0));
     			  				if("0".equals(retVal2.getValue(0))){
     			  				phoneNum = retVal2.getValue("2.0.0");
     			  				prePayFee = retVal2.getValue("2.0.1");
     			  				jifen = retVal2.getValue("2.0.2");
     			  				phoneFeeStr  = phoneNum+"~"+prePayFee+"~"+jifen+"~";
     			  				System.out.println("--------------------------------------phoneFeeStr----------------------"+phoneFeeStr);			  				
     			  				}
     			  				
     			  			}
     			  			//每个服务订单会返回一个流水,由订单子项~流水串打印一张发票, 把这个串先放入set中过滤重复元素,在压入JS数组中
     			  			
     			  			String prtLoginAccept = servOrderUtype.getValue(7);
     			  			String prtFlagElement = arrayOrderNo046 + "~" + prtLoginAccept;
     			  			
     			  			System.out.println("-----------------prtFlagElement-------------------"+prtFlagElement);
     			  			prtFlagSet.add(prtFlagElement) ;
     			  			if("Y".equals(isComp)){
     			  				out.print("servOrder.push('<input type=radio v_isPrtFeeDetail = " + isPrtFeeDetail + "  v_phone_no_str=" + phoneNum + " v_phone_fee_str=" + phoneFeeStr + "  v_prtFlag=" + prtFlagElement + " v_iscomp="+isComp+" v_phoneNo ="+gCustId+" v_opType="+ arrayOrderName +" v_custName= "+ gCustName +" onclick=showMyFee(this.v_span) v_span="+tmp+" name=servOrders value=" +arrayOrderUtype.getValue(1)+"~"+ tmp+"~"+servOrderUtype.getValue(6) + "~" + master_serv_type+">"+ tmp +"');");
     			  			
     			  			}else{
     			  				out.print("servOrder.push('<input type=radio v_isPrtFeeDetail = " + isPrtFeeDetail + "  v_phone_no_str=" + phoneNum + " v_phone_fee_str= " + phoneFeeStr + " v_prtFlag=" + prtFlagElement + " v_iscomp="+isComp+" onclick=showMyFee(this.v_span) v_span="+tmp+" name=servOrders value=" +arrayOrderUtype.getValue(1)+"~"+ tmp+"~"+servOrderUtype.getValue(6) + "~" + master_serv_type+">"+ tmp +"');");	
     			  			
     			  			}
     			  		}else if(m ==5){		//翻译服务定单的缴费状态
     			  		  if("0".equals(tmp)){
     			  				out.println("servOrder.push('未缴费')");
     			  		  }else if("1".equals(tmp)){
     			  		  	out.println("servOrder.push('已缴费')");	
     			  		  }else{
     			  		  	out.println("servOrder.push('部分缴费')");		
     			  		  }
	     			  	}else{
	     			  		out.println("servOrder.push('" + tmp + "');");
	     			  	}
     			    }
     			       			    
     			    //显示费用信息列表
     			    
     			    out.println("var feeOrder = new Array();");	// 存放费用科目的JS数组,一个服务订单一个这样的数组,最后把所有服务订单的费用数组压入allFeeArray
     			     
     			    for(int m = 0 ; m < retVal.getSize("2."+i+".1."+j+".1");m++){
     			    	UType feesUtype = retVal.getUtype("2."+i+".1."+j+".1."+m);	//取费用UTYPE
     			    	out.println("totalFee1 = Number(totalFee1) + Number("+feesUtype.getValue(1)+")");	       //应收费用	累加
     			    	out.println("totalFee2 = Number(totalFee2) + Number("+feesUtype.getValue(2)+")");          //优惠费用	累加
     			    	out.println("totalFee3 = Number(totalFee3) + Number("+feesUtype.getValue(3)+")");          //实收费用	累加
     			    	
     			    	UType totalUtype = feesUtype.getUtype(4);	//取费用科目集合UTYPE
   			    		String  arrayOrder = arrayOrderUtype.getValue(1);
   			    		servOrder = servOrderUtype.getValue(0);
     			    	int rowcount = totalUtype.getSize();	//取费用科目集合个数
     			    	
     			    	for(int n = 0 ; n< rowcount; n++){
     			    		if("0".equals(feeFlag)) feeFlag = "1"; 	//只要有费用科目,就不属于免费单,要显示缴费界面
     			    		UType uuu = totalUtype.getUtype(n);
     			    		String textStyle = "";
     			    		String classStyle = "";
     			    		String feeCode = "";	//2011/11/17 wanghfa添加
     			    		for (int k = 0 ; k< uuu.getSize()-8;k++){
     			    			String tmp = uuu.getValue(k);
     			    		  if(k == 1) continue;
     			    		  if(k == 0){
     			    		  	String  tmp2 = uuu.getValue(k+1);	//取费用代码
     			    		  	feeCode = uuu.getValue(k+1);	//取费用代码
     			    		  	String  feeName = uuu.getValue(6);	//取费用名称,费用名称前面有个隐藏域,存费用类型和费用代码,以及费用科目的服务订单和子项订单
     			    		  	/* ningtn 宽带初装费不可以修改 */
     			    		  		textStyle = "readonly";
     			    		  		classStyle = "forMoney required";
     			    		  		if(tmp2.equals("21")){
     			    		  			/* 特殊号码预存，不可改 */
     											textStyle = "readonly";
     											classStyle = "forMoney required InputGrey";
     										}else if(tmp2.equals("9001")){
     			    		  			/* SIM卡费用 */
     			    		  			/* SIM卡费用，又改回原模式了
     			    		  			if(WtcUtil.haveStr(feeFav,"a003")){
     												textStyle = "";
     												classStyle = "forMoney required";
     											}else{
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}
     											*/
     											textStyle = "";
     											classStyle = "forMoney required";
     										}else if(tmp2.equals("9002")){
     			    		  			/* 开户选号费 */
     			    		  			if(WtcUtil.haveStr(feeFav,"a004")){
     												textStyle = "";
     												classStyle = "forMoney required";
     											}else{
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}
     										}else if(tmp2.equals("1001") || tmp2.equals("2") || tmp2.equals("1000")){
     			    		  			/* 入网预存款 入网预存 入网预存费 */
     			    		  			if(WtcUtil.haveStr(feeFav,"a002")){
     												textStyle = "";
     												classStyle = "forMoney required";
     											}else{
     												textStyle = "readonly";
     												classStyle = "forMoney required InputGrey";
     											}
     										}
     			    		  	if(opcodeadd.equals("4977")){
     										if(tmp2.equals("9003")){
     											textStyle = "readonly";
     											classStyle = "forMoney required InputGrey";
     										}
     									}
     			    		  %>
	     									feeOrder.push("<%=servOrder%>");
	     									feeOrder.push("<input type=hidden v_pparent=<%=arrayOrder%> v_type=fee_codes v_mustFee=1 v_parent=<%=servOrder%> name=fee_code<%=n%>_<%=k%> v_feeType=<%=tmp%> value=<%=tmp2%>><input type='text'name=fee_name<%=n%>_<%=k%> value=<%=feeName%>>"); 
	     									
     			    			<%
     			    				continue;
     			    			}
     			    			if(k == 4){
     			    				//定义营业优惠,营优=实收-产优-实收,并存于实收文本框后的第二个隐藏域中,第一个隐藏域是实收副本,用于用户输入非法时,恢复原值
     			    			    float opFee0466 = Float.parseFloat(uuu.getValue(2)) -  Float.parseFloat(uuu.getValue(3)) - Float.parseFloat(uuu.getValue(4));
     			    				//累加营业优惠
     			    				totalOpFee += opFee0466;	
     			    				String opFee046 = String.valueOf(opFee0466);
     			    				//System.out.println(Float.parseFloat(uuu.getValue(2))+"-"+Float.parseFloat(uuu.getValue(4))+":"+Float.parseFloat(uuu.getValue(3))+" =opFee046  = " +opFee046);
     			    			%>
     			    					feeOrder.push("<input type=text size=10  maxLength='15' name=realPayFee<%=n%>_<%=k%> v_feeCode=<%=feeCode%> class='<%=classStyle%>' vflag=1  onchange = changeRealPayFee() <%=textStyle%> value='<%=tmp%>'><input type=hidden name=realfee<%=n%>_<%=k%>  value='<%=tmp%>'><input type='text' style='display:none' id='opchangeFee<%=n%>_<%=k%>' value='<%=opFee046%>' v_oldvalue='0'>");
     			    			<%
     			    				continue;
     			    			}
     			    			if(k == 5){	//基本上没种情况都要判断做特殊处理,其实不用写循环了,不过刚开始做的时候慢慢加的,就这样吧...
     			    			 	k++;
     			    				continue;
     			    			}
     			    			System.out.println(" ========= ningtn fq046 ====  [" + n + " = " + k + " - " + tmp + "]");
     			  		    out.println("feeOrder.push('" + tmp + "');");	//压入费用JS数组中
     			    	  }
     			    	  		if("0".equals(master_serv_type)){	//如果是C网业务,收取方式为selStrCdma	,下拉框改变定义了changeFeeWay方法
     			    	 	 %>
     			    	  		feeOrder.push("<select v_type='feeWay' style='width:100px' name='feeWay<%=m%>_<%=n%>' onchange='changeFeeWay()'><%=selStrCdma%></select>");
     			    	   <%
     			    	   		}else{	//其他为selStr
     			    	   %>
     			    	   		feeOrder.push("<select v_type='feeWay' style='width:100px' name='feeWay<%=m%>_<%=n%>' onchange='changeFeeWay()'><%=selStr%></select>");
     			    	   <%	}
     			    	  		if("9004".equals(uuu.getValue(1))){//选号费默认不打印在发票上 打印方式改变时,将变化的值会存在isPrint隐藏域,用于同步打印方式
     			    	   %>		
		     						feeOrder.push("<select v_type='isPrint' style='width:100px' name='isPrint<%=m%>_<%=n%>' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option value='T'>打印</option><option selected value='F'>不打印</option></select>");
		     					<%}else{
		     					%>
		     						feeOrder.push("<select v_type='isPrint' style='width:100px' name='isPrint<%=m%>_<%=n%>' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option selected value='T'>打印</option><option value='F'>不打印</option></select>");
		     					<%}
		     					
		     						String feeCodeSeq            = 		uuu.getValue(8).trim();	   //费用明细序号   	
		     						String factorType    		 = 		uuu.getValue(9).trim();    //费用因子类型      
		     						String factorCode            = 		uuu.getValue(10).trim();    //费用因子代码      
		     						String factorValueBegin      = 		uuu.getValue(11).trim();   //费用因子起始值    
		     						String factorValueEnd        = 		uuu.getValue(12).trim();   //费用因子结束值    
		     						String factorDetailCode      = 		uuu.getValue(13).trim();   //费用因子明细代码  
		     						String offerId               = 		uuu.getValue(14).trim();   //销售品标识     
		     						String feeParams			 =   	feeCodeSeq + "~" + factorType + "~" + factorCode + "~" + factorValueBegin + "~" + factorValueEnd + "~" + factorDetailCode + "~" + offerId;
		     						System.out.println(".........feeParams = "+feeParams);
		     						
		     					%>
		     					feeOrder.push("<input type='hidden' name='feeParams<%=m%>_<%=n%>' value=<%=feeParams%>><%=uuu.getValue(6)%>");
     			    	  <%
     			      } 
     			    }
     			    out.println(" allFeeArray.push(feeOrder);");
     			  }%>
     			 
     	<%
       }   
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@servOrders =  "+servOrders);
				Iterator it = prtFlagSet.iterator(); 
				while(it.hasNext()){
 					String prtFlagTmp =(String) it.next();
					out.println("prtFlagSet.push('" + prtFlagTmp + "');");
				}

		}else{%>
					rdShowMessageDialog("客户订单详细信息查询失败!",0);	
					feeFlag = "1";
		<%}%>
</script>


<%

//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 start
		boolean isTT = false;
		String searchSql = "select count(*) from dloginmsg a,dchngroupmsg b where a.GROUP_ID=b.group_id and b.class_code='200' and a.login_no = '" + loginNo + "'";
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retcode="retCode2" retmsg="retMsg2">
			<wtc:sql><%=searchSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end"/>
<%
		if ((!"0".equals(result2[0][0])) && (servPhoneNo.substring(0,3).equals("451") || servPhoneNo.substring(0,3).equals("045") || servPhoneNo.substring(0,3).equals("046"))) {
			isTT = true;
			System.out.println("============wanghfa=============是否为铁通开户： 是");
		} else {
			isTT = false;
			System.out.println("============wanghfa=============是否为铁通开户： 否");
		}
//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 end
%>

<%
  if("0".equals(feeFlag.trim())){	// 免费单,直接跳到缴费
%>
    <script language="javaScript">
     window.location = "/npage/sq046/fq046_3.jsp?<%=PageListNav.writeRequestUrl(parametersMap)%>&arrayOrder="+"<%=arrayOrders%>"+"&servOrder="+"<%=servOrders%>";
    </script>
  <%  
  }else{
  	String sql = "SELECT create_accept FROM dservordermsg WHERE serv_order_id ='"+servOrder+"'";
  	System.out.println("sOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShowsOrderItemShow"+sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result5" scope="end" />
<%

%>
<!--调用sOrderItemShow服务,返回客户订单custOrderId下的所有订单子项,服务订单,和费用科目,并进行处理=====END-->	
<script type="text/JavaScript">
	  var selStr = "";
	  var selStrCdma = "";
	  var closeFlag = false;	//由于营业员非法操作,造成大量代收费订单,在非法关闭缴费界面后,调用onbeforeonload记录日志,需定义一个标志位
	  
 	  window.onload=function(){
   			
		   	$("#sys_note").val("操作员<%=loginNo%>对订单<%=custOrderId%>进行<%=opName%>操作");
		   	
		  	var prnFlag = "<%=prtFlag%>";
		  	if(prnFlag == "Y"){
		  	}
		  	
		  	if("<%=feeFlag%>"!="0")
		  	{
					g("tbl0").innerHTML='<table  cellSpacing=0  id="listdiv2"><tr><th>客户订单编号</th><th>客户订单子项编号</th><th>业务对象类型</th><th>销售品</th><th>订单子项状态</th><th>受理时间</th><th>操作员工</th></tr></table>';
					g("tbl1").innerHTML='<table   cellSpacing=0 id="servtbl"><tr><th>服务定单号</th><th>客户订单子项号</th><th>业务组号</th><th>用户名称</th><th>服务类型</th><th>缴费状态</th> </tr></table>';
					g("tbl2").innerHTML="<table   cellSpacing=0 id='feetbl'><tr><th>服务定单号</th><th>费用科目</th><th>应收金额</th><th style=\"display:none\">优惠金额</th><th>实收金额</th><th>收取方式</th><th>打印</th><th>说明</th></tr></table>";
					selStr = "<%=selStr%>";
					selStrCdma = "<%=selStrCdma%>";
					addTr046('listdiv2','1',arrayOrder ,7);	//画订单子项列表
					addTr046('servtbl','1',servOrder ,6);		//画服务定单列表
					var radioObj = document.getElementsByName("servOrders"); 
					radioObj[0].checked = true;		//选上一个服务定单,服务订单前面的radio只是用于选择其他费用
					
					//for(var i =allFeeArray.length-1 ; i>=0; i--){	//循环画费用列表,一个服务订单一个费用列表,分类显示
					for(var i =0 ; i<allFeeArray.length; i++){	//循环画费用列表,一个服务订单一个费用列表,分类显示
						var tableName = "tbl"+servOrderNoArray[i];	//费用列表的名字: tbl+服务订单号
						if(i == 0){
							g("tbl2").innerHTML ="<table   cellSpacing=0 id='"+ tableName +"'><tr class='showhand'><th>服务定单号&nbsp;&nbsp; <span id='span"+servOrderNoArray[i]+"' style='cursor:pointer;color:#ff9900' onclick='showhand(this)'>隐藏详细</span></th><th>费用科目</th><th>应收金额</th><th  style=\"display:none\">优惠金额</th><th>实收金额</th><th>收取方式</th><th>打印</th><th>说明</th></tr></table>";
						}else{
							g("tbl2").innerHTML = g("tbl2").innerHTML + "<table   cellSpacing=0  id='"+ tableName +"'><tr class='showhand'><th>服务定单号&nbsp;&nbsp; <span id='span"+servOrderNoArray[i]+"' style='cursor:pointer;color:#ff9900' onclick='showhand(this)'>隐藏详细</span></th><th>费用科目</th><th>应收金额</th><th style=\"display:none\">优惠金额</th><th>实收金额</th><th>收取方式</th><th>打印</th><th>说明</th></tr></table>";
						}
						var rowIndex = g(tableName).rows.length;
						addTr046(tableName,"1",allFeeArray[i] ,8);
					}
					g("arrayOrder").value = "<%=arrayOrders%>";
					g("servOrder").value = "<%=servOrders%>";
					document.all.form1.totalFee1.value= totalFee1;
					document.all.form1.totalFee2.value= Number(totalFee2) + Number("<%=totalOpFee%>");
					document.all.form1.totalFee3.value= totalFee3;

					//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 start
<%
					if (isTT == true) {
%>
						document.all.form1.totalFee1.value= "0";
						document.all.form1.totalFee2.value= "0";
						document.all.form1.totalFee3.value= "0";
<%
					}
%>
					//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 end

		  	}
			//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 start
<%
			if (isTT == true) {
%>
			submit_cfm();
<%
			}
%>
			//2010-7-2 19:27 wanghfa添加 铁通开户费用问题的修改 end
			
			var a = 0;
			var realPayFeeObj;
			while(true) {
				realPayFeeObjs = document.getElementsByName("realPayFee" + a + "_4");
				if (realPayFeeObjs.length > 0) {
					if (realPayFeeObjs[0].v_feeCode == "9001") {
						realPayFeeObjs[0].value = "0";
					}
					
					var inputObj = realPayFeeObjs[0]; 
					
					var feeValue = inputObj.value;
					var trObj = inputObj.parentNode.parentNode;
					var objs = trObj.childNodes;
					var inputObjOld =  objs[4].childNodes[1];	//实收文本框后第一个隐藏域,即当前实收副本,用于非法输入后的恢复
					if(!validateElement(inputObj)){
						inputObj.value = inputObjOld.value;
						return false;	
					}
					var opFee = objs[4].childNodes[2];// 实收文本框后第二个隐藏域,存当前营业优惠额
					var opValueTmp = Number(objs[2].innerHTML)-Number(objs[3].innerHTML)-Number(inputObj.value) ;//实收改变后,新的营业员优惠 = 应收-产优-新实收
	
					/* 铁通开户，用户交款不能少于配置的最低预存款 */
					if("<%=opcodeadd%>" == "4977"){
						var valueTemp = Number(inputObj.value) - Number(objs[2].innerHTML);
						if(valueTemp < 0){
							inputObj.value = inputObjOld.value;
							rdShowMessageDialog("实收金额不能小于于应收收金额!",0);	
							return false;
						}
					}
					g("totalFee2").value = Number(g("totalFee2").value) + opValueTmp - Number(opFee.value);//总优惠+新优惠-旧优惠(产优不变)
					opFee.value = opValueTmp;	//再新也要变老,孙子迟早要当爷爷的	--我是来围观的
					
				  g("totalFee3").value = Number(g("totalFee3").value) + Number(feeValue) - Number(inputObjOld.value);	//总实收 ,去旧加新
				  inputObjOld.value = feeValue;	//再新也要变老,孙子迟早要当爷爷的
			 	  //alert(objs[4].childNodes[2].value);
				} else {
					break;
				}
				a ++;
			}
		}
		  
			   /*
		        * 显示和隐藏费用列表
		       */ 
			  function showhand(srcObj){
					var s = srcObj.innerHTML;
					var tblObj = srcObj.parentNode.parentNode.parentNode;
					var trObjs = tblObj.childNodes;
				if(s.indexOf("隐藏详细") >= 0){
					for(i=1;i<trObjs.length;i++)
					{
						trObjs[i].style.display="none";
					}
					srcObj.innerHTML="显示详细";
				}else if (s.indexOf("显示详细") >= 0) {
					for(i=1;i<trObjs.length;i++)
					{
						 trObjs[i].style.display="";
					}
					srcObj.innerHTML="隐藏详细";
				}
			}

			/*
	        * 点击费用科目前面的radio,就会显示其费用列表
	       	*/
			function showMyFee(servOrderNo){
				var obj = g("span"+servOrderNo);
				obj.innerHTML="显示详细";
				showhand(obj);	
			}
		  
		   /*
	        * 以前用ajax方式调用费用查询,后来根据免费单不走缴费页面的需求,不用这种方式了
	       	*/
		 /* function initData(){
		  		var myPacket = new AJAXPacket("fq046_ajax.jsp","正在获得费用信息，请稍候......");
		  		myPacket.data.add("retType","showAll");
		  		myPacket.data.add("custOrderId","<%=custOrderId%>");
		  		myPacket.data.add("opCode","<%=opCode%>");
		  		core.ajax.sendPacket(myPacket);
			    myPacket=null;
		  }*/
		  
		   /*
	        * 改变收取方式,如果是系统补缴预存(4)方式时,将打印方式设为不打印,即不打印倒发票
	       	*/
		  function changeFeeWay(){
		  	var srcObj = event.srcElement;
		  	g(srcObj.v_type).value=srcObj.options[srcObj.selectedIndex].value;	
		  	var trobj = srcObj.parentNode.parentNode;
		  	var tdobjs = trobj.childNodes;
		  	// alert(srcObj.options[srcObj.selectedIndex].value);
		  	if(srcObj.options[srcObj.selectedIndex].value == "4"){
		  		tdobjs[6].childNodes[0].value='F'	;
		  		g(tdobjs[6].childNodes[0].v_type).value = tdobjs[6].childNodes[0].value;	
		  	}else{
		  		tdobjs[6].childNodes[0].value='T'	;	
		  		g(tdobjs[6].childNodes[0].v_type).value=tdobjs[6].childNodes[0].value;
		  	}
		  }
		  
       /*
        *动态删除行
       */ 
     function delTr046(serverOrderNo,tableName){
          var obj = document.getElementById(tableName);
     	    var trObjs = obj.childNodes[0].childNodes;
     	    for ( var i =1; i < trObjs.length; i++)	{
     	    			 var tdObjs = trObjs[i].childNodes;
     	    	     var inputObj = tdObjs[0].childNodes[0];
     	    	     if(inputObj.v_parent == serverOrderNo){
     	    	       if(tableName == "servtbl"){delTr046(inputObj.value,"feetbl");}
     	    	       if(tableName == "feetbl"){
     	    	       		document.all.form1.totalFee1.value= Number(document.all.form1.totalFee1.value)-Number(tdObjs[1].innerHTML);
      								document.all.form1.totalFee2.value= Number(document.all.form1.totalFee2.value)-Number(tdObjs[2].innerHTML)-Number(tdObjs[4].childNodes[0].value);
      								document.all.form1.totalFee3.value= Number(document.all.form1.totalFee3.value)-Number(tdObjs[3].childNodes[0].value);
      								document.all.form1.fee_submit.disabled=true;
     	    	       }
	                 trObjs[i].parentNode.removeChild(trObjs[i]);
	 		      			 i--;    
                 }  
     	    }         
     }
     
       /*
        *实收金额,根据niuyc要求,取消营业员优惠,放开改变实收金额的权限,营优=应收-产优-实收 ,做成隐藏字段
       */ 	
       
			function changeRealPayFee(){
				var inputObj = event.srcElement; 
				
				var feeValue = inputObj.value;
				var trObj = inputObj.parentNode.parentNode;
				var objs = trObj.childNodes;
				var inputObjOld =  objs[4].childNodes[1];	//实收文本框后第一个隐藏域,即当前实收副本,用于非法输入后的恢复
				if(!validateElement(inputObj)){
					inputObj.value = inputObjOld.value;
					return false;	
				}
				var opFee = objs[4].childNodes[2];// 实收文本框后第二个隐藏域,存当前营业优惠额
				var opValueTmp = Number(objs[2].innerHTML)-Number(objs[3].innerHTML)-Number(inputObj.value) ;//实收改变后,新的营业员优惠 = 应收-产优-新实收
				/*if(opValueTmp < 0){	根据山西要求,去掉金额限制
					inputObj.value = inputObjOld.value;
					rdShowMessageDialog("实收金额不能大于应收收金额!",0);	
				}else{*/
				/* 铁通开户，用户交款不能少于配置的最低预存款 */
				if("<%=opcodeadd%>" == "4977"){
					var valueTemp = Number(inputObj.value) - Number(objs[2].innerHTML);
					if(valueTemp < 0){
						inputObj.value = inputObjOld.value;
						rdShowMessageDialog("实收金额不能小于应收金额!",0);	
						return false;
					}
				}

					//opFee.v_oldvalue = opFee.value;
					g("totalFee2").value = Number(g("totalFee2").value) + opValueTmp - Number(opFee.value);//总优惠+新优惠-旧优惠(产优不变)
					opFee.value = opValueTmp;	//再新也要变老,孙子迟早要当爷爷的	--我是来围观的
					
				  g("totalFee3").value = Number(g("totalFee3").value) + Number(feeValue) - Number(inputObjOld.value);	//总实收 ,去旧加新
				  inputObjOld.value = feeValue;	//再新也要变老,孙子迟早要当爷爷的
			 	  //alert(objs[4].childNodes[2].value);
			}
	
			/*
	        *公共方法,获取元素
	       */ 	
			function g(objectId) 
			{
				if (document.getElementById && document.getElementById(objectId))
				{
					return document.getElementById(objectId);
				}
				else if (document.all && document.all[objectId])
				{
					return document.all[objectId];
				}
				else 
				{
					return false;
				}
			}
	
	
			 /*
	        *动态添加行
	       */ 					
			function addTr046(tableID,trIndex,arrTdCont,colNum)
			{
				if(colNum == "undefined")
					colNum = 1;
				var tableId=g(tableID);
				var insertTr=new Array();
				for(var i = 0 ; i < (arrTdCont.length/colNum); i++){
						var k =1+i*colNum;
						//alert(tableID.indexOf("tbl") + "::" +  arrTdCont[k].indexOf("value=2"));
						if(tableID.indexOf("tbl") == 0 && (arrTdCont[k].indexOf("value=22") != -1 || arrTdCont[k].indexOf("value=2") != -1 || arrTdCont[k].indexOf("value=200") != -1 || arrTdCont[k].indexOf("value=20") != -1 || arrTdCont[k].indexOf("value=21") != -1)){
							insertTr[i] = tableId.insertRow(1);		
						}else{
							insertTr[i] = tableId.insertRow(trIndex);			
						}
						
						var arrTd=new Array();				
						for(var j = 0;j < colNum;j++)
						{
							
							arrTd[j]=insertTr[i].insertCell(j);
							if(tableID.substring(0,3)=="tbl"&&j==1){
								arrTdCont[i*colNum+j] = arrTdCont[i*colNum+j].replace("type='text'","type='text' readOnly class='InputGrey'");
							}
							arrTd[j].innerHTML = arrTdCont[i*colNum+j];
							if(tableID.substring(0,3)=="tbl"&&j==3){
								arrTd[j].style.display="none";
							}
							
						}
						trIndex  = Number(trIndex)+1;
					}
			}
 
	  	 /*
        *回调方法
       */ 
     	function doProcess(packet)
     	{
	     		/*tianyang add for pos缴费 start*/
					var verifyType = packet.data.findValueByName("verifyType");
					var sysDate = packet.data.findValueByName("sysDate");
					if(verifyType=="getSysDate"){
						document.all.Request_time.value = sysDate;
						return false;
					}
					/*tianyang add for pos缴费 end*/
     	}
     
       /*
        *同步缴费方式和是否打印
       */ 
	     function changeAll(vType){
	          var selValue = g(vType).value;
	          var obj = document.form1.elements;
	          for(var i = 0 ; i< obj.length; i ++){
	               if(obj[i].v_type == vType){
	                    var objs = obj[i].childNodes;
	               	 for(var j = 0 ; j < objs.length ; j ++ ){
	               	     if(objs[j].value == selValue){
	               	          objs[j].selected = true;    
	               	     }
	               	 }
	               }
	          }
	     }
	     
	     var custId = "";
function formatNumber(feeValue){
	
	feeValue = feeValue+"";
	if(feeValue.indexOf("\.")!=-1){
		feeValue = feeValue+"00";
	}else{
		feeValue = feeValue+".00";
	}
	return feeValue.substring(0,feeValue.indexOf("\.")+3);
	
}  

var chinaFee = "";
function showPrtDlgbill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var printInfo1 = "";
	for (var m = 0 ; m < prtFlagSet.length; m ++){
	     			var arrayOrderId = prtFlagSet[m].split("~")[0];
	     			var prtLoginAccept = prtFlagSet[m].split("~")[1];
	     			var opType = "";
	     			var custName = "";
	     			var phoneNo = "";
	     			var userId = "<%=gCustId%>"
	     			var checkNo = "";
	     			
 						var machFee = 0;
 						var simFee = 0;
 						var fee_sumPay = 0;
 						var cashPay = "";
 						var posPay = "0.00"; 						
 						if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
 							posPay = document.all.totalFee3.value; 							
 						}else{
 							cashPay = document.all.totalFee3.value;
 						}
 						var checkPay = document.all.checkPay.value;
 						
  	
  	var note = custId + phoneNo + "普通开户" + "现金款：" + cashPay + "支票款：" + checkPay + "POS机款：" + posPay;
  	
    printInfo = "<%=loginNo%>|";            //工号
    printInfo = printInfo + prtLoginAccept + "|";         //流水
    
    $("#servtbl :radio").each(function(i){
   			if(this.checked){
   				opType   = $(this).parent().parent().find("td:eq(4)").text();
   				custName = $(this).parent().parent().find("td:eq(3)").text();
   				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
   			}
 		});
 		
  	     	  var tableName = "tbl"+servOrderNoArray[0];
	     	  	var tabobj = g(tableName);
	     	  
				for(i=1; i < tabobj.rows.length; i++){
						var feename = tabobj.rows(i).cells(1).children[1].value;
						if(feename == "SIM卡费用"){
							simFee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("预存")!=-1){
							fee_sumPay +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}else if(feename.indexOf("机器费")!=-1){
							machFee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
						}
				}
 
 		
    printInfo = printInfo + opType+"交费明细" + "|";  
    printInfo +="<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>"+"|";
    printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>"+"|";
    printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>"+"|";
    printInfo = printInfo + custName + "|";         //用户名
    printInfo += "|";         //卡号
    printInfo = printInfo + phoneNo + "|";         //手机号
    printInfo = printInfo + userId + "|";        //协议号码
    printInfo = printInfo + document.all.checkNo.value + "|";       //支票号码
    printInfo = printInfo + document.all.totalFee3.value + "|"; //大写
    printInfo = printInfo + document.all.totalFee3.value + "|"; //小写
    printInfo = printInfo + "SIM卡费： " + simFee + "~";           //SIM卡费
    printInfo = printInfo + "入网预存费：" + fee_sumPay + "~";     //入网预存
    printInfo = printInfo + "现金款：" + cashPay + "~";          //现金款
    printInfo = printInfo + "支票款：" + checkPay + "~";       //支票款
    printInfo = printInfo + "POS机款：" + posPay + "~";          /** tianyang add for pos **/
    printInfo = printInfo + "机器费：  " + machFee + "~";          //机器费
    printInfo = printInfo + "备注：    " + note + "|";                       //备注
    printInfo += " |";
    printInfo += " |";
    printInfo += " |";
    printInfo += " |";
    printInfo += " |";
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
    
    /********tianyang add at 20090928 for POS缴费需求****start*****/
    if(document.all.payType.value=="BX" || document.all.payType.value=="BY"){
			printInfo = printInfo + document.all.MerchantNameChs.value + "|";	     	
			printInfo = printInfo + document.all.CardNoPingBi.value + "|";
			printInfo = printInfo + document.all.MerchantId.value + "|";
			printInfo = printInfo + document.all.BatchNo.value + "|";
			printInfo = printInfo + document.all.IssCode.value + "|";
			printInfo = printInfo + document.all.TerminalId.value + "|";
			printInfo = printInfo + document.all.AuthNo.value + "|";
			printInfo = printInfo + document.all.Response_time.value + "|";
			printInfo = printInfo + document.all.Rrn.value + "|";
			printInfo = printInfo + document.all.TraceNo.value + "|";
			printInfo = printInfo + document.all.AcqCode.value + "|";
			printInfo = printInfo + "|";
    }
    /********tianyang add at 20090928 for POS缴费需求****end*******/
    
  }
  
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=" + DlgMessage;
	var loginAccept = prtLoginAccept;
	var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,"",prop);
}	     

function showBroadBill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var prtLoginAccept = "";
	for (var m = 0 ; m < prtFlagSet.length; m ++){
		var arrayOrderId = prtFlagSet[m].split("~")[0];
		prtLoginAccept = prtFlagSet[m].split("~")[1];
		var opType = "";
		var custName = "";
		var phoneNo = "";
		var cashPay = document.all.totalFee3.value;
	  $("#servtbl :radio").each(function(i){
 			if(this.checked){
 				opType   = $(this).parent().parent().find("td:eq(4)").text();
 				custName = $(this).parent().parent().find("td:eq(3)").text();
 				phoneNo  = $(this).parent().parent().find("td:eq(2)").text();
 			}
 		});
 		var tableName = "tbl"+servOrderNoArray[0];
  	var tabobj = g(tableName);
  	var simcardfee = 0;
  	var prefee = 0;
  	var installfee = 0;
		for(i=1; i < tabobj.rows.length; i++){
				var feename = tabobj.rows(i).cells(1).children[1].value;
				if(feename == "SIM卡费用"){
					simcardfee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("预存")!=-1){
					prefee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
				}else if(feename.indexOf("初装费")!=-1){
					installfee += parseInt(tabobj.rows(i).cells(4).children[0].value);
				}
		}
		getBroadMsg(phoneNo);
		printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += prtLoginAccept + "|";
		printInfo += custName + "|";
		printInfo += " " + "|";
		printInfo += " " + "|";
		printInfo += $("#broadNo").val() + "|";
		printInfo += " " + "|";
		printInfo += cashPay + "|";
		printInfo += cashPay + "|";
		printInfo += "初装费：" + installfee + "元" + "~" + "宽带套餐预存款：" + prefee + "元" + "~";
		printInfo += "客服热线：10050" + "~";
		printInfo += "网址：http://www.bc880.com" + "|";
	}
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "发票打印";
	var loginAccept = prtLoginAccept;
	var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=9test&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,"",prop);
}

function getBroadMsg(phoneNo){
		var getdataPacket = new AJAXPacket("/npage/sq046/fq046_getBroadmsg.jsp","正在获得数据，请稍候......");
		getdataPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(getdataPacket,doBroadMsgBack);
		getdataPacket = null;
}
function doBroadMsgBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	result = packet.data.findValueByName("result");
	if(retCode == "000000"){
		$("#broadNo").val(result);
	}
}

function ajaxGetToCFee(totalFee){
	var packet1 = new AJAXPacket("/npage/sq046/ajaxGetTcf.jsp","请稍后...");
								packet1.data.add("totalFee",totalFee);
								core.ajax.sendPacket(packet1,doAjaxGetToCFee);
								packet1 =null;
}
function doAjaxGetToCFee(packet){
		chinaFee =  packet.data.findValueByName("chinaFee");
}
function showPrtDlg1(printType,DlgMessage,submitCfm,printStr)
{   
	var h=198;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=result5[0][0]%>";
	var phone_no	= "<%=servPhoneNo%>";
	
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
	var printStr = printStr;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=1104&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(printStr,printStr,prop);
	
	return true;
}     

$(document).ready(function (){
	getprintinfonew();
});
				var sysAccept4977 = "";
				var printinfo = "";//断点恢复时取不到动态div
function getprintinfonew(){   	
				
				
     	  if(typeof(parent.document.getElementById("<%=gCustId%>"))!="undefined"&&parent.document.getElementById("<%=gCustId%>")!=null){
     	  	printinfo = parent.document.getElementById("<%=gCustId%>").printinfo;
     	  	parent.document.getElementById("<%=gCustId%>").printinfo = "";//取完值清空
     	  	//alert("参数传递的 printinfo=["+printinfo+"]");
     	  	//alert(printinfo);
     	  }  
     	  
     	  if(printinfo==""){
     	   
	     	  var arrayOrderss = new Array();
	     	  arrayOrderss="<%=arrayOrders%>".split("|");
	     	  //alert(arrayOrderss.length);
	     	 
	     	  for (var i = 0 ; i < arrayOrderss.length ; i++ ){
	     	  	 if(printinfo!=""){
		     	  	//可能有2个定单，第一个取得免填单信息后第二个不必执行
		     	  	break;
			     	 }
		     	  //alert("diaoyong");
			     	var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","正在查询信息，请稍候......");
						myPacket.data.add("path","");
						myPacket.data.add("sOrderArrayId",arrayOrderss[i]);
						myPacket.data.add("opcode","<%=opcodeadd%>");
						myPacket.data.add("optype","1");
					  core.ajax.sendPacket(myPacket,dosaveflag);
					  myPacket = null;
					}
					
					  //alert("服务返回的 printinfo=["+printinfo+"]");

     	  
     	  }
}
     	 
function dosaveflag(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var printinfoquery = packet.data.findValueByName("printinfoquery");
		
		 if(retCode != "000000"){
			rdShowMessageDialog("查询免填单信息出错，错误代码:"+retCode+"，错误信息:"+retMsg,0);
		 }else {
		 	if(printinfo.length==0) {
		 		printinfo=printinfoquery;
		 	}
		 	
		 }

    }
    
 
     	  var opcode = "<%=opCode%>";
     		function submit_cfm(){
     	  	/*yanpx add*/
     	  	if("<%=opcodeadd%>" =="1104" ||"<%=opcodeadd%>" =="d535" ||"<%=opcodeadd%>" =="e887"){/* lijy add @20110517 d535,4977分支的添加，用户ims开户,宽带开户免填单打印*/
	     	  	var tableName = "tbl"+servOrderNoArray[0];
	     	  	var tabobj = g(tableName);
	     	  	var simcardfee = 0;
	     	  	var prefee = 0;
	     	  	var installfee = 0;
						for(i=1; i < tabobj.rows.length; i++){
								var feename = tabobj.rows(i).cells(1).children[1].value;
								if(feename == "SIM卡费用"){
									simcardfee  +=parseInt(tabobj.rows(i).cells(4).children[0].value);
									//printinfo = printinfo.replace("SIMCARDFEE",tabobj.rows(i).cells(4).children[0].value);
								}else if(feename.indexOf("预存")!=-1){
									prefee +=parseInt(tabobj.rows(i).cells(4).children[0].value);
									//printinfo = printinfo.replace("PREMONEY",tabobj.rows(i).cells(4).children[0].value);
								}else if(feename.indexOf("初装费")!=-1){
									installfee += parseInt(tabobj.rows(i).cells(4).children[0].value);
								}
						}
						printinfo = printinfo.replace("SIMCARDFEE",simcardfee+".00");
						printinfo = printinfo.replace("PREMONEY",prefee+".00");
						printinfo = printinfo.replace("INSTALLFEE",installfee+".00");
						printinfo = printinfo.replace(/\|xg\|/g,"\\");
						showPrtDlg1("Detail","确实要打印电子免填单吗？","Yes",printinfo);
						//alert(g(tableName).rows(1).cells(1).children[1].value+"|"+g(tableName).rows(1).cells(4).children[0].value);
		   		}
		   		/*end*/
     	  	if("<%=errCode%>"!=0){
     	  		rdShowMessageDialog("服务sShowNumInfo查询错误：<%=errCode%>--<%=errMsg%>");
     	  		return false;
     	  		}
     	  	closeFlag = true;
     	  	doCfm();
     	  }
 		 var map046 = {};
			map046.put = {
			      "items": function(obj,a,c){
			        var b = [];
			        for(var i in obj){
			          if(a == i){
			          	obj[i]=	Number(obj[i]) + Number(c);
			          	  //alert(a+":"+ obj[a]);
						return;
			          }
			         }
			          obj[a] =c;
			//           alert(a+":"+ obj[a]);
			        return b;
			      }
			};
	      function showPrtDlg(){
	     		var prtAccpetLoginStr = "";
	     		//发票打印根据订单子项+流水号()确定一张发票 ,prtFlagSet数组中存储的就是 订单子项~流水号
	     		for (var m = 0 ; m < prtFlagSet.length; m ++){
	     			var arrayOrderId = prtFlagSet[m].split("~")[0];
	     			var prtLoginAccept = prtFlagSet[m].split("~")[1];
	     			var phoneFlag = 0;
		        	var  feeArray = {}
	     			
	     				var phoneNo = "";
						var custName = "";
						var opType = "";
						
						 

						var detail="";
						var city="<%=siteName%>";
						
	     			var detailFee1 = 0;
						var detailFee2 = 0;
						var detailFee3 = 0;
						var detailFee4 = 0;
						var amount = 0;
			      var detailstr = "";
		      	var tblObj = g("servtbl");
		      	var trObjs = tblObj.childNodes[0].childNodes;
		      	for(var i = 1;i<trObjs.length;i++){
		      		var tdObjs = trObjs[i].childNodes;
		      		//var inputObj = tdObjs[0].childNodes[0]
		      		
		      		var inputObj = tdObjs[0].childNodes[0]   //update 2009
		      		if( inputObj.v_prtFlag == prtFlagSet[m]){
			      				if(inputObj.v_iscomp == "Y"){
				      				phoneNo = inputObj.v_phoneNo; 
									//custName = inputObj.v_custName;
									opType =  inputObj.v_opType; 
								}else{
									phoneNo = tdObjs[2].innerHTML; 
									//custName = tdObjs[3].innerHTML;
									opType =  tdObjs[4].innerHTML; 	
								}
								var servOrderNo = inputObj.v_span;
								var feeTblObj = g("tbl"+servOrderNo);
								var feeTrObjs = feeTblObj.childNodes[0].childNodes;
								for(var j = 1; j < feeTrObjs.length;j++){
									var feeTdObjs = feeTrObjs[j].childNodes;
									var isprintvalue = feeTdObjs[6].childNodes[0].value;
									if(isprintvalue == "T" && parseFloat(feeTdObjs[4].childNodes[0].value) != 0){//当该费用科目实收费用不为0并且为打印状态,才打印倒发票上
										map046.put.items(feeArray,feeTdObjs[1].childNodes[1].value,feeTdObjs[4].childNodes[0].value);
										detailFee1 += Number(feeTdObjs[2].innerText);
										detailFee3 += Number(feeTdObjs[4].childNodes[0].value);
									}
								}
								if(inputObj.v_isPrtFeeDetail == "TRUE"){
									var feeDetail = "";
									var phoneFeeStr = inputObj.v_phone_fee_str;
									var phoneNoStr = inputObj.v_phone_no_str;
									feeDetail += "缴费前话费：" + phoneFeeStr.split("~")[1] +"|";
									feeDetail += "缴费前积分：" +  phoneFeeStr.split("~")[2] +"|" ;
									getPayFeeAfter(phoneNoStr);
									var feeStrAfter = g("payFeeAfter").value;
									feeDetail += "缴费后话费：" + feeStrAfter.split("~")[0] +"|";
									feeDetail += "缴费后积分：" + feeStrAfter.split("~")[1] +"|";
		      						//printDetailBill2(phoneNoStr,arrayOrderId,custName,opType,amount,city,prtLoginAccept,feeDetail,arrayOrderId);
		      					}
							}
						}
						for(var aa in feeArray){
							detail += aa + "："	+ feeArray[aa] +"|";
						}
					 	amount = detailFee3;
					 	if(detailFee1 == 0 && detailFee3 ==0){
					 		//continue;	
					 	}
					 	custName = document.all.custNameforsQ046.value;
					 	var sqlVq046 = "select id_no from dcustmsg where phone_no= '"+phoneNo+"'";
					 	var packet1 = new AJAXPacket("/npage/offerConfiguration/offerScene/ajaxGetSqlResult.jsp","请稍后...");
								packet1.data.add("sqlV1",sqlVq046);
								core.ajax.sendPacket(packet1,doQuerySel);
								packet1 =null;		
						
						city = custId		;
					 	var mode_code = "";
					 	var fav_code = "";
					 	var area_code ="";
					 	var memo = "备注："+custId+phoneNo+opType;
					 	
						a=printDetailBill(phoneNo,arrayOrderId,custName,opType,amount,city,prtLoginAccept,detail,arrayOrderId,mode_code,fav_code,area_code,memo);
						
						prtAccpetLoginStr = arrayOrderId + "~" + a + "~|";
					}
					g("prtAccpetLoginStr").value = prtAccpetLoginStr;
				}
			function doQuerySel(packet){
				  var error_code = packet.data.findValueByName("code");
					var error_msg =  packet.data.findValueByName("msg");
					prodCompInfo1 = packet.data.findValueByName("offerLimitArray");
					custId = prodCompInfo1[0][0];
			}  
			function getPayFeeAfter(phoneNoStr)	  {
				var myPacket = new AJAXPacket("/npage/sq046/fq046_getAfterFee.jsp","正在验证号码，请稍候......");       
				myPacket.data.add("phone_no",phoneNoStr);
				core.ajax.sendPacket(myPacket,getPayFeeAfter046,true);
				myPacket =null;
			}
		function getPayFeeAfter046(packet){
			var retCode = packet.data.findValueByName("retCode");
			if(retCode != "0"){
					rdShowMessageDialog("获取服务号码信息失败！无法打印收据!",0)	;
					g("payFeeAfter").value = "0~0~";
			}else{
				var result = packet.data.findValueByName("payFeeAfter");
				g("payFeeAfter").value = result;
			}
		}
			
			 function doCfm()
		    {
		        //显示打印对话框
		        var h = 150;
		        var w = 350;
		        var t = screen.availHeight / 2 - h / 2;
		        var l = screen.availWidth / 2 - w / 2;
		        if(g("op_note").value.trim() == "") g("op_note").value=g("sys_note").value;
	      		if(!checksubmit(form1))	
	     				return false;
	     		  //$("#fee_submit").attr("disabled",true);
		        if (rdShowConfirmDialog("确认要提交本次操作吗？") == 1)
		        {
		        	try{
				     	  var printObj = parent.document.getElementById("<%=gCustId%>");
				     	  if(printObj){
				     	  	parent.document.removeChild(printObj);
				     	  }	
			     		}catch(e){
				     	}	       	
		            conf();
		        }else{
		        	$("#fee_submit").attr("disabled",false);	
		        }
		    }
		    
	       /*
	        *提交表单, 给缴费服务准备费用串,订单子项编号~服务定单编号~@费用代码~实收~产优~应收~营优~收取方式~是否打印~费用代码~七个参数
	       */ 
						function conf(){
							var feeStr = "";
							for( var k = 0 ; k < servOrderNoArray.length;k++){
							var obj = document.getElementById("tbl"+servOrderNoArray[k]);
							var trObjs = obj.childNodes[0].childNodes;
							var rowsNum = trObjs.length;
							for ( var i =1; i < trObjs.length; i++)	{
								var tdObjs = trObjs[i].childNodes; 
								//加个判断,每条费用,如果应收!=产优+营优+实收,说明费用出现问题,给出警告,return false;
								//alert(Number(tdObjs[2].innerText) +"=="+Number(tdObjs[3].innerText)+"+"+Number(tdObjs[4].childNodes[0].value)+"+"+Number(tdObjs[4].childNodes[2].value));
								//alert(Number(tdObjs[2].innerText)!= Number(tdObjs[3].innerText)+Number(tdObjs[4].childNodes[0].value)+Number(tdObjs[4].childNodes[2].value));
								if(Number(tdObjs[2].innerText)!= Number(tdObjs[3].innerText)+Number(tdObjs[4].childNodes[0].value)+Number(tdObjs[4].childNodes[2].value)){
									rdShowMessageDialog("费用出现异常问题,请到客户首页做断点重新受理!",0);
									$("#fee_submit").attr("disabled",false);	
									return false;
								
								}    	    	
								for(var j = 1; j < tdObjs.length-1; j++){
									//var inputObj = tdObjs[j].childNodes[0];
									if(j == 1  || j == 4 || j == 5 || j == 6 ){
										var inputObj = tdObjs[j].childNodes[0];
										if(j == 1){
											feeStr += inputObj.v_pparent;
											feeStr += "~";
											feeStr += inputObj.v_parent;
											feeStr += "~@";    	    		           
										}     	    		    
										feeStr += inputObj.value; 
										if(j == 4){
											feeStr += "~" + tdObjs[j].childNodes[2].value; 	
										}
									}else{
										feeStr += tdObjs[j].innerHTML;     
									}
									feeStr += "~";
								}
								if(tdObjs[7].childNodes[0].value == "otherFee"){
									rowsNum = rowsNum+1;
									feeStr += tdObjs[1].childNodes[0].v_feeType + "~" + rowsNum  + "~0~0~0~0~0~0" + "|";	
								}else{
									feeStr += tdObjs[1].childNodes[0].v_feeType + "~" + tdObjs[7].childNodes[0].value + "|";  //传给缴费服务增加费用类型(取费用名称前面的hidden控件的v_feeType属性值)和费用因子(取说明前面的hidden控件的value值)参数,	
								}
								}
							}
														

							
							//alert(document.all.totalFee3.value);
							/**** tianyang add for pos start ****/
							if(Number(document.all.totalFee3.value)>99999){
									rdShowMessageDialog("实收总额应小于10万!");
							}else{
									if(document.all.payType.value=="BX")
						    	{
							    		/*set 输入参数*/
											var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
											var trantype      = "00";                                  //交易类型
											var bMoney        = document.all.totalFee3.value;					 //缴费金额
											var tranoper      = "<%=loginNo%>";                        //交易操作员
											var orgid         = "<%=groupId%>";                        //营业员归属机构
											var trannum       = "<%=servPhoneNo%>";                    //电话号码
											getSysDate();       /*取boss系统时间*/
											var respstamp     = document.all.Request_time.value;       //提交时间
											var transerialold = "";			                               //原交易唯一号,在缴费时传入空
											var org_code      = "<%=orgCode%>";                        //营业员归属						
											CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
											if(ccbTran=="succ") posSubmitForm(feeStr);
						    	}
									else if(document.all.payType.value=="BY")
									{
											var transType     = "05";																	/*交易类型 */         
											var bMoney        = document.all.totalFee3.value;         /*交易金额 */         
											var response_time = "";                                   /*原交易日期 */       
											var rrn           = "";                                   /*原交易系统检索号 */ 
											var instNum       = "";                                   /*分期付款期数 */     
											var terminalId    = "";                                   /*原交易终端号 */			
											getSysDate();       //取boss系统时间                                            
											var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
											var workno        = "<%=loginNo%>";                       /*交易操作员 */       
											var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
											var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
											var phoneNo       = "<%=servPhoneNo%>";                   /*交易缴费号 */       
											var toBeUpdate    = "";						                        /*预留字段 */         
											var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
											if(icbcTran=="succ") posSubmitForm(feeStr);
									}else{
											posSubmitForm(feeStr);
									}
							}							
							/**** tianyang add for pos end ****/
						}
   
   	function do_cfm(packet){
   		var err_code = packet.data.findValueByName("errorCode");
   		var retMessage = packet.data.findValueByName("retMessage");
   		
   		if(err_code == "0"){
   			if(typeof(parent.frames['user_index'])!="undefined"){
   		    parent.frames['user_index'].location.reload();
   		  }
   		  
   		  /*** tianyang add for pos start *** boss交易成功 调用银行确认函数 *****/
				if(document.all.payType.value=="BX"){
					BankCtrl.TranOK();
					//alert("建行提交 BankCtrl.TranOK()");
				}
				if(document.all.payType.value=="BY"){
					var IfSuccess = KeeperClient.UpdateICBCControlNum();
					//alert("工行提交 var IfSuccess = KeeperClient.UpdateICBCControlNum()");
				}
				/*** tianyang add for pos end *** boss交易成功 调用银行确认函数 *****/
				
			//2010-7-5 8:46 wanghfa修改 铁通开户和普通开户最后提示信息不同 start
<%
			if (isTT == true) {
%>
	   			rdShowMessageDialog("业务受理成功!",2);
<%
			} else if (isTT == false) {
%>
	   			rdShowMessageDialog("缴费成功!",2);
<%
			}
%>
   			//rdShowMessageDialog("缴费成功!",2);
			//2010-7-5 8:46 wanghfa修改 铁通开户和普通开户最后提示信息不同 end
   			var is_release = packet.data.findValueByName("is_release");
   			if(is_release == "Y"){
				parent.removeTab('<%=opCode%>');
	     	}else{
		      parent.addTab(false,'q025','客户订单审核','/npage/sq025/fq025.jsp?gCustId=<%=gCustId%>&custOrderId='+g("custOrderId").value+'&opCode=q025&opName=客户订单审核');
		      if((typeof parent.removeTab )=="function")
					{
						 parent.removeTab('<%=opCode%>');
					}
				}
   		}else{
   			rdShowMessageDialog("缴费失败!"+retMessage,0);	
   			$("#fee_submit").attr("disabled",false);	
   			return false;
   		}
   	}
       /*
        *增加其他费用
       */ 
    function addType()
		{	
			var iWidth=45; //窗口宽度
			var iHeight=35;//窗口高度
			var typeStr="";
			/*for(var i=0;i<parseFloat(document.all.table1.rows.length,10)-1;i++)
			{
				//alert(document.all.table1.rows.length);
				//alert(document.all.table1.rows[i+1].cells[1].innerText)
				typeStr=typeStr+document.all.table1.rows[i+1].cells[1].innerText+"~";
			}*/
			var servOrder = $("input[@type=radio][@name=servOrders][@checked]").val();	//取要添加可选费用的服务定单串  子项号~服务号~服务标识~主体服务类型
			if(typeof(servOrder)=="undefined"){
				rdShowMessageDialog("请先选择要添加其它费用的服务定单!",0);
				return false;
			}
			var obj = document.form1.elements;
			var servOrderNo = servOrder.split("~")[1];
		 	for(var i = 0 ; i< obj.length; i ++){
             if(obj[i].v_type == "fee_codes" && obj[i].v_mustFee != "1" && obj[i].v_parent == servOrderNo){//带着已经添加过的其他费用,用来验证,新添加的费用是否合法
               typeStr +=  obj[i].v_parent+"@"+obj[i].value+"$";  
             }
      }
			var newUrl="/npage/sq046/fq046_add_type.jsp?typeStr="+typeStr+"&servOrder="+servOrder;
			//var newUrl="f_add_type1.jsp";
			var ss= window.showModalDialog(newUrl,"补交科目","dialogWidth:"+iWidth+";dialogHeight:"+iHeight+";");
			//返回的其他费用串:
			//分解其他费用串,动态添加倒对应服务订单的费用列表,费用元素,格式与必选费用相同,只是最后的说明换做删除按钮,可以进行删除操作,调用delFee();delTr()
			if(ss != undefined)
			{
				var rowArray =  ss.split("|");
				var arrayOrderNo = rowArray[0].split("~")[0];
				var servOrderNo = rowArray[0].split("~")[1];
				var masterServType = rowArray[0].split("~")[3];
				for(var i =1 ; i < rowArray.length-1; i++){
					var tabRowNum = g("tbl"+servOrderNo).rows.length;
					var colArray = rowArray[i].split("~");
					var trArray = new Array();
					for(var j=0;j< colArray.length-4;j++)
					if(j==0){
						trArray.push(servOrderNo);
						var tmpStr = "<input type=hidden v_type=fee_codes v_pparent="+arrayOrderNo+"  v_parent="+servOrderNo+" name=other_fee_code"+i+" v_feeType=" + colArray[j] + " value=" + colArray[1] + "><input id=other_fee_name"+i+" class='required' name=other_fee_name"+i+" type=text  class='required' value="+colArray[7]+">";
						trArray.push(tmpStr);						
					}else if(j==1){
					}else if(j==4){
						trArray.push("<input type=text size=10 maxLength='15' name=otherRealPayFee_"+i+" class='forMoney required' vflag=1 onchange = changeRealPayFee() value='"+colArray[j]+"'><input type=hidden name=otherRealfee_"+i+"  value='"+colArray[j]+"'><input type=hidden id=otherOpchangeFee_"+i+" value='0' v_oldvalue='0'>");
					}else{
						trArray.push(colArray[j]);
					}
					if(masterServType =="0"){
						trArray.push("<select v_type='feeWay' style='width:100px' name='otherFeeWay_"+i+"' onchange='changeFeeWay()'>"+selStrCdma+"</select>");
					}else{
						trArray.push("<select v_type='feeWay' style='width:100px' name='otherFeeWay_"+i+"' onchange='changeFeeWay()'>"+selStr+"</select>");	
					}
					trArray.push("<select v_type='isPrint' style='width:100px' name='otherIsPrint_"+i+"' onchange='g(v_type).value=this.options[selectedIndex].value'><br><option selected value='T'>打印</option><option value='F'>不打印</option></select>");
					
					//1.在删除按钮控件增加v_fee1属性,存储添加其他费用后的原始应收总额,用户删除其他费用删除是,恢复原来的费用状态.
					//2.删除按钮控件前面的hidden控件,存储七个费用因子参数.写死的, 20090330 wangljadd
					
					trArray.push("<input type='hidden' name='otherFeeParams_"+i+"' value='otherFee'><input type='button' v_fee1='"+colArray[2]+"' class='butDel' onclick='delFee();delTr()'>");
					addTr("tbl"+servOrderNo,tabRowNum,trArray,"0|1");
					setselect(g("otherFeeWay_"+i),colArray[5]);
					setselect(g("otherIsPrint_"+i),colArray[6]);
					g("totalFee1").value = Number(g("totalFee1").value)+ Number(colArray[2]); //应收总额
					g("totalFee2").value = Number(g("totalFee2").value)+ Number(colArray[3]); //优惠总额
					g("totalFee3").value = Number(g("totalFee3").value)+ Number(colArray[4]); //实收总额
				}
			}
		}
		
		   /*
        *删除其他费用
       */ 
		function delFee(){
					var obj = event.srcElement;
					var trobj = obj.parentNode.parentNode;
					var tdobjs = trobj.childNodes;
					var inputobj1 = tdobjs[4].childNodes[0];
					var inputobj2 = tdobjs[4].childNodes[2];
					var innerobj3 = tdobjs[3].innerText;
					g("totalFee1").value = Number(g("totalFee1").value)- Number(obj.v_fee1);  //应收总额
					g("totalFee2").value = Number(g("totalFee2").value)-Number(inputobj2.value)-Number(innerobj3); //优惠总额
					g("totalFee3").value = Number(g("totalFee3").value)-Number(inputobj1.value); //实收总额
		}
		
		  /*
        *设置下拉框
       */ 
		function setselect(obj,obj_value){
				var objs = obj.childNodes;
				for(var i = 0 ; i<objs.length;i++){
					if(objs[i].value==obj_value){
						objs[i].selected = true; 
					}	
				}
		}
		  /*
	        *为了避免大量待收费和待审核单子产生,提醒营业员
	       */ 
		//window.onbeforeunload =function LeaveWin(){
		//	/*if (rdShowMessageDialog("您在离开缴费页面之前,将进行缴费操作,您确定您的配置完成,进行缴费吗?") == 1)
	  //      {
	  //         doCfm();
	  //      } */
	  //      if(!closeFlag){
	  //      	//doCfm();
	  //      	closeLog();
	  //      	rdShowMessageDialog("该订单还未缴费,处于待收费状态,请到客户首页查询该订单进行断点重新受理操作!");
	  //      	
	  //      	
	  //      	
	  //  	}
		//}
		   /*
	        *为了分析大量待收费和待审核单子产生的情况,在非法关闭缴费页面的时候,加了日志记录功能
	       */ 
		function closeLog(){
			var myPacket = new AJAXPacket("/npage/sq046/fq046_log_ajax.jsp","正在获得信息，请稍候......");
			var opNote = "操作员<%=loginNo%>非法关闭<%=opName%>页面,<%=custOrderId%>订单处于待缴费状态";
			myPacket.data.add("opNote",opNote);
			myPacket.data.add("custOrderId",g("custOrderId").value);	
			myPacket.data.add("opCode",g("opCode").value);	
			myPacket.data.add("loginNo","<%=loginNo%>");
			core.ajax.sendPacket(myPacket,getCloseLog);	
			myPacket=null;	
		}
		function getCloseLog(packet){
			var err_code = packet.data.findValueByName("errorCode");
			//alert(err_code);
		}
    		
/*tianyang add POS缴费 start*/
function getSysDate()
{
	var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
	myPacket.data.add("verifyType","getSysDate");
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}
function padLeft(str, pad, count)
{
		while(str.length<count)
		str=pad+str;
		return str;
}
function getCardNoPingBi(cardno)
{
		var cardnopingbi = cardno.substr(0,6);
		for(i=0;i<cardno.length-10;i++)
		{
			cardnopingbi=cardnopingbi+"*";
		}
		cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
		return cardnopingbi;
}
/* POS缴费中 按钮无效设置成false  start*/
/*function posSetButton(){
		document.form1.fee_submit.disabled=false;
		document.form1.confirm.disabled=false;
}*/
/* POS缴费中 页面提交  start*/
function posSubmitForm(feeStr){
			/*
			目前e887 IMS centrex业务不收费。
			showPrtDlgbill("Bill","确实要进行发票打印吗？","Yes");
			*/		
			var myPacket = new AJAXPacket("/npage/sq046/fq046_3_ajax.jsp","正在获得信息，请稍候......");
			myPacket.data.add("feeStr",feeStr);
			myPacket.data.add("arrayOrder",g("arrayOrder").value);	
			myPacket.data.add("servOrder",g("servOrder").value);	
			myPacket.data.add("custOrderId",g("custOrderId").value);	
			myPacket.data.add("opCode",g("opCode").value);	
			myPacket.data.add("opName",g("opName").value);	
			myPacket.data.add("gCustId",g("gCustId").value);	
			myPacket.data.add("feeWay",g("feeWay").value);	
			myPacket.data.add("isPrint",g("isPrint").value);	
			myPacket.data.add("prtAccpetLoginStr",g("prtAccpetLoginStr").value);			
			myPacket.data.add("checkNo",g("checkNo").value);	
			myPacket.data.add("bankCode",g("bankCode").value);	
			myPacket.data.add("checkPay",g("checkPay").value);
			myPacket.data.add("offeridkd","<%=offeridkd%>");
			/** pos机新增参数 start **/
			myPacket.data.add("payType" ,document.all.payType.value);/** 缴费类型 payType=BX 是建行 payType=BY 是工行 **/
			myPacket.data.add("MerchantNameChs" ,document.all.MerchantNameChs.value);
			myPacket.data.add("MerchantId" ,document.all.MerchantId.value);
			myPacket.data.add("TerminalId" ,document.all.TerminalId.value);
			myPacket.data.add("IssCode" ,document.all.IssCode.value);
			myPacket.data.add("AcqCode" ,document.all.AcqCode.value);
			myPacket.data.add("CardNo" ,document.all.CardNo.value);
			myPacket.data.add("BatchNo" ,document.all.BatchNo.value);
			myPacket.data.add("Response_time" ,document.all.Response_time.value);
			myPacket.data.add("Rrn" ,document.all.Rrn.value);
			myPacket.data.add("AuthNo" ,document.all.AuthNo.value);
			myPacket.data.add("TraceNo" ,document.all.TraceNo.value);
			myPacket.data.add("Request_time" ,document.all.Request_time.value);
			myPacket.data.add("CardNoPingBi" ,document.all.CardNoPingBi.value);
			myPacket.data.add("ExpDate" ,document.all.ExpDate.value);
			myPacket.data.add("Remak" ,document.all.Remak.value);
			myPacket.data.add("TC" ,document.all.TC.value);
			/** pos机新增参数 end **/
			core.ajax.sendPacket(myPacket,do_cfm);	
			myPacket=null;
}
/*tianyang add POS缴费 end*/    		
    		
//add by liubo 加入撤单 start-----------------------------------------				
function commitJsp3(a,b)
{
		var quetype="q034";
		var reasonType ="3";
		var reasonDescription = "在缴费处统一撤单";		
		var startTime = "";
		var endTime = "";
		var osr="1";
		
 	 //var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
		var aa=g("arrayOrder").value.substring(0,g("arrayOrder").value.indexOf("|"));    //客户订单子项和服务定单
		var myPacket = new AJAXPacket("/npage/sq046/fq046_cancel.jsp?opcodestr=1&opCode=<%=opCode %>&opName=<%=opName%>","正在撤单，请稍候......");
		myPacket.data.add("retType","orderdata");
		myPacket.data.add("quetype",quetype);
		myPacket.data.add("reasonType",reasonType); 
		myPacket.data.add("reasonDescription",reasonDescription);
		myPacket.data.add("quevalue",aa);
		myPacket.data.add("phoneNo",<%=servPhoneNo%>);	
		myPacket.data.add("startTime",startTime);
		myPacket.data.add("endTime",endTime);
		myPacket.data.add("_orderID",g("custOrderId").value+"->"+g("arrayOrder").value);
		myPacket.data.add("workName","<%=loginNo%>");
		core.ajax.sendPacket(myPacket,rollbackPro);		 
		myPacket=null; 
}

function rollbackPro(packet){
	 var errorCode = packet.data.findValueByName("errorCode");
	 var errorMsg = packet.data.findValueByName("errorMsg");
	 if(errorCode!="0"){
		  rdShowMessageDialog("撤单失败!"+errorMsg,0);
		 
	 }else{
	 	  rdShowMessageDialog("撤单成功!");
	 	  parent.user_index.clearPage();	
	}
	return;
}

function checkWay()
{   //支票支付方式
    var obj = "check"+0;
    if(document.all.checkRadio.checked == true)
    {
    		document.all.payType.value = "0";/*交易类型*/
        document.all.checkRadio.checked = true;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "";	
        /*将建行及工商radio取消checked
          20100201 ningtn tianyang add for pos*/
        document.all.ccb.checked = false;
        document.all.icbc.checked = false;
        
    }
}    
function NocheckWay()
{   //非支票支付方式 
    var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.NocheckRadio.checked == true)
    {
    		document.all.payType.value = "0";/*交易类型*/
        document.all.checkRadio.checked = false;
        document.all.NocheckRadio.checked = true;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";
		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = "";
				/*将建行及工商radio取消checked
          20100201 ningtn tianyang add for pos*/
        document.all.ccb.checked = false;
        document.all.icbc.checked = false;
        
     }    
}
/** 银行POS机缴费 @20100201 ningtn tianyang add for pos start **/
function checkCCB(){
		//将支票缴费部分隐藏
		var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.ccb.checked == true)
    {    		
    		document.all.payType.value = "BX";/*交易类型*/
        document.all.checkRadio.checked = false;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = ""; 
				/*将工商银行 取消单选*/
				document.all.icbc.checked = false;
     }
     
}
function checkICBC(){
		//将支票缴费部分隐藏
		var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(document.all.icbc.checked == true)
    {    		
    		document.all.payType.value = "BY";/*交易类型*/
        document.all.checkRadio.checked = false;
        document.all.NocheckRadio.checked = false;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";		
        document.all.checkNo.value = "";
        document.all.bankCode.value = "";
        document.all.bankName.value = "";
        document.all.checkPay.value = "";
				document.all.checkPrePay.value = ""; 
				/*将建设银行 取消单选*/
				document.all.ccb.checked = false;
     }     
}
/** 银行POS机缴费 @20100201 ningtn tianyang add for pos end **/

function getBankCode()
{ 
  	//调用公共js得到银行代码
    if((document.all.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("请输入支票号码！",0);
        document.all.checkNo.focus();
        return false;
    }
    
  var getCheckInfo_Packet = new AJAXPacket("/npage/sq046/f1104_6.jsp","正在获得支票相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
  getCheckInfo_Packet.data.add("checkNo",document.all.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet,doGetBankCode);
	getCheckInfo_Packet=null;   
 } 

function doGetBankCode(packet){   //得到支票信息
		var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    
        var obj = "chPayNum" + 0;        
        if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0")
            {
    		        document.all.checkNo = "";
                document.all.bankCode.value = "";
                document.all.bankName.value = "";                
                document.all.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("该支票的帐户余额为0！",0);
            }
            else
            {   document.all(obj).style.display = "";            }
            
            document.all.bankCode.value = bankCode;
            document.all.bankName.value = bankName;
            document.all.checkPrePay.value = checkPrePay;            
    	}
    	else
    	{
    		document.all.checkNo.value = "";
            document.all.bankCode.value = "";
            document.all.bankName.value = "";
            document.all(obj).style.display = "none"; 
            document.all.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}


function getpreFee()
{
 	if(1*document.all.checkPay.value>1*document.all.totalFee3.value){
 		rdShowMessageDialog("金额超过要缴款金额",0);               		
 		document.all.checkPay.value = "";
 		document.all.totalFee3.value = document.all.totalFee1.value;
 		document.all.checkPay.focus();
		return false;	
 	}
 	
 	document.all.totalFee3.value = 1*document.all.totalFee3.value - 1*document.all.checkPay.value;
}

 
//add by liubo 加入撤单 end-----------------------------------------		


function show4100Page(){
    var path="/npage/sq046/show4100Page.jsp?oldMSISDN=<%=oldMSISDN%>&servPhoneNo=<%=servPhoneNo%>";
    var ret=window.showModalDialog(path,"","dialogWidth:750px;center:yes;");
}
</script>
     <!--通过客户订单编号查询客户订单状态 -->
     <%
     	long startTime2 = System.currentTimeMillis();
     	System.out.println("------------------custOrderId---------------------"+custOrderId);
     %>
<%String regionCode_sQCustOrderInfo = (String)session.getAttribute("regCode");%>
     <wtc:utype name="sQCustOrderInfo" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sQCustOrderInfo%>">
          <wtc:uparam value="<%=custOrderId%>" type="STRING"/>      
     </wtc:utype>
<%
		long endTime2 = System.currentTimeMillis();
		System.out.println("...................调用订单状态查询的时间为:  " + endTime2 +"-" + startTime2 + " =="+(endTime2-startTime2));

       retCode_046 = retVal.getValue(0);
       retMsg_046 = retVal.getValue(1);
       
      System.out.println("------------------retCode_046---------------------"+retCode_046);
			System.out.println("------------------retMsg_046----------------------"+retMsg_046);
			
     if(!retCode_046.equals("0")){
%>
<script>
       rdShowMessageDialog("查询客户订单状态信息失败！",0);	   
       window.history.go(-1);
</script>
<%
     }
     System.out.println();
     String feeStatus = retVal.getValue("2.1.0");//缴费状态,0未缴费,1已缴费,2部分缴费
     if(feeStatus.equals("0")){
          feeStatus = "未缴费";
     }else if(feeStatus.equals("1")){
          feeStatus = "已缴费";     
     }else{
         feeStatus = "部分缴费";    
     }
%>

<div id = "operation">
  <FORM action="" method="post" name="form1" id="Form" >
<%@ include file="/npage/include/header.jsp" %>  

     <div class="title"><div id="title_zi">客户基本信息</div></div>
     <%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
</div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">未缴费订单</div></div>
     <div class="list">
     <table  cellSpacing=0>
     	<tr>
     		<th>选择</th><th>客户订单编号</th><th>受理营业厅</th><th>订单创建时间</th><th>订单状态</th><th>受理工号</th><th>缴费状态</th>
     	</tr>
     	<tr>
     		<td><input type="radio" checked disabled="true" name="sCustOrderId" id="sCustOrderId" value="<%=custOrderId%>" onclick="FeeCheck()">1</td>
     		<td><%=custOrderId%></td> 
     		<td><%=retVal.getValue("2.0.1")%></td>
     		<td><%=retVal.getValue("2.0.3")%></td>
     		<td><%=retVal.getValue("2.0.4")%></td>
     		<td><%=retVal.getValue("2.0.5")%></td>
     		<td><%=feeStatus%></td>	
     	</tr>
     </table>
     </div>
     </div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">客户订单子项</div></div>
     <div class="list">
          <table  cellSpacing=0 id="listdiv2">
               <tr>
                    <th>客户订单编号</th>
                    <th>客户订单子项编号</th>
                    <th>业务对象类型</th>
                    <th>销售品</th>
                    <th>订单子项状态</th> 
                    <th>受理时间</th>
                    <th>操作员工</th>
               </tr>                                                                        
          </table> 
     </div>
     
     
     </div>
<div id="Operation_Table">
     <div class="title"><div id="title_zi">服务定单信息</div></div>
		<div class="list" id="tbl1">
          <table  cellSpacing=0 id="servtbl">
          	<tr>
          		 <th>服务定单号</th><th>客户订单子项号</th><th>业务组号</th><th>用户名称</th><th>服务类型</th><th>缴费状态</th> 
          	</tr> 
          </table>
     </div>
</div>
<div id="Operation_Table">
    <div class="title"><div id="title_zi">选定费用科目</div></div>
     <div class="list" id="tbl2">
     	 <table  cellSpacing=0 id="feetbl">
                 <tr>
                 	 <th>服务定单号</th>
                   <th>费用科目</th>
                   <th>应收金额</th>
                   <th  style=\"display:none\">优惠金额</th>
                   <th>实收金额</th>
                   
                   <th>收取方式</th>
                   <th>打印</th>
                   <th>说明</th>
                 </tr>            
               </table>
     </div>
	<div class="search">
		<table cellSpacing=0>
		  <tr>
			<td class=blue>应收总额</td>
			<td>
                    <input type="text" name="totalFee1" class='forMoney required' vflag=1  id="totalFee1" size="15" readonly="true" />
               </td>
               
               <td class=blue>实收总额</td>
            	<td>
                    <input type="text" name="totalFee3" class='forMoney required' vflag=1  id="totalFee3" size="15" readonly="true" />
               </td>
                    <input type="hidden" name="totalFee2"  vflag=1  id="totalFee2" size="15" readonly="true"   />
		   </tr>
		   <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">交款方式</div>
                  </TD>
                  <TD nowrap  > 
                    <input name="checkRadio" type="radio" onclick="checkWay()" value="check"  index="48">
                    支票交款 <br>	
                    &nbsp;<input type="radio" name="NocheckRadio" onClick="NocheckWay()" value="nocheck" checked index="49">
                    非支票交款 
                   <!-- ningtn 20100201 tianyang add for pos --><br>
					&nbsp;<input name="ccb" type="radio" onclick="checkCCB()" value="ccb"  index="50">建设银行POS机交款<br>					      
				    &nbsp;<input name="icbc" type="radio" onClick="checkICBC()" value="icbc" index="51">工商银行POS机交款
                  </TD>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
          </tr>
		</table>
		    
		    <TABLE id=check0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR > 
                  <TD  nowrap class=blue   width=15%> 
                    <div align="left">支票号码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input class="button" v_must=0 v_name="支票号码" v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font color="red">*</font>
								<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=查询>
            </TD>
                  <TD nowrap class=blue   width=15%> 
                    <div align="left">银行代码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input name=bankCode  class="button" maxlength="12" readonly Class="InputGrey" size="8">
				<input name=bankName  class="button" readonly Class="InputGrey">
                  </TD>                                              
            </TR>
           </TBODY>
         </TABLE>
        <TABLE id=chPayNum0  cellSpacing="0" style="display:none">
          <TBODY> 
            <TR> 
                  <TD  nowrap class=blue width="15%"> 
                    <div align="left">支票交款</div>
                  </TD>
            <TD  width="35%">
              	    <input class="button" v_must=1 v_type=money v_account=subentry name=checkPay value=0.00 maxlength=15 onkeyup="getpreFee()" index="51" onblur="checkElement(this)">
                    <font color="red">*</font> </TD> 
                  <TD  class=blue width="15%"> 
                    <div align="left">支票余额</div>
                  </TD>
                  <TD  width="35%"> 
                    <input class="button" name="checkPrePay" value=0.00 readonly Class="InputGrey">
                  </TD>               
            </TR>            
          </TBODY>
        </TABLE>
         
     </div>
     </div>
<div id="Operation_Table">
 	<div class="title"><div id="title_zi">备注信息</div></div> 
 	<div class="input">	
			<table cellSpacing=0>
		 
				<tr>
					<td class=blue>用户备注</td>
					<td colspan="3">
							<input type="hidden" size="100"  value="" name="op_note" id="op_note"/>
							<input type="text" size="100" maxlength="100"  value=""  name="sys_note" id="sys_note" readOnly class="InputGrey"  />
					</td>
				</tr>			
				<tr>
					<td id=footer colspan=4>
						<div id="operation_button">
	<input type="button" class="b_foot_long" name="b_pay_way" value="同步收取方式" onclick="changeAll('feeWay')" style="display:none"/>
	<input type="button" class="b_foot_long" name="b_is_print" value="同步打印方式" onclick="changeAll('isPrint')" style="display:none"/>
		<input type="button" class="b_foot_long" name="BAddOtherFee" value="其它费用" onClick="addType()" style="display:none"/>
		<input type="hidden"  value="<%=offeridkd%>">
    <input type="button" class="b_foot_long" name="fee_submit" id="fee_submit"  onclick="submit_cfm()"   value="收费处理" />
   <input class="b_foot" name=confirm  type=button index="8" value="撤单" onclick="commitJsp3('q034','撤单')" onkeydown="if(event.keyCode==13){}">
   <%if(opcodeadd.equals("4100")){%>
   	<input class="b_foot_long" name=confirm  type=button index="8" value="查询跨省开户情况" onclick="show4100Page()">
   <%}%>
</div>
					</td>
				</tr>	 
			</table>
		</div>	
</div>

	<%@ include file="/npage/include/footer.jsp" %>
	<input type="hidden" name="arrayOrder" id="arrayOrder" value="">
	<input type="hidden" name="servOrder" id="servOrder" value="">
	<input type="hidden" name="feeStr" id="feeStr" value="">
	<input type="hidden" name="custOrderId" id="custOrderId" value="<%=custOrderId%>">
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	<input type="hidden" name="gCustId" id="opName" value="<%=gCustId%>">
	<input type="hidden" name="feeWay" id="feeWay" value="0">
	<input type="hidden" name="isPrint" id="isPrint" value="0">
	<input type="hidden" name="prtAccpetLoginStr" id="prtAccpetLoginStr" value="0">
	<input type="hidden" name="payFeeAfter" id="payFeeAfter" value="0">
	
	<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->			
	<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
	<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- tianyang add at 20100201 for POS缴费需求*****end*******-->
	<input type="hidden" name="broadNo" id="broadNo" value="">
</form>
</div>

<!-- **** tianyang add for pos ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/sq046/posCCB.jsp" %>
<!-- **** tianyang add for pos ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/sq046/posICBC.jsp" %>

</body>
</html>
<%
		endTime1 = System.currentTimeMillis();
	 	System.out.println("...................处理结果的时间为:  " + endTime1 +"-" + beginTime1 + " =="+(endTime1-beginTime1));	
	 	
	 	long totalend =  System.currentTimeMillis();
	 	System.out.println("...................总时间:  " + totalend +"-" + totalBegin + " =="+(totalend-totalBegin));	
	 	
}%>
     
