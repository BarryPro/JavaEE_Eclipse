<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String loginNo = request.getParameter("loginNo");
String expireTime = request.getParameter("expireTime");
%>
<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String[][] baseInfo = (String[][])arr.get(0);
String org_code = baseInfo[0][16];
String regionCode = org_code.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String ipAddr = request.getRemoteAddr();
%>

<script language="JavaScript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%
/*
 *  0-集团客户关键人信息 1-集团客户扩展信息 2-移动信息化产品 3-集团客户基本信息
 *  操作类型(3)  A-新增 U-修改		操作标识 Y-新增或修改 N-删除(0,1,2)
 *  上级集团客户编码		   集团客户归属省编码	 	   集团客户归属省编码                集团客户归属省编码
 *  集团客户归属省代码     人员角色                是否有IT部门               	     中国移动信息化产品
 *  集团客户归属省编码     姓名                    IT部门名称                        信息化产品流水    
 *  EC集团客户编码         性别                    是否有专属资费方案                产品流水标识      
 *  集团客户名称           联系电话                资费套餐内容                  
 *  客户分类标识           职务                    平均收入                      
 *  信用等级编号           昵称                    平均数据业务收入              
 *  客户重要级别           生日                    员工月平均话费                
 *  客户忠诚度             纪念日                  话费月报销额度                
 *  国家ID（电话区号）     配偶姓名                话费报销方式                  
 *  税号/营业执照号码      秘书姓名                是否使用联通话音业务          
 *  法人代表               毕业院校                是否使用联通数据业务          
 *  注册资金               同窗                    未来变化趋势                  
 *  企业类型/公司性质      兴趣、爱好              中国移动手机数                
 *  企业规模               上级领导                中国移动手机用户比例          
 *  企业员工数             上级部门                对信息化的需求程度            
 *  所在省/地市            下级部门                对信息化集成的需求程度        
 *  邮编                   社交圈                  对行业终端定制的需求程度      
 *  地址                                           对跨省一体化实施能力的需求    
 *  公司主页                                       对一点账单结算的需求          
 *  业务使用情况/公司背景							             对MAS的需求程度               
 *  省BOSS内集团客户编码                           客户扩展信息流水             
 *  备注信息
 *  客户经理工号
 *  姓名
 *  联系电话
 *  手机
 *  传真
 *  电子邮件
 *  客户经理上级领导姓名
 *  客户经理上级领导电话
 *  客户服务等级
 */


    String tmp_Action="";
    String p_Action = request.getParameter("p_Action");
    String pactionFlag="";
    if(p_Action.equals("1")){
      tmp_Action="1";
    }else{
    	if(p_Action.equals("2")) {
    		tmp_Action="2";
      }else if(p_Action.equals("3")) {
      	tmp_Action="3";
    	}    	
    }
    int keyperson_num         = Integer.parseInt(request.getParameter("hiddendate_keyperson_num"));
    int extinfo_num           = Integer.parseInt(request.getParameter("hiddendate_extinfo_num"));
    int cmccprd_num           = Integer.parseInt(request.getParameter("hiddendate_cmccprd_num"));
    //int keyperson_delete_num  = Integer.parseInt(request.getParameter("hiddendate_keyperson_delete_num"));
    //int extinfo_delete_num    = Integer.parseInt(request.getParameter("hiddendate_extinfo_delete_num"));
    //int cmccprd_delete_num    = Integer.parseInt(request.getParameter("hiddendate_cmccprd_delete_num"));
    System.out.println("keyperson_num       :"+keyperson_num       );
    System.out.println("extinfo_num         :"+extinfo_num         );
    System.out.println("cmccprd_num         :"+cmccprd_num         );
    //System.out.println("keyperson_delete_num:"+keyperson_delete_num);
    //System.out.println("extinfo_delete_num  :"+extinfo_delete_num  );
    //System.out.println("cmccprd_delete_num  :"+cmccprd_delete_num  );
    String delete_num  = request.getParameter("hiddendate_delete_num");
    int all_num = keyperson_num                         
                + extinfo_num                         
                + cmccprd_num                         
                //+ keyperson_delete_num                        
                //+ extinfo_delete_num                         
               // + cmccprd_delete_num
                + 1;
    System.out.println("all_num:"+all_num);
    String[] inputArray0  = new String[all_num];
    String[] inputArray1  = new String[all_num];
    String[] inputArray2  = new String[all_num];
    String[] inputArray3  = new String[all_num];
    String[] inputArray4  = new String[all_num];
    String[] inputArray5  = new String[all_num];
    String[] inputArray6  = new String[all_num];
    String[] inputArray7  = new String[all_num];
    String[] inputArray8  = new String[all_num];
    String[] inputArray9  = new String[all_num];
    String[] inputArray10 = new String[all_num];
    String[] inputArray11 = new String[all_num];
    String[] inputArray12 = new String[all_num];
    String[] inputArray13 = new String[all_num];
    String[] inputArray14 = new String[all_num];
    String[] inputArray15 = new String[all_num];
    String[] inputArray16 = new String[all_num];
    String[] inputArray17 = new String[all_num];
    String[] inputArray18 = new String[all_num];
    String[] inputArray19 = new String[all_num];
    String[] inputArray20 = new String[all_num];
    String[] inputArray21 = new String[all_num];
    String[] inputArray22 = new String[all_num];
    String[] inputArray23 = new String[all_num];
    String[] inputArray24 = new String[all_num];
    String[] inputArray25 = new String[all_num];
    String[] inputArray26 = new String[all_num];
    String[] inputArray27 = new String[all_num];
    String[] inputArray28 = new String[all_num];
    String[] inputArray29 = new String[all_num];
    String[] inputArray30 = new String[all_num];
    String[] inputArray31 = new String[all_num];
    String[] inputArray32 = new String[all_num];
    String[] inputArray33 = new String[all_num];
    String[] inputArray34 = new String[all_num];
    String[] inputArray35 = new String[all_num];
    String[] inputArray36 = new String[all_num];
    String[] inputArray37 = new String[all_num];
    
    String[] inputArray40 = new String[all_num];
    String[] inputArray41 = new String[all_num];
       
       
                        
    inputArray0[0]  = "3";// 0-集团客户关键人信息 1-集团客户扩展信息 2-移动信息化产品 3-集团客户基本信息    
    inputArray1[0]  = tmp_Action;// 操作类型(3)  A-新增 U-修改		操作标识 Y-新增或修改 N-删除(0,1,2)
    inputArray2[0]  = request.getParameter("p_ParentCustomerNumber"  );// 上级集团客户编码    
    inputArray3[0]  = request.getParameter("p_CompanyID1"             );// 集团客户归属省代码
    System.out.println("22="+inputArray3[0]);
    inputArray4[0]  = request.getParameter("p_CustomerProvinceNumber");// 集团客户归属省编码
    inputArray5[0]  = request.getParameter("p_CustomerNumber"        );// EC集团客户编码
    System.out.println("gaopengSeeLog======2EC集团客户编码2="+inputArray5[0]);
    inputArray6[0]  = request.getParameter("p_CustomerName"          );// 集团客户名称
    inputArray7[0]  = request.getParameter("p_CustomerClassID"       );// 客户分类标识
    inputArray8[0]  = request.getParameter("p_CreditLevelID"         );// 信用等级编号
    inputArray9[0]  = request.getParameter("p_CustomerRankID"        );// 客户重要级别
    inputArray10[0] = request.getParameter("p_LoyaltyLevelID"        );// 客户忠诚度
    inputArray11[0] = request.getParameter("p_NationID"              );// 国家ID（电话区号）
    inputArray12[0] = request.getParameter("p_TaxNum"                );// 税号/营业执照号码
    inputArray13[0] = request.getParameter("p_Corporation"           );// 法人代表
    inputArray14[0] = request.getParameter("p_LoginFinancing"        );// 注册资金
    inputArray15[0] = request.getParameter("p_IndustryID"            );// 行业类别
    inputArray16[0] = request.getParameter("p_OrganizationTypeID"    );// 企业类型/公司性质
    inputArray17[0] = request.getParameter("p_EmployeeAmountId"      );// 企业规模
    inputArray18[0] = request.getParameter("p_MemberCount"           );// 企业员工数
    inputArray19[0] = request.getParameter("p_Location"              );// 所在省/地市
    inputArray20[0] = request.getParameter("p_PostCode"              );// 邮编
    inputArray21[0] = request.getParameter("p_AddressFullName"       );// 地址
    inputArray22[0] = request.getParameter("p_Homepage"              );// 公司主页
    inputArray23[0] = request.getParameter("p_Background"            );// 业务使用情况/公司背景
    inputArray24[0] = request.getParameter("p_OrgCustID"             );// 省BOSS内集团客户编码
    inputArray25[0] = request.getParameter("p_Description"           );// 备注信息
    inputArray26[0] = request.getParameter("p_StaffNumber"           );// 客户经理工号
    inputArray27[0] = request.getParameter("p_StaffName"             );// 姓名
    inputArray28[0] = request.getParameter("p_ContactPhone"          );// 联系电话
    inputArray29[0] = request.getParameter("p_MobilePhone"           );// 手机
    inputArray30[0] = request.getParameter("p_ContactFax"            );// 传真
    inputArray31[0] = request.getParameter("p_E_mail"                );// 电子邮件
    inputArray32[0] = request.getParameter("p_LeaderName"            );// 客户经理上级领导姓名
    inputArray33[0] = request.getParameter("p_LeaderTel"             );// 客户经理上级领导电话
    inputArray34[0] = request.getParameter("customerServLevel"       );// 客户服务等级	//2012/2/13 wanghfa修改
    inputArray35[0] = request.getParameter("isDirectManageCust"      );// 是否直管客户 0 否，1 是
    inputArray36[0] = request.getParameter("directManageCustNo"      );// 直管客户编码	
    inputArray37[0] = request.getParameter("groupNo"       					 );// 组织机构代码
    
    inputArray40[0] = request.getParameter("groupYearPay"       					 );// 集团年营业额
    inputArray41[0] = request.getParameter("unitCustLevel"       					 );// 集团客户级别（2016年） 
    
    //处理值为undefined的字段
    System.out.println("=="+inputArray2.length);
    System.out.println("==1"+inputArray3[0]);
    
    inputArray2[0] =(inputArray2[0]==null||inputArray2[0].equals("undefined"))?"":inputArray2[0]  ;
    inputArray3[0] =(inputArray3[0]==null||inputArray3[0].equals("undefined"))?"":inputArray3[0]  ;
    inputArray4[0] =(inputArray4[0]==null||inputArray4[0].equals("undefined"))?"":inputArray4[0]  ;
    inputArray5[0] =(inputArray5[0]==null||inputArray5[0].equals("undefined"))?"":inputArray5[0]  ;
    inputArray6[0] =(inputArray6[0]==null||inputArray6[0].equals("undefined"))?"":inputArray6[0]  ;
    inputArray7[0] =(inputArray7[0]==null||inputArray7[0].equals("undefined"))?"":inputArray7[0]  ;
    inputArray8[0] =(inputArray8[0]==null||inputArray8[0].equals("undefined"))?"":inputArray8[0]  ;
    inputArray9[0] =(inputArray9[0]==null||inputArray9[0].equals("undefined"))?"":inputArray9[0]  ;
    inputArray10[0]=(inputArray10[0]==null||inputArray10[0].equals("undefined"))?"":inputArray10[0];
    inputArray11[0]=(inputArray11[0]==null||inputArray11[0].equals("undefined"))?"":inputArray11[0];
    inputArray12[0]=(inputArray12[0]==null||inputArray12[0].equals("undefined"))?"":inputArray12[0];
    inputArray13[0]=(inputArray13[0]==null||inputArray13[0].equals("undefined"))?"":inputArray13[0];
    inputArray14[0]=(inputArray14[0]==null||inputArray14[0].equals("undefined"))?"":inputArray14[0];
    inputArray15[0]=(inputArray15[0]==null||inputArray15[0].equals("undefined"))?"":inputArray15[0];
    inputArray16[0]=(inputArray16[0]==null||inputArray16[0].equals("undefined"))?"":inputArray16[0];
    inputArray17[0]=(inputArray17[0]==null||inputArray17[0].equals("undefined"))?"":inputArray17[0];
    inputArray18[0]=(inputArray18[0]==null||inputArray18[0].equals("undefined"))?"":inputArray18[0];
    inputArray19[0]=(inputArray19[0]==null||inputArray19[0].equals("undefined"))?"":inputArray19[0];
    inputArray20[0]=(inputArray20[0]==null||inputArray20[0].equals("undefined"))?"":inputArray20[0];
    inputArray21[0]=(inputArray21[0]==null||inputArray21[0].equals("undefined"))?"":inputArray21[0];
    inputArray22[0]=(inputArray22[0]==null||inputArray22[0].equals("undefined"))?"":inputArray22[0];
    inputArray23[0]=(inputArray23[0]==null||inputArray23[0].equals("undefined"))?"":inputArray23[0];
    inputArray24[0]=(inputArray24[0]==null||inputArray24[0].equals("undefined"))?"":inputArray24[0];
    inputArray25[0]=(inputArray25[0]==null||inputArray25[0].equals("undefined"))?"":inputArray25[0];
    inputArray26[0]=(inputArray26[0]==null||inputArray26[0].equals("undefined"))?"":inputArray26[0];
    inputArray27[0]=(inputArray27[0]==null||inputArray27[0].equals("undefined"))?"":inputArray27[0];
    inputArray28[0]=(inputArray28[0]==null||inputArray28[0].equals("undefined"))?"":inputArray28[0];
    inputArray29[0]=(inputArray29[0]==null||inputArray29[0].equals("undefined"))?"":inputArray29[0];
    inputArray30[0]=(inputArray30[0]==null||inputArray30[0].equals("undefined"))?"":inputArray30[0];
    inputArray31[0]=(inputArray31[0]==null||inputArray31[0].equals("undefined"))?"":inputArray31[0];
    inputArray32[0]=(inputArray32[0]==null||inputArray32[0].equals("undefined"))?"":inputArray32[0];
    inputArray33[0]=(inputArray33[0]==null||inputArray33[0].equals("undefined"))?"":inputArray33[0];
    inputArray35[0]=(inputArray35[0]==null||inputArray35[0].equals("undefined"))?"":inputArray35[0];
    inputArray36[0]=(inputArray36[0]==null||inputArray36[0].equals("undefined"))?"":inputArray36[0];
    inputArray37[0]=(inputArray37[0]==null||inputArray37[0].equals("undefined"))?"":inputArray37[0];
		
		inputArray40[0]=(inputArray40[0]==null||inputArray40[0].equals("undefined"))?"":inputArray40[0];
		inputArray41[0]=(inputArray41[0]==null||inputArray41[0].equals("undefined"))?"":inputArray41[0];    
    
    for(int i=1;
        i<keyperson_num+1;
        i++){
        int ii=i-1;
    		inputArray0[i]  =  "0";//
        inputArray1[i]  =  "Y";//
        inputArray2[i]  =  request.getParameter("a_CustomerProvinceNumber_KeyPerson"+ii);//集团客户归属省编码	  
        inputArray3[i]  =  request.getParameter("a_Role"+ii         );//人员角色            
        inputArray4[i]  =  request.getParameter("a_PartyName"+ii    );//姓名                
        inputArray5[i]  =  request.getParameter("a_Sex"+ii          );//性别                
        inputArray6[i]  =  request.getParameter("a_ContactPhone"+ii );//联系电话            
        inputArray7[i]  =  request.getParameter("a_Title"+ii        );//职务                
        inputArray8[i]  =  request.getParameter("a_Alias"+ii        );//昵称                
        inputArray9[i]  =  request.getParameter("a_Birthday"+ii     );//生日                
        inputArray10[i] =  request.getParameter("a_Memorial"+ii     );//纪念日              
        inputArray11[i] =  request.getParameter("a_Mate"+ii         );//配偶姓名            
        inputArray12[i] =  request.getParameter("a_Secretary"+ii    );//秘书姓名            
        inputArray13[i] =  request.getParameter("a_School"+ii       );//毕业院校            
        inputArray14[i] =  request.getParameter("a_ClassMates"+ii   );//同窗                
        inputArray15[i] =  request.getParameter("a_Hobby"+ii        );//兴趣、爱好          
        inputArray16[i] =  request.getParameter("a_Leader"+ii       );//上级领导            
        inputArray17[i] =  request.getParameter("a_LeaderDept"+ii   );//上级部门            
        inputArray18[i] =  request.getParameter("a_Vassal"+ii       );//下级部门            
        inputArray19[i] =  request.getParameter("a_Intercourse"+ii  );//社交圈              
        inputArray20[i] =  "0";
        inputArray21[i] =  " ";
        inputArray22[i] =  " ";
        inputArray23[i] =  " ";
        inputArray24[i] =  " ";
        inputArray25[i] =  " ";
        inputArray26[i] =  " ";
        inputArray27[i] =  " ";
        inputArray28[i] =  " ";
        inputArray29[i] =  " ";
        inputArray30[i] =  " ";
        inputArray31[i] =  " ";
        inputArray32[i] =  " ";
        inputArray33[i] =  " ";
        inputArray34[i] =  " ";
        inputArray35[i] =  " ";
        inputArray36[i] =  " ";
        inputArray37[i] =  " ";
        
        inputArray40[i] =  " ";
        inputArray41[i] =  " ";
        
         //处理值为undefined的字段
         inputArray2[i] =  (inputArray2[i]==null||inputArray2[i].equals("undefined"))?"":inputArray2[i]  ;
         inputArray3[i] =  (inputArray3[i]==null||inputArray3[i].equals("undefined"))?"":inputArray3[i]  ;
         inputArray4[i] =  (inputArray4[i]==null||inputArray4[i].equals("undefined"))?"":inputArray4[i]  ;
         inputArray5[i] =  (inputArray5[i]==null||inputArray5[i].equals("undefined"))?"":inputArray5[i]  ;
         inputArray6[i] =  (inputArray6[i]==null||inputArray6[i].equals("undefined"))?"":inputArray6[i]  ;
         inputArray7[i] =  (inputArray7[i]==null||inputArray7[i].equals("undefined"))?"":inputArray7[i]  ;
         inputArray8[i] =  (inputArray8[i]==null||inputArray8[i].equals("undefined"))?"":inputArray8[i]  ;
         inputArray9[i] =  (inputArray9[i]==null||inputArray9[i].equals("undefined"))?"":inputArray9[i]  ;
        inputArray10[i] = (inputArray10[i]==null||inputArray10[i].equals("undefined"))?"":inputArray10[i];
        inputArray11[i] = (inputArray11[i]==null||inputArray11[i].equals("undefined"))?"":inputArray11[i];
        inputArray12[i] = (inputArray12[i]==null||inputArray12[i].equals("undefined"))?"":inputArray12[i];
        inputArray13[i] = (inputArray13[i]==null||inputArray13[i].equals("undefined"))?"":inputArray13[i];
        inputArray14[i] = (inputArray14[i]==null||inputArray14[i].equals("undefined"))?"":inputArray14[i];
        inputArray15[i] = (inputArray15[i]==null||inputArray15[i].equals("undefined"))?"":inputArray15[i];
        inputArray16[i] = (inputArray16[i]==null||inputArray16[i].equals("undefined"))?"":inputArray16[i];
        inputArray17[i] = (inputArray17[i]==null||inputArray17[i].equals("undefined"))?"":inputArray17[i];
        inputArray18[i] = (inputArray18[i]==null||inputArray18[i].equals("undefined"))?"":inputArray18[i];
        inputArray19[i] = (inputArray19[i]==null||inputArray19[i].equals("undefined"))?"":inputArray19[i];

    }       
    for(int i=1+keyperson_num;
        i<1+keyperson_num+extinfo_num;
        i++){        
        int ii=i-1-keyperson_num;
        inputArray0[i]  = "1";
        inputArray1[i]  = "Y";
        inputArray2[i]  = request.getParameter("a_CustomerProvinceNumber_ExtInfo"+ii);//集团客户归属省编码         
        inputArray3[i]  = request.getParameter("a_HasITDept"+ii);//是否有IT部门               
        inputArray4[i]  = request.getParameter("a_ITDeptName"+ii);//IT部门名称                 
        inputArray5[i]  = request.getParameter("a_FeeCase"+ii);//是否有专属资费方案         
        inputArray6[i]  = request.getParameter("a_FeeCaseInfo"+ii);//资费套餐内容               
        inputArray7[i]  = request.getParameter("a_ARPU"+ii);//平均收入                   
        inputArray8[i]  = request.getParameter("a_DataARPU"+ii);//平均数据业务收入           
        inputArray9[i]  = request.getParameter("a_AvgFee"+ii);//员工月平均话费             
        inputArray10[i] = request.getParameter("a_Quota"+ii);//话费月报销额度             
        inputArray11[i] = request.getParameter("a_RewardType"+ii);//话费报销方式               
        inputArray12[i] = request.getParameter("a_UnicomTone"+ii);//是否使用联通话音业务       
        inputArray13[i] = request.getParameter("a_UnicomData"+ii);//是否使用联通数据业务       
        inputArray14[i] = request.getParameter("a_Trends"+ii);//未来变化趋势               
        inputArray15[i] = request.getParameter("a_MobileUser"+ii);//中国移动手机数             
        inputArray16[i] = request.getParameter("a_MobileRate"+ii);//中国移动手机用户比例       
        inputArray17[i] = request.getParameter("a_Informationize"+ii);//对信息化的需求程度         
        inputArray18[i] = request.getParameter("a_Intergration"+ii);//对信息化集成的需求程度     
        inputArray19[i] = request.getParameter("a_Terminal"+ii);//对行业终端定制的需求程度   
        inputArray20[i] = request.getParameter("a_TransProv"+ii);//对跨省一体化实施能力的需求 
        inputArray21[i] = request.getParameter("a_SinglePay"+ii);//对一点账单结算的需求       
        inputArray22[i] = request.getParameter("a_Mas"+ii);//对MAS的需求程度            
        inputArray23[i] = request.getParameter("a_ExtInfoAcceptID"+ii);//客户扩展信息流水   
        System.out.println("gaopengSeeLog2037======a_ExtInfoAcceptID"+ii+"==="+inputArray23[i]);        
        inputArray24[i] = request.getParameter("0");//
        inputArray25[i] = request.getParameter(" ");//
        inputArray26[i] = request.getParameter(" ");//
        inputArray27[i] = request.getParameter(" ");//
        inputArray28[i] = request.getParameter(" ");//
        inputArray29[i] = request.getParameter(" ");//
        inputArray30[i] = request.getParameter(" ");//
        inputArray31[i] = request.getParameter(" ");//
        inputArray32[i] = request.getParameter(" ");//
        inputArray33[i] = request.getParameter(" ");//
        inputArray34[i] =  " ";
        inputArray35[i] =  " ";
        inputArray36[i] =  " ";
        inputArray37[i] =  " ";
        
        inputArray40[i] =  " ";
        inputArray41[i] =  " ";
        
        //处理值为undefined的字段
         inputArray2[i] =  (inputArray2[i]==null||inputArray2[i].equals("undefined"))?"":inputArray2[i]  ;
         inputArray3[i] =  (inputArray3[i]==null||inputArray3[i].equals("undefined"))?"":inputArray3[i]  ;
         inputArray4[i] =  (inputArray4[i]==null||inputArray4[i].equals("undefined"))?"":inputArray4[i]  ;
         inputArray5[i] =  (inputArray5[i]==null||inputArray5[i].equals("undefined"))?"":inputArray5[i]  ;
         inputArray6[i] =  (inputArray6[i]==null||inputArray6[i].equals("undefined"))?"":inputArray6[i]  ;
         inputArray7[i] =  (inputArray7[i]==null||inputArray7[i].equals("undefined"))?"":inputArray7[i]  ;
         inputArray8[i] =  (inputArray8[i]==null||inputArray8[i].equals("undefined"))?"":inputArray8[i]  ;
         inputArray9[i] =  (inputArray9[i]==null||inputArray9[i].equals("undefined"))?"":inputArray9[i]  ;
        inputArray10[i] = (inputArray10[i]==null||inputArray10[i].equals("undefined"))?"":inputArray10[i];
        inputArray11[i] = (inputArray11[i]==null||inputArray11[i].equals("undefined"))?"":inputArray11[i];
        inputArray12[i] = (inputArray12[i]==null||inputArray12[i].equals("undefined"))?"":inputArray12[i];
        inputArray13[i] = (inputArray13[i]==null||inputArray13[i].equals("undefined"))?"":inputArray13[i];
        inputArray14[i] = (inputArray14[i]==null||inputArray14[i].equals("undefined"))?"":inputArray14[i];
        inputArray15[i] = (inputArray15[i]==null||inputArray15[i].equals("undefined"))?"":inputArray15[i];
        inputArray16[i] = (inputArray16[i]==null||inputArray16[i].equals("undefined"))?"":inputArray16[i];
        inputArray17[i] = (inputArray17[i]==null||inputArray17[i].equals("undefined"))?"":inputArray17[i];
        inputArray18[i] = (inputArray18[i]==null||inputArray18[i].equals("undefined"))?"":inputArray18[i];
        inputArray19[i] = (inputArray19[i]==null||inputArray19[i].equals("undefined"))?"":inputArray19[i];
        inputArray20[i] = (inputArray20[i]==null||inputArray20[i].equals("undefined"))?"":inputArray20[i];
        inputArray21[i] = (inputArray21[i]==null||inputArray21[i].equals("undefined"))?"":inputArray21[i];
        inputArray22[i] = (inputArray22[i]==null||inputArray22[i].equals("undefined"))?"":inputArray22[i];
        inputArray23[i] = (inputArray23[i]==null||inputArray23[i].equals("undefined"))?"":inputArray23[i];

        
        
        
        
    }   
        
        
    for(int i=1+keyperson_num+extinfo_num;
        i<1+keyperson_num+extinfo_num+cmccprd_num;
        i++){ 
        int ii=i-1-keyperson_num-extinfo_num;
        inputArray0[i]  = "2";
        inputArray1[i]  = "Y";
        inputArray2[i]  = request.getParameter("a_CustomerProvinceNumber_CMCCPrd"+ii);//集团客户归属省编码    
        inputArray3[i]  = request.getParameter("a_CMCCPrd"+ii);//中国移动信息化产品    
        inputArray4[i]  = request.getParameter("a_ExtInfoAcceptID_CMCCPrd"+ii);//信息化产品流水        
        inputArray5[i]  = request.getParameter("a_CMCCAcceptID"+ii);//产品流水标识          
        inputArray6[i]  = request.getParameter("0");//  
        inputArray7[i]  = request.getParameter(" ");//
        inputArray8[i]  = request.getParameter(" ");//  
        inputArray9[i]  = request.getParameter(" ");//  
        inputArray10[i] = request.getParameter(" ");//  
        inputArray11[i] = request.getParameter(" ");//  
        inputArray12[i] = request.getParameter(" ");//  
        inputArray13[i] = request.getParameter(" ");//    
        inputArray14[i] = request.getParameter(" ");//  
        inputArray15[i] = request.getParameter(" ");//  
        inputArray16[i] = request.getParameter(" ");//  
        inputArray17[i] = request.getParameter(" ");//  
        inputArray18[i] = request.getParameter(" ");//  
        inputArray19[i] = request.getParameter(" ");//  
        inputArray20[i] = request.getParameter(" ");//
        inputArray21[i] = request.getParameter(" ");//  
        inputArray22[i] = request.getParameter(" ");//  
        inputArray23[i] = request.getParameter(" ");//           
        inputArray24[i] = request.getParameter(" ");//
        inputArray25[i] = request.getParameter(" ");//
        inputArray26[i] = request.getParameter(" ");//
        inputArray27[i] = request.getParameter(" ");//
        inputArray28[i] = request.getParameter(" ");//
        inputArray29[i] = request.getParameter(" ");//
        inputArray30[i] = request.getParameter(" ");//
        inputArray31[i] = request.getParameter(" ");//
        inputArray32[i] = request.getParameter(" ");//
        inputArray33[i] = request.getParameter(" ");//
        inputArray34[i] =  " ";
        inputArray35[i] =  " ";
        inputArray36[i] =  " ";
        inputArray37[i] =  " ";
        
        inputArray40[i] =  " ";
        inputArray41[i] =  " ";
        
        
        inputArray2[i]=(inputArray2[i]==null||inputArray2[i].equals("undefined"))?"":inputArray2[i];
        inputArray3[i]=(inputArray3[i]==null||inputArray3[i].equals("undefined"))?"":inputArray3[i];
        inputArray4[i]=(inputArray4[i]==null||inputArray4[i].equals("undefined"))?"":inputArray4[i];
        inputArray5[i]=(inputArray5[i]==null||inputArray5[i].equals("undefined"))?"":inputArray5[i];
    }
    
