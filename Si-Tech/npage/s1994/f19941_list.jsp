<%
   /*
   * 功能: 集团客户基本资料
　 * 版本: v1.0
　 * 日期: 2007/08/20
　 * 作者: baixf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-1-19      qidp       修改样式
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%	
    String opCode = "1994";
    String opName = "集团客户销户";
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                   //工号
	String workName = (String)session.getAttribute("workName");               	//工号姓名
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");                  //登陆密码
	String regionCode=org_code.substring(0,2);

	Logger logger = Logger.getLogger("f19941_list.jsp");

	String unit_id = request.getParameter("cust_id");   //获得关系编号	
	String cust_id =""; 


    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	//ArrayList acceptList = new ArrayList();


	//获取客户关系类型列表

 	
//法人类型
 	//ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
 	sqlStr1 ="select * from sGrpLeaderType";
 	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 	//String[][] retListString1 = (String[][])retList1.get(0);
 	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="2">
    	<wtc:sql><%=sqlStr1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr1" scope="end" />
	<%
    String[][] retListString1 = retArr1;
//企业类型
 	//ArrayList retList2 = new ArrayList();  
	String sqlStr2="";
 	sqlStr2 ="select * from sGrpEntCode";
 	//retList2 = impl.sPubSelect("2",sqlStr2,"region",regionCode);
 	//String[][] retListString2 = (String[][])retList2.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="2">
    	<wtc:sql><%=sqlStr2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end" />
	<%
    String[][] retListString2 = retArr2;

//集团类型
 	//ArrayList retList3 = new ArrayList();  
	String sqlStr3="";
 	sqlStr3 ="select * from sGrpTypeCode";
 	//retList3 = impl.sPubSelect("2",sqlStr3,"region",regionCode);
 	//String[][] retListString3 = (String[][])retList3.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3"  outnum="2">
    	<wtc:sql><%=sqlStr3%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr3" scope="end" />
	<%
    String[][] retListString3 = retArr3;
//集团状态
 	//ArrayList retList4 = new ArrayList();  
	String sqlStr4="";
 	sqlStr4 ="select * from sGrpStatusCode";
 	//retList4 = impl.sPubSelect("2",sqlStr4,"region",regionCode);
 	//String[][] retListString4 = (String[][])retList4.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4"  outnum="2">
    	<wtc:sql><%=sqlStr4%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr4" scope="end" />
	<%
    String[][] retListString4 = retArr4;
//区域类型
 	//ArrayList retList5 = new ArrayList();  
	String sqlStr5="";
 	sqlStr5 ="select * from sGrpAreaCode";
 	//retList5 = impl.sPubSelect("2",sqlStr5,"region",regionCode);
 	//String[][] retListString5 = (String[][])retList5.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5"  outnum="2">
    	<wtc:sql><%=sqlStr5%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr5" scope="end" />
	<%
    String[][] retListString5 = retArr5;
	//规模等级
	//ArrayList retList6 = new ArrayList();  
	String sqlStr6="";
 	sqlStr6 ="select * from sGrpOwnerCode";
 	//retList6 = impl.sPubSelect("2",sqlStr6,"region",regionCode);
 	//String[][] retListString6 = (String[][])retList6.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6"  outnum="2">
    	<wtc:sql><%=sqlStr6%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr6" scope="end" />
	<%
    String[][] retListString6 = retArr6;
	//有效标识
 	//ArrayList retList7 = new ArrayList();  
	String sqlStr7="";
 	sqlStr7 ="select * from sGrpValidFlag";
 	//retList7 = impl.sPubSelect("2",sqlStr7,"region",regionCode);
 	//String[][] retListString7 = (String[][])retList7.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode7" retmsg="retMsg7"  outnum="2">
    	<wtc:sql><%=sqlStr7%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr7" scope="end" />
	<%
    String[][] retListString7 = retArr7;

 	//付款方式
 	//ArrayList retList8 = new ArrayList();  
	String sqlStr8="";
 	sqlStr8 ="select * from sGrpPayType";
 	//retList8 = impl.sPubSelect("2",sqlStr8,"region",regionCode);
 	//String[][] retListString8 = (String[][])retList8.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode8" retmsg="retMsg8"  outnum="2">
    	<wtc:sql><%=sqlStr8%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr8" scope="end" />
	<%
    String[][] retListString8 = retArr8;



 	//区域代码
 	//ArrayList retList10 = new ArrayList();  
	String sqlStr10="";
 	sqlStr10 ="select * from dgrpgroups";
 	//retList10 = impl.sPubSelect("2",sqlStr10,"region",regionCode);
 	//String[][] retListString10 = (String[][])retList10.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode10" retmsg="retMsg10"  outnum="2">
    	<wtc:sql><%=sqlStr10%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr10" scope="end" />
	<%
    String[][] retListString10 = retArr10;
 	//行业代码
 	//ArrayList retList11 = new ArrayList();  
	String sqlStr11="";
 	sqlStr11 ="select * from sGrpBigTradeCode";
 	//retList11 = impl.sPubSelect("2",sqlStr11,"region",regionCode);
 	//String[][] retListString11 = (String[][])retList11.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11"  outnum="2">
    	<wtc:sql><%=sqlStr11%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr11" scope="end" />
	<%
    String[][] retListString11 = retArr11;
 	//省内代码
 	//ArrayList retList12 = new ArrayList();  
	String sqlStr12="";
 	sqlStr12 ="select * from sGrpProTradeCode";
 	//retList12 = impl.sPubSelect("2",sqlStr12,"region",regionCode);
 	//String[][] retListString12 = (String[][])retList12.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12"  outnum="2">
    	<wtc:sql><%=sqlStr12%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr12" scope="end" />
	<%
    String[][] retListString12 = retArr12;
 	//照片代码
 	//ArrayList retList13 = new ArrayList();  
	String sqlStr13="";
 	sqlStr13 ="select * from sgrpbigphotocode";
 	//retList13 = impl.sPubSelect("2",sqlStr13,"region",regionCode);
 	//String[][] retListString13 = (String[][])retList13.get(0);
    %>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode13" retmsg="retMsg13"  outnum="2">
    	<wtc:sql><%=sqlStr13%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr13" scope="end" />
	<%
    String[][] retListString13 = retArr13;
	
	
	//获取现有客户关系信息
  String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1994";
	paraArr[3] = "";
	paraArr[4] = unit_id;
						
	//acceptList = impl.callFXService("s1994CustQry",paraArr,"50");
	%>
    <wtc:service name="s1994CustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="s1994CustQryCode" retmsg="s1994CustQryMsg" outnum="53" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
    </wtc:service>
    <wtc:array id="s1994CustQryArr" scope="end"/>
    <%
	String errCode=s1994CustQryCode;
	String errMsg=s1994CustQryMsg;
	
	 unit_id="";
	String unit_name="";
	String unit_code="";
	String trade_code="";
	String ent_type="";
	String trade_big_code="";
	String province_trade_code="";
	String area_type="";
String area_code="";
//	String org_code="";
    String owner_code="";
	String contact_person="";
	String contact_phone="";
	String contact_mobile_phone="";
    String unit_addr="";
	String unit_zip="";
	String fax="";
	String web="";
	String unit_leader="";
	String run_area="";
	String jion_date="";
	String enrol_fee="";
	String year_turnover="";
	String year_gain="";
	String top_repre_name="";
	String top_repre_phone="";
	String unit_create_date="";
	String business_licenceno="";
	String licence_validdate="";
	String it_equip="";
	String network_info="";
	String computer_num="";
	String tel_branch="";
	String tel_budget="";
	String person_num="";
	String sum_num="";
	String mobile_num="";
	String union_num="";
	String spirit_num="";
	String telcom_num="";
	String other_num="";
	String love_service_mode="";
    String love_redound_mode="";
	String photo_code="";
	String grp_type="";
	String grp_status="";
//	String unit_addr="";
	String op_note="";
    String create_date="";
	String boss_vpmn_code="";
	String instigate_flag="";
	String getcontract_flag="";
	String v_isDirectManageCust = "0";//是否直管客户
	String v_directManageCustNo = "";//直管客户编码
	String v_groupNo = "";//组织结构编码

%>
<%
	if(errCode.equals("000000")){
	
		//String[][] tmpresult0=(String[][])acceptList.get(0);
		//String[][] tmpresult1=(String[][])acceptList.get(1);
		//String[][] tmpresult2=(String[][])acceptList.get(2);
		//String[][] tmpresult3=(String[][])acceptList.get(3);
		//String[][] tmpresult4=(String[][])acceptList.get(4);
		//String[][] tmpresult5=(String[][])acceptList.get(5);
		//String[][] tmpresult6=(String[][])acceptList.get(6);
		//String[][] tmpresult7=(String[][])acceptList.get(7);	
		//String[][] tmpresult8=(String[][])acceptList.get(8);	
		//String[][] tmpresult9=(String[][])acceptList.get(9);
        //
        //
		//String[][] tmpresult10=(String[][])acceptList.get(10);
		//String[][] tmpresult11=(String[][])acceptList.get(11);
		//String[][] tmpresult12=(String[][])acceptList.get(12);
		//String[][] tmpresult13=(String[][])acceptList.get(13);
		//String[][] tmpresult14=(String[][])acceptList.get(14);
		//String[][] tmpresult15=(String[][])acceptList.get(15);
		//String[][] tmpresult16=(String[][])acceptList.get(16);
		//String[][] tmpresult17=(String[][])acceptList.get(17);	
		//String[][] tmpresult18=(String[][])acceptList.get(18);	
		//String[][] tmpresult19=(String[][])acceptList.get(19);
		//		String[][] tmpresult20=(String[][])acceptList.get(20);
		//String[][] tmpresult21=(String[][])acceptList.get(21);
		//String[][] tmpresult22=(String[][])acceptList.get(22);
		//String[][] tmpresult23=(String[][])acceptList.get(23);
		//String[][] tmpresult24=(String[][])acceptList.get(24);
		//String[][] tmpresult25=(String[][])acceptList.get(25);
		//String[][] tmpresult26=(String[][])acceptList.get(26);
		//String[][] tmpresult27=(String[][])acceptList.get(27);	
		//String[][] tmpresult28=(String[][])acceptList.get(28);	
		//String[][] tmpresult29=(String[][])acceptList.get(29);
		//		String[][] tmpresult30=(String[][])acceptList.get(30);
		//String[][] tmpresult31=(String[][])acceptList.get(31);
		//String[][] tmpresult32=(String[][])acceptList.get(32);
		//String[][] tmpresult33=(String[][])acceptList.get(33);
		//String[][] tmpresult34=(String[][])acceptList.get(34);
		//String[][] tmpresult35=(String[][])acceptList.get(35);
		//String[][] tmpresult36=(String[][])acceptList.get(36);
		//String[][] tmpresult37=(String[][])acceptList.get(37);	
		//String[][] tmpresult38=(String[][])acceptList.get(38);	
		//String[][] tmpresult39=(String[][])acceptList.get(39);
		//		String[][] tmpresult40=(String[][])acceptList.get(40);
		//String[][] tmpresult41=(String[][])acceptList.get(41);
		//String[][] tmpresult42=(String[][])acceptList.get(42);
		//String[][] tmpresult43=(String[][])acceptList.get(43);
		//String[][] tmpresult44=(String[][])acceptList.get(44);
		//String[][] tmpresult45=(String[][])acceptList.get(45);
		//String[][] tmpresult46=(String[][])acceptList.get(46);
		//String[][] tmpresult47=(String[][])acceptList.get(47);	
		//String[][] tmpresult48=(String[][])acceptList.get(48);
		//String[][] tmpresult49=(String[][])acceptList.get(49);

     
	 cust_id=s1994CustQryArr[0][0].trim();                                             
	 unit_id=s1994CustQryArr[0][1].trim();
	 unit_code=s1994CustQryArr[0][2].trim(); 
     System.out.println("QQQQQQQQQQQQQ"+unit_code);                                          
	 unit_name=s1994CustQryArr[0][3].trim();                                           
	 trade_code=s1994CustQryArr[0][4].trim();                                          
	 province_trade_code=s1994CustQryArr[0][5].trim();                                 
	 unit_addr=s1994CustQryArr[0][6].trim();                                           
	 unit_zip=s1994CustQryArr[0][7].trim();	                                          
	 contact_person=s1994CustQryArr[0][8].trim();                                      
	 contact_phone=s1994CustQryArr[0][9].trim();                                       
                                                                                  
	 contact_mobile_phone=s1994CustQryArr[0][10].trim();                                             
	 fax=s1994CustQryArr[0][11].trim();                                                
	 web=s1994CustQryArr[0][12].trim();                                                
	 unit_leader=s1994CustQryArr[0][13].trim();                                        
	 run_area=s1994CustQryArr[0][14].trim();                                           
	 enrol_fee=s1994CustQryArr[0][15].trim();                                          
	 year_turnover=s1994CustQryArr[0][16].trim();                                      
	 year_gain=s1994CustQryArr[0][17].trim();                                          
	 top_repre_name=s1994CustQryArr[0][18].trim();                                     
	 top_repre_phone=s1994CustQryArr[0][19].trim();                                    
                                                                                  
	 unit_create_date=s1994CustQryArr[0][20];                                  
	 business_licenceno=s1994CustQryArr[0][21].trim();                                 
	 licence_validdate=s1994CustQryArr[0][22];                       
	 it_equip=s1994CustQryArr[0][23].trim();                                        
	 network_info=s1994CustQryArr[0][24].trim();                                    
	 computer_num=s1994CustQryArr[0][25].trim();                                    
	 tel_branch=s1994CustQryArr[0][26].trim();                                      
	 tel_budget=s1994CustQryArr[0][27].trim();                                      
	 person_num=s1994CustQryArr[0][28].trim();                                      
	 sum_num=s1994CustQryArr[0][29].trim();                                         
                                                                               
	 mobile_num=s1994CustQryArr[0][30].trim();                                             
	 union_num=s1994CustQryArr[0][31].trim();                                              
	 spirit_num=s1994CustQryArr[0][32].trim();                                             
	 telcom_num=s1994CustQryArr[0][33].trim();                                             
	 other_num=s1994CustQryArr[0][34].trim();                                              
     love_service_mode=s1994CustQryArr[0][35].trim();                                      
	 love_redound_mode=s1994CustQryArr[0][36].trim();                                      
	 ent_type=s1994CustQryArr[0][37].trim();                                               
	 grp_type=s1994CustQryArr[0][38].trim();                                               
	 grp_status=s1994CustQryArr[0][39].trim();                                             
	                                                                                  
	 area_type=s1994CustQryArr[0][40].trim();                                              
     area_code=s1994CustQryArr[0][41].trim();                                              
     owner_code=s1994CustQryArr[0][42].trim();                                             
     create_date=s1994CustQryArr[0][43].trim();                                            
	 org_code=s1994CustQryArr[0][44].trim();
	 op_note=s1994CustQryArr[0][45].trim();                                                
	 photo_code=s1994CustQryArr[0][46].trim();                                             
   	 boss_vpmn_code=s1994CustQryArr[0][47].trim();                                         
	instigate_flag=s1994CustQryArr[0][48].trim();        
	getcontract_flag=s1994CustQryArr[0][49].trim(); 
		v_isDirectManageCust = s1994CustQryArr[0][50].trim();    
		v_directManageCustNo = s1994CustQryArr[0][51].trim();   
		v_groupNo = s1994CustQryArr[0][52].trim();    
		}                                                                             
	else{                                                                             
%>                                                                                    
		<script language="javascript" >                                               
			rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>",0);      
		</script>                                                                     
<%
}
%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title>基本资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 

/*--------- 提交修改页面 -------------*/
	$(function(){
		$("#isDirectManageCust").val("<%=v_isDirectManageCust%>");
		$("#directManageCustNo").val("<%=v_directManageCustNo%>");	
		$("#groupNo").val("<%=v_groupNo%>");		
	});
