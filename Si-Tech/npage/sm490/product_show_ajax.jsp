<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String opCode =WtcUtil.repNull(request.getParameter("opCode"));	//"1210";//操作代码
	String workNo=(String)session.getAttribute("workNo");//操作员登录工号---------j		
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		
		
		
		String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));
		String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));
		String offerId=WtcUtil.repNull(request.getParameter("offerId"));
		String offerName=WtcUtil.repNull(request.getParameter("offerName"));
		String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));
		String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));
		
		
		
		String offer_att_type = WtcUtil.repNull(request.getParameter("offer_att_type"));
		String smCode = WtcUtil.repNull(request.getParameter("smCode"));
		
		System.out.println("--------------------------offer_att_type------------------------"+offer_att_type);
		System.out.println("--------------------------smCode--------------------------------"+smCode);
		
		String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));
		String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));
		String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));
		String closeId=WtcUtil.repNull(request.getParameter("closeId"));
		String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));
		
	//String groupId=(String)session.getAttribute("siteId");//区域标识
	String groupId=(String)session.getAttribute("groupId");
	System.out.println("##################################################################groupId==="+groupId);
	String parm=WtcUtil.repNull(request.getParameter("param"));
	//String flag=(String)session.getAttribute("isPorvinceWorkNo");//是否省级工号
	String flag="N";
			System.out.println("#########################################更新后的flag==="+flag);
	System.out.println("#########################################更新后的groupId==="+groupId);
	gCustId=WtcUtil.repNull(request.getParameter("gCustId"));	//用户ID"200011190320";---------j
	String USER_RANGE="0101010";//使用限制
	String CUST_GROUP_ID="";//客户群标识
	String OFFER_ID=offerId;	//"100005329";//用户已订购的基本销售品标识---------j
	String OFFER_ATTR_SEQ="";//销售品属性标识
	String QRYFLAG=WtcUtil.repNull(request.getParameter("QRYFLAG"));//查询类型(0,查询;1高级检索)
	String OFFER_ATTR_TYPE="";//销售品分类标识//A
	String[][] productInfo=null; 
	int    num=0;
	String flagShow="false";
	String offerType=WtcUtil.repNull(request.getParameter("offerType"));//销售品类型
	String offerCode=WtcUtil.repNull(request.getParameter("offerCode"));//销售品编码
	String receiveRegion=WtcUtil.repNull(request.getParameter("receiveRegion"));//渠道类型标识
	if("1".equals(QRYFLAG)){
		groupId=receiveRegion;
		groupId=receiveRegion;
		receiveRegion="";
	}	
System.out.println("==opCode=="+opCode);	
System.out.println("==QRYFLAG=="+QRYFLAG);
System.out.println("==gCustId=="+gCustId);
System.out.println("==OFFER_ID=="+OFFER_ID);
System.out.println("==workNo=="+workNo);
System.out.println("==flag=="+flag);
System.out.println("==groupId=="+groupId);	
System.out.println("==offerCode=="+offerCode);
System.out.println("==offerName=="+offerName);	
System.out.println("==offerType=="+offerType);
System.out.println("==OFFER_ATTR_SEQ=="+OFFER_ATTR_SEQ);	
System.out.println("==OFFER_ATTR_TYPE=="+OFFER_ATTR_TYPE);
System.out.println("==USER_RANGE=="+USER_RANGE);
System.out.println("==CUST_GROUP_ID=="+CUST_GROUP_ID);	
System.out.println("==receiveRegion=="+receiveRegion);
String regionCode = (String)session.getAttribute("regCode");
String lSql = "SELECT COUNT(*) FROM dcustinnet WHERE open_time+1>SYSDATE AND TO_CHAR(open_time,'YYYYMM')=TO_CHAR(SYSDATE,'YYYYMM') AND id_no="+servId;
  String offerCode1 = offerCode;
  
  
  if(offerCode!=null&&(!"".equals(offerCode))){
%>
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
    		  <wtc:param value="218"/>
    		  <wtc:param value="<%=offerCode%>"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>
    		
    		<%
    			if(result_t.length>0&result_t[0][0]!=null){
    				offerCode1 = result_t[0][0];
    			}
    			if(offerCode1.trim().equals("")) offerCode1 = "0";
   }  
    		
%>

	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=lSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 	
	 	
