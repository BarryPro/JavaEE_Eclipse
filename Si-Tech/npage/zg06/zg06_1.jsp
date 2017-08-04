<%
	/********************
	 *version v2.0
	 *开发商: si-tech
	 *author:
	 *update:anln@2009-02-12 页面改造,修改样式
	 *update by qidp @ 2009-04-10 集团页面整合
	 *update by qidp @ 2009-06-02 整合端到端流程
	 ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="org.apache.log4j.Logger"%>


<%
   	String opCode = "zg06";	
	String opName = "集团产品余额提醒阀值设置";	//header.jsp需要的参数  
	Logger logger = Logger.getLogger("zg06_1.jsp");
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr1);
    String addDate = Integer.toString(iDate+1);
	String op_code="zg06"; 
	String unit_id = request.getParameter("unit_id");
	String groupUserId = request.getParameter("grpIdNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String org_code = ((String)session.getAttribute("orgCode")).substring(0,7);
	String nopass  =(String)session.getAttribute("password"); 
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String districtCode = Department.substring(2,4);
	String powerRight = (String)session.getAttribute("powerRight"); 
	String sqlStr = "";
	String service_name = "";
	String m2mFlag1 = "N";
	String m2mFlag2 = "N";

	
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	String[][] resulta = new String[][]{};
	String[][] resultList = new String[][]{};
	String[][] resultList2 = new String[][]{};
	int resultListLength2=0;

    productCfg prodcfg = new productCfg();
	int nextFlag=1; //标记是第一步还是第二步
	String listShow="none";
	
	StringBuffer nameList=new StringBuffer();
	StringBuffer nameValueList=new StringBuffer();
	StringBuffer nameGroupList=new StringBuffer();
	StringBuffer nameListNew=new StringBuffer();
	StringBuffer nameGroupListNew=new StringBuffer();
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());	
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	//String[][] result2  = null;
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
	String ProvinceRun = "";
	if (result2 != null && result2.length != 0) {
		ProvinceRun = result2[0][0];
	}
	
	
	//得到页面参数
	String grpOutNo = "";
	String idcMebNo   ="";
	String smCode      ="";
	String smName    ="";
	String custName    ="";
	String iUserPwd    ="";
	String runCode      ="";
	String runName  ="";
	String ownerGrade   ="";
	String gradeName="";
	String ownerType ="";
	String ownerTypeName   ="";
	String custAddr   ="";
	String idType="";
	String idName="";
	String idIccid="";
	String card_name="";
	String totalOwe="";
	String totalPrepay="";
	String firstOweConNo="";
	String firstOweFee="";
	String bak_field="";
	String backPrepay="";
	String backInterest="";
	String notBackPrepay="";
	String openTime="";
	String grpIdNo="";
	String iccid="";
	String idNo="";
	String temp_buf="";
	String user_no2="";
	String unit_id2="";
	String cust_id2="";
	String iccid2 = "";
	String product_code3="";
	Vector temp=new Vector();
	StringBuffer fieldCode=new StringBuffer();
	StringBuffer fieldCode2=new StringBuffer();//for add item


	StringBuffer numberList=new StringBuffer();
	System.out.println("1");
	//得到列表操作
	//String action=request.getParameter("action");
	
	/******* add by qidp @ 2009-06-02 整合端到端流程 *******/
	String in_GrpId = request.getParameter("in_GrpId");
	String in_IdNo = request.getParameter("IdNo");
    String in_ChanceId = request.getParameter("in_ChanceId");
    String wa_no = request.getParameter("wa_no1");
    String action = "";
    String openLabel = "";/*添加标志位，link：走端到端流程通过任务控制进入此订购模块；opcode：不走端到端流程，通过opcode打开此页面。*/
	String qryFlag=request.getParameter("qryFlag")==null?"":request.getParameter("qryFlag");
    /*判断接入此模块的方式，并做相应的处理。*/
    if(in_ChanceId != null){//由任务管理接入时，商机编码不为空。
        action = "query";
        openLabel = "link";
        //liujian 2012-9-13 17:56:43 申告
        qryFlag = "qryCust";
        
    }else{
        in_GrpId = "";
        in_ChanceId = "";
        wa_no = "";
        in_IdNo = "";
        action = request.getParameter("action");
        openLabel = "opcode";
    }
    
	
	
	System.out.println("3691~~~~qryFlag"+qryFlag);    
    String ccDisp="";
    if ( qryFlag.equals("qryCptCpm") )
    {
    ccDisp="block"; 
    }
	else
	{
	 ccDisp="none"; 
	}
    
    /******* end of add *******/
	String []   paramsArray=new String [38];
	String [][] paramsOut=new String[][]{};	
	String [][] paramsOut26=new String[][]{};
	String [][] paramsOut27=new String[][]{};
	String [][] paramsOut28=new String[][]{};
	String [][] paramsOut29=new String[][]{};
	String [][] paramsOut30=new String[][]{};
	String [][] paramsOut31=new String[][]{};
	String [][] userFieldGrpNo=new String[][]{}; 
	String [][] userFieldGrpName=new String[][]{};
	String [][]userFieldMaxRows=new String[][]{};
	String [][]userFieldMinRows=new String[][]{};
	String [][]userFieldCtrlInfos=new String[][]{};
	String [][]userUpdateFlag=new String[][]{};
	String [][]openParamFlag=new String[][]{};
	String [][]timeMOStr=new String[][]{};
	String [][]vpmnStr=new String[][]{};
	String [][]manyPropertyStr=new String[][]{};
	String modeType=request.getParameter("userType");
	String error_code="9";
	String error_msg="";
	int resultListLength=0;
	System.out.println("&&&&&&&&&&&&&&*****************%%%%%%%%%%%%%%%%%%%%%%---"+action);
	if (action!=null&&action.equals("query")){
		//try{
			grpIdNo=request.getParameter("grpIdNo");
			iccid=request.getParameter("iccid");
			 idcMebNo=request.getParameter("idcMebNo");		
			 //user_no2=request.getParameter("user_no");	
			 //unit_id2=request.getParameter("unit_id");
			 //cust_id2=request.getParameter("cust_id");
			 //iccid2 = request.getParameter("iccid");
			 
			 iccid2=(request.getParameter("iccid") == null)?"":(request.getParameter("iccid"));
            cust_id2=(request.getParameter("cust_id") == null)?"":(request.getParameter("cust_id"));
            unit_id2=(request.getParameter("unit_id") == null)?"":(request.getParameter("unit_id"));
            user_no2=(request.getParameter("user_no") == null)?"":(request.getParameter("user_no"));
            iUserPwd=WtcUtil.repNull((String)request.getParameter("userPassword"));
            
			 product_code3=request.getParameter("product_code2");

			 if(openLabel!=null && openLabel.equals("link")){
			    grpIdNo = in_IdNo;
			 }

		     	 String [] paramsIn=new String []{workno,grpIdNo,"3517"};
		     	 %>
		     	 	<wtc:service name="s3691QryE" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="55" >
					<wtc:param value="<%=workno%>"/>
					<wtc:param value="<%=grpIdNo%>"/>
					<wtc:param value="3517"/>					
					<wtc:param value="<%=in_ChanceId%>"/> 
				</wtc:service>
				<%
				System.out.println("&&&&&&&&&&&&&&*****************%%%%%%%%%%%%%%%%%%%%%%---"+grpIdNo);
				%>
				<wtc:array id="paramsOut1" start="0" length="40" scope="end"/>
				<wtc:array id="paramsOut261" start="26" length="4" scope="end"/>
				<wtc:array id="paramsOut271" start="27" length="1" scope="end"/>
				<wtc:array id="paramsOut281" start="28" length="1" scope="end"/>
				<wtc:array id="paramsOut291" start="29" length="1" scope="end"/>
				<wtc:array id="paramsOut301" start="30" length="1" scope="end"/>
				<wtc:array id="paramsOut311" start="31" length="1" scope="end"/>
				<wtc:array id="userFieldGrpNo1" start="32" length="1" scope="end"/>
				<wtc:array id="userFieldGrpName1" start="33" length="1" scope="end"/>
				<wtc:array id="userFieldMaxRows1" start="34" length="1" scope="end"/>
				<wtc:array id="userFieldMinRows1" start="35" length="2" scope="end"/>				
				<wtc:array id="userFieldCtrlInfos1" start="37" length="1" scope="end"/>
				<wtc:array id="userUpdateFlag1" start="38" length="1" scope="end"/>
				<wtc:array id="openParamFlag1" start="39" length="1" scope="end"/>
				<wtc:array id="timeMOStr1" start="40" length="2" scope="end"/>
				<wtc:array id="vpmnStr1" start="42" length="12" scope="end"/>
				<wtc:array id="manyPropertyStr1" start="54" length="1" scope="end"/>
		     	 <%
		     	 	paramsOut=paramsOut1;
		     	 	paramsOut26=paramsOut261;
		     	 	paramsOut27=paramsOut271;
		     	 	paramsOut28=paramsOut281;
		     	 	paramsOut29=paramsOut291;
		     	 	paramsOut30=paramsOut301;
		     	 	paramsOut31=paramsOut311;
		     	 	userFieldGrpNo=userFieldGrpNo1;
		     	 	userFieldGrpName=userFieldGrpName1;
		     	 	userFieldMaxRows=userFieldMaxRows1;
		     	 	userFieldMinRows=userFieldMinRows1;
		     	 	userFieldCtrlInfos=userFieldCtrlInfos1;
		     	 	userUpdateFlag = userUpdateFlag1;
		     	 	openParamFlag = openParamFlag1;
		     	 	timeMOStr = timeMOStr1;
		     	 	vpmnStr = vpmnStr1;
		     	 	manyPropertyStr = manyPropertyStr1;
		     	 	
		     	 	error_code=retCode2;             		
                    error_msg=retMsg2;
             if(!(error_code.equals("000000")))
			{
%>
                <script>
                    rdShowMessageDialog("错误代码：<%=error_code%>错误信息：<%=error_msg%>",0);
				    history.go(-1);
                </script>
<%
			}
			if(paramsOut!=null&&paramsOut.length>0){
				 for (int i=0;i<26;i++){				
					paramsArray[i]=paramsOut[0][i];
				 }
			}
			System.out.println("-----xCott-----paramsOut26.length---"+paramsOut26.length);

			for (int i=0;i<paramsOut26.length;i++){
				fieldCode.append(paramsOut26[i][0]+"|");
			}
			
System.out.println("2");
			/*paramsOut27=(String[][])retArray.get(27);
			paramsOut28=(String[][])retArray.get(28);
			paramsOut29=(String[][])retArray.get(29);
			paramsOut30=(String[][])retArray.get(30);
			paramsOut31=(String[][])retArray.get(31);
			userFieldGrpNo=(String[][])retArray.get(32);
			userFieldGrpName=(String[][])retArray.get(33);
			userFieldMaxRows=(String[][])retArray.get(34);
			userFieldMinRows=(String[][])retArray.get(35);
			userFieldCtrlInfos=(String[][])retArray.get(37);*/
			
System.out.println("3");
			if(paramsOut30!=null&&paramsOut30.length>0){
				for (int i=0;i<paramsOut30.length;i++){		
					if (paramsOut30[i][0].equals("14")){
						temp.add(paramsOut26[i][0]);
					}
				}
			}
			System.out.println("000000000000000000000000000000000000000="+retCode2);
			
			 
			 nextFlag=2;
			 listShow="";
				//得到数据的行数
				//得到具体数据
			//得到集团用户编码add
			String bizCode = "";
			if ("ML".equals(paramsArray[9])||"AD".equals(paramsArray[9])){
                String sql1="select trim(field_value) from dgrpusermsgadd where id_no = '"+paramsArray[0]+"' and TRIM(field_code) = 'YWDM0'";
                %>
                	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode44" retmsg="retMsg44" outnum="1">
                		<wtc:sql><%=sql1%></wtc:sql>
                	</wtc:pubselect>
                	<wtc:array id="result44" scope="end" />
                <%
                    
                    if("000000".equals(retCode44) && result44.length>0){
                        bizCode = result44[0][0];
                    }else{
                %>
                        <script>
                            rdShowMessageDialog("取bizCode失败！",0);
                		    history.go(-1);
                        </script>
                <%
                    }
            }
		     	 	
//------------add by hansen-------------
//----得到该用户没有添加的项
System.out.println("=========================&&&&&--vpmn--"+paramsArray[0]);
 

        if ("ML".equals(paramsArray[9])||"AD".equals(paramsArray[9])){
            /* 适用于行业网关1.0 */
            sqlStr=" select a.param_code,a.param_name,'11',a.param_type,a.param_length,b.null_able,b.open_param_flag "
            +"   from sbizparamcode a, sbizparamdetail b ,SBILLSPCODE c"
            +"  where a.param_code = b.param_code "
            +"    and b.param_set = c.param_set  "
            +"    and trim( c.bizcodeadd )='"+bizCode+"' "
            +"    and b.update_flag = 'Y'  "
            +"    and b.multi_able = 'N'  "
            +"    and b.show_flag = 'Y'   "
            +"    and a.param_code in (SELECT a.param_code "
            +"                           FROM sbizparamcode a, sbizparamdetail b,SBILLSPCODE c "
            +"                          WHERE a.param_code = b.param_code "
            +"    						   and b.param_set = c.param_set "
            +"    						   and trim( c.bizcodeadd )='"+bizCode+"' "
            +"                             and a.param_code not in ('00020','00021')"
            +"                         MINUS "
            +"                         SELECT a.field_code "
            +"                           FROM DGRPUSERMSGADD a "
            +"                          WHERE a.id_no = '"+paramsArray[0]+"') "
            +"  order by b.param_order, a.param_type ";
            
             
        }else{
            sqlStr="select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,b.ctrl_info,b.open_param_flag "
         +"  from sUserFieldCode a,SGRPSMFIELDRELA b"
         +"     where a.field_code=b.field_code"
         +"     AND b.user_type = '"+paramsArray[9]+"'"
         +"     AND b.update_flag = 'Y'"
         +"     AND a.field_code not in ( 'ZHWW0')"
         +"   and a.field_code in("
         +" SELECT a.field_code"
             +"      FROM suserfieldcode a, SGRPSMFIELDRELA b"
             +"      where a.field_code = b.field_code"
             +"      AND b.user_type = '"+paramsArray[9]+"'"
             +"      MINUS"
             +"      SELECT a.field_code"
             +"      FROM DGRPUSERMSGADD a, SGRPSMFIELDRELA c"
             +"      WHERE a.id_no = '"+paramsArray[0]+"'"
             +"      AND a.field_code = c.field_code"
             +"      AND a.user_type = c.user_type)"
             +" order by b.field_order,a.field_type";
             
            }
                if(!"va".equals(paramsArray[9])){
			//resultList2=(String[][])callView.sPubSelect("6",sqlStr).get(0);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="7">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result3" scope="end" />
			<%
			resultList2=result3;
			if (retCode3.equals("000000")&&resultList2 != null&&resultList2.length>0)
			{
				if (resultList2[0][0].equals(""))
				{
					resultList2 = null;
				}
			}
			if (retCode3.equals("000000")&&resultList2 != null&&resultList2.length>0)
			{
				for(int i=0;i<resultList2.length;i++)
				{
					if (resultList2[i][2].equals("10")){
						numberList.append(resultList2[i][0]+"|");
					}
				}
			}

			resultListLength2=0;
			if (resultList2 != null&&resultList2.length>0){
				resultListLength2=resultList2.length;
				//代码拼串传递到下个页面
			    for (int i=0;i<resultListLength2;i++){
					fieldCode2.append(resultList2[i][0]+"|");
					for(int j=0;j<resultList2[0].length;j++){
					    System.out.println("============:"+resultList2[i][j]);
					}
				}
			}
		  	
}
//---------------------------


		
	}
	String busiFlag = "";
	String getBusiFlagSql = "";
    if ("link".equals(openLabel)){
        getBusiFlagSql = "select trim(field_value) from dgrpusermsgadd where id_no = " + in_IdNo + " and field_code = '1010' ";
    }else {
       getBusiFlagSql = "select trim(field_value) from dgrpusermsgadd where id_no = " + groupUserId + " and field_code = '1010' ";
    }
    
    if ("hj".equals(paramsArray[9])){
%>
        <wtc:service name="TlsPubSelCrm" outnum="1" retcode="retCode111" retmsg="retMsg111">
    		<wtc:param value="<%=getBusiFlagSql%>"/>
    	</wtc:service>
        <wtc:array id="busiFlagResult" scope="end"/> 
<%  
        System.out.println(" zhoubyt ttttt = " + busiFlagResult.length);
        if (busiFlagResult.length > 0){
            busiFlag = busiFlagResult[0][0];
            System.out.println(" zhoubyt ttttt = " + busiFlag);
        }
    }
    
    System.out.println(" zhoubynnn ==============" + groupUserId);