System.out.println("====wanghfa==== inputArray0.length = " + inputArray0.length);
for(int i=0;i<inputArray0.length;i++){
	System.out.print("in["+i+"] :"+inputArray0[i] );
	System.out.print(" in["+i+"] :"+inputArray1[i] );
	System.out.print(" in["+i+"] :"+inputArray2[i] );
	System.out.print(" in["+i+"] :"+inputArray3[i] );
	System.out.print(" in["+i+"] :"+inputArray4[i] );
	System.out.print(" gaopengSeelog2002 inininin["+i+"] :"+inputArray5[i] );
	System.out.print(" in["+i+"] :"+inputArray6[i] );
	System.out.print(" in["+i+"] :"+inputArray7[i] );
	System.out.print(" in["+i+"] :"+inputArray8[i] );
	System.out.print(" in["+i+"] :"+inputArray9[i] );
	System.out.print(" in["+i+"]:"+inputArray10[i]);
	System.out.print(" in["+i+"]:"+inputArray11[i]);
	System.out.print(" in["+i+"]:"+inputArray12[i]);
	System.out.print(" in["+i+"]:"+inputArray13[i]);
	System.out.print(" in["+i+"]:"+inputArray14[i]);
	System.out.print(" in["+i+"]:"+inputArray15[i]);
	System.out.print(" in["+i+"]:"+inputArray16[i]);
	System.out.print(" in["+i+"]:"+inputArray17[i]);
	System.out.print(" in["+i+"]:"+inputArray18[i]);
	System.out.print(" in["+i+"]:"+inputArray19[i]);
	System.out.print(" in["+i+"]:"+inputArray20[i]);
	System.out.print(" in["+i+"]:"+inputArray21[i]);
	System.out.print(" in["+i+"]:"+inputArray22[i]);
	System.out.print(" in["+i+"]:"+inputArray23[i]);
	System.out.print(" in["+i+"]:"+inputArray24[i]);
	System.out.print(" in["+i+"]:"+inputArray25[i]);
	System.out.print(" in["+i+"]:"+inputArray26[i]);
	System.out.print(" in["+i+"]:"+inputArray27[i]);
	System.out.print(" in["+i+"]:"+inputArray28[i]);
	System.out.print(" in["+i+"]:"+inputArray29[i]);
	System.out.print(" in["+i+"]:"+inputArray30[i]);
	System.out.print(" in["+i+"]:"+inputArray31[i]);
	System.out.print(" in["+i+"]:"+inputArray32[i]);
	System.out.print(" in["+i+"]:"+inputArray33[i]);
	System.out.print(" in["+i+"]:"+inputArray33[i]);
	System.out.print(" in["+i+"]:"+inputArray34[i]);
	System.out.println("--------------------------------------");
}
%>
<%