<wtc:utype name="sGetChgBOffer" id="retVal2" scope="end">
	<wtc:uparams>
				<wtc:uparam value="<%=opCode%>" type="string " />
				<wtc:uparam value="<%=QRYFLAG%>" type="string"/>
				<wtc:uparam value="<%=servId%>" type="long"/>	<!-- 由custID转为servId-->
				<wtc:uparam value="<%=OFFER_ID%>" type="long"/>
				<wtc:uparam value="<%=workNo%>" type="string"/>
				<wtc:uparam value="<%=flag%>" type="string"/>
				<wtc:uparam value="<%=groupId%>" type="long"/>
				<wtc:uparam value="<%=offerCode1%>" type="string" />
				<wtc:uparam value="<%=offerName%>" type="string"/>
				<wtc:uparam value="<%=offerType%>" type="long" />
				<wtc:uparam value="<%=OFFER_ATTR_SEQ%>" type="long"/>
				<wtc:uparam value="<%=offer_att_type%>" type="string"/>
				<wtc:uparam value="<%=USER_RANGE%>" type="string"/>
				<wtc:uparam value="<%=CUST_GROUP_ID%>" type="long"/>
				<wtc:uparam value="<%=receiveRegion%>" type="string"/>	
				<wtc:uparam value="<%=smCode%>" type="long"/>		
	</wtc:uparams>							
</wtc:utype>
<%


		String liFlag = result_t[0][0];
		
		System.out.println("-----------------------------liFlag--------------------------------"+liFlag);

		String retCode2=retVal2.getValue(0);
		String retMsg2 =retVal2.getValue(1);
System.out.println("===retCode2==="+retCode2);	
System.out.println("===retMsg2===jjjjjjjjjjjjjjjjjjjjjj"+retMsg2);		
		/*if(retCode2.equals("0"))
		{*/
			flagShow="true";
			num= retVal2.getSize("2");
			System.out.println("===num==="+num);	
			productInfo=new String[num][19];
			for(int i=0;i<num;i++)
			{
				for(int j=0;j<retVal2.getSize("2."+i);j++)
				{
					productInfo[i][j]=retVal2.getValue("2."+i+"."+j);
					//System.out.println("productInfo["+i+"]["+j+"]==="+productInfo[i][j]);
				}
			}
%>		
<script type="text/javascript">
    $(document).ready(function(){
        $("#ta tr:even").addClass("double");
        $("#proList :radio").bind("click",checklim);
        
        
    });
</script>

		<table id="ta" cellspacing=0>
					<tr>
						<th nowrap>选择</th>
						<th nowrap>销售品代码</th>
						<th nowrap>销售品名称</th>
						<th nowrap>生效时间</th>
						<th nowrap>销售品描述</th>
						<th nowrap>定价计划</th>	
						<th nowrap>失效时间</th>	

					</tr>	
<%
 String cudate =new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
 String cudate1 =new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()).toString();
 
 
		if(flagShow.equals("true"))
		{
			for(int i=0;i<num;i++)
			{			
				String effecttime=WtcUtil.repNull(productInfo[i][17]);
				effecttime=effecttime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
				if(effecttime.length()>8) effecttime=effecttime.substring(0,8);

				String effecttype=WtcUtil.repNull(productInfo[i][11]);
				String effecttypeName=effecttype;
				if(effecttype.length()>0){
					effecttype=effecttype.substring(0,1);
					if(effecttypeName.length()>1)
					effecttypeName=effecttypeName.substring(1);
					if("3".equals(effecttype)){
						effecttime="自定义";
					}
					
					if(!liFlag.equals("0")){
						effecttime = cudate;
						productInfo[i][17] = cudate1;
					}
				}

%>				    	
					<tr>
						<td><input type="radio" name="proRad" onclick='midPrompt(<%=productInfo[i][0]%>,this)' value="<%=productInfo[i][0]+","+productInfo[i][1]+","+productInfo[i][2] +","+effecttype+","+productInfo[i][13]+","+productInfo[i][14]+","+productInfo[i][17]+","+productInfo[i][18]+",,"+productInfo[i][3] %>" ></td>
						<td><%=productInfo[i][0]%></td>
						<td id='offer_td_<%=productInfo[i][0]%>'><%=productInfo[i][2]%></td>
						<td><%=effecttime%></td>
						<td><%=productInfo[i][3]%></td>
						<td><input type="button" class="b_text" value="查看" onclick="window.showModalDialog('showPrice.jsp?OFFER_ID=<%=productInfo[i][0]%>','dialogHeight=300px','dialogWidth=650px','help=no','status=no')" /></td>
						<td><%=productInfo[i][18].substring(0,8)%></td>
					</tr>
					
<%
			}
	  }
%>				
			</table>
			

				