</script>
</head>

<body>


	<form name="form1"  method="post">
<div id="Main">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">集团基本资料</div>
</div>
			  <TABLE cellspacing="0">
	          <TBODY>
			  <input type='hidden' name="unit_id" value="<%=unit_id%>">
	            <TR> 			
				<TD class=blue>集团编号</TD>		
		            <TD colspan="3">
		              	<input type="text" class="InputGrey" name="unit_code" value="<%=unit_code%>" readOnly>
		            </TD> 	              
	            </TR>
	            <TR> 			
					<TD class=blue>集团名称</TD>
	            	<TD >
		              	<input type="text" class="InputGrey" readOnly name="unit_name" v_must="1" v_type="string" maxlength="100" value="<%=unit_name%>" >		            	
	            	</TD> 
					<TD class=blue>客户ID</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="cust_id" value="<%=cust_id%>" readOnly >
		            </TD> 
	            </TR>
	            <TR> 			
				   	<TD class=blue>行业代码</TD>
		            <TD>
		              	<select name="trade_code" v_must="1" v_type="string" readOnly >
		              		<option value=""></option>
		              	<%
											for(int i=0;i < retListString11.length;i ++){
											if(trade_code.equals(retListString11[i][0]))
								{
						%>
									<option value='<%=retListString11[i][0]%>' selected><%=retListString11[i][1]%></option>
						<%
								}
								else
								{
										%>
              				<option value='<%=retListString11[i][0]%>'><%=retListString11[i][1]%></option>
										<%
											}
										}
						%>
		              	</select>
		              	
		            </TD> 	              
								<TD class=blue>省内行业</TD>
	            	<TD>
		              	<select name="province_trade_code" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>	
		              	<%
											for(int i=0;i < retListString12.length;i ++){
											if(province_trade_code.equals(retListString12[i][0]))
								{
						%>
									<option value='<%=retListString12[i][0]%>' selected><%=retListString12[i][1]%></option>
						<%
								}
								else
								{
										%>
              				<option value='<%=retListString12[i][0]%>'><%=retListString12[i][1]%></option>
										<%
											}
											}
						%>
		              	</select>	
		              		
	            	</TD> 
	            </TR>
	            <TR> 			
			  
			   		<TD class=blue>法人</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="unit_leader" v_must="0" v_type="string" maxlength="20" value="<%=unit_leader%>" readOnly >
		            </TD> 	

								<TD class=blue>地址</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="unit_addr" v_must="0" v_type="string" maxlength="100" value="<%=unit_addr%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>邮编</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="unit_zip" v_must="0" v_type="zip" maxlength="6" value="<%=unit_zip%>" readOnly >
		            </TD> 	              
								<TD class=blue>联系人</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="contact_person" v_must="0" v_type="string" maxlength="20" value="<%=contact_person%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>联系电话</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="contact_phone" v_must="0" v_type="phone" maxlength="15" value="<%=contact_phone%>" readOnly >
		            </TD> 	              
								<TD class=blue>联系手机</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="contact_mobile_phone" v_must="0" v_type="mobphone" maxlength="11" value="<%=contact_mobile_phone%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>传真</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="fax" v_type="string" maxlength="15" value="<%=fax%>" readOnly >
		            </TD> 	              
								<TD class=blue>网址</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="web" v_type="string" maxlength="50" value="<%=web%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>经营范围</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="run_area" v_type="string" maxlength="40" value="<%=run_area%>" readOnly >
		            </TD> 	              
								<TD class=blue>注册资金</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="enrol_fee" v_must="0" v_type="money" maxlength="11" value="<%=enrol_fee%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>年营业额</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="year_turnover" v_must="0" v_type="money" maxlength="41" value="<%=year_turnover%>" readOnly >
		            </TD> 	              
								<TD class=blue>年利润</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="year_gain" v_must="0" v_type="money" maxlength="41" value="<%=year_gain%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>首席代表</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="top_repre_name" v_type="string" maxlength="20" value="<%=top_repre_name%>" readOnly >
		            </TD> 	              
								<TD class=blue>首席代表电话</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="top_repre_phone" v_type="string" maxlength="20" value="<%=top_repre_phone%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   	<TD class=blue>集团成立纪念日</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="unit_create_date" v_type="date" maxlength="10" value="<%=unit_create_date%>" readOnly >
		            </TD> 	  
					<TD class=blue>拍照标识</TD>
	            	<TD>
		              	<select name="photo_code" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>
		              	<%
							for(int i=0;i < retListString13.length;i ++)
							{
							
								if(photo_code.equals(retListString13[i][0]))
								{
						%>
									<option value='<%=retListString13[i][0]%>' selected><%=retListString13[i][1]%></option>
						<%
								}
								else
								{
						%>
            	 					<option value='<%=retListString13[i][0]%>'><%=retListString13[i][1]%></option>
						<%
							}
							}
						%>
		              	</select>
		              	           	
	            	</TD>

	            </TR>
	            <TR> 			
				   		 	<TD class=blue>营业执照号码</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="business_licenceno" v_must="0" v_type="0_9" maxlength="30" value="<%=business_licenceno%>" readOnly >
		            </TD> 	              
								<TD class=blue>营业执照有效期</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="licence_validdate" v_must="0" v_type="date" maxlength="11" value="<%=licence_validdate%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>信息化设施</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="it_equip" v_type="string" maxlength="20" value="<%=it_equip%>" readOnly >
		            </TD> 	              
								<TD class=blue>计算机局域网</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="network_info" v_type="string" maxlength="20" value="<%=network_info%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>电脑数</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="computer_num" v_must="0" v_type="0_9" maxlength="21" value="<%=computer_num%>" readOnly >
		            </TD> 	              
								<TD class=blue>通信部门</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="tel_branch" v_must="0" v_type="string" maxlength="20" value="<%=tel_branch%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>通信预算</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="tel_budget" v_must="0" v_type="0_9" maxlength="38" value="<%=tel_budget%>" readOnly >
		            </TD> 	              
								<TD class=blue>员工数</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="person_num" v_must="0" v_type="0_9" maxlength="38" value="<%=person_num%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>手机部数</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="sum_num" v_must="0" v_type="0_9" maxlength="38" value="<%=sum_num%>" readOnly >
		            </TD> 	              
								<TD class=blue>移动手机部数</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="mobile_num" v_must="0" v_type="0_9" maxlength="38" value="<%=mobile_num%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>联通手机部数：</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="union_num" v_must="0" v_type="0_9" maxlength="38" value="<%=union_num%>" readOnly >
		            </TD> 	              
								<TD class=blue>小灵通部数：</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="spirit_num" v_must="0" v_type="0_9" maxlength="38" value="<%=spirit_num%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>固定电话部数</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="telcom_num" v_must="0" v_type="0_9" maxlength="38" value="<%=telcom_num%>" readOnly >
		            </TD> 	              
								<TD class=blue>其他数量</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="other_num" v_must="0" v_type="0_9" maxlength="38" value="<%=other_num%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>最感兴趣移动业务</TD>
		            <TD>
		              	<input type="text" class="InputGrey" name="love_service_mode" v_type="string" maxlength="20" value="<%=love_service_mode%>" readOnly >
		            </TD> 	              
								<TD class=blue>最希望优惠方式</TD>
	            	<TD>
		              	<input type="text" class="InputGrey" name="love_redound_mode" v_type="string" maxlength="20" value="<%=love_redound_mode%>" readOnly >		            	
	            	</TD> 
	            </TR>
	            <TR> 			
				   		 	<TD class=blue>企业类型</TD>
		            <TD>
		              	<select name="ent_type" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>
		              	<%
											for(int i=0;i < retListString2.length;i ++){
											if(ent_type.equals(retListString2[i][0]))
								{
						%>
									<option value='<%=retListString2[i][0]%>' selected><%=retListString2[i][1]%></option>
						<%
								}
								else
								{
											
										%>
              				<option value='<%=retListString2[i][0]%>'><%=retListString2[i][1]%></option>
										<%
											}
											}
						%>
		              	</select>
		              	
		            </TD> 	              
								<TD class=blue>集团类型</TD>
	            	<TD>
		              	<select name="grp_type" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>
		              	<%
											for(int i=0;i < retListString3.length;i ++){
											if(grp_type.equals(retListString3[i][0]))
								{
						%>
									<option value='<%=retListString3[i][0]%>' selected><%=retListString3[i][1]%></option>
						<%
								}
								else
								{
										%>
              				<option value='<%=retListString3[i][0]%>'><%=retListString3[i][1]%></option>
										<%
											}
										}
						%>
		              	</select>
		              	            	
	            	</TD> 
	            </TR>
	            <TR > 			
				   	<TD class=blue>集团状态</TD>
		            <TD>
		              	<select name="grp_status" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>
		              	<%
							for(int i=0;i < retListString4.length;i ++){
								if(grp_status.equals(retListString4[i][0]))
								{
						%>
									<option value='<%=retListString4[i][0]%>' selected><%=retListString4[i][1]%></option>
						<%
								}
								else
								{
										%>
              				<option value='<%=retListString4[i][0]%>'><%=retListString4[i][1]%></option>
										<%
											}
							}
						%>
		              	</select>
		              	
					<TD class=blue>区域类型</TD>
	            	<TD>
		              	<select name="area_type" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>   
		              	<%
							for(int i=0;i < retListString5.length;i ++)
							{
								if(area_type.equals(retListString5[i][0]))
								{
						%>
									<option value='<%=retListString5[i][0]%>' selected><%=retListString5[i][1]%></option>
						<%
								}
								else
								{
						%>
              						<option value='<%=retListString5[i][0]%>'><%=retListString5[i][1]%></option>
						<%
								}
							}
						%>
		              	</select>
		              	      	
	            	</TD> 
	            </TR>
	            <TR> 			
				   	<!--TD>区域代码：</TD>
		            <TD>
		              	<select name="area_code">
		              	<%
											for(int i=0;i < retListString10.length;i ++){
										%>
              				<option value='<%=retListString10[i][0]%>'><%=retListString10[i][1]%></option>
										<%
											}
						%>
		              	</select>
		            </TD--> 	              
					<TD class=blue>规模等级</TD>
	            	<TD colspan="3">
		              	<select name="owner_code" v_must="1" v_type="string" readOnly >
		              		<option value=''></option>
		              	<%
							for(int i=0;i < retListString6.length;i ++)
							{
								if(owner_code.equals(retListString6[i][0]))
								{
						%>
									<option value='<%=retListString6[i][0]%>' selected><%=retListString6[i][1]%></option>
						<%
								}
								else
								{
						%>
              						<option value='<%=retListString6[i][0]%>'><%=retListString6[i][1]%></option>
						<%
								}
							}	
						%>
		              	</select>
		              	        	
	            	</TD> 
	            </TR>
	            <!--TR bgcolor="#F5F5F5"> 			
              
								<TD>boss_vpmn_code：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" name="boss_vpmn_code" v_name="boss_vpmn_code" v_must="0" v_type="string" maxlength="40" value="<%=boss_vpmn_code%>">		            	
	            	</TD>	
	            </TR-->
	            <tr>
	            	<td class=blue>是否是策反集团</td>
	            	<td>
	            		<select name="instigate_flag" v_must="1" v_type="string"  >
	            			<option value="Y" <%if("Y".equals(instigate_flag)){%> selected <%}%>>是->Y</option>
	            			<option value="N" <%if("N".equals(instigate_flag)){%> selected <%}%>>否->Y</option>
	            		</select>
	            	</td>
	            	<td class=blue>是否获得竞争对手协议</td>
	            	<td>
	            		<select name="getcontract_flag" v_must="1" v_type="string"  >
	            			<option value="Y" <%if("Y".equals(getcontract_flag)){%> selected <%}%>>是->Y</option>
	            			<option value="N" <%if("N".equals(getcontract_flag)){%> selected <%}%>>否->Y</option>
	            		</select>
	            	</td>
	            </tr>
	            <tr>
	            	<td class='blue'>是否直管客户
								</td>
								<td> 
								  <select name="isDirectManageCust" id="isDirectManageCust" disabled >
								  	<option value="0" selected>否</option>
								  	<option value="1">是</option>
								  </select>
								</td>
	            	<TD class="blue">直管客户编码
								</TD>
								<TD> 
									<input type="text" name="directManageCustNo" id="directManageCustNo"  v_type="string"  readonly class="InputGrey" />
								</TD>
	            </tr>
	            <tr>
	            	<TD class="blue">组织机构代码
								</TD>
								<TD colspan="3"> 
									<input type="text" name="groupNo" id="groupNo"  v_type="string" readonly class="InputGrey" />
								</TD>
	            </tr>
	            <TR>
	          		<TD class=blue>备注</TD>
	          		<TD colspan="3">
	          				<input class="InputGrey" readOnly size="60" name="op_note" v_type="string" v_maxlength="100" value="<%=op_note%>">
	          		</TD>
	          	</TR>
	          </TBODY>
	        </TABLE> 

<%@ include file="/npage/include/footer.jsp" %>		
	 </form>

</body>
</html>
<script language='javascript'>
	//document.all.trade_code.value="<%=trade_code%>";
	//document.all.ent_type.value="<%=ent_type%>";
	//document.all.grp_type.value="<%=grp_type%>";
	//document.all.grp_status.value="<%=grp_status%>";
	//document.all.area_code.value="<%=area_code%>";
	//document.all.owner_code.value="<%=owner_code%>";
	//document.all.photo_code.value="<%=photo_code%>";
	//document.all.province_trade_code.value="<%=province_trade_code%>";
</script>