/*
 * 中国移动BBOSS与省公司集团业务接口规范V2.0.8
 */

String sel_idType      = request.getParameter("sel_idType");
String p_TaxNum        = request.getParameter("p_TaxNum");
String hid_up_filePath = request.getParameter("hid_up_filePath");
String hid_up_HostIp   = java.net.InetAddress.getLocalHost().getHostAddress().toString();

	System.out.println("-------hejwa2002-----------sel_idType-------------------->"+sel_idType);
	System.out.println("-------hejwa2002-----------p_TaxNum---------------------->"+p_TaxNum);
	System.out.println("-------hejwa2002-----------hid_up_filePath--------------->"+hid_up_filePath);
	System.out.println("-------hejwa2002-----------hid_up_HostIp----------------->"+hid_up_HostIp);		

    if(tmp_Action.equals("1"))
{
%>
<wtc:service name="s9109Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="6"  retcode="Code" retmsg="Msg">
   <wtc:param value="<%=workNo%>"/>
   <wtc:param value="<%=org_code%>"/>
   <wtc:params value="<%=inputArray0%>"/>
   <wtc:params value="<%=inputArray1%>"/>
   <wtc:params value="<%=inputArray2%>"/> 
   <wtc:params value="<%=inputArray3%>"/> 
   <wtc:params value="<%=inputArray4%>"/> 
   <wtc:params value="<%=inputArray5%>"/> 
   <wtc:params value="<%=inputArray6%>"/> 
   <wtc:params value="<%=inputArray7%>"/> 
   <wtc:params value="<%=inputArray8%>"/> 
   <wtc:params value="<%=inputArray9%>"/> 
   <wtc:params value="<%=inputArray10%>"/> 
   <wtc:params value="<%=inputArray11%>"/> 
   <wtc:params value="<%=inputArray12%>"/> 
   <wtc:params value="<%=inputArray13%>"/> 
   <wtc:params value="<%=inputArray14%>"/> 
   <wtc:params value="<%=inputArray15%>"/> 
   <wtc:params value="<%=inputArray16%>"/> 
   <wtc:params value="<%=inputArray17%>"/> 
   <wtc:params value="<%=inputArray18%>"/> 
   <wtc:params value="<%=inputArray19%>"/> 
   <wtc:params value="<%=inputArray20%>"/> 
   <wtc:params value="<%=inputArray21%>"/> 
   <wtc:params value="<%=inputArray22%>"/> 
   <wtc:params value="<%=inputArray23%>"/> 
   <wtc:params value="<%=inputArray24%>"/> 
   <wtc:params value="<%=inputArray25%>"/> 
   <wtc:params value="<%=inputArray26%>"/> 
   <wtc:params value="<%=inputArray27%>"/> 
   <wtc:params value="<%=inputArray28%>"/> 
   <wtc:params value="<%=inputArray29%>"/> 
   <wtc:params value="<%=inputArray30%>"/> 
   <wtc:params value="<%=inputArray31%>"/> 
   <wtc:params value="<%=inputArray32%>"/> 
   <wtc:params value="<%=inputArray33%>"/> 
   <wtc:params value="<%=inputArray34%>"/>
   <wtc:params value="<%=inputArray35%>"/>
   <wtc:params value="<%=inputArray36%>"/>
   <wtc:params value="<%=inputArray37%>"/>
   <wtc:params value="<%=inputArray40%>"/>
   <wtc:params value="<%=inputArray41%>"/>
 	
 	<wtc:param value="<%=sel_idType%>"/>
 	<wtc:param value="<%=hid_up_filePath%>"/>
 	<wtc:param value="<%=hid_up_HostIp%>"/>			
 	
</wtc:service>
<wtc:array id="result" scope="end"/>

<%if(Code.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("操作成功!",1);
		window.location.replace("f2002_1.jsp");
</script>
<%
}else{
%>
<script language="JavaScript">
		rdShowMessageDialog("<%=Msg%>!",0);
		
		window.location.replace("f2002_1.jsp");
</script>
<%
}

}
else 
{
		
	
%>
<wtc:service name="s9109Cfm1" routerKey="region" routerValue="<%=regionCode%>" outnum="6"  retcode="Code" retmsg="Msg">
   <wtc:param value="<%=workNo%>"/>
   <wtc:param value="<%=org_code%>"/>
   <wtc:params value="<%=inputArray0%>"/> 
   <wtc:params value="<%=inputArray1%>"/>
   <wtc:params value="<%=inputArray2%>"/> 
   <wtc:params value="<%=inputArray3%>"/> 
   <wtc:params value="<%=inputArray4%>"/> 
   <wtc:params value="<%=inputArray5%>"/> 
   <wtc:params value="<%=inputArray6%>"/> 
   <wtc:params value="<%=inputArray7%>"/> 
   <wtc:params value="<%=inputArray8%>"/> 
   <wtc:params value="<%=inputArray9%>"/> 
   <wtc:params value="<%=inputArray10%>"/> 
   <wtc:params value="<%=inputArray11%>"/> 
   <wtc:params value="<%=inputArray12%>"/> 
   <wtc:params value="<%=inputArray13%>"/> 
   <wtc:params value="<%=inputArray14%>"/> 
   <wtc:params value="<%=inputArray15%>"/> 
   <wtc:params value="<%=inputArray16%>"/> 
   <wtc:params value="<%=inputArray17%>"/> 
   <wtc:params value="<%=inputArray18%>"/> 
   <wtc:params value="<%=inputArray19%>"/> 
   <wtc:params value="<%=inputArray20%>"/> 
   <wtc:params value="<%=inputArray21%>"/> 
   <wtc:params value="<%=inputArray22%>"/> 
   <wtc:params value="<%=inputArray23%>"/> 
   <wtc:params value="<%=inputArray24%>"/> 
   <wtc:params value="<%=inputArray25%>"/> 
   <wtc:params value="<%=inputArray26%>"/> 
   <wtc:params value="<%=inputArray27%>"/> 
   <wtc:params value="<%=inputArray28%>"/> 
   <wtc:params value="<%=inputArray29%>"/> 
   <wtc:params value="<%=inputArray30%>"/> 
   <wtc:params value="<%=inputArray31%>"/> 
   <wtc:params value="<%=inputArray32%>"/> 
   <wtc:params value="<%=inputArray33%>"/> 
   <wtc:params value="<%=inputArray34%>"/>
   <wtc:params value="<%=inputArray35%>"/>
   <wtc:params value="<%=inputArray36%>"/>
   <wtc:params value="<%=inputArray37%>"/>
   <wtc:params value="<%=inputArray40%>"/>
   <wtc:params value="<%=inputArray41%>"/>

 	<wtc:param value="<%=sel_idType%>"/>
 	<wtc:param value="<%=hid_up_filePath%>"/>
 	<wtc:param value="<%=hid_up_HostIp%>"/>		
   		   	
</wtc:service>
<wtc:array id="result" scope="end"/>



<%if(Code.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("操作成功!",1);
		
		window.location.replace("f2002_1.jsp");
</script>
<%
}else{
%>
<script language="JavaScript">
		rdShowMessageDialog("<%=Msg%>!",0);
		window.location.replace("f2002_1.jsp");
</script>
<%
}
}
%>


