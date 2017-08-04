 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-15 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.StringTokenizer"%>
 
<%
	
	String opCode1 = request.getParameter("opCodeFlag");
	String v_smCode = request.getParameter("v_smCode");
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@opCode="+opCode1);
	String opType = "";
	if("3202".equals(opCode1)){
	    opType = "u02";
	}else if("3204".equals(opCode1)){
	    opType = "u06";
	}else if("3205".equals(opCode1)){
	    opType = "u07";
	}
	String opName1 = "集团产品资料变更";	//header.jsp需要的参数  
    //ArrayList retArray = null;
    String error_code = "0";
    String error_msg = "";
   

    String[] retStr = null;
    String unit_id=request.getParameter("unit_idAdd");
    System.out.println("unit_id===="+unit_id);
    String iLoginAccept    = request.getParameter("login_accept");     //操作流水号
    String iOpCode         = opCode1;         //操作代码
    String iWorkNo         = (String)session.getAttribute("workNo");           //操作员工号
    String iLogin_Pass     = request.getParameter("NoPass");           //操作员密码
    String iOrgCode        = (String)session.getAttribute("orgCode");          //操作员机构代码
    String iSys_Note       = request.getParameter("sysnote");          //系统操作备注
    String iOp_Note        = request.getParameter("tonote");           //用户操作备注
    String iIpAddr         = request.getParameter("ip_Addr");          //操作员IP地址
    String iGrp_Id         = request.getParameter("grpIdNo");          //集团用户ID	 
	String idcMebNo        = request.getParameter("idcMebNo");         //IDC用户编码
	String user_no         = request.getParameter("user_no");
	String sProductCode    = request.getParameter("product_code2");
	System.out.println("########################sProductCode---"+sProductCode);
	
	String iflags_no_2 = (String)request.getParameter("FZHWW0");   // 综合v网标记
	
	String name_list	   = request.getParameter("nameList");		   //集团字段代码
	String grp_list	       = request.getParameter("nameGroupList");	   //字段对应的行号
	String open_flag_list = request.getParameter("openFlagList");
	String name_list_new   = request.getParameter("nameListNew");	   //集团新增字段代码
	String grp_list_new    = request.getParameter("nameGroupListNew"); //新增字段对应的行号
	String open_flag_list_new = request.getParameter("openFlagListNew");

	String iPay_Type	   = request.getParameter("payType");     //付款方式
	String iCash_Pay	   = request.getParameter("should_handfee");     //支付金额
	String iCheck_No	   = request.getParameter("checkNo");     //支票号码
	String iBank_Code	   = request.getParameter("bankCode");     //银行代码
	String iCheck_Pay	   = request.getParameter("checkPay");     //支票交款
	String iShouldHandFee  = request.getParameter("should_handfee");   //应收手续费
    	String iHandFee        = request.getParameter("real_handfee");     //实收手续费
	String feeList="";//费用信息
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCash_Pay+"~"+iShouldHandFee+"~"+iHandFee+"~";
    String iRegion_Code = iOrgCode.substring(0,2);
    
    String in_ChanceId = request.getParameter("in_ChanceId2"); //商机编码：端到端时由销售方面传入；其他时，传空串“”。
    String wa_no = request.getParameter("waNo");
    
    String vServArea = request.getParameter("F10310");
    String vScp_Code = request.getParameter("F10312");
    String vGroup_Type = request.getParameter("F10313");
    String vSubState = request.getParameter("F10314");
    String vFunFlags = request.getParameter("F10315");
    String vInterFee = request.getParameter("F10317");
    String vOutFee = request.getParameter("F10318");
    String vOutGrpFee = request.getParameter("F10319");
    String vNormalFee = request.getParameter("F10320");
    String vAdmin_No = request.getParameter("F10321");
    String vTrans_No = request.getParameter("F10322");

    String ZNVW_MSG =   vServArea
                +"~"+   vScp_Code
                +"~"+   vGroup_Type
                +"~"+   vSubState
                +"~"+   vFunFlags
                +"~"+   vInterFee
                +"~"+   vOutFee
                +"~"+   vOutGrpFee
                +"~"+   vNormalFee
                +"~"+   vAdmin_No
                +"~"+   vTrans_No
                +"~"    ;


    String vShort_Flag = request.getParameter("F10323");
    String vInside_GroupNum = request.getParameter("F10324");
    String vInside_UserNum = request.getParameter("F10325");
    String vMax_Close = request.getParameter("F10326");
    String vOutside_UserNum = request.getParameter("max_outnumcl");
    String vMax_Users = request.getParameter("F10328");
    String vPkgType = request.getParameter("F10329");
    String vPkgDay = request.getParameter("F10330");
    String vDiscount = request.getParameter("F10331");
    String vLmt_Fee = request.getParameter("F10332");

    String ZNVW_PROD =   vShort_Flag
                +"~"+   vInside_GroupNum
                +"~"+   vInside_UserNum
                +"~"+   vMax_Close
                +"~"+   vOutside_UserNum
                +"~"+   vMax_Users
                +"~"+   vPkgType
                +"~"+   vPkgDay
                +"~"+   vDiscount
                +"~"+   vLmt_Fee
                +"~"    ;


    String vGroup_Name = request.getParameter("group_name");
    String vFee_Rate = request.getParameter("fee_rate");
    String vProvince_Code = request.getParameter("province");
    String vContact = request.getParameter("contact");
    String vTelephone = request.getParameter("telephone");
    String vAddress = request.getParameter("address");
    String vBusi_Type = request.getParameter("busi_type");
    String vChg_Flag = request.getParameter("chg_flag");
    String vEnd_Time = request.getParameter("srv_stop");
    String vCover_Region = request.getParameter("cover_region");
    
    String ZNVW_DOC =   vGroup_Name
                +"~"+   vFee_Rate
                +"~"+   vProvince_Code
                +"~"+   vContact
                +"~"+   vTelephone
                +"~"+   vAddress
                +"~"+   vBusi_Type
                +"~"+   vChg_Flag
                +"~"+   vEnd_Time
                +"~"+   vCover_Region
                +"~"    ;
	System.out.println(ZNVW_DOC);
    
    String StartTime       = request.getParameter("StartTime"); 
    String EndTime       = request.getParameter("EndTime");  
    String MOCode       = request.getParameter("MOCode");  
    String CodeMathMode       = request.getParameter("CodeMathMode");  
    String MOType       = request.getParameter("MOType");  
    String DestServCode       = request.getParameter("DestServCode");  
    String ServCodeMathMode       = request.getParameter("ServCodeMathMode");  
    String stimestr     = request.getParameter("F00020");  
    String szMOstr      = request.getParameter("F00021");  
    String acquiescentScales[]= null;
    if("LL".equals(v_smCode)){
			acquiescentScales = (String[])request.getParameterValues("acquiescentScale");
		}
	
	String timeMOStr = ""+"~"+stimestr+"~"+StartTime+"~"+EndTime+"~"+szMOstr+"~"+MOCode+"~"+CodeMathMode+"~"+MOType+"~"+DestServCode+"~"+ServCodeMathMode+"~";
    
    try
    {		   
			StringTokenizer token=new StringTokenizer(name_list,"|");
			StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
			StringTokenizer token_flag=new StringTokenizer(open_flag_list,"|");
        	StringTokenizer token_flag2=new StringTokenizer(open_flag_list,"|");
        	StringTokenizer token_flag3=new StringTokenizer(open_flag_list,"|");
			
			StringTokenizer token_new=new StringTokenizer(name_list_new,"|");
			StringTokenizer token_grp_new=new StringTokenizer(grp_list_new,"|");
			StringTokenizer token_flag_new=new StringTokenizer(open_flag_list_new,"|");
        	StringTokenizer token_flag_new2=new StringTokenizer(open_flag_list_new,"|");
        	StringTokenizer token_flag_new3=new StringTokenizer(open_flag_list_new,"|");
	
			int length=token.countTokens();
			System.out.println("##################length="+length);
			int cnt = 0;
    	    while (token_flag3.hasMoreElements()){
        	    if("Y".equals(token_flag3.nextElement())){
        	        cnt++;
        	    }
    	    }
    	    length = cnt;
	        System.out.println("******************length="+length);
			int newLen=token_new.countTokens();
			System.out.println("##################newLen="+newLen);
			int cntNew = 0;
    	    while (token_flag_new3.hasMoreElements()){
        	    if("Y".equals(token_flag_new3.nextElement())){
        	        cntNew++;
        	    }
    	    }
    	    newLen = cntNew;
	    
			//System.out.println(length);
			
			//获得域代码、域值和行号
			String fieldCodes[] = new String [length];
			String fieldValues[]= new String [length];
			String fieldRowNo[]= new String [length];
			String v_fieldRowNo[]= new String [length];
			
			ArrayList fieldValueAry = new ArrayList();
			ArrayList fieldCodeAry = new ArrayList();
			ArrayList fieldRowNoAry = new ArrayList();
			Vector vec = new Vector();

			int i=0;	//总数组个数
			int m=0;
			int j=0;    //附加资费个数
			int k=0;	//组号个数，与域个数相同
			int p=0;	//每个组中的一个域的记录条数
			//解析组号字符串
			while (token_grp.hasMoreElements()){
    			if("Y".equals(token_flag.nextElement())){
    				fieldRowNo[k]=(String)token_grp.nextElement();
    				//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
    				k++;
    		    }else{
            	    token_grp.nextElement();
        	    }
			}
			
			//解析名字和值字符串
			while (token.hasMoreElements()){
    			if("Y".equals(token_flag2.nextElement())){
    				fieldCodes[i]=(String)token.nextElement();
    				//System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
    				//System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
    				
    				if(!vec.contains(fieldCodes[i]))
    				{
    					if(!fieldRowNo[i].equals("0"))	//行号从1开始
    					{
    						String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
    						for(p=0;p<tempValues.length;p++)
    						{
    							fieldValueAry.add(tempValues[p]);
    							fieldCodeAry.add(fieldCodes[i]);
    							v_fieldRowNo[p]=Integer.toString(p+1);
    							fieldRowNoAry.add(v_fieldRowNo[p]);
    						}
    					} 
    					else //非成行内容
    					{
    						fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
    						fieldCodeAry.add(fieldCodes[i]);
    						fieldRowNoAry.add("0");
    					}
    					vec.add(fieldCodes[i]);
    				}
    				i++;
				}else{
            	    token.nextElement();    
            	}
			}
			
			int v_length = fieldValueAry.size();
			if(v_length!=length){ //删除||增加
				fieldValues=(String[])fieldValueAry.toArray(new String[v_length]);
				fieldCodes = new String [v_length];
				fieldCodes=(String[])fieldCodeAry.toArray(new String[v_length]);
				fieldRowNo = new String [v_length];
				fieldRowNo=(String[])fieldRowNoAry.toArray(new String[v_length]);
			}else{  //个数没变
				fieldValues=(String[])fieldValueAry.toArray(new String[length]);
			}
			
			//获得域代码、域值和行号结束
			
			//获得新增域代码、域值和行号
			String newFieldCodes[] = new String [newLen];
			String newFieldValues[]= new String [newLen];
			String newFieldRowNo[]= new String [newLen];
			
			ArrayList newFieldValueAry = new ArrayList();
			Vector newVec = new Vector();

			i=0;	//总数组个数
			m=0;
			j=0;    //附加资费个数
			k=0;	//组号个数，与域个数相同
			p=0;	//每个组中的一个域的记录条数
			//解析组号字符串
			while (token_grp_new.hasMoreElements()){
			    if("Y".equals(token_flag_new.nextElement())){
    				newFieldRowNo[k]=(String)token_grp_new.nextElement();
    				//System.out.println("###########********newFieldRowNo["+k+"]**********##########"+newFieldRowNo[k]);
    				k++;
				}else{
            	    token_grp_new.nextElement();
        	    }
			}
			
			//解析名字和值字符串
			while (token_new.hasMoreElements()){
			    if("Y".equals(token_flag_new2.nextElement())){
    				newFieldCodes[i]=(String)token_new.nextElement();
    				//System.out.println("###########********newFieldCodes["+i+"]**********##########"+newFieldCodes[i]);
    				//System.out.println("###########********newFieldRowNo["+i+"]**********##########"+newFieldRowNo[i]);
    				
    				if(!newVec.contains(newFieldCodes[i]))
    				{
    					if(!newFieldRowNo[i].equals("0"))	//行号从1开始
    					{
    						String[] tempValues = (String[])request.getParameterValues("F"+newFieldCodes[i]);
    						for(p=0;p<tempValues.length;p++)
    						{
    							newFieldValueAry.add(tempValues[p]);
    							//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
    						}
    					}
    					else
    					{
    						newFieldValueAry.add(request.getParameter("F"+newFieldCodes[i]));
    						//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
    					}
    					newVec.add(newFieldCodes[i]);
    				}
    				i++;
				}else{
            	    token_new.nextElement();    
            	}
			}
			
			newFieldValues=(String[])newFieldValueAry.toArray(new String[newLen]);
			//获得新增域代码、域值和行号结束
			
			String temp_str="";
			
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{idcMebNo        });
            //System.out.println("bbbbbbidcMebNo"+idcMebNo);
            paramsIn.add(new String[]{feeList         });
            
            if(length>0)
            {
            paramsIn.add(fieldCodes                    );
            paramsIn.add(fieldValues                   );
            paramsIn.add(fieldRowNo                    );
            }
          else{
          	paramsIn.add(""                    );
            paramsIn.add(""                   );
            paramsIn.add(""                    );
          	}
            if (newLen== 0)
            	 paramsIn.add(temp_str                 );
            else
            	 paramsIn.add(newFieldCodes            );
            if (newLen== 0)
               paramsIn.add(temp_str                   );
            else
               paramsIn.add(newFieldValues             );
            if (newLen== 0)
               paramsIn.add(temp_str                   );
            else
               paramsIn.add(newFieldRowNo              );
            