%>
    
	<HEAD>
	<TITLE>集团产品资料变更</TITLE>	
	<SCRIPT type=text/javascript>	
		onload=function(){	
			if('<%=action%>' == 'query') {
				$('#cptCpmQry').css('display','none');	
			}	
		    var disableStr = "";
		    document.all.in_ChanceId2.value = "<%=in_ChanceId%>";
		    
        <%
            /*****************************
             * 走端到端时，调用服务，获取销售方面传入的数据。
             *****************************/
//            try{
                if(openLabel!=null && openLabel.equals("link")){
                %>
                    <wtc:service name="QryServMC" routerKey="region" routerValue="<%=regionCode%>" retcode="QryServMCCode" retmsg="QryServMCMsg" outnum="21" >
                        <wtc:param value="<%=in_GrpId%>"/>
                        <wtc:param value="<%=in_ChanceId%>"/> 
                        <wtc:param value="1"/>
                        <wtc:param value="<%=in_IdNo%>"/>
                        <wtc:param value=""/>
                    </wtc:service>
                    <wtc:array id="QryServMCArr" start="6" length="15" scope="end"/>
                    <wtc:array id="QryServMCArr2" start="0" length="6" scope="end"/>
                    
                <%
                    if("000000".equals(QryServMCCode) && QryServMCArr2.length>0){
                        for(int i=0;i<QryServMCArr2.length;i++){
                            out.print("if(document.getElementById('"+QryServMCArr2[i][1]+"') != null){");
                            //zhouby
                            //System.out.println(" zhoubyt " + QryServMCArr2[i][1]);
                            //System.out.println(" zhoubyt " + QryServMCArr2[i][3]);
%>
                            var zValue = '<%=QryServMCArr2[i][3]%>';
                            var zTarget = document.getElementById("<%=QryServMCArr2[i][1]%>");
<%                      
                        System.out.println(" zhoubyt 品牌 = " + paramsArray[9]);
                        System.out.println(" zhoubyt  busiFlag = " + busiFlag);
                        //if ("hl".equals(paramsArray[9]) || 
                          //      ("hj".equals(paramsArray[9]) && "211".equals(busiFlag))
                            //){
                        if (("hl".equals(paramsArray[9]) || "hj".equals(paramsArray[9])) && 
                                openLabel.equals("link")){%>
                            if ($(zTarget).is('select') && zValue == ''){
                                $(zTarget).empty().html('<option value=""></option>');
                            } else {
                                $(zTarget).val(zValue);
                            }
<%                      }else{%>
                            zTarget.value = zValue;
<%                      }
                            out.print("}");
                        }
                    }else{
                        %>
                        rdShowMessageDialog("<%=QryServMCCode%>" + "[" + "<%=QryServMCMsg%>" + "]" ,0);
                        <%
                        System.out.println("zg01_1.jsp -> service QryServMC :"+QryServMCCode+"----"+QryServMCMsg);
                    }
                    
                    if("000000".equals(QryServMCCode) && QryServMCArr.length>0){
                        out.print("document.all.iccid.value=\""+QryServMCArr[0][0]+"\";");
                        out.print("document.all.cust_id.value=\""+QryServMCArr[0][1]+"\";");
                        out.print("document.all.unit_id.value=\""+QryServMCArr[0][2]+"\";");
                        out.print("document.all.user_no.value=\""+QryServMCArr[0][14]+"\";");
                    }
                }
//            }catch(Exception e){
//                e.printStackTrace();
//                System.out.println("f3691_1.jsp -> Call service QryServMC failed!");
//            }
if (action!=null&&action.equals("query")){
%>
    $("#chkPass").attr("disabled",true);
<%
        if("ML".equals(paramsArray[9]) || "AD".equals(paramsArray[9])){
            if(timeMOStr.length>0){
%>
         	 	    var timeStr = "<%=timeMOStr[0][0]%>";
         	 	    var timeArray = new Array();
                    timeArray = timeStr.split('~');
                    if(document.all.F00020 != null)
                    document.all.F00020.value = timeArray[0];
                    if(document.all.StartTime != null)
                    document.all.StartTime.value = timeArray[1];
                    if(document.all.EndTime != null)
                    document.all.EndTime.value = timeArray[2];
                    
                    var moStr = "<%=timeMOStr[0][1]%>";
                    var moArray = new Array();
                    moArray = moStr.split('~');
                    if(document.all.F00021 != null) document.all.F00021.value = moArray[0];
                    if(document.all.MOCode != null) document.all.MOCode.value = moArray[1];
                    if(document.all.CodeMathMode != null) document.all.CodeMathMode.value = moArray[2];
                    if(document.all.MOType != null) document.all.MOType.value = moArray[3];
                    if(document.all.DestServCode != null) document.all.DestServCode.value = moArray[4];
                    if(document.all.ServCodeMathMode != null) document.all.ServCodeMathMode.value = moArray[5];
<%
            }
        }
        if("vp".equals(paramsArray[9])){
%>
            document.all.vpmn_flag.style.display = "";
            document.all.group_name.value = "<%=vpmnStr[0][0]%>";
            document.all.province.value = "<%=vpmnStr[0][1]%>";
            document.all.contact.value = "<%=vpmnStr[0][2]%>";
            document.all.telephone.value = "<%=vpmnStr[0][3]%>";
            document.all.address.value = "<%=vpmnStr[0][4]%>";
            document.all.srv_start.value = "<%=vpmnStr[0][5]%>";
            document.all.srv_stop.value = "<%=vpmnStr[0][6]%>";
            document.all.fee_rate.value = "<%=vpmnStr[0][7]%>";
            document.all.busi_type.value = "<%=vpmnStr[0][8]%>";
            document.all.chg_flag.value = "<%=vpmnStr[0][9]%>";
            document.all.cover_region.value = "<%=vpmnStr[0][10]%>";
            document.all.max_outnumcl.value = "<%=vpmnStr[0][11]%>";
        <%}}%>
        <%
        /*****************************
         * 走端到端时，根据要求，一些元素不允许修改。
         *****************************/
     
        String sql33 = "";
//        try{
            if(openLabel!=null && openLabel.equals("link")){
                sql33 = "select name_id,name_type from sgrpmsgdisabled where sm_code = '"+paramsArray[9]+"' and OP_TYPE = '2' and disabled_flag = 'N'";
                System.out.println("sql33 = " + sql33);
            %>
            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode00" retmsg="retMsg00" outnum="2">
            		<wtc:sql><%=sql33%></wtc:sql>
            	</wtc:pubselect>
            	<wtc:array id="result00" scope="end" />
            <%
                if(retCode00.equals("000000") && result00.length>0){
                    for(int i=0;i<result00.length;i++){
                        if("01".equals(result00[i][1])){//01:文本框
                            out.print("if(document.all('"+result00[i][0]+"') != null){");
                                out.print("document.all('"+result00[i][0]+"').readOnly=true;");
                                out.print("$(document.all('"+result00[i][0]+"')).addClass(\"InputGrey\");");
                            out.print("}");
                        }else if("02".equals(result00[i][1])){//02:下拉框
                            out.print("if(document.all('"+result00[i][0]+"')!=null){");
                                out.print("document.all('"+result00[i][0]+"').disabled=true;");
                                out.print("disableStr = disableStr + \""+result00[i][0]+"\" + \"|\";");
                                out.print("");
                            out.print("}");
                        }else if("03".equals(result00[i][1])){//03:按钮
                            out.print("if(document.all('"+result00[i][0]+"')!=null){");
                                out.print("document.all('"+result00[i][0]+"').disabled=true;");
                            out.print("}");
                        }
                    }
                }
            }
//        }catch(Exception e){
//            e.printStackTrace();
//            System.out.println("# f3691_1.jsp -> failed! SQL = " + sql33);
//        }
        %>
        
    <%if(!"aavg21".equals(workno.toLowerCase())){
        if("vp".equals(paramsArray[9])){
    %>
            if($("#F10328") != null){
                $("#F10328").attr("readOnly",true);
                $("#F10328").addClass("InputGrey");
            }
    <%
        }
    }%>
		}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
	//alert("retType is "+retType);
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.userPassword.value = "";
	        	frm.userPassword.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
				document.frm.next.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！");
			document.frm.next.disabled = true;
    		return false;
        }
     }	
	 if(retType == "check_no") //集团用户编码
     {
        if(retCode == "000000")
        {
            var tmp_fld = packet.data.findValueByName("tmp_fld");
            if (tmp_fld == "false") {
    	    	rdShowMessageDialog("集团用户编码校验失败，请重新输入！",0);
    	    	return false;	        	
            } else {
				GetIdcMebNo();
            }
         }
        else
        {
			var retMsg = packet.data.findValueByName("retMsg");
            rdShowMessageDialog(retMsg);
			document.frm.grpOutNo.focus();
    		return false;
        }
     }
	 if(retType == "getCheckInfo")
	{   //得到支票信息
        var obj = "checkShow"; 
        if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0.00"){
                frm.bankCode.value = "";
                frm.bankName.value = "";                
                frm.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("该支票的帐户余额为0！");
            }
            else {   
					document.all(obj).style.display = "";            
			        frm.bankCode.value = bankCode;
					frm.bankName.value = bankName;
		            frm.checkPrePay.value = checkPrePay;
					if(frm.real_handfee.value==''){//add
						frm.checkPay.value='0.00';
					}
					else
					{
					    frm.checkPay.value = frm.real_handfee.value;
					}
			}
		}
    	else
    	{
    		frm.checkNo.value = "";
            frm.bankCode.value = "";
            frm.bankName.value = "";
            document.all(obj).style.display = "none"; 
            frm.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}
 
      
}
	function changePayType(){
		if (document.all.checkPayTR.style.display=="none"){
			document.all.checkPayTR.style.display="";
		}
		else {
			document.all.checkPayTR.style.display="none";
		}
	}
	 
	function check_HidPwd()
	{
	    var idNo = document.frm.grpIdNo.value;
	    var Pwd1 = document.frm.userPassword.value;
	    var checkPwd_Packet = new AJAXPacket("../s3691/pubCheckPwdIDC.jsp","正在进行密码校验，请稍候......");
	    checkPwd_Packet.data.add("retType","checkPwd");
		checkPwd_Packet.data.add("idNo",idNo);
		checkPwd_Packet.data.add("Pwd1",Pwd1);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;	
		
	}
	 //下一步
	function nextStep(){
	  if(frm.grpIdNo.value.trim() == "")
	  {
	      rdShowMessageDialog("请输入集团用户编码！");
	      frm.grpIdNo.focus();
	      return false;
	  }
	  	 /*
		frm.action="zg06_1.jsp?action=query";
		frm.method="post";
		frm.submit();
		frm.next.disabled=true; */
		var unit_id = document.all.unit_id.value;
		var id_no = document.all.grpIdNo.value;
		//alert("unit_id is "+unit_id+);
		frm.action="zg06_2.jsp?unit_id="+unit_id+"&id_no="+id_no;
		frm.submit();
		frm.next.disabled=true;
		 
	}
	 
	 
	//取流水
	function getSysAccept()
	{
		var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
		getSysAccept_Packet.data.add("retType","getSysAccept");
		core.ajax.sendPacket(getSysAccept_Packet);
		getSysAccept_Packet=null;
	}
	
	 
	 

	 
	 
	//获得主套餐
	function GetIdcMebNo()
	{
		var pageTitle = "IDC成员编码查询";
	    	var fieldName = "成员用户ID|成员编码|业务类型";
		var sqlStr = "select member_id,member_no,e.sm_name"
	              +"  from dGrpUserMebMsg a,dGrpUserMsg b,dAccountIdInfo c,"
	              +" sBusiTypeSmCode d,sSmCode e"
	              +" where a.id_no=b.id_no"
	              +" and b.user_no=c.msisdn"
	              +" and b.sm_code=c.service_type"
	              +" and c.service_no='"+document.frm.grpOutNo.value+"'"
	              +" and c.service_type=d.sm_code"
	              +" and c.service_type=e.sm_code"
	              +" and e.region_code='"+document.frm.OrgCode.value.substring(0,2)+"'";
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "1|1";
		var retToField = "idcMebNo";
		var returnNum="3";
		PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum);
	}

	//调用公共界面，进行集团客户选择
	function getCptCpmIfo()
	{
		document.all.qryFlag.value="qryCptCpm";
	    var pageTitle = "集团客户选择";
	    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团编号|付费帐户|品牌名称|品牌代码|";
		var sqlStr = "";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
	    var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
	    var cust_id = document.frm.cust_id.value;
	    if(document.frm.iccid.value == "" &&
	       document.frm.cust_id.value == "" &&
	       document.frm.unit_id.value == "" &&
	       document.frm.user_no.value == "")
	    {
	        rdShowMessageDialog("请输入证件号码、客户ID、集团编号或集团号进行查询！",0);
	        document.frm.iccid.focus();
	        return false;
	    }
	
	    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
	    {
	    	frm.cust_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
	    {
	    	frm.unit_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.user_no.value == "0")
	    {
	    	frm.user_no.value = "";
	        rdShowMessageDialog("集团号不能为0！",0);
	    	return false;
	    }
	
	    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
	}

	function getInfo_Cust()
	{
		document.all.qryFlag.value="qryCust";
	    var pageTitle = "集团客户选择";
	    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团编号|付费帐户|品牌名称|品牌代码|";
		var sqlStr = "";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
	    var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
	    var cust_id = document.frm.cust_id.value;
	    if(document.frm.iccid.value == "" &&
	       document.frm.cust_id.value == "" &&
	       document.frm.unit_id.value == "" &&
	       document.frm.user_no.value == "")
	    {
	        rdShowMessageDialog("请输入证件号码、客户ID、集团编号或集团号进行查询！",0);
	        document.frm.iccid.focus();
	        return false;
	    }
	
	    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
	    {
	    	frm.cust_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
	    {
	    	frm.unit_id.value = "";
	        rdShowMessageDialog("必须是数字！",0);
	    	return false;
	    }
	
	    if(document.frm.user_no.value == "0")
	    {
	    	frm.user_no.value = "";
	        rdShowMessageDialog("集团号不能为0！",0);
	    	return false;
	    }
	
	    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
	}

	function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	    var path = "<%=request.getContextPath()%>/npage/s3691/f3691_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
	    path = path + "&cust_id=" + document.all.cust_id.value;
	    path = path + "&unit_id=" + document.all.unit_id.value;
	    path = path + "&user_no=" + document.all.user_no.value;
	    path = path + "&qryFlag=" + document.all.qryFlag.value;
	    
	
	    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	
		return true;
	}
	//liujian 添加obj入参，从f3691_sel.jsp返回
	function getvaluecust(retInfo,object)
	{
	  var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
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
	     
	    //nextStep()
	}
	function call_flags(){
       var h=580;
       var w=1150;
       var t=screen.availHeight/2-h/2;
       var l=screen.availWidth/2-w/2;
       var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    	   
    	var str=window.showModalDialog('group_flags.jsp?flags='+document.frm.F10315.value+'&sm_code=<%=paramsArray[9]%>',"",prop);/*diling add for 增加品牌参数@2012/11/6 */
    	   
    	if( str != undefined ){
    		document.frm.F10315.value = str;
    	}
    	return true;
    }
    
    //设置不允许下发时间段列表
    function setTime()
    {
    	window.open('f2890_setTime.jsp','','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    	
    }
    //设置上行业务指令
    function setMO()
    {
    	window.open('f2890_setMo.jsp','','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }
    
function ctrlF10340(selectId)
{
	var f10340txt = "";
	var f10341txt = "";
	if(selectId.value == "11")
	{
		f10340txt = "<select id='F10340' name='F10340' datatype=66 onchange='ctrlF10341(frm.F10340);'>";
		f10340txt = f10340txt + "<option  value='00'>00--无专用APN</option>";
		f10340txt = f10340txt + "<option  value='01'>01--专用APN</option>";
		f10340txt = f10340txt + "</select>";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	else
	{
		f10340txt = "<input id='F10340' name='F10340'  class='button' type='hidden' datatype=66  value='0'>&nbsp";
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10340.innerHTML=f10340txt;
	divF10341.innerHTML=f10341txt;
}


function ctrlF10341(selectId)
{
	var f10341txt = "";
	if(selectId.value == "01")
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='text' datatype=67  value=''>&nbsp;<font class='orange'>*</font>";
	}
	else
	{
		f10341txt = "<input id='F10341' name='F10341'  class='button' type='hidden' datatype=67  value='0'>&nbsp";
	}
	divF10341.innerHTML=f10341txt;
}

//TD-商务宝："业务类型"域对"2G号码"文本域的联动控制 
//ADD by shengzd @ 20090519
function ctrlF10342(selectId)
{
	var f10342txt = "";
	if(selectId.value == "01")
	{
		f10342txt = "<input id='F10344' name='F10344'  class='button' type='text' datatype=72 maxlength=11 value=''>&nbsp"; //被隐藏的"2G号码"默认值为空 
	}
	else
	{
		f10342txt = "<input id='F10344' name='F10344'  class='button' type='hidden' datatype=72 maxlength=11 value='0'>&nbsp";
	}
	divF10344.innerHTML=f10342txt;
}
function inits()
{
	document.frm.next.disabled = true;
	//document.frm.next.disabled = false;
}
</script>
</HEAD>
<BODY onload="inits()">
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">集团产品余额提醒阀值设置</div>
		</div>	
		<input type="hidden" name="product_code" value="">
		<input type="hidden" name="product_level"  value="1">
		<input type="hidden" name="op_type" value="1">
		<input type="hidden" name="grp_no" value="0">
		<input type="hidden" name="tfFlag" value="n">
		<input type="hidden" name="chgpkg_day"   value="">
		<input type="hidden" name="TCustId"  value="">
		<input type="hidden" name="unit_name"  value="">
		<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
		<input type="hidden" name="op_code"  value="3691">
		<input type="hidden" name="OrgCode"  value="<%=org_code%>">
		<input type="hidden" name="region_code"  value="<%=regionCode%>">
		<input type="hidden" name="district_code"  value="<%=districtCode%>">
		<input type="hidden" name="WorkNo"   value="<%=workno%>">
		<input type="hidden" name="NoPass"   value="<%=nopass%>">
		<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
		<input type="hidden" name="grpOutNo"   value="">
		<input type="hidden" name="custAddr"   value="">
		<input type="hidden" name="idIccid"   value="">
		<input type="hidden" name="unit_idAdd"   value="<%=unit_id%>">
		<input type="hidden" name="qryFlag"   value="<%=qryFlag%>">



        <TABLE  cellSpacing=0>
	    <TR>
	        <TD width="18%" class="blue">
	              证件号码
	        </TD>
            	<TD width="32%">
                <input name=iccid  id="iccid" size="20" maxlength="18" v_type="string" v_must=1  index="1"  value="<%=iccid2%>" 
                <%
                    if (action!=null&&action.equals("query")){
                        out.print(" readOnly class='InputGrey' ");
                    }
                %>
                >
                <input name=custQuery class="b_text" type=button id="custQuery"  
                	onClick="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" 
                	style="cursor：hand" value=查询 
                <%
                    if (action!=null&&action.equals("query")){
                        out.print(" disabled ");
                    }
                %>
                >
                
                <input name=cptCpmQry' class="b_text" type=button id="cptCpmQry"  
                	onClick="getCptCpmIfo();" style="cursor：hand" value=协议合同查询 
                <%
                    if (action!=null&&action.equals("query")){
                        out.print(" disabled ");
                    }
                %>
                >                
                
            </TD>
            <TD width="18%" class="blue">集团客户ID</TD>
            <TD width="32%">
             	<input  type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1  index="2" value="<%=cust_id2%>"
             	<%
                    if (action!=null&&action.equals("query")){
                        out.print(" readOnly class='InputGrey' ");
                    }
                %>
             	>
            </TD>
          </TR><input type="hidden" name="product_name2">
          <TR>
            <TD class="blue">
               集团编号
            </TD>
            <TD>		    
               <input name=unit_id  id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1  index="3" value="<%=unit_id2%>"
               <%
                    if (action!=null&&action.equals("query")){
                        out.print(" readOnly class='InputGrey' ");
                    }
                %>
               >            
            </TD>
            <TD class="blue" width="18%">集团号或智能网编号</TD>
            <TD>
              <input  name="user_no" size="20" v_must=1 v_type=string  index="4" value="<%=user_no2%>"
              <%
                    if (action!=null&&action.equals("query")){
                        out.print(" readOnly class='InputGrey' ");
                    }
                %>
              >
            </TD>
          </TR>
          <TR>
	     <TD width=18% nowrap class="blue"> 集团用户ID</TD>
             <TD width="32%" >
		<input name=grpIdNo  id="grpIdNo" size="24" maxlength="15" v_type="0_9" v_must=1  index="3" value="<%=grpIdNo%>"
		<%
                    if (action!=null&&action.equals("query")){
                        out.print(" readOnly class='InputGrey' ");
                    }
                %>
		>
		<font class="orange">*</font>
		              <input type="hidden" name="cust_name">
		              <input type="hidden" name="grp_name">
		              <input type="hidden" name="product_code2" value="<%=product_code3%>">
		          
		              <input type="hidden" name="account_id">
		              <input type="hidden" name="sm_name">
		              <input type="hidden" name="sm_code" id="sm_code">
	    </TD> 
		<TD class="blue">集团产品密码</TD>
            <TD >
	 
           	<%if(!ProvinceRun.equals("20"))  //不是吉林
			  		{
					%>  
                <jsp:include page="/npage/common/pwd_8.jsp">
                <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
	            <jsp:param name="pname" value="userPassword"  />
	            <jsp:param name="pwd" value="<%=iUserPwd%>"  />
 	            </jsp:include>
          <%}else{%>
 	            <input name=userPassword type="password"  id="custPwd" size="6" maxlength="6" value="<%=iUserPwd%>" v_must=1>
         <%}%>
            <input name=chkPass type=button onClick="check_HidPwd();"  class="b_text" style="cursor：hand" id="chkPass" value=校验>
	    <font class="orange">*</font>
	   </TD>
	</TR>
    </TABLE>
	<!---- 隐藏的列表-->
        <TABLE  cellSpacing=0  style="display:<%=listShow%>">
	   <TR>
            <TD width="18%" class="blue">
              集团用户号码
            </TD>
            <TD width="32%">
                <input name="idcMebNo" class="InputGrey" id="idcMebNo" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="<%=paramsArray[1]%>" readonly>
                <font class="orange">*</font>
            </TD>
	    <TD width=18% class="blue">客户名称</TD>
            <TD width="32%">
              <input name=custName class="InputGrey"  id="custName" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="<%=paramsArray[4]%>" readonly>
            </TD>
          </TR>
          <TR>
            <TD width="18%" class="blue">品牌名称</TD>
            <TD width="32%">
              <input  name="smName" size="24" readonly v_must=1 v_type=string class="InputGrey"  index="4" value="<%=paramsArray[2]%>" readonly>
            </TD>
            <TD class="blue">产品名称</TD>
            <TD>
              <input  name="smName" size="24" readonly v_must=1 v_type=string class="InputGrey"  index="4" value="<%=paramsArray[3]%>" readonly>
            </TD>
          </TR>
          </TABLE>
         
		  
	<%
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$111111");
		//为include文件提供数据
		int fieldCount=paramsOut28.length;
		
		//fieldCount=9;	//add
		boolean isGroup = false;
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];//add
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldGrpName=new String[fieldCount];
		String []fieldGrpNo=new String[fieldCount];
		String []fieldMaxRow=new String[fieldCount];
		String []fieldMinRow=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		String []updateFlag=new String[fieldCount];
		String []openFlag=new String[fieldCount];
		String []manyPropertys=new String[fieldCount];
		String userType=paramsArray[9];
		int iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=paramsOut26[iField][0];
			fieldNames[iField]=paramsOut28[iField][0];
			fieldPurposes[iField]=paramsOut29[iField][0];//add
			fieldValues[iField]=paramsOut27[iField][0];
			System.out.println("diling---fieldValues["+iField+"]="+fieldValues[iField]);
			dataTypes[iField]=paramsOut30[iField][0];
			fieldLengths[iField]=paramsOut31[iField][0];
			fieldGrpNo[iField]=userFieldGrpNo[iField][0];
			fieldMaxRow[iField]=userFieldMaxRows[iField][0];
			fieldMinRow[iField]=userFieldMinRows[iField][0];
			fieldGrpName[iField]=userFieldGrpName[iField][0];
			fieldCtrlInfos[iField]=userFieldCtrlInfos[iField][0];
			updateFlag[iField]=userUpdateFlag[iField][0];
			openFlag[iField]=openParamFlag[iField][0];
			manyPropertys[iField] = manyPropertyStr[iField][0];
			
			iField++;
		}
	%>
	
		<% //------add by hansen-----
		//为include文件提供数据  
		int fieldCount2=resultListLength2;
		String []fieldCodes2=new String[fieldCount2];
		String []fieldNames2=new String[fieldCount2];
		String []fieldPurposes2=new String[fieldCount2];
		String []fieldValues2=new String[fieldCount2];
		String []dataTypes2=new String[fieldCount2];
		String []fieldLengths2=new String[fieldCount2];
		String []fieldCtrlInfos2=new String[fieldCount2];
		String []openFlagNew=new String[fieldCount2];
		int iField2=0;
		while(iField2<fieldCount2)
		{
		
			fieldCodes2[iField2]=resultList2[iField2][0];
			fieldNames2[iField2]=resultList2[iField2][1];
			fieldPurposes2[iField2]=resultList2[iField2][2];
			fieldValues2[iField2]="";
			dataTypes2[iField2]=resultList2[iField2][3];
			fieldLengths2[iField2]=resultList2[iField2][4];
			fieldCtrlInfos2[iField2]=resultList2[iField2][5];
			openFlagNew[iField2]=resultList2[iField2][6];
			
			iField2++;
		}
	%>
	<%
		System.out.println("3691~~~qryFlag~~~~"+qryFlag);//qryCptCpm
		if(qryFlag.equals("qryCust") )
		{
		%>
		<%@ include file="/npage/s3691/fpubDynaFields_modify.jsp"%>			
		<%
		}
		else
		{
		%>		
		
		<wtc:service name="sQryContractNo" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="ccRc" retmsg="ccRm" outnum="54" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="3690"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=grpIdNo%>"/>					
		</wtc:service>
		<wtc:array id="ccrst" scope="end"/>
		<%
		if (!ccRc.equals("000000"))
		{
		%>
		<script>
			rdShowMessageDialog("<%=ccRc%>:<%=ccRm%>");
			removeCurrentTab();
			
		</script>
		<%
		}
		
		
			for ( int i=0;i<ccrst[0].length;i++ )
			{
				System.out.println("3691~~~~ccrst[0]["+i+"]=="+ccrst[0][i]);
			}
		%>
		<div class="title"   style="display:<%=ccDisp%>" >
			<div id="title_zi">项目合同产品协议信息</div>
		</div>	
		<TABLE  cellSpacing=0 id= 'tabCnttCpt' name= 'tabCnttCpt' style="display:<%=ccDisp%>" >
			<td class='blue'>项目合同编号</td>
			<td>
				<input type='text' name='cntNo' value='<%=ccrst[0][1]%>' maxlength='10'>
				<font class='orange'>*</font>
			</td>
			<td class='blue'>产品协议编号</td>
			<td>
				<input type='text' name='cptNo' value='<%=ccrst[0][0]%>'maxlength='10'>
				<input type="hidden" name="prodOpenTime" value='<%=ccrst[0][6]%>' >
				<!--权限标识-->
				<input type="hidden" name="prodRight" value='<%=ccrst[0][2]%>' >
				<!--## 5	oCnttCode		合同父编号-->
				<input type="hidden" name="oCnttCode" value='<%=ccrst[0][3]%>' >
				<!--## 6	oCptCode		协议父编号-->
				<input type="hidden" name="oCptCode" value='<%=ccrst[0][4]%>' >
				<!--## 7	oUnitId			集团编号-->
				<input type="hidden" name="oUnitId" value='<%=ccrst[0][5]%>' >
			</td>	
		</table>
		<%
		}
		%>

	
        
        <TABLE cellSpacing="0">        
            <TR>
              <TD id="footer">
			 <%
			 if (nextFlag==1){
			 %>
			 &nbsp;
			  <input name="next" id="next"  type=button class="b_foot" value="查询" onclick="nextStep()" >
			 <%
			 } 
			 %>
              		&nbsp; 
              		<input  name=back  class="b_foot" type=button value="清除" onclick="window.location='zg06_1.jsp'">
			&nbsp;
              		<input  name="kkkk"  class="b_foot" onClick="removeCurrentTab()" type=button value="关闭">
              	     </TD>
            </TR>	
        </TABLE>
      			<!-------------隐藏域--------------->
			<input type="hidden" name="modeCode" value="">
			<input type="hidden" name="oldPwd" value="<%=(paramsArray[4])%>">
			<input type="hidden" name="modeType" value="<%=paramsArray%>">
			<input type="hidden" name="typeName">
			<input type="hidden" name="addMode">
			<input type="hidden" name="modeName">
			<input type="hidden" name="openFlagList">
			<input type="hidden" name="openFlagListNew">
			<input type="hidden" name="nameList"  value="<%=nameList%>">
			<input type="hidden" name="nameValueList"  value="<%=nameValueList%>">
			<input type="hidden" name="nameGroupList"  value="<%=nameGroupList%>">
			<input type="hidden" name="nameListNew"  value="<%=nameListNew%>">
			<input type="hidden" name="nameGroupListNew"  value="<%=nameGroupListNew%>">
			<input type="hidden" name="fieldNamesList">
			<input type="hidden" name="choiceFlag">
			<input type="hidden" name="tonote" size="60" value="集团产品资料变更">
			<input type="hidden" name="StartTime" value="">
            <input type="hidden" name="EndTime" value="">
            <input type="hidden" name="MOCode" value="">
            <input type="hidden" name="CodeMathMode" value="">
            <input type="hidden" name="MOType" value="">
            <input type="hidden" name="DestServCode" value="">
            <input type="hidden" name="ServCodeMathMode" value="">
            <input type="hidden" name="in_ChanceId2" value="">
            <input type="hidden" name="fee_rate"  value="">
            <input type="hidden" name="busi_type"  value="">
            <input type="hidden" name="cover_region"  value="">
            <input type="hidden" name="chg_flag"  value="">
            <input type="hidden" name="max_outnumcl"  value="">
            <input type="hidden" name="opCodeFlag" value="">
            <input type="hidden" name="waNo" value="<%=wa_no%>">
			<!-------------隐藏域--------------->
			<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>  
</FORM>
	 <script language="JavaScript">
	 	 <%if (nextFlag==1){%>
	 		document.frm.grpIdNo.focus();
	  	<%}%>
		<%
		if (nextFlag==2 && qryFlag.equals("qryCust") ){
			out.println("calcAllFieldValues();");
		}
		%>
	 </script>
</BODY>
</HTML>
<script>
    /*liujian 2012-12-24 14:55:47 二维码业务
    * 1. 设置二维码使用费(元)(10641)表单为不可编辑
    * 2. 设置二维码条数(10639) 和 单条费率（元/条）(10640)的key事件，使 二维码使用费(元) = 二维码条数 × 单条费率（元/条）
    * 3. 二维码条数、单条费率、二维码使用费都必须输入整数
    */
    $(function() {
    	var smCode = '<%=paramsArray[9]%>';
    	if($.trim(smCode) == 'EW') {
    		//初始化二维码条数、单条费率、二维码使用费
    		$('#F10641').attr('readOnly',true);
    		$('#F10641').addClass("InputGrey");
	    	setSignalValue($('#F10639'));
	    	setSignalValue($('#F10640'));
	    	setSignalValue($('#F10642'));
	    	setSignalValue($('#F10643'));
	    	setSumValue();
	    	//注册二维码条数键盘事件
	        $('#F10639').keyup(function() {
	            setSignalValue($(this));
	            setSumValue();
	        });
	        //注册单条费率键盘事件
	        $('#F10640').keyup(function() {
	            setSignalValue($(this));
	            setSumValue();
	        });
	        //注册验码设备费事件，只能是整数
	        $('#F10642').keyup(function() {
	            setSignalValue($(this));
	        });
	        //注册一次性开发费用事件，只能是整数
	        $('#F10643').keyup(function() {
	            setSignalValue($(this));
	        });
    	}
    	var cityCode = '';
    	if($.trim(smCode).toLowerCase() == 'hj' && '<%=paramsArray[10]%>'=='214') {
    		if($('#F10652').val()) {
    			$('#F10652').parent().append("<br><span>填写本产品已有接入号，当接入号数大于1个时可变更</span>");	
    		}
    		$('#F10654').css('display','none');
    		cityCode = $('#F10654').val();
    		
    		//获取省份名称
    		var packet = new AJAXPacket("../s3690/f3690_ajax_rent.jsp","正在获得数据，请稍候......");
	        packet.data.add("method","getProv");
	        core.ajax.sendPacket(packet,doGetProv);
	        packet = null;	
	        $('#provSelect').change(function() {
	    		var pv = $('#provSelect').val();
	    		var stm = new Array();
	    		if(pv == '') {
	    			if($('#citySelect').val()) {
						$('#citySelect').empty();
						stm.push('<option value="">请选择</option>');	
						$('#citySelect').append(stm.join(''));
					}else {
						stm.push('<select id="citySelect">');
						stm.push('	<option value="">请选择</option>');	
						stm.push('</select>');
						$('#provSelect').after(stm.join(''));	
					}
	    		}else {
		    		//获取区号名称
		    		var packet = new AJAXPacket("../s3690/f3690_ajax_rent.jsp","正在获得数据，请稍候......");
			        packet.data.add("method","getCity");
			        packet.data.add("prov_code",pv);
			        core.ajax.sendPacket(packet,doGetCity);
			   		packet = null;	
		    	}
	    	});
	    	$('#provSelect').change();
	    	$('#citySelect').change(function() {
	    		$('#F10654').val($('#citySelect').val());
	    	});
	    	$('#citySelect').change();
	    	//通过城市code获取省份code
    		//获取省份名称
    		var codepacket = new AJAXPacket("../s3690/f3690_ajax_rent.jsp","正在获得数据，请稍候......");
	        codepacket.data.add("method","getProvCode");
	        codepacket.data.add("cityCode",cityCode);
	        core.ajax.sendPacket(codepacket,doGetProvCode);
	        codepacket = null;	
    	}
    	
    });
    //获取所有的省份，设置省份下拉框
    function doGetProv(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var provArray = packet.data.findValueByName("provArray");
		if(retCode == '000000') {
			var stm = new Array();
			if(provArray && provArray.length > 0) {
				stm.push('<select id="provSelect">');
				stm.push('	<option value="">请选择</option>');
				for(var i = 0,len = provArray.length; i < len; i++) {
					var prov = provArray[i];
					stm.push('<option value="' + prov.code + '">' + prov.name + '</option>');	
				}	
				stm.push('</select>');
			}
			$('#F10654').after(stm.join(''));
		}else {
			rdShowMessageDialog("错误代码:" + retCode + ",错误信息:" + retMsg,0);	
		}
		
    }
    //获取某个省份下所有的城市，设置城市下拉框
    function doGetCity(packet) {
    	var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var cityArray = packet.data.findValueByName("cityArray");
		var stm = new Array();
		if($('#citySelect').val()=='' || $('#citySelect').val()) {
			$('#citySelect').empty();	
		}else {
			stm.push('<select id="citySelect">');
			stm.push('</select>');
			$('#provSelect').after(stm.join(''));	
		}
		if(retCode == '000000') {
			stm = [];
			if(cityArray && cityArray.length > 0) {	
				for(var i = 0,len = cityArray.length; i < len; i++) {
					var city = cityArray[i];
					stm.push('<option value="' + city.code + '">' + city.name + '</option>');	
				}	
			}
			$('#citySelect').append(stm.join(''));
			
		}else {
			rdShowMessageDialog("错误代码:" + retCode + ",错误信息:" + retMsg,0);	
		}	
    }
    //获取对应的省份，设置省份下拉框
    function doGetProvCode(packet) {
    	var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var provCode = packet.data.findValueByName("provCode");
		var cityCode = packet.data.findValueByName("cityCode");
		if(retCode == '000000') {
			$('#provSelect').val(provCode);
			$('#provSelect').change();
			$('#citySelect').val(cityCode);
			$('#citySelect').change();
		}else {
			rdShowMessageDialog("错误代码:" + retCode + ",错误信息:" + retMsg,0);	
		}	
    }
    
    //设置二维码条数、单条费率的值
    function setSignalValue($this) {
        var _this = $this.val()?$this.val():'';
        $this.val(_this.replace(/[^\.\d]/g,''));
        _this = $this.val();
        if(!_this || isNaN(_this)) {
            $this.val(0);
        }else {
	        $this.val(parseInt($this.val(),10));
	    }
    }
    //计算二维码使用费
    function setSumValue() {
        var first = parseInt($('#F10639').val(),10);
        var second = parseInt($('#F10640').val(),10);
        $('#F10641').val(first * second );
    }
    /* liujian 2012-12-24 15:34:48 二维码业务 结束*/
        
</script>