for(int ii=0;ii<fieldCodes.length;ii++){
    System.out.println("---------codes------"+fieldCodes[ii]);
    System.out.println("---------values-----"+fieldValues[ii]);
    System.out.println("---------rowno------"+fieldRowNo[ii]);
}

for(int ii=0;ii<newFieldCodes.length;ii++){
    System.out.println("---------newcodes------"+newFieldCodes[ii]);
    System.out.println("---------newvalues-----"+newFieldValues[ii]);
    System.out.println("---------newrowno------"+newFieldRowNo[ii]);
}

			//传入参数数组           
			//retStr = callView.callService("s3517Cfm", paramsIn, "1", "region", iRegion_Code);
			%>				
			<wtc:service name="s3691CfmE" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
				<wtc:param value="<%=iLoginAccept%>"/>
				<wtc:param value="3691"/>
				<wtc:param value="<%=iWorkNo%>"/>
				<wtc:param value="<%=iLogin_Pass%>"/>
				<wtc:param value="<%=iSys_Note%>"/>
				<wtc:param value="<%=iOp_Note%>"/>
				<wtc:param value="<%=iIpAddr%>"/>
				<wtc:param value="<%=iOrgCode%>"/>
				<wtc:param value="<%=iGrp_Id%>"/>
				<wtc:param value="<%=sProductCode%>"/>
				<wtc:param value="<%=idcMebNo%>"/>
				<wtc:param value="<%=feeList%>"/>
				<wtc:param value="<%=iflags_no_2%>"/>
                <wtc:param value="<%=user_no%>"/>
                <wtc:param value="2"/>
                <wtc:param value="<%=wa_no%>"/>
                <wtc:param value="<%=ZNVW_MSG%>"/>
                <wtc:param value="<%=ZNVW_PROD%>"/>
                <wtc:param value="<%=ZNVW_DOC%>"/>
                <wtc:param value="<%=timeMOStr%>"/>
                <wtc:param value="<%=opType%>"/>
			<%
				 if(length>0){
			%>
				<wtc:params value="<%=fieldCodes%>"/>
				<wtc:params value="<%=fieldValues%>"/>
				<wtc:params value="<%=fieldRowNo%>"/>
			<%	}else{
			%>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
			<%	}%>
			
			<% if(newLen== 0){%>
				<wtc:param value="<%=temp_str%>"/>
            		<%}else{%>
            			<wtc:params value="<%=newFieldCodes%>"/>
           		<%} if(newLen== 0){%>
           			<wtc:param value="<%=temp_str%>"/>
            		<%}else{%>
            			<wtc:params value="<%=newFieldValues%>"/>
               		<% }if(newLen== 0){%>
           			<wtc:param value="<%=temp_str%>"/>
           		<%}else{%>	
           			<wtc:params value="<%=newFieldRowNo%>"/> 
           		<%}%>   
           		<%if("LL".equals(v_smCode)){%>
           				<wtc:params value="<%=acquiescentScales%>"/> 
           		<%}%>
			</wtc:service>	
	
	
			<%			
			System.out.println("2222222222222222");
            			error_code = retCode1;
            			error_msg= retMsg1;
            			System.out.println("33333333333333");
    }catch(Exception e){
		e.printStackTrace();
       // logger.error("Call s3691Cfm is Failed!");
    }
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode1+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName1+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
	System.out.println(url);
    if(error_code .equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            removeCurrentTab();
        </script>
<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
%>

<jsp:include page="<%=url%>" flush="true"/>
</html>
