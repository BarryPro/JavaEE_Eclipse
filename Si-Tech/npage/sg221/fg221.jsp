<%
    /********************
     * @ OpCode    :  7983
     * @ OpName    :  集团成员增加
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-20
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
    String opCode = "g221";
    String opName = "集团成员包年续签";
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    Logger logger = Logger.getLogger("fg221.jsp");
    String dateStr2 = "";
    
    Date date = new Date();
    SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
    GregorianCalendar gc = new GregorianCalendar();
    gc.setTime(date); 
    gc.add(2,1);
    gc.set(gc.get(gc.YEAR),gc.get(gc.MONTH),gc.get(gc.DATE));
    String beginDate=df.format(gc.getTime())+"01";
    gc.add(1,1);
    String endDate=df.format(gc.getTime())+"01";
    System.out.println("xxxxxxxxxxxxxxxx"+beginDate);
    System.out.println("xxxxxxxxxxxxxxxx"+endDate);
    
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
    String groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
    String districtCode = orgCode.substring(2,4);
    
    String[][] result = new String[][]{};
    String[][] payArr = new String[][]{};
    String[][] packArr = new String[][]{};
    String[][] resultList = new String[][]{};
    int resultListLength=0;
    
    String nextFlag = "1";
    String iIccid = "";
    String iUnitId = "";
    String iCustId = "";
    String iServiceNo = "";
    String iProductId = "";
    String iAccountId = "";
    String iSmCode = "";
    String iSmName = "";
    String iBelongCode = "";
    String iProductPwd = "";
    String iRequestType = "";
    String id_no = "";
    String listShow="none";
    String iMonthFlag = "";
    String iUserType = "";
    String iGrpName = "";
    String iProductName = "";
    String zhwwFlag = "";
    String iMaxTermNum = "";
    String iAddTermNum = "";
    String iUseTermNum = "";
    String limitcount = "";
    String arcFlag = "";
    
    /*begin 定义客户经理工号和姓名、集团类别 变量 by diling*/
    String iCustManagerNoHiden = "";
    String iCustManagerNameHiden = "";
    String iUnitTypeHiden = "";
    /*end add by diling*/
    /*begin 定义目前占比、上限占比、可添加智能网成员数、地市 变量 by diling@2012/6/12 */
    String iPreProportionHiden = "";
    String iHighestLimitHiden = "";
    String iAddVpMemberHiden = "";
    String iRegionNameHiden = "";
    /*end add by diling*/
	String iBizCode = ""; //wanghao add
    String action = WtcUtil.repNull((String)request.getParameter("action"));
    /* 点击"下一步"后，进行处理。 */
    if("next".equals(action)){
        nextFlag = "2";
        iIccid = WtcUtil.repNull((String)request.getParameter("iccid"));
        iCustId = WtcUtil.repNull((String)request.getParameter("cust_id"));
        iUnitId = WtcUtil.repNull((String)request.getParameter("unit_id"));
        iServiceNo = WtcUtil.repNull((String)request.getParameter("service_no"));
        iProductId = WtcUtil.repNull((String)request.getParameter("product_id"));
        iAccountId = WtcUtil.repNull((String)request.getParameter("account_id"));
        iSmCode = WtcUtil.repNull((String)request.getParameter("sm_code"));
        //iSmCode = "vp";
        iSmName = WtcUtil.repNull((String)request.getParameter("sm_name"));
        id_no = WtcUtil.repNull((String)request.getParameter("id_no"));
        iBelongCode = WtcUtil.repNull((String)request.getParameter("belong_code"));
        iProductPwd = WtcUtil.repNull((String)request.getParameter("product_pwd"));
        iRequestType = WtcUtil.repNull((String)request.getParameter("request_type"));
        iMonthFlag = WtcUtil.repNull((String)request.getParameter("month_flag"));
        iGrpName = WtcUtil.repNull((String)request.getParameter("grp_name"));
        iProductName = WtcUtil.repNull((String)request.getParameter("product_name"));
        iMaxTermNum = WtcUtil.repNull((String)request.getParameter("max_term_num_tmp"));
        iAddTermNum = WtcUtil.repNull((String)request.getParameter("add_term_num_tmp"));
        iUseTermNum = WtcUtil.repNull((String)request.getParameter("use_term_num_tmp"));
        limitcount = WtcUtil.repNull((String)request.getParameter("limitcount"));
        
        /*begin add by diling@2012/5/14 */
        iCustManagerNoHiden = WtcUtil.repNull((String)request.getParameter("custManagerNoHiden"));
        iCustManagerNameHiden = WtcUtil.repNull((String)request.getParameter("custManagerNameHiden"));
        iUnitTypeHiden = WtcUtil.repNull((String)request.getParameter("unitTypeHiden"));
        /*end add by diling*/
        /*begin add by diling for 获取目前占比、上限占比、可添加智能网成员数、地市 变量 @2012/6/12 */
        iPreProportionHiden = WtcUtil.repNull((String)request.getParameter("preProportionHiden"));
        iHighestLimitHiden = WtcUtil.repNull((String)request.getParameter("highestLimitHiden"));
        iAddVpMemberHiden = WtcUtil.repNull((String)request.getParameter("addVpMemberHiden"));
        iRegionNameHiden = WtcUtil.repNull((String)request.getParameter("regionNameHiden"));
        /*end add by diling@2012/6/12*/
       
        /*********************
         * 判断工号或集团是否有办理此业务的权限
         *********************/
        try{
            %>
                <wtc:service name="sCheckLogin" routerKey="region" routerValue="<%=regionCode%>" retcode="sCheckLoginCode" retmsg="sCheckLoginMsg" outnum="2" >
                	<wtc:param value="<%=workNo%>"/>
                	<wtc:param value="<%=workPwd%>"/> 
                    <wtc:param value="<%=iSmCode%>"/>
                    <wtc:param value="m01"/>
                    <wtc:param value="<%=iRequestType%>"/>
                    <wtc:param value="<%=iProductId%>"/>
                    <wtc:param value="<%=iCustId%>"/>
                 	<wtc:param value="<%=id_no%>"/>
                </wtc:service>
            <%
            if(!"000000".equals(sCheckLoginCode)){
                %>
                    <script type=text/javascript>
                        rdShowMessageDialog("错误代码：<%=sCheckLoginCode%><br/>错误信息:<%=sCheckLoginMsg%>",0);
                        window.location.href="fg221.jsp";
                    </script>
                <%
            }
        }catch(Exception e){
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("调用服务sCheckLogin失败！",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
            e.printStackTrace();
        }

        /* 取biz_code,用于后面取付费信息与套餐信息 */

        try{
            String bizCodeSql = "";
    		bizCodeSql="select nvl(field_value,'') from dGrpUserMsgAdd "
    			    +" where field_code='YWDM0' and id_no="+id_no;
    		%>
        		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode01" retmsg="retMsg01" outnum="1">
                    <wtc:sql><%=bizCodeSql%></wtc:sql>
        		</wtc:pubselect>
        		<wtc:array id="result01" scope="end" />	
    		<%
    		if ("000000".equals(retCode01)){
    		    if(result01.length>0){
    			    iBizCode = result01[0][0];
    			}else{
    			    iBizCode = "";
    			}
    		}else{
			%>
    			<script type=text/javascript>
                    rdShowMessageDialog("查询业务代码失败！<br>错误代码：<%=retCode01%>,错误信息：<%=retMsg01%>",0);
                    window.location.href="fg221.jsp";
                </script>
			<%
    		}
        }catch(Exception e){
        %>
			<script type=text/javascript>
                rdShowMessageDialog("查询业务代码失败！",0);
                window.location.href="fg221.jsp";
            </script>
		<%
            e.printStackTrace();
        }

        /*********************
         * 取付费信息
         * field_code2 : 1-付费方式可用
         * field_code3 : 0-固定集团付费;1-默认集团可选;2-固定个人付费;3-默认个人可选 
         *********************/
        try{
            String paySql = "select field_code2,field_code3 from dbvipadm.scommoncode where common_code ='1002' and field_code1='"+iSmCode+"'" ; 
			if("AD".equals(iSmCode)||"ML".equals(iSmCode)||"MA".equals(iSmCode)){
				paySql = paySql + "and  field_code4='"+iRequestType+"' ";
			}
			System.out.println("# paySql = "+paySql);
            %>
                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="2">
                	<wtc:sql><%=paySql%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr1" scope="end"/>
            <%
            if("000000".equals(retCode1)){
                if(retArr1.length>0){
                    payArr = retArr1;
                }else{
                    paySql="select count(*) from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+iBizCode+"'"+
	                    " and b.common_code = '1002'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and a.field_code='YWDM0'  and b.field_code2='"+regionCode+"'";
                    %>
                		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
                		    <wtc:sql><%=paySql%></wtc:sql>
                		</wtc:pubselect>
                		<wtc:array id="result12" scope="end" />	
            		<%
            		if("000000".equals(retCode12)){
            		    if(result12.length>0 && Integer.parseInt(result12[0][0])>0){
                		    /*chendx 20110315 新增common_code=1004字段标识业务代码和付费方式的显示关系*/
		                   paySql="select field_code4 from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+iBizCode+"'"+
	                    		" and b.common_code = '1002'  and a.field_value = b.field_code1 and a.id_no = "+id_no+" and a.field_code='YWDM0'  and b.field_code2='"+regionCode+"'";
		                	%>
		                		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode00" retmsg="retMsg00" outnum="1">
		                		    <wtc:sql><%=paySql%></wtc:sql>
		                		</wtc:pubselect>
		                		<wtc:array id="result00" scope="end" />	
		            		<%
		            		System.out.println("# paySql = "+paySql);
		            		if("000000".equals(retCode00) && result00.length>0){
		            			 payArr = new String[][]{{"1","1"}};
		            			 payArr[0][1] = result00[0][0];
		            			 System.out.println("2222 payArr[0] = "+payArr[0][0]);
	                    		 System.out.println("2222 payArr[1] = "+payArr[0][1]);	
		            		}else{
		            			payArr = new String[][]{{"1","1"}};
	                		    System.out.println("33333 payArr[0] = "+payArr[0][0]);
	                    		System.out.println("33333 payArr[1] = "+payArr[0][1]);	
		            		}
		            		/*chendx 20110315 end*/
                		}else{
                		    paySql="select count(*) from dGrpUserMsg a, dbvipadm.sCommonCode b where a.run_code='A' "+
	                            " and b.common_code = '1002'   and a.product_code = b.field_code1 and a.id_no = "+id_no+" and field_code2='"+regionCode+"'";
                            %>
                    			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode13" retmsg="retMsg13" outnum="1">
                    			    <wtc:sql><%=paySql%></wtc:sql>
                    			</wtc:pubselect>
                    			<wtc:array id="result13" scope="end" />	
                			<%
                			if("000000".equals(retCode13)){
                			    if(result13.length>0 && Integer.parseInt(result13[0][0])>0){
                			        payArr = new String[][]{{"1","1"}};
                			    }else{
                			        payArr = new String[][]{{"",""}};
                			    }
                			}else{
                    	    %>
                                <script type=text/javascript>
                                    rdShowMessageDialog("取付费信息失败！<br>错误代码：<%=retCode13%>,错误信息：<%=retMsg13%>",0);
                                    window.location.href="fg221.jsp";
                                </script>
                            <%
                			}
            		    }
                	}else{
                	    %>
                            <script type=text/javascript>
                                rdShowMessageDialog("取付费信息失败！<br>错误代码：<%=retCode12%>,错误信息：<%=retMsg12%>",0);
                                window.location.href="fg221.jsp";
                            </script>
                        <%
            	    }
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取付费信息失败！<br>错误代码：<%=retCode1%>,错误信息：<%=retMsg1%>",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
            }
        }catch(Exception e){
            e.printStackTrace();
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取付费信息失败！",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
        }
        
        /*********************
         * 取套餐信息
         * field_code4 : 有值-套餐信息可用
         * field_code4 : (套餐选择类型) 1-彩铃类;2-AD类;3-其他类
         *********************/
        try{
            String sRequestType = "";
            if("AD".equals(iSmCode)){
                sRequestType = iRequestType;
            }else if("CT".equals(iSmCode)){
            	String [] paraIn = new String[2];
            	String sqlStr = "select trim(field_value) FROM dgrpusermsgadd where id_no=:id_no and field_code = '1010' ";
            	paraIn[0] = sqlStr;    
        		paraIn[1]="id_no="+id_no;
            	
            	%>
			        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_CT" retmsg="retMsg_CT" outnum="1" >
			        	<wtc:param value="<%=paraIn[0]%>"/>
			        	<wtc:param value="<%=paraIn[1]%>"/> 
			        </wtc:service>
			        <wtc:array id="retArr_CT" scope="end"/>
			    <%
            	if(retCode_CT.equals("000000")){
		            sRequestType = ((String[][])retArr_CT)[0][0];
		        }
            	
            }
            else{
                sRequestType = " ";
            }
            String packSql = "select field_code4 from dbvipadm.scommoncode where common_code ='1001' and field_code1='"+iSmCode+"' and field_code2='"+regionCode+"' and field_code3='"+sRequestType+"' ";
			System.out.println("# packSql = "+packSql);
            %>
                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1">
                	<wtc:sql><%=packSql%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr2" scope="end"/>
            <%
            if("000000".equals(retCode2)){
                if(retArr2.length>0){
                    packArr = retArr2;
                }else{
                    packSql="select count(*) from dGrpUserMsgAdd a, dbvipadm.sCommonCode b where  a.field_value = '"+iBizCode+"'"+
	                    " and b.common_code = '1001'   and a.field_value = b.field_code1 and a.id_no = "+id_no+" and field_code='YWDM0' and field_code2='"+regionCode+"'";
					System.out.println("# packSql = "+packSql);
        		%>
            		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode22" retmsg="retMsg22" outnum="1">
                        <wtc:sql><%=packSql%></wtc:sql>
            		</wtc:pubselect>
            		<wtc:array id="result22" scope="end" />	
        		<%
        		    if("000000".equals(retCode22)){
        		        if(result22.length>0 && Integer.parseInt(result22[0][0])>0){
        		            packArr = new String[][]{{"2"}};
        		        }else{
        		            packSql="select count(*) from dGrpUserMsg a, dbvipadm.sCommonCode b where a.run_code='A' and"+
	                            " b.common_code = '1001'   and a.product_code = b.field_code1 and a.id_no = "+id_no+ "and field_code2='"+regionCode+"'";
            			%>
                			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode23" retmsg="retMsg23" outnum="1">
                				<wtc:sql><%=packSql%></wtc:sql>
                			</wtc:pubselect>
                			<wtc:array id="result23" scope="end" />	
            			<%
            			    if("000000".equals(retCode23)){
            			        if(result23.length>0 && Integer.parseInt(result23[0][0])>0){
            			            packArr = new String[][]{{"2"}};
            			        }else{
            			            packArr = new String[][]{{""}};
            			        }
                			}else{
                            %>
                                <script type=text/javascript>
                                    rdShowMessageDialog("取套餐信息失败！<br>错误代码：<%=retCode23%>,错误信息：<%=retMsg23%>",0);
                                    window.location.href="fg221.jsp";
                                </script>
                            <%
            			    }
        		        }
        		    }else{
                    %>
                        <script type=text/javascript>
                            rdShowMessageDialog("取套餐信息失败！<br>错误代码：<%=retCode22%>,错误信息：<%=retMsg22%>",0);
                            window.location.href="fg221.jsp";
                        </script>
                    <%
        		    }
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取套餐信息失败！<br>错误代码：<%=retCode2%>,错误信息：<%=retMsg2%>",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
            }
        }catch(Exception e){
            e.printStackTrace();
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取套餐信息失败！",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
        }
        
        /* vp时,查询综合v网信息 */
        if("vp".equals(iSmCode)){
            /* modify by qidp @ 2009-11-11
            String zhwwSql = "select trim(field_value) from dgrpusermsgadd where id_no=(select group_id from dvpmngrpmsg where group_no = '" + iUnitId+ "') and field_code='ZHWW0'";
            */
            String zhwwSql = "select trim(field_value) from dgrpusermsgadd where id_no='"+id_no+"' and field_code='ZHWW0'";
            System.out.println("# zhwwSql = "+zhwwSql);
            %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="zhwwCode" retmsg="zhwwMsg"  outnum="1">
                <wtc:sql><%=zhwwSql%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="zhwwArr" scope="end"/>
            <%
            if("000000".equals(zhwwCode)){
                if(zhwwArr.length>0){
                    zhwwFlag = zhwwArr[0][0];
                }else{
                    zhwwFlag = "";
                }
                System.out.println("# return from f7983_1.jsp -> zhwwFlag = "+zhwwFlag);
            }else{
            %>
		        <script type=text/javascript>
		            rdShowMessageDialog("查询综合v网信息失败！",0);
		            window.location.href="fg221.jsp";
		        </script>
		    <%
            }
            
            String  insql = "select to_char(last_day(sysdate)+1,'YYYY-MM-DD')  from  dual";
            %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg61" outnum="1">
                <wtc:sql><%=insql%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="result6" scope="end" />
            <%
            if("000000".equals(retCode6) && result6.length>0){
                dateStr2 = result6[0][0];
            }else{
                dateStr2 = "";
            }
            /*chendx 20100727 添加vp成员增加时判断是否为安利集团*/
            String acrSql = "SELECT COUNT(*) FROM dacrossvpmnrelation WHERE group_no = '"+iServiceNo+"' AND acr_group_no = '6002002500'";
            System.out.println("acrSql = "+acrSql);
        		%>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="acrCode" retmsg="acrMsg" outnum="1">
                <wtc:sql><%=acrSql%></wtc:sql>
            </wtc:pubselect>
            <wtc:array id="acrCount" scope="end" />
            <%
            if( "000000".equals(acrCode) && Integer.parseInt(acrCount[0][0])>0 ){
                 arcFlag = "1";
            }else{
                 arcFlag = "0";
            }
            /*20100727 end*/
        }
    }else{
        
    }
    
    /* 组织动态展示数据 */
    String sqlStr = "";
    if("2".equals(nextFlag)){
        iUserType = iSmCode;
        System.out.println("#  iUserType = "+iUserType);
        /* 加判断，如果是1 用原有逻辑，如果是4 用新逻辑 ， 否则什么都不做 */
        String levelFlagSql = "SELECT level_flag FROM sbusitypesmcode WHERE sm_code = '" + iSmCode + "'";
        String levelFlag = "";
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" 
					 routerValue="<%=regionCode%>"  retcode="levelFlagCode" retmsg="levelFlagMsg" outnum="1">
            <wtc:sql><%=levelFlagSql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="levelFlagRet" scope="end" />
<%
				if("000000".equals(levelFlagCode)){
					if(levelFlagRet != null && levelFlagRet.length > 0){
						levelFlag = levelFlagRet[0][0];
					}
				}
				System.out.println("======= levelFlag ==" + levelFlag);
				if("1".equals(levelFlag)){
	        sqlStr = "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length, "
	            +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,b.field_defvalue "
	            +" from sUserFieldCode a,sUserTypeFieldRela b,sUserTypeGroup c "
	            +" where a.busi_type = b.busi_type "
	            +" and a.field_code=b.field_code "
	            +" and b.user_type= '" + iUserType + "' " 
	            +" and a.busi_type = c.busi_type "
	            +" and b.user_type = c.user_type  "
	            +" and b.field_grp_no = c.field_grp_no " 
	            +" order by b.field_grp_no,b.field_order";
        }else {
        	/* 先取产品的业务小类，用于显示成员属性 */
        	String subClassSql = "SELECT field_value "
														+" FROM dgrpusermsgadd "
														+" WHERE field_code = '1010'"
														+" AND id_no = " + id_no;
				  System.out.println("!@@@@@@@@@@@  " + subClassSql);
					String subClassVal = "";
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" 
					 routerValue="<%=regionCode%>"  retcode="subClassCode" retmsg="subClassMsg" outnum="1">
            <wtc:sql><%=subClassSql%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="subClassRet" scope="end" />
<%
	        if("000000".equals(subClassCode)){
						if(subClassRet != null && subClassRet.length > 0){
							subClassVal = subClassRet[0][0];
						}
					}
					if("4".equals(levelFlag)||"CT".equals(iSmCode)){
					/* 拼接新的sql语句 */
					sqlStr = "select a.param_code,a.param_name,'11',a.param_type,a.param_length,"
						+" c.param_group,d.field_grp_name,d.max_rows,d.min_rows,c.null_able,c.default_value"
						+" FROM sbizparamcode a,sbizparamset b,sbizparamdetail c,sUserTypeGroup d"
						+" WHERE a.param_code = c.param_code "
						+" AND b.param_set =c.param_set"
						+" AND b.srv_code = trim(d.user_type)"
						+" AND nvl(trim(c.param_group),'0') = to_char(d.field_grp_no)"
						+" AND b.srv_code = '" + subClassVal +"'"
						+" AND c.op_type = 'm01'"
						+" order by c.param_group,c.param_order";
        }
    	else	
    		{
    		sqlStr = "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length, "
	            +" b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info,b.field_defvalue "
	            +" from sUserFieldCode a,sUserTypeFieldRela b,sUserTypeGroup c "
	            +" where a.busi_type = b.busi_type "
	            +" and a.field_code=b.field_code "
	            +" and b.user_type= '" + subClassVal + "' " 
	            +" and a.busi_type = c.busi_type "
	            +" and b.user_type = c.user_type  "
	            +" and b.field_grp_no = c.field_grp_no " 
	            +" order by b.field_grp_no,b.field_order";
    		}
        }
        System.out.println("# 动态展示SQL -> "+sqlStr);
        try{
            %>
                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4"  outnum="11">
                	<wtc:sql><%=sqlStr%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr4" scope="end"/>
            <%
            
            String test[][] = retArr4;
    
            System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
            for(int outer=0 ; test != null && outer< test.length; outer++)
            {
                    for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                    {
                            System.out.print(" | "+test[outer][inner]);
                    }
                    System.out.println(" | ");
            }
            if(retCode4.equals("000000")){
               // resultList = retArr4;
            }else{
                %>
    		        <script type=text/javascript>
    		            rdShowMessageDialog("错误代码：<%=retCode4%> <br/>错误信息：<%=retMsg4%>",0);
    		            window.location.href="fg221.jsp";
    		        </script>
    		    <%
            }
    		resultListLength=resultList.length;
    		if(resultListLength>0){
    		    listShow="";
    		}
		}catch(Exception e){
		    e.printStackTrace();
		    %>
		        <script type=text/javascript>
		            rdShowMessageDialog("获取成员属性信息失败！",0);
		            window.location.href="fg221.jsp";
		        </script>
		    <%
		}
    }
    
        /*********************
         * 选择是否允许批量或者单个号码操作
         * field_code3 : 0-单个号码 1-批量号码\文件录入 2-VPMN类 3-批量号码
         *********************/
         //wanghao 从前面copy过来
        String phoneType = "";
		String sRequestType = "";
        if("AD".equals(iSmCode)||"ML".equals(iSmCode)||"MA".equals(iSmCode)){
            sRequestType = iRequestType;
        }else{
            sRequestType = " ";
        }
        try{
            String phoneSql = "select field_code3 from dbvipadm.scommoncode where common_code = '1003' and field_code1 = '"+iSmCode+"' and field_code2 = '"+sRequestType+"'"; 
            System.out.println("# phoneSql = "+phoneSql);
            %>
                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6"  outnum="1">
                	<wtc:sql><%=phoneSql%></wtc:sql>
                </wtc:pubselect>
                <wtc:array id="retArr6" scope="end"/>
            <%
            if("000000".equals(retCode6)){
                if(retArr6.length>0){
                    phoneType = retArr6[0][0];
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取套餐信息失败！<br>错误代码："+retCode6+"错误信息："+retMsg6,0);
                    window.location.href="fg221.jsp";
                </script>
            <%
            }
        }catch(Exception e){
            e.printStackTrace();
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("取套餐信息失败！",0);
                    window.location.href="fg221.jsp";
                </script>
            <%
        }
        
    String addModeFlag = "";
    
    /* requestListShow:控制操作类型的展示 */
    String requestListShow = "none";
    if("AD".equals(iSmCode) || "ML".equals(iSmCode) || "MA".equals(iSmCode)){
        requestListShow = "";
    }else{
        requestListShow = "none";
    }
    System.out.println("### requestListShow = "+requestListShow);
    
    /* payListShow:控制付费信息的展示 */
    String payListShow = "none";
    String payValue = "";
    if(payArr.length>0 && "1".equals(payArr[0][0])){
        payListShow = "";
        payValue = payArr[0][1];
        addModeFlag = "10";
    }else{
        payListShow = "none";
    }
    System.out.println("### payListShow = "+payListShow);
	
	/* packListShow:控制套餐信息的展示 */
	String packListShow = "none";
	String packListShowCR = "none";
	String packValue = "";
	String packFlag = "";
    if(packArr.length>0 && !"".equals(packArr[0][0]) && !"03".equals(iRequestType) && !"04".equals(iRequestType)){
        if("CR".equals(iSmCode)){
            packListShow = "none";
            packListShowCR = "";
        }else{
            packListShow = "";
            packListShowCR = "none";
        }
        packFlag = "";
        packValue = packArr[0][0];
        addModeFlag = "9";
    }else{
        packFlag = "none";
        packListShow = "none";
        packListShowCR = "none";
    }
    System.out.println("### packListShow = "+packListShow);
    
    if(payListShow == "" && packFlag == ""){
        addModeFlag = "11";
    }
    
    if(payListShow == "none" && packFlag == "none"){
        addModeFlag = "0";
    }
    
	String phoneListShow = "none";
    if("1".equals(phoneType)){
        phoneListShow = "";
    }else{
        phoneListShow = "none";
    }
    System.out.println("### phoneListShow = "+phoneListShow);
	
    /* 取操作流水 */
    String sysAccept = "";
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    <%
    sysAccept = seq;
    System.out.println("#           - 流水："+sysAccept);
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>集团成员增加</title>
<script type=text/javascript>
    var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头
    var oprType_Add = "a";
    
    onload=function(){
        changeOthers();
        <% if("2".equals(nextFlag)){ %>
            /*add by diling*/
            $("#custManagerInfo").css("display","");
            $("#unitTypeInfo").css("display","");
            /*end */
            $("#iccid").attr("readOnly",true);
            $("#iccid").addClass("InputGrey");
            $("#cust_id").attr("readOnly",true);
            $("#cust_id").addClass("InputGrey");
            $("#unit_id").attr("readOnly",true);
            $("#unit_id").addClass("InputGrey");
            $("#service_no").attr("readOnly",true);
            $("#service_no").addClass("InputGrey");
            $("#product_id").attr("readOnly",true);
            $("#product_id").addClass("InputGrey");
            $("#product_name").attr("readOnly",true);
            $("#product_name").addClass("InputGrey");
            $("#account_id").attr("readOnly",true);
            $("#account_id").addClass("InputGrey");
            $("#sm_code").attr("readOnly",true);
            $("#sm_code").addClass("InputGrey");
            $("#sm_name").attr("readOnly",true);
            $("#sm_name").addClass("InputGrey");
            $("#product_pwd").attr("readOnly",true);
            $("#product_pwd").addClass("InputGrey");
            $("#belong_code").find("option:not(:selected)").remove();
            
            if("<%=iSmCode%>" == "AD" || "<%=iSmCode%>" == "ML" || "<%=iSmCode%>" == "MA"){
                //选择黑名单类和白名单类时显示期望日期
            	var vRequestType = "<%=iRequestType%>";
            	document.all.request_type.value=vRequestType;
            	$("#request_type").find("option:not(:selected)").remove();
            	if(vRequestType == "03" || vRequestType == "04"){
            	    document.all.expTime.style.display="";
            	}else{
            	    document.all.expTime.style.display="none";
            	}
            }
            
            if($("#sm_code").val() == "ap" || $("#sm_code").val() == "ZH"){//diling add 2012/7/23 15:12 增加智慧城管对静态ip地址的验证，如为IP类型为动态，则不需要输入ip地址
              $("#F81008").change(function(){
                if(document.all.F81008.value == "1"){
                  $("#F81002").attr("readOnly",true);
                  $("#F81002").val("");
                }else{
                  $("#F81002").removeAttr("readOnly");
                }  
              }); 
            }
        <% } %>
        
        if("<%=iSmCode%>" == "vp"){
            /* vp时,查询综合v网信息 */
            if("<%=zhwwFlag%>" == ""){
                //document.all.F80023.value="0";
                document.all.ZHWW.value="0";
            }
            else if("<%=zhwwFlag%>" == "vm"){
                //document.all.F80023.value="1";
                document.all.ZHWW.value="1";
            }
            else if("<%=zhwwFlag%>" == "vt"){
                //document.all.F80023.value="2";
                document.all.ZHWW.value="2";
            }
            else{
                //document.all.F80023.value="0";
                document.all.ZHWW.value="0";
            }
            
            //$("#F80023").attr("disabled",true);
            //$("#F80023").find("option:not(:selected)").remove();
            
            if($("#F80023").val() == "0"){
                //document.all.phone_type.value="1";
                //$("#phone_type").find("option:selected").remove(); 
                $("#phone_type").find("option[value='1']").remove(); 
            }
            
            /* vp时,下月套餐资费生效日期赋值为下月第一天 */
            //document.all.F80006.value="<%=dateStr2%>";
        }
        
<%
        if ("j1".equals(iSmCode)) {
%>
            chkMulti();
<%
    	} else if("1".equals(phoneType)){
%>
            $("#single_type").css("display","none");
            document.all.input_type[1].checked = true;
            chkMulti();
<%
		} else if ("3".equals(phoneType)) {
%>
            document.all.input_type[1].checked = true;
            chkMulti();
<%
		}
%>
    }
    
    /* 查询集团用户信息 */
    function getCustInfo(){
        var pageTitle = "集团客户选择";
        var fieldName = "证件号码|集团客户ID|集团客户名称|集团产品ID|集团号|产品代码|产品名称|集团编号|产品付费帐户|品牌代码|品牌名称|包月标识|操作类型|最大终端数量|已增加终端数量|可用数量|limitcount|集团类别|集团客户经理姓名|集团客户经理工号|目前占比公式|上限占比公式|可添加智能网成员数|地市名称|";//update diling@2012/6/12
        var sqlStr = "";
        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "24|0|1|7|4|5|8|9|3|11|2|6|10|12|13|14|15|16|17|18|19|20|21|22|23|"; //update diling

        var retToField = "iccid|cust_id|unit_id|service_no|product_id|account_id|sm_code|id_no|month_flag|grp_name|product_name|sm_name|request_type_flag|max_term_num_tmp|add_term_num_tmp|use_term_num_tmp|limitcount|unitTypeHiden|custManagerNameHiden|custManagerNoHiden|preProportionHiden|highestLimitHiden|addVpMemberHiden|regionNameHiden|";//update diling@2012/6/12 
        /**add by liwd 20081127,group_id来自dcustDoc的group_id end **/

        if(document.frm.iccid.value == "" && document.frm.cust_id.value == "" && document.frm.unit_id.value == "" && document.frm.service_no.value == "")
        {
            rdShowMessageDialog("请输入证件号码、客户ID、集团ID或集团号进行查询！");
            document.frm.iccid.focus();
            return false;
        }
        
        if((document.frm.cust_id.value) != "" && forNonNegInt(frm.cust_id) == false)
        {
            frm.cust_id.value = "";
            rdShowMessageDialog("客户ID必须是数字！");
            return false;
        }
        
        if((document.frm.unit_id.value) != "" && forNonNegInt(frm.unit_id) == false)
        {
            frm.unit_id.value = "";
            rdShowMessageDialog("集团ID必须是数字！");
            return false;
        }
        
        PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    }
    
    function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "<%=request.getContextPath()%>/npage/s7983/fpubcust_sel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType+"&iccid=" + document.frm.iccid.value;
        path = path + "&cust_id=" + document.frm.cust_id.value;
        path = path + "&unit_id=" + document.frm.unit_id.value;
        path = path + "&service_no=" + document.frm.service_no.value;
        path = path + "&regionCode=" + document.frm.iRegionCode.value;
        path = path + "&op_code=" + document.frm.op_code.value;
        retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    	return true;
    }
    
    function getvaluecust(retInfo){
        var retToField = "iccid|cust_id|unit_id|service_no|product_id|account_id|sm_code|id_no|month_flag|grp_name|product_name|sm_name|request_type_flag|max_term_num_tmp|add_term_num_tmp|use_term_num_tmp|limitcount|unitTypeHiden|custManagerNameHiden|custManagerNoHiden|preProportionHiden|highestLimitHiden|addVpMemberHiden|regionNameHiden|"; //diling add@2012/6/12
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
        var vSmCode = $("#sm_code").val();
        if(vSmCode == "AD" || vSmCode == "ML" || vSmCode == "MA"){
            document.all.requestTab1.style.display="";
            document.all.requestTab2.style.display="";
            document.all.request_type.value=$("#request_type_flag").val();
            $("#request_type").find("option:not(:selected)").remove();
        }else{
            document.all.requestTab1.style.display="none";
            document.all.requestTab2.style.display="none";
        }
        
        $("#iccid").attr("readOnly",true);
        $("#cust_id").attr("readOnly",true);
        $("#unit_id").attr("readOnly",true);
        $("#service_no").attr("readOnly",true);
    }
    
    /* 校验集团产品密码 */
    function chkProductPwd(){
        var cust_id = document.all.cust_id.value;
        var Pwd1 = document.all.product_pwd.value;
        var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
        checkPwd_Packet.data.add("retType","checkPwd");
    	checkPwd_Packet.data.add("cust_id",cust_id);
    	checkPwd_Packet.data.add("Pwd1",Pwd1);
    	core.ajax.sendPacket(checkPwd_Packet);
    	checkPwd_Packet = null;
    }
    
    function doProcess(packet)
    {
        var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode");
        var retMessage=packet.data.findValueByName("retMessage");

		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		var backArrMsg2=packet.data.findValueByName("backArrMsg2");
        
        self.status="";
        if(retType == "checkPwd") //集团客户密码校验
        {
            if(retCode == "000000")
            {
                var retResult = packet.data.findValueByName("retResult");
                if (retResult == "false") {
                    rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
                    frm.product_pwd.value = "";
                    frm.product_pwd.focus();
                    return false;	        	
                } else {
                    rdShowMessageDialog("客户密码校验成功！",2);
                    if(<%=nextFlag%>==1){
                        $("#next").attr("disabled",false);
                    }
                }
            }
            else
            {
                rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
                return false;
            }
        }
        else if(retType == "phoneno"){
            if( parseInt(retCode) == 0 ){
                var num = backArrMsg[0][0];
                if( parseInt(num) < 2){
                    $("#PHONENO").val("");
                    $("#ISDNNO").val("");
                    $("#USERNAME").val("");
                    $("#IDCARD").val("");
                    $("#PCOMMENT").val("");
                    rdShowMessageDialog("欠费用户(非托收用户)不能申请VPMN业务!",0);
                    document.frm.ISDNNO.focus();
                    return false;
                }
                else{
                    dynAddRow();
                }
            }else{
                $("#PHONENO").val("");
                $("#ISDNNO").val("");
                $("#USERNAME").val("");
                $("#IDCARD").val("");
                $("#PCOMMENT").val("");
                rdShowMessageDialog("错误代码："+retCode+"</br>错误信息："+retMessage+"!",0);
                return false;
            }
        }
        else if(retType == "checkPhone"){
        	
        	var retIdNo = packet.data.findValueByName("returnIdNo");//wangzn add 2011/6/8 16:19:08
        	var postCode = packet.data.findValueByName("postCode");//wangzn add 2011/6/8 16:19:08
        	var IMPI = packet.data.findValueByName("IMPI");//wangzn add 2011/6/8 16:19:08
        	var IMPUList = packet.data.findValueByName("IMPUList");//wangzn add 2011/6/8 16:19:08
        	var sCtShortNo  =packet.data.findValueByName("sCtShortNo");
			var sUserType   =packet.data.findValueByName("sUserType");
			var PortalName  =packet.data.findValueByName("PortalName");
			var PortalPass  =packet.data.findValueByName("PortalPass");
            if(parseInt(retCode) == 0){
                rdShowMessageDialog("校验成功！",2);
				$("#checkPhoneFlag").val("1");
                $("#sure").attr("disabled",false);
                if($("#F70003").val()!=undefined)
                {
	                $("#F70003").val('+86'+$("#single_phoneno").val());//wangzn add 2011/6/7 16:30:27
	                $("#F70003").val($("#F70003").val().replace("+860", "+86"));
	                $("#F70003").attr("readOnly",true);//wangzn 2011/6/7 16:31:48
            	}
            	if($("#F70001").val()!=undefined)
            	{
	                $("#F70001").val($("#single_phoneno").val());//wangzn add 2011/6/8 16:20:09
	                $("#F70001").attr("readOnly",true);//wangzn add 2011/6/8 16:20:09
            	}
            	if($("#F70027").val()!=undefined)
            	{
            		$("#F70027").val(postCode);//wangzn add 2011/6/8 16:20:09
                	$("#F70027").attr("readOnly",true);//wangzn add 2011/6/8 16:20:09
            	}
                if($("#F70028").val()!=undefined)
                {
                	 $("#F70028").val(IMPI);//wangzn add 2011/6/8 16:20:09
               		 $("#F70028").attr("readOnly",true);//wangzn add 2011/6/8 16:20:09
                }
                if( $("#F70029").val()!=undefined)
                {
	                $("#F70029").val(IMPUList);//wangzn add 2011/6/8 16:20:09
	                $("#F70029").attr("readOnly",true);//wangzn add 2011/6/8 16:20:09
				}
				if( $("#F70026").val()!=undefined)
                {
	                $("#F70026").val(sCtShortNo);
	            }
	            if( $("#F70019").val()!=undefined)
                {
	                $("#F70019").val(sUserType);
	            }
	            if( $("#F70022").val()!=undefined)
                {
	                $("#F70022").val(PortalName);
	            }
	            if( $("#F70023").val()!=undefined)
                {
	                $("#F70023").val(PortalPass);
	            }
            }else{
                //rdShowMessageDialog("错误代码："+retCode+"<br/>错误信息："+retMessage,0);
                if (rdShowConfirmDialog("错误代码"+retCode+"<br>错误信息"+retMessage +"<br>是否保存错误信息？")==1)	
        		{
        			var path="/npage/s7983/f7983_printxls.jsp?phoneNo=" + document.all.single_phoneno.value;
        			path = path + "&grpName=" + document.all.grp_name.value;
					path = path + "&returnMsg=" + retMessage;
					path = path + "&unitID=" + document.all.unit_id.value;
  					path = path + "&op_Code=" + "7983";
  					path = path + "&orgCode=" + document.all.org_code.value;
  					path = path + "&sm_name=" + document.all.sm_name.value;
  					window.open(path);
        		}		
            }
        }
        else if(retType =="phonenoMobile"){
        	if( parseInt(retCode) == 0 ){
        		document.all.mobile_phone.value=backArrMsg;
        	}
        	else{
                $("#PHONENO").val("");
                $("#ISDNNO").val("");
                $("#USERNAME").val("");
                $("#IDCARD").val("");
                $("#PCOMMENT").val("");
                rdShowMessageDialog("错误代码："+retCode+"</br>错误信息："+retMessage+"!",0);
                return false;
            }
        } else if (retType == "checkJ1Phone") {	//wanghfa添加 2010-12-3 11:08 移动总机接入BOSS系统需求
            if(parseInt(retCode) == 0){
                var num = backArrMsg[0][0];
                if(parseInt(num) < 2){
                    $("#j1PhoneNo").val("");
                    rdShowMessageDialog("欠费用户(非托收用户)不能申请VPMN业务!",0);
                    document.getElementById("j1PhoneNo").focus();
                    return;
                }
                else{
                    dynAddRow();
                }
            }else{
                rdShowMessageDialog("错误代码："+retCode+"</br>错误信息："+retMessage+"!",0);
                return false;
            }
        }
        else{
            rdShowMessageDialog("错误代码："+retCode+"错误信息："+retMessage+"",0);
            return false;
        }
    }
    
        /* 清除 */
    function resetJsp(){
        //document.all.frm.reset();
        window.location='fg221.jsp';
    }
    
    /* 下一步 */
    function nextStep(){
        if(!check(document.all.frm)){return false}
        
        var vSmCode = $("#sm_code").val();
        if(vSmCode == "AD" || vSmCode == "ML" || vSmCode == "MA"){
            if($("#request_type").val().trim() == ''){
                rdShowMessageDialog("请选择操作类型！",0);
                return false;
            }
        }
        
        frm.action="fg221.jsp?action=next";
        frm.method="post";
        frm.submit();
    }
    
    /* 上一步 */
    function previouStep(){
        frm.action="fg221.jsp";
    	frm.method="post";
    	frm.submit();
    }
    
    /* 点选单个输入时 */
    function chkSingle(){
        $("#inputType").val("single");
        $("#sure").attr("disabled",true);
        $("#single").css("display","block");
        $("#multi").css("display","none");
        $("#file").css("display","none");
        <%
        if ("ap".equals(iSmCode)) {
        	%>
					//document.getElementById("F81002").value = "";
					document.getElementById("F81002").disabled = false;
					document.all.sure.disabled = true;
					<%
        }
        %>
    }
    
    /* 点选批量输入时 */
    function chkMulti(){
        $("#inputType").val("multi");
        $("#sure").attr("disabled",false);
        $("#single").css("display","none");
        $("#multi").css("display","block");
        $("#file").css("display","none");
    }
    
    /* 点选录入文件时 */
    function chkFile(){
        $("#inputType").val("file");
        $("#sure").attr("disabled",false);
        $("#single").css("display","none");
        $("#multi").css("display","none");
        $("#file").css("display","block");
        <%
        if ("ap".equals(iSmCode)) {
        	%>
					//document.getElementById("F81002").value = "";
					document.getElementById("F81002").disabled = true;
					<%
        }
        %>
    }
    
    /* 点选vpmn号码输入时 */
    function chkVpmnMulti(){
        $("#vpmnInputType").val("vpmnMulti");
        $("#vpmnMulti").css("display","block");
        $("#vpmnFile").css("display","none");
    }
    
    /* 点选vpmn文件录入时 */
    function chkVpmnFile(){
        $("#vpmnInputType").val("vpmnFile");
        $("#vpmnMulti").css("display","none");
        $("#vpmnFile").css("display","block");
    }
    
    /* 从txt文件录入手机号码 */
    function checkPhNo(){
        fso = new ActiveXObject("Scripting.FileSystemObject");
        var ForReading =1,f2;
        f2 = fso.OpenTextFile(document.all.PosFile.value,ForReading);
        var temps = f2.ReadAll();
        document.all.multi_phoneNo.value=temps;
        
        var phnoNoArr = temps.split("|");
        
        for(var i=0;i<phnoNoArr.length-1;i++){
            if(phnoNoArr[i].replace(/\s/g,'').length!=11){
                rdShowMessageDialog("电话号码应该为11位"+phnoNoArr[i]);
            }
            for(var j=i+1;j<phnoNoArr.length-1;j++){
                if(phnoNoArr[i].replace(/\s/g,'')==phnoNoArr[j].replace(/\s/g,'')){
                    rdShowMessageDialog("电话号码重复"+phnoNoArr[j]);
                }
            }
        }
        resetfilp();
    }
    
    function resetfilp(){
        document.getElementById("PosFile").outerHTML = document.getElementById("PosFile").outerHTML;
    }
    
    function call_ISDNNOINFO()
    {
        if(!checkElement(document.all.ISDNNO)) return false;	
        /*lilm增加对短号的校验 短号应判断必须是6开头，且第二位不能为0，位数是4-6位 */
        /*wuxy增加 网外短号可以是7开头 ，位数为3-8位**/
        if(!checkElement(document.all.PHONENO)) return false;
        //wuxy add 20100330 
        check_nomobile_phone();
        var mobile_flag=document.all.mobile_phone.value;
        var shortNo = document.frm.PHONENO.value;
        if(mobile_flag.substr(0,1)==0)
        {
        	if(shortNo.substr(0,1)==7)
        	{
        		if(shortNo.length<3||shortNo.length>8)
        		{
        			rdShowMessageDialog("7开头的短号码位数必须为3-8位!");
        		    return false;
        		}
        	}
        	else
        	{
        		if(shortNo.substr(0,1) !=6)
        		{
        		    rdShowMessageDialog("短号码必须是6或7开头!");
        		    return false;
        		}
        		if(shortNo.length<4||shortNo.length>6)
        		{
        			rdShowMessageDialog("6开头的短号码位数必须为4-6位!");
        		    return false;
        		}
        		
        		if(shortNo.substr(1,1) ==0)
        		{
        		    rdShowMessageDialog("短号码第二位不能为0!");
        		    return false;
        		}  
        	}
        }
        else
        {
        	if(shortNo.length<4||shortNo.length>6)
        	{
        		rdShowMessageDialog("短号码位数必须为4-6位!");
        	    return false;
        	}
        	if(shortNo.substr(0,1) !=6)
        	{
        	    rdShowMessageDialog("短号码必须是6开头!");
        	    return false;
        	}
        	if(shortNo.substr(1,1) ==0)
        	{
        	    rdShowMessageDialog("短号码第二位不能为0!");
        	    return false;
        	}  
        	
        }
       
        
        			        		       			
        var path = "f7983_no_infor.jsp";
        path = path + "?loginNo=" + document.frm.work_no.value + "&phoneNo=" + document.frm.ISDNNO.value;
        path = path + "&opCode=" + document.frm.op_code.value + "&orgCode=" + document.frm.org_code.value;
        path = path + "&ZHWW=" + document.frm.ZHWW.value;
        path = path + "&phone_type=" + document.frm.phone_type.value;
        var retInfo = window.showModalDialog(path);
        if(typeof(retInfo) == "undefined")
        {
            document.frm.USERNAME.value = "";
            document.frm.IDCARD.value = "";			           
        }else{ 
            if(parseInt(document.frm.ZHWW.value)>=1){ 
                document.frm.USERNAME.value = oneTokSelf(retInfo,"|",1);
                document.frm.IDCARD.value = oneTokSelf(retInfo,"|",2);
                dynAddRow();
            }else{
                document.frm.USERNAME.value = oneTokSelf(retInfo,"|",1);
                document.frm.IDCARD.value = oneTokSelf(retInfo,"|",2);
                var sSmCode = oneTokSelf(retInfo,"|",3);
                if( sSmCode == "cb" )
                {
                    rdShowConfirmDialog("长白行用户不能申请VPMN业务!",0);    
                    document.all.ISDNNO.focus();
                    return false;
                }
                var run_code = oneTokSelf(retInfo,"|",6);
                if( run_code != "A" && run_code != "B" && run_code != "C" && 
                    run_code != "D" && run_code != "E" && run_code != "F" && 
                    run_code != "G" && run_code != "H" && run_code != "I" && 
                    run_code != "K" && run_code != "L" && run_code != "M" &&
                    run_code != "O") //diling update@2011/10/24 增加一个O状态
                {
                    rdShowConfirmDialog("非正常状态用户[" + run_code + "]，不能办理VPMN业务!",0);	
                    document.all.ISDNNO.focus();
                    return false;
                }
                var sTotalFee = oneTokSelf(retInfo,"|",4);
                if ( parseInt(sTotalFee) > 0 )
                {
                    check_phone();
                }else{
                    dynAddRow();
                }
            } 			           
        }
        
        selAttr();
    }
    // 查出 当前默认属性
    function selAttr(){
       var cust_id = document.all.cust_id.value;
       var myPacket = new AJAXPacket("selAttr.jsp","正在查询套餐名称，请稍候......");	
       myPacket.data.add("cust_id",cust_id);
       core.ajax.sendPacket(myPacket,doMsg);
       myPacket = null;
    }
    function doMsg(packet){
         var retCode = packet.data.findValueByName("retCode");
         var retMessage = packet.data.findValueByName("retMessage");
         var retResult = packet.data.findValueByName("result");
         if(retCode == "000000")
         {
         	$("#attr").val(retResult);
         }else{
            rdShowMessageDialog("错误代码："+retCode+"  错误信息："+retMessage+"!");	
            return;
         }
      }
    //wanghfa添加方法 2010-12-2 17:42 移动总机接入BOSS系统
	function j1AddPhoneNo() {
		if (!checkElement(document.getElementById("j1No"))) {
			rdShowMessageDialog("分机号码为4-6位数字，请重新填写！", 1);
			document.getElementById("j1No").focus();
			return false;
		} else if (!checkElement(document.getElementById("j1PhoneNo"))) {
			document.getElementById("j1PhoneNo").focus();
			return false;
		} else if (!checkElement(document.getElementById("j1UserName"))) {
			document.getElementById("j1UserName").focus();
			return false;
		} else if (!checkElement(document.getElementById("j1ShortName"))) {
			document.getElementById("j1ShortName").focus();
			return false;
		} else {
		  	var patrn=/^[a-z]$/;
		  	if(document.getElementById("j1ShortName").value.trim().substring(0,1).search(patrn) == -1){
				rdShowMessageDialog("成员姓名拼音首字母必须以小写字母开始！");
				document.getElementById("j1No").focus();
				return;
			}
		}
		
		var j1Provider = document.getElementById("j1Provider").value;
		if (j1Provider == "0") {
		  	var patrn=/^[6][1-9]\d{2,4}$/;
		  	if(document.getElementById("j1No").value.search(patrn) == -1){
				rdShowMessageDialog("移动运营商分机号码第一位必须为6；第二位不能为0，请重新输入！");
				document.getElementById("j1No").focus();
				return;
			}
		} else if (j1Provider == "1") {
		  	var patrn=/^[8]\d{3,5}$/;
		  	if(document.getElementById("j1No").value.search(patrn) == -1){
				rdShowMessageDialog("其他运营商分机号码第一位必须为8，请重新输入！");
				document.getElementById("j1No").focus();
				return;
			}
		}
		
		//if (j1Provider == "0") {
			var path = "f7983_no_infor.jsp";
			path = path + "?loginNo=" + document.frm.work_no.value + "&phoneNo=" + document.getElementById("j1PhoneNo").value;
			path = path + "&opCode=" + document.frm.op_code.value + "&orgCode=" + document.frm.org_code.value;
			path = path + "&ZHWW=1&j1=1";
			path = path + "&phone_type=" + j1Provider;
			
			var retInfo = window.showModalDialog(path);
			
			if(typeof(retInfo) == "undefined") {
				return;
			} else if (retInfo == "-4") {
				rdShowMessageDialog("运营商错误，此号码为移动运营商号码！", 0);
				return;
			} else {
				dynAddRow();
			}
		//} else {
		//	dynAddRow();
		//}
	}
	
    function check_phone()
    {
        var sqlBuf="";
        var myPacket = new AJAXPacket("CallCommONESQL.jsp","正在验证用户号码，请稍候......");
        if(!checkElement(document.frm.PHONENO)) return false;
        if(!checkElement(document.all.ISDNNO)) return false;
        sqlBuf="select count(*) from dcustmsg a, dconusermsg b where a.id_no = b.id_no and phone_no ='"+document.frm.ISDNNO.value +"'";
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("sqlBuf",sqlBuf);
        myPacket.data.add("recv_number",1);
        core.ajax.sendPacket(myPacket);
        myPacket=null;			
    }
	
	//wanghfa添加 2010-12-3 11:14 移动总机接入BOSS系统需求
    function j1CheckPhone() {
		var sqlBuf="";
		var myPacket = new AJAXPacket("CallCommONESQL.jsp","正在验证用户号码，请稍候......");
		sqlBuf = "select count(*) from dcustmsg a, dconusermsg b where a.id_no = b.id_no and phone_no ='" + document.getElementById("j1PhoneNo").value +"'";
		myPacket.data.add("verifyType", "checkJ1Phone");
		myPacket.data.add("sqlBuf", sqlBuf);
		myPacket.data.add("recv_number", 1);
		core.ajax.sendPacket(myPacket);
		myPacket=null;			
    }
	
        function check_nomobile_phone()
    {
        var sqlBuf="";
        var myPacket = new AJAXPacket("CallCommONESQL.jsp","正在验证用户号码，请稍候......");
        if(!checkElement(document.frm.PHONENO)) return false;
        if(!checkElement(document.all.ISDNNO)) return false;
        sqlBuf="select count(*) from dbresadm.sNoType where trim(no)=substr('"+document.frm.ISDNNO.value +"',1,3) ";
        myPacket.data.add("verifyType","phonenoMobile");
        myPacket.data.add("sqlBuf",sqlBuf);
        myPacket.data.add("recv_number",1);
        core.ajax.sendPacket(myPacket);
        myPacket=null;			
    }
    
    function oneTokSelf(str,tok,loc)
    {
        var temStr=str;
        
        var temLoc;
        var temLen;
        for(ii=0;ii<loc-1;ii++)
        {
            temLen=temStr.length;
            temLoc=temStr.indexOf(tok);
            temStr=temStr.substring(temLoc+1,temLen);
        }
        if(temStr.indexOf(tok)==-1)
            return temStr;
        else
            return temStr.substring(0,temStr.indexOf(tok));
    }
    
    //wanghfa修改 2010-12-3 13:51 移动总机接入BOSS系统需求
    function dynAddRow() {
    	var smCode = document.getElementById("sm_code").value;
    	if (smCode == "j1") {
    		var j1No = document.getElementById("j1No").value;
    		var j1PhoneNo = document.getElementById("j1PhoneNo").value;
    		var j1UserName = document.getElementById("j1UserName").value;
    		var j1ShortName = document.getElementById("j1ShortName").value;
    		
			if (parseInt(document.all.addRecordNum.value) > 4 ) {
				rdShowMessageDialog("最多只能操作5个号码 !!");
				return;
			} else if(verifyUnique(j1No, j1PhoneNo) == false) {
				rdShowMessageDialog("已经有一条”分机号码“或者”真实号码“相同的数据!!");
				return;
			}
			
			var tr1 = dyntb.insertRow();	//注意：插入的必须与下面的在一起,否则造成空行.yl.
			tr1.id="tr"+dynTbIndex;
			tr1.insertCell().innerHTML = '<div align="center"><input id=R0 type=checkBox size=4 value="删除" onClick="dynDelRow()" ></input></div>';
			tr1.insertCell().innerHTML = '<div><input id=R1 type=text size=10 value="' + j1No + '" class="InputGrey" readonly></input></div>';
			tr1.insertCell().innerHTML = '<div><input id=R2 type=text value="'+ j1PhoneNo+'"  class="InputGrey" readonly></input></div>';
			tr1.insertCell().innerHTML = '<div><input id=R3 type=text value="'+ j1UserName+'" maxlength=10 class="InputGrey"  readonly ></input></div>';
			tr1.insertCell().innerHTML = '<div><input id=R5 type=text value="'+ j1ShortName+'" class="InputGrey"  readonly></input></div>';
			//tr1.insertCell().innerHTML = '<div><input id=R6 type=text size=8 value=""  class="InputGrey" readonly ></input></div>';
			dynTbIndex++;
			document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    	} else {
	        var phone_no="";
	        var isdn_no="";
	        var user_name="";
	        var id_card="";
	        var note="";
	        var add_no="";
	        var tmpStr="";
	        var flag=false;
	        
            phone_no = document.all.PHONENO.value;
            isdn_no = document.all.ISDNNO.value;
            
            if(!checkElement(document.all.PHONENO)) return false;
            if(!checkElement(document.all.ISDNNO)) return false;
	        
	        user_name = document.all.USERNAME.value;
	        id_card = document.all.IDCARD.value;
	        note = document.all.PCOMMENT.value;
	        queryAddAllRow(0,phone_no,isdn_no,user_name,id_card,note);
    	}
    }

    function queryAddAllRow(add_type,phone_no,isdn_no,user_name,id_card,note)
    {
        var tr1="";
        var i=0;
        var tmp_flag=false;
        
        var exec_status="";
        if ( parseInt(document.all.addRecordNum.value) > 4 )
        {
            rdShowMessageDialog("最多只能操作5个号码 !!");
            return false;
        }
        /*begin diling add for 如果为vp用户，则增加成员不能超过可添加成员数量@2012/6/12*/
        var smCode_vpFlag = document.getElementById("sm_code").value;
        if(smCode_vpFlag=="vp"){
          var v_addVpMember = document.getElementById("addVpMember").value; //可添加vpmn成员数
          var v_iRegionNameHiden = $("#iRegionNameHiden").val();
          if ( (Number(document.all.addRecordNum.value)+1 )> Number(v_addVpMember) ){
          rdShowMessageDialog(""+v_iRegionNameHiden+"公司的智能网总容量已达到上限，不能再新增成员！");
          return false;
          }
        }
        /*begin diling add @2012/6/12*/
        tmp_flag = verifyUnique(phone_no,isdn_no);
        if(tmp_flag == false)
        {
            rdShowMessageDialog("已经有一条'短号'或者'真实号码'相同的数据!!");
            return false;
        }
        tr1=dyntb.insertRow();    //注意：插入的必须与下面的在一起,否则造成空行.yl.
        tr1.id="tr"+dynTbIndex;
        tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="删除" onClick="dynDelRow()" ></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   size=10 value="'+ phone_no+'" class="InputGrey" readonly></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text   value="'+ isdn_no+'"  class="InputGrey" readonly></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text   value="'+ user_name+'" maxlength=10 class="InputGrey"  readonly ></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R4    type=text   value="'+ id_card+'" class="InputGrey"  readonly></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R5    type=text   value="'+ note+'"   class="InputGrey" readonly></input></div>';
        tr1.insertCell().innerHTML = '<div align="center"><input id=R6    type=text  size=8 value="'+ exec_status+'"  class="InputGrey" readonly ></input></div>';
        dynTbIndex++;
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }

    function dynDelRow()
    {
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
            if(document.all.R0[a].checked == true)
            {
                document.all.dyntb.deleteRow(a+1);
                break;
            }
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }


    function dyn_deleteAll()
    {
    //清除增加表中的数据
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
            document.all.dyntb.deleteRow(a+1);
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }

    function verifyUnique(phone_no,isdn_no)
    {
        var tmp_phoneNo="";
        var tmp_isdnNo="";
        var op_type = oprType_Add;
        
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
            tmp_phoneNo = document.all.R1[a].value;
            tmp_isdnNo = document.all.R2[a].value;
            
            if( op_type == oprType_Add)
            {
                if( (phone_no.trim() == tmp_phoneNo.trim()) || (isdn_no.trim()== tmp_isdnNo.trim())){
                    return false;
                }
            }else{
                if( (isdn_no.trim() == tmp_isdnNo.trim())){
                    return false;
                }
            }
        }
        return true;
    }
    
    function changeOthers(){
        if($("#sm_code").val() == "CR"){
            var vPayFlag = $("#pay_flag").val();
            var vMebMonthFlag = $("#mebMonthFlag").val();
            
            if(vPayFlag == "1" && vMebMonthFlag == "N"){
                document.all.tbs2.style.display = "";
                document.all.tbs3.style.display = "";
            }else{
                document.all.tbs2.style.display = "none";
                document.all.tbs3.style.display = "none";
            }
        }
    }
    
    function changeMatureFlag(){
        var iMatureFlag = $("#matureFlag").val();
        if(iMatureFlag == "Y"){
            $("#matureProdCodeQuery").attr("disabled",false);
        }else{
            $("#matureProdCodeQuery").attr("disabled",true);
        }
    }
    
    function getmatureProdCodeQuery()
    {  
     	var pageTitle = "保年到期转包月产品选择";
        var fieldName = "产品属性代码|产品属性|";    
    		var sqlStr = "";
        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "2|2|3|";
        var retToField = "matureProdCode|matureProdName|";
        var product_id = document.frm.product_id.value;
        //首先判断是否已经选择了集团信息
        if(document.frm.product_id.value == "")
       {
        rdShowMessageDialog("请首先选择集团信息！",0);
        return false;
       }
    	if(PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    }
 
    function PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
    {   
        var vGrpProdCode = $("#product_id").val();
        var vOpType = $("#request_type").val();
        var vIdNo = $("#id_no").val();
        var vSmCode = $("#sm_code").val();
        var vRegionCode = $("#iRegionCode").val();
        var vOpCode = $("#op_code").val();
        var vBizCode = $("#iBizCode").val();
        var vPayFlag = "";
        if(vSmCode == "CR"){
            vPayFlag = $("#pay_flag").val();
        }else{
            vPayFlag = "";
        }
        
        var path = "/npage/s7983/fpubmatureProdCode_sel.jsp"; 
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;
        path = path + "&groupFlag=Y";
        path = path + "&product_id=" + document.all.product_id.value;  
        path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  
        path = path + "&payType=" +document.all.pay_flag.value; 
        path = path + "&id_no=" + vIdNo;
        path = path + "&smCode=" + vSmCode;
        path = path + "&regionCode=" + vRegionCode;
        path = path + "&opCode=" + vOpCode;
        path = path + "&bizCode=" + vBizCode;
        path = path + "&payFlag=" + vPayFlag;
        path = path + "&grpProdCode=" + vGrpProdCode;
        path = path + "&opType="+vOpType;
        retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    	return true;	
    }

    function getmatureProd(retInfo)
    { 
    	var retToField = "matureProdCode|matureProdName|";
    	if(retInfo ==undefined)      
    	{
    		//ChgCurrStep("custQuery");
    		return false;
    	}
    	
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
    }
    
    function getAdditiveBill(){
        var vMebMonthFlag = $("#mebMonthFlag").val();
        var vGrpProdCode = $("#product_id").val();
        var vOpType = $("#request_type").val();
        var vIdNo = $("#id_no").val();
        var vSmCode = $("#sm_code").val();
        var vRegionCode = $("#iRegionCode").val();
        var vOpCode = $("#op_code").val();
        var vBizCode = $("#iBizCode").val();
        var vPayFlag = "";
        var vUnitId= $("#unit_id").val();
        if(vSmCode == "CR"){
            vPayFlag = $("#pay_flag").val();
        }else{
            vPayFlag = "";
        }

        var path = "/npage/s7983/pubAdditiveBill.jsp";
        path = path + "?mebMonthFlag=" + vMebMonthFlag;
        path = path + "&grpProdCode=" + vGrpProdCode;
        path = path + "&opType="+vOpType;
        path = path + "&id_no=" + vIdNo;
        path = path + "&smCode=" + vSmCode;
        path = path + "&regionCode=" + vRegionCode;
        path = path + "&opCode=" + vOpCode;
        path = path + "&bizCode=" + vBizCode;
        path = path + "&payFlag=" + vPayFlag;
        path = path + "&unitId=" + vUnitId;
        
        retInfo = window.open(path,"newwindow","height=450, width=400,top=90,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
    	return true;
    }
    
    /* getAdditiveBill()方法中获取的新资费信息，在pubAdditiveBill.jsp中调用 */
    function doQueryRate(rateCode,rateName){
        if($("#sm_code").val() != "CR"){
            $("#addProductId").val(rateCode);
            $("#addProductName").val(rateName);
        }else{
            $("#addProductIdCR").val(rateCode);
            $("#addProductNameCR").val(rateName);
            $("#pay_flag").find("option:not(:selected)").remove(); // 彩铃时，选择附加套餐后，付费方式改为不可变。
        }
    }
/// begin    add by yanpx 20091126
function validDate(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("日期格式有误，正确格式为“年年年年月月日日”，请重新输入！");
	//obj.value="";
	obj.select();
 	obj.focus();
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("年的格式有误，有效年份应介于1900-3000之间，请重新输入！");
	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("月的格式有误，有效月份应介于01-12之间，请重新输入！");
  	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("日的格式有误，有效日期应介于01-31之间，请重新输入！");
	   //obj.value="";
	   obj.select();
       obj.focus();
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("该月份最多30天,没有31号！");
 	         //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("闰年二月份最多29天！");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("非闰年二月份最多28天！");
      	     //obj.value="";
			 obj.select();
	        obj.focus();
           return false;
		   }
		 }
      }
  }
  return true;
}    
function refMain(){
    		                if($("#single_phoneno1").val() == ""){
                    rdShowMessageDialog("请输入手机号码！",0); 
                    $("#single_phoneno1").focus();
                    return false;
                }
                		                if($("#single_phonenoname").val() == ""){
                    rdShowMessageDialog("请输入成员用户ID！",0); 
                    $("#single_phonenoname").focus();
                    return false;
                }
                		                if($("#new_offerids").val() == ""){
                    rdShowMessageDialog("请输入新包年资费！",0); 
                    $("#new_offerids").focus();
                    return false;
                }
                showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
        frm.action="fg221Cfm.jsp";
    		frm.method="post";
    		frm.submit();
                }
    function refMain1(){
    

                
                
                
    
        <% if(resultList.length>0){ %>
        if(!checkDynaFieldValues(false)){
			return false;
		}


		<%}%>

        var ind1Str ="";
        var ind2Str ="";
        var ind3Str ="";
        var ind4Str ="";
        var ind5Str ="";

        /* vpmn时,拼写数据 */
        if($("#sm_code").val() == "vp"){
            if($("#vpmnInputType").val() == "vpmnMulti"){         //vpmn号码录入
                if( dyntb.rows.length == 2){//缓冲区没有数据
                    rdShowMessageDialog("没有指定成员号码，请增加数据!",0);
                    return false;
                }else{
                    for(var a=1; a<document.all.R0.length ;a++)//删除从tr1开始，为第三行
                    {
                        ind1Str =ind1Str +document.all.R1[a].value+"|";
                        ind2Str =ind2Str +document.all.R2[a].value+"|";
                        ind3Str =ind3Str +document.all.R3[a].value+"|";
                        ind4Str =ind4Str +document.all.R4[a].value+"|";
                        ind5Str =ind5Str +document.all.R5[a].value+"|";
                    }
                }
                
                //2.对form的隐含字段赋值
                
                document.all.tmpR1.value = ind1Str;
                document.all.tmpR2.value = ind2Str;
                document.all.tmpR3.value = ind3Str;
                document.all.tmpR4.value = ind4Str;
                document.all.tmpR5.value = ind5Str;
            }else{  //vpmn文件录入
                if($("#vpmnPosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#vpmnPosFile").focus();
                    return false;
                }
            }
            //wangzn 091205 B
            //alert("["+document.all.limitcount.value+"]");
            //alert("["+document.all.F80003.value+"]");
            if(document.all.limitcount.value=="1"&&document.all.F80003.value=="0")
					{
							rdShowMessageDialog("该集团主资费不可使用，请为集团成员选择个人套餐资费!");
			        return false;
					}
					if(document.all.limitcount.value=="1"&&document.all.F80004.value=="0")
					{
							rdShowMessageDialog("该集团主资费不可使用，请为集团成员选择个人套餐资费!");
			        return false;
					}
            //wangzn 091205 E
            
            
        } else if($("#sm_code").val() == "j1"){	//wanghfa添加此判断体 2010-12-2 16:43 移动总机j1接入BOSS系统
            if ($("#inputType").val() == "multi") {         //j1号码录入
                if ( dyntb.rows.length == 2) {//缓冲区没有数据
                    rdShowMessageDialog("没有指定成员号码，请增加数据！",0);
                    return;
                } else {
                    for(var a=1; a<document.all.R0.length ;a++) {
                        ind1Str =ind1Str + document.all.R1[a].value+"|";
                        ind2Str =ind2Str + document.all.R2[a].value+"|";
                        ind3Str =ind3Str + document.all.R3[a].value+"|";
                        //ind4Str =ind4Str + document.all.R4[a].value+"|";
                        ind5Str =ind5Str + document.all.R5[a].value+"|";
                    }
                }
                
                //2.对form的隐含字段赋值
                
                document.all.tmpR1.value = ind1Str;
                document.all.tmpR2.value = ind2Str;
                document.all.tmpR3.value = ind3Str;
                document.all.tmpR4.value = ind4Str;
                document.all.tmpR5.value = ind5Str;
            } else if ($("#inputType").val() == "file") {  //j1文件录入
                if($("#vpmnPosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#vpmnPosFile").focus();
                    return false;
                }
            }
            
        } else if($("#sm_code").val() == "np"){
            if($("#allPayFlag").val() == "1"){
                if($("#allFlag").val() == "0"){
                    if($("#cycleMoney").val() == ""){
                        rdShowMessageDialog("请您输入定额金额！",0);
                        $("#cycleMoney").focus();
                        return false;
                    }else{
                        if(!forMoney(document.all.cycleMoney)){
                            $("#cycleMoney").val("");
                            $("#cycleMoney").focus();
                            return false;
                       }
                    }
                }
                if($("#beginDate").val() == ""){
                    rdShowMessageDialog("请您输入开始时间！",0);
                    $("#beginDate").focus();
                    return false;
                }else{
                    if(!forDate(document.all.beginDate)){
                        $("#beginDate").val("");
                        $("#beginDate").focus();
                        return false;
                    }
                }
                
                if($("#endDate").val() == ""){
                    rdShowMessageDialog("请您输入结束时间！",0); 
                    $("#endDate").focus();
                    return false;
                }else{
                    if(!forDate(document.all.endDate)){
                        $("#endDate").val("");
                        $("#endDate").focus();
                        return false;
                    }
                }
                
                if($("#beginDate").val()<"<%=dateStr%>"){
                    rdShowMessageDialog("开始时间应不小于当前日期！",0);
                    $("#beginDate").val("");
                    $("#beginDate").focus();
                    return false;
                }
                
                if($("#beginDate").val() > $("#endDate").val()){
                    rdShowMessageDialog("结束时间应不小于开始日期！",0);
                    $("#endDate").val("");
                    $("#endDate").focus();
                    return false;
                }
            }
            
            if(document.all.input_type[0].checked){         //单个录入
                if($("#single_phoneno").val() == ""){
                    rdShowMessageDialog("成员用户手机号码不能为空！",0);
                    $("#single_phoneno").focus();
                    return false;
                }else{
                    if(!forMobil(document.all.single_phoneno)){
                        return false;
                    }
                }
            }else if(document.all.input_type[1].checked){    //批量录入
                if($("#multi_phoneNo").val() == ""){
                    rdShowMessageDialog("号码不能为空！",0);
                    $("#multi_phoneNo").focus();
                    return false;
                } else {	//2011/7/7 wanghfa添加 解决入参空格导致服务down掉
                	while ($("#multi_phoneNo").val().indexOf(" ") != -1) {
	                	$("#multi_phoneNo").val($("#multi_phoneNo").val().replace(" ", ""));
                	}
                }
            }else{
                if($("#PosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#PosFile").focus();
                    return false;
                }
            }
            
        }else{
            if(document.all.input_type[0].checked){         //单个录入
                if($("#single_phoneno").val() == ""){
                    rdShowMessageDialog("成员用户手机号码不能为空！",0);
                    $("#single_phoneno").focus();
                    return false;
                }else{
                    if(!forMobil(document.all.single_phoneno)){
                        return false;
                    }
                }
            }else if(document.all.input_type[1].checked){    //批量录入
                if($("#multi_phoneNo").val() == ""){
                    rdShowMessageDialog("号码不能为空！",0);
                    $("#multi_phoneNo").focus();
                    return false;
                } else {	//2011/7/7 wanghfa添加 解决入参空格导致服务down掉
                	while ($("#multi_phoneNo").val().indexOf(" ") != -1) {
	                	$("#multi_phoneNo").val($("#multi_phoneNo").val().replace(" ", ""));
                	}
                }
            }else{
                if($("#PosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#PosFile").focus();
                    return false;
                }
            }
            
            if($("#sm_code").val() == "AD" || $("#sm_code").val() == "ML" || $("#sm_code").val() == "MA"){
                if($("#request_type").val() == '03' || $("#request_type").val() == '04'){
                    if($("#expect_time").val() == ""){
                        rdShowMessageDialog("请输入期望日期！",0);
                        $("#expect_time").select();
                        $("#expect_time").focus();
                        return false;
                    }else{
						if(validDate(document.all.expect_time)==false) return false;
                    }
                }
            }  
          }

        if($("#sm_code").val() == "ap" && document.all.input_type[0].checked){
            if(document.all.F81008 != null && document.all.F81008.value == "0"){
                if($("#F81002").val() == ""){
                    rdShowMessageDialog("请输入IP地址！",0);
                    $("#F81002").focus();
                    return false;
                }else{
                    if(!forIp(document.all.F81002)){
                        return false;
                    }
                }
            }
        }
        if($("#sm_code").val() == "ZH" && document.all.input_type[0].checked){//haoyy add 2012/7/23 15:12 增加智慧城管对静态ip地址的验证
            if(document.all.F81008 != null && document.all.F81008.value == "0"){
                if($("#F81002").val() == ""){
                    rdShowMessageDialog("请输入IP地址！",0);
                    $("#F81002").focus();
                    return false;
                }else{
                    if(!forIp(document.all.F81002)){
                        return false;
                    }
                }
            }
        }
        if($("#sm_code").val() == "ap" || $("#sm_code").val() == "ZH"){//diling add 2012/7/23 15:12 增加智慧城管对静态ip地址的验证，如为IP类型为动态，则不需要输入ip地址
            if(document.all.F81008 != null && document.all.F81008.value == "1"){
                if($("#F81002").val() != ""){
                    $("#F81002").val("");
                }
            }
        }
        <%if("".equals(packFlag)){%>
            if($("#sm_code").val() != "CR"){
                if($("#addProductId").val() == ""){
                    rdShowMessageDialog("请您选择附加资费！",0);
                    $("#selectAdditive").focus();
                    return false;
                }
            }else{
                if($("#addProductIdCR").val() == ""){
                    rdShowMessageDialog("请您选择附加资费！",0);
                    $("#selectAdditiveCR").focus();
                    return false;
                }
            }
        <%}%>
        
        if($("#pay_flag").val()=="1" && $("#mebMonthFlag").val()=="N" && $("#matureFlag").val()=="Y" && $("#matureProdCode").val()==""){
            rdShowMessageDialog("请您选择包年转包月产品！",0);
            $("#matureProdCodeQuery").focus();
            return false;
        }
        $("#op_note").val("操作员<%=workNo%>进行集团成员增加操作！");
        
        var phonNos = document.all.tmpR2.value;
		var phonNoArr = phonNos.split("\|");
		var phonNosLength = phonNoArr.length;
		if(phonNosLength > 2){
			$("#phoneFlag").val("more");
		}
		if($("#inputType").val() == 'file' || $("#vpmnInputType").val() == 'vpmnFile'){
			$("#phoneFlag").val("file");
		}
		$("#phonNosLength").val(phonNosLength);
        	   // 文件录入的方式 多余一个时， 并且是 vpmn
        if(("<%=iSmCode%>" == "vp") && ( $("#inputType").val() == 'file' || $("#vpmnInputType").val() == 'vpmnFile' || phonNosLength>2 ) ){
        	$("#phonNosLength").val(3);//数字无实际意义，让其大于2，是为了，下个页面能打印免填单,将多余1个和文件上传打印合在一起
        	 <% if(resultList.length>0){ %>
    			spellList();
    		 <% } %>
        	    document.frm.target="_self";
    		    document.frm.encoding="application/x-www-form-urlencoded";
        		frm.action="f7983_2.jsp";
    		    frm.method="post";
    		    frm.submit();
        }else{
        showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
        
        var confirmFlag=0;
		confirmFlag = rdShowConfirmDialog("是否提交本次操作？");
		if (confirmFlag==1) {
		    <% if(resultList.length>0){ %>
    			spellList();
    		<% } %>
    		$("#sure").attr("disabled",true);
    		if($("#inputType").val() == 'file' || $("#vpmnInputType").val() == 'vpmnFile'){
        		document.frm.target="_self";
    		    document.frm.encoding="application/x-www-form-urlencoded";
    		}
			frm.action="f7983_2.jsp";
    		frm.method="post";
    		frm.submit();
    		$("#sure").attr("disabled",true);
    		loading();
		} else {
   		$("#sure").attr("disabled",false);
			return;	
		}
        }
        
     
    }
    
	//打印信息
	function printInfoVP(printType)
	{ 
		var retInfo = "";
		var phonNo = "";
		var tmpOpCode= "<%=opCode%>";
		var thisType = $("#F80003 option:selected").text().split("-->")[1]; // 当月套餐类型
		var thatType = $("#F80004 option:selected").text().split("-->")[1]; // 下月套餐类型
		if(thisType == "初始值"){
			thisType = $("#attr").val();
		}
		if(thatType == "初始值"){
			thatType = $("#attr").val();
		}
	    var phonNos = document.all.tmpR2.value;
		var phonNoArr = phonNos.split("\|");
		//if(phonNoArr.length > 2){
		//	for(var i=0;i<phonNoArr.length-1;i++){
				///if(i == phonNoArr.length-2){
				//	phonNo = phonNo + phonNoArr[i];
				//}else{
		//		    phonNo = phonNo + phonNoArr[i] + ",";
			    //}
		//	}
		//}else{
	        phonNo = phonNoArr[0];
	    //}
		var nameN = document.all.tmpR3.value.substr(0,document.all.tmpR3.value.indexOf("\|"));
		var shortNo = document.all.tmpR1.value.substr(0,document.all.tmpR1.value.indexOf("\|"));
    	//retInfo+="用户名称:"+document.frm.grp_name.value+"|";
    	retInfo+="集团产品名称:"+document.frm.product_name.value+"|";
    	retInfo+="业务类型：集团成员增加"+"|";
    	retInfo+="集团名称："+document.all.grp_name.value+"|";
    	retInfo+="证件号码:"+document.frm.iccid.value+"|";
        retInfo+="手机号："+phonNo+"|";
        if(phonNoArr.length == 2){
        retInfo+="姓名："+nameN+"|";
    	retInfo+="当月集团V网资费套餐名称："+thisType+"|";
    	retInfo+="下月集团V网资费套餐名称："+thatType+"|";
    	retInfo+="新短号："+shortNo+"|";
    	retInfo+=""+"|";
        }
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	
    	retInfo+="流水："+document.frm.sysAccept.value+"|";
    	retInfo+="操作工号："+'<%=workNo%>'+"|";
    	retInfo+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
		return retInfo;
	   
	}
	
	
		function printInfo(printType)
	{ 
		var retInfo = "";
		var tmpOpCode= "<%=opCode%>";
		
		retInfo+='<%=workName%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="证件号码:"+document.frm.iccid.value+"|";
    	retInfo+="用户名称:"+document.frm.grp_name.value+"|";
    	retInfo+="集团产品名称:"+document.frm.product_name.value+"|";
    	retInfo+="手机号码:"+document.all.single_phoneno1.value+"|";
      retInfo+="原包年资费:"+document.all.old_offerids.value+"|";
      retInfo+="原包年资费名称:"+document.all.old_offernames.value+"|";
      retInfo+="新包年资费:"+document.all.new_offerids.value+"|";
        retInfo+="新包年资费名称:"+document.all.new_offernames.value+"|";
        retInfo+=""+"|";
        retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="业务类型：集团成员包年续签"+"|";
    	retInfo+="流水："+document.frm.sysAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.frm.op_note.value+"|";
    	retInfo+=""+"|";
		return retInfo;
		
	}
    
    function showPrtDlg(printType,DlgMessage,submitCfm){
        var h=200;
		var w=352;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var printStr = "";
		var hljPrint="hljPrint.jsp";
		printStr = printInfo(printType);		
		if(printStr == "failed")
		{
			return false;
		}
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/"+hljPrint+"?DlgMsg=" + DlgMessage;
		var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
		var ret=window.showModalDialog(path,"",prop);
    }
    
    function changePayFlag(){
    	if(document.all.allPayFlag.value=="0")
    	{
    		document.all.line_111.style.display="none";
    		document.all.line_1.style.display="none";
    		document.all.line_2.style.display="none";
    	}
    	else
    	{
    		document.all.line_111.style.display="";
    		document.all.line_1.style.display="";
    		document.all.line_2.style.display="";
    	}
    }
    
    function changeFlag(){
    	if(document.all.allFlag.value=="1"){
    		document.all.line_111.style.display="none";
    		document.all.cycleMoney.value="0";
    	}
    	else{
    		document.all.line_111.style.display="";
    		document.all.cycleMoney.value="";
    	}
    }
    
    function call_flags()
    {
        var h=480;
        var w=800;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.showModalDialog('user_flags.jsp?flags='+document.frm.F80016.value,"",prop);
        if( typeof(str) != "undefined" ){
            document.frm.F80016.value = str;
        }
        return true;
    }
    
    function phoneNoCheck(){
        if($("#single_phoneno").val() == ""){
            rdShowMessageDialog("成员用户手机号码不能为空！",0);
            $("#single_phoneno").focus();
            return false;
        }else{
            if(!forMobil(document.all.single_phoneno)){
                return false;
            }
        }
                
        var vLoginNo = "<%=workNo%>";
        var vLoginPwd = "<%=workPwd%>";
        var vOpCode = "<%=opCode%>";
        var vOrgCode = "<%=orgCode%>";
        var vGrpIdNo = $("#id_no").val();
        var vPhoneNo = $("#single_phoneno").val();
        var vProductId = $("#product_id").val();
        var vSmCode = $("#sm_code").val();
        var vRequestType = $("#request_type").val();
        
        var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPhoneNo.jsp","正在进行手机号码校验，请稍候......");
        myPacket.data.add("retType","checkPhone");
    	myPacket.data.add("loginNo",vLoginNo);
    	myPacket.data.add("loginPwd",vLoginPwd);
    	myPacket.data.add("opCode",vOpCode);
    	myPacket.data.add("orgCode",vOrgCode);
    	myPacket.data.add("grpIdNo",vGrpIdNo);
    	myPacket.data.add("phoneNo",vPhoneNo);
    	myPacket.data.add("productId",vProductId);
    	myPacket.data.add("smCode",vSmCode);
    	myPacket.data.add("requestType",vRequestType);
    	core.ajax.sendPacket(myPacket);
    	myPacket = null;
    }
    
    function doUnLoading(){
        $("#sure").attr("disabled",false);
        unLoading();
    }
    
    function Getbaonianzifei()
{
    var pageTitle = "新包年主资费";
    var fieldName = "资费类型|类型名称|资费代码|资费名称|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "4|0|1|2|3|";
    var retToField = "new_offerids|new_offernames|";
    var cust_id = document.frm.cust_id.value;

    PubSimpSelCust1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}

function PubSimpSelCust1(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	
    var path = "<%=request.getContextPath()%>/npage/sg221/fg221_2.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&jituanchanpinid=<%=id_no%>";
    path = path + "&product_id=" + document.all.product_id.value+"&sm_code=" + document.all.sm_code.value;
    path = path + "&request_type=" + document.all.request_type.value+"&unit_id=" + document.all.unit_id.value;
    path = path + "&jituanchanpinid=<%=id_no%>";
    
    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getvaluecust2(retInfo)
{   
  	var retToField = "new_offerids|new_offernames|";
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


    $("#iccid,#cust_id,#unit_id,#user_no").attr("readOnly",true);
    $("#iccid,#cust_id,#unit_id,#user_no").addClass("InputGrey");

}


  /* 单个用户查询 */
    function Getsingle_phoneno(){
        var vServiceNo = document.frm.service_no.value;
        var vRegionCode = document.all.frm.org_code.value.substring(0,2);
        var vSinglePhoneNo = $("#single_phoneno1").val();
        var vIdNo = $("#id_no").val();
        var vSmCode = $("#sm_code").val();
        var vProductId = $("#product_id").val();
        var vRequestType = "";
        //alert("vIdNo="+vIdNo);
        if(vSmCode == "AD" || vSmCode == "ML"){
            vRequestType = $("#request_type").val();
        }
        if(vSinglePhoneNo != ""){
            if(!forMobil(document.all.single_phoneno1)){
                rdShowMessageDialog("手机号码格式不正确，请重新输入！",0);
                $("#single_phoneno1").val("");
                $("#single_phoneno1").focus();
                return false;
            }
            var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/sg221/pubChkNo.jsp","正在获得成员信息，请稍候......");
        	packet.data.add("workNo","<%=workNo%>");
        	packet.data.add("opCode","<%=opCode%>");
        	packet.data.add("idNo",vIdNo);
        	packet.data.add("smCode",vSmCode);
        	packet.data.add("productId",vProductId);
        	packet.data.add("serviceNo",vServiceNo);
        	packet.data.add("regionCode",vRegionCode);
        	packet.data.add("singlePhoneNo",vSinglePhoneNo);
        	packet.data.add("requestType",vRequestType);
        	core.ajax.sendPacket(packet,doGetsingle_phoneno);
        	packet = null;
        }else{
            GetMemberPhoneno();
        }
    }
    
    function doGetsingle_phoneno(packet){
        var retCode = packet.data.findValueByName("retCode");		
        var retMsg = packet.data.findValueByName("retMessage");
        var retPhoneNoNum = packet.data.findValueByName("retPhoneNoNum");
        var retMemberUse = packet.data.findValueByName("retMemberUse");
        var retSinglePhoneno = packet.data.findValueByName("retSinglePhoneno");
        var singlephoneTypes = packet.data.findValueByName("singlephoneTypes");
        var oldofferisds = packet.data.findValueByName("oldofferisds");
        var oldoffernamesd = packet.data.findValueByName("oldoffernamesd");
        //singlephoneTypes="Y";
        if(retCode == "000000"){
            if(retPhoneNoNum != 0){

                $("#single_phonenoname").val(retMemberUse);
                $("#single_phoneno1").val(retSinglePhoneno);
                $("#old_offerids").val(oldofferisds);
                $("#old_offernames").val(oldoffernamesd);
                $("#sure").attr("disabled",false);
                return true;
            }else{
                rdShowMessageDialog("此集团没有该成员信息,请重新输入！",0);
                $("#single_phoneno1").val("");
                $("#single_phoneno1").focus();
                return false;
            }
        }else{
            rdShowMessageDialog("错误代码："+retCode+"<br/>错误信息："+retMsg,0);
            return false;
        }
    }
    
    function GetMemberPhoneno(){
    	var pageTitle = "集团成员编码查询";
        var fieldName = "成员用户ID|成员用户手机号码|业务类型|原成员包年资费|原成员包年资费名称|原成员包年资费名称";

    	var sqlStr = "";
    	var selType = "S";    //'S'单选；'M'多选
    	var retQuence = "6|0|1|2|3|4|5";
    	var retToField = "single_phonenoname|single_phoneno1|old_offerids|old_offernames";
    	var returnNum="3";
    	PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum);
    }
    
    function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,returnNum)
    {
    var prop="dialogHeight:600px; dialogWidth:750px; dialogLeft:600px; dialogTop:600px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var vSinglePhoneNo = $("#single_phoneno1").val();
        var vIdNo = $("#id_no").val();
        var vSmCode = $("#sm_code").val();
        var vProductId = $("#product_id").val();
        var vWorkNo = "<%=workNo%>";
        var vOpCode = "<%=opCode%>";
        var vOpType = "m08";
        var vRequestType = "";
        if(vSmCode == "AD" || vSmCode == "ML"){
            vRequestType = $("#request_type").val();
        }
          
        var path = "<%=request.getContextPath()%>/npage/sg221/fGetPhoneNo.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType; 
    	path = path + "&returnNum=" + returnNum;
    	path = path + "&phoneNo="+vSinglePhoneNo;
    	path = path + "&idNo="+vIdNo;
    	path = path + "&smCode="+vSmCode;
    	path = path + "&productId="+vProductId;
    	path = path + "&workNo="+vWorkNo;
    	path = path + "&opCode="+vOpCode;
    	path = path + "&opType="+vOpType;
    	path = path + "&requestType="+vRequestType;
        retInfo = window.showModalDialog(path,"",prop);
        if(retInfo ==undefined)      
        {
        	return false;
        }
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
        var sphonesno="";
        sphonesno = document.all.single_phoneno1.value;
        if(sphonesno.indexOf(",")!=-1) {
        	var sphonesdno =sphonesno.trim().split(",");
        	document.all.single_phoneno1.value=sphonesdno[0];

        }
        var oldofferidsss = document.all.old_offerids.value;
        var olsdw =oldofferidsss.split(",");
        document.all.old_offerids.value=olsdw[1];
        document.all.old_offernames.value=olsdw[2];
        
      $("#sure").attr("disabled",false);
    	return true;
    }
</script>

</head>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团用户信息查询</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue' nowrap width='18%'>证件号码</td>
        <td width='32%'><input type='text' name='iccid' id='iccid' value='<%=iIccid%>' v_must='1' />
            <input type='button' class='b_text' name='iccid_query' id='iccid_query' value='查询' onClick="getCustInfo()" />
            <font class='orange'>*</font>
        </td>
        <td class='blue' nowrap width='18%'>集团客户ID</td>
        <td>
            <input type='text' id='cust_id' name='cust_id' value='<%=iCustId%>' v_must='1' />
            <font class='orange'>*</font>
        </td>
    </tr>
    
    <tr>
        <td class='blue' nowrap>集团编号</td>
        <td>
            <input type='text' name='unit_id' id='unit_id' value='<%=iUnitId%>' v_must='1' />
            <font class='orange'>*</font>
        </td>
        <td class='blue' nowrap>集团号或智能网编号</td>
        <td>
            <input type='text' id='service_no' name='service_no' value='<%=iServiceNo%>' v_must='1' />
            <font class='orange'>*</font>
        </td>
    </tr>
    
    <tr>
        <td class='blue' nowrap>产品名称</td>
        <td>
            <input type='text' id='product_name' name='product_name' value='<%=iProductName%>' readOnly/>
            <input type='hidden' name='product_id' id='product_id' value='<%=iProductId%>' v_must='1' readOnly />
            <font class='orange'>*</font>
        </td>
        <td class='blue' nowrap>产品付费账户</td>
        <td>
            <input type='text' id='account_id' name='account_id' value='<%=iAccountId%>' v_must='1' readOnly />
            <font class='orange'>*</font>
        </td>
    </tr>
    
    <tr>
        <td class='blue' nowrap>品牌名称</td>
        <td>
            <input type='text' name='sm_name' id='sm_name' value='<%=iSmName%>' v_must='1' readOnly />
            <input type='hidden' name='sm_code' id='sm_code' value='<%=iSmCode%>' v_must='1' readOnly />
            <font class='orange'>*</font>
        </td>
        <td class='blue' nowrap>归属地区</td>
        <td>
            
            <select name="belong_code" id="belong_code">
<%
				try
				{
					String sqlStr2 = "select substr(:org_code,1,2),substr(:org_code,1,7)||'|'||:GroupId,'工号所在地' from dual";
					System.out.println("sqlStr================"+sqlStr2);
					System.out.println("org_code="+orgCode+",GroupId="+groupId);
                    String paraIn1="org_code="+orgCode+",GroupId="+groupId;
                    %>
                    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode14" retmsg="retMsg14" outnum="3" >
                    	<wtc:param value="<%=sqlStr2%>"/>
                    	<wtc:param value="<%=paraIn1%>"/> 
                    </wtc:service>
                    <wtc:array id="retArr14" scope="end"/>
                    <%
                    if(retCode14.equals("000000") && retArr14.length>0){
                        result = retArr14;
                    }
					int recordNum = result.length;
					for(int i=0;i<recordNum;i++)
					{
					    if("2".equals(nextFlag) && iBelongCode.equals(result[i][1])){
						%>
						    <option value="<%=result[i][1]%>" selected><%=result[i][1]%>--<%=result[i][2]%></option>
						<%
					    }else{
					    %>
						    <option value="<%=result[i][1]%>"><%=result[i][1]%>--<%=result[i][2]%></option>
						<%
					    }
					}
				}catch(Exception e){
					System.out.println("Call Service TlsPubSelCrm is Failed!");
				}
%>
            </select>
        </td>
    </tr>
    
    <tr>
        <td class='blue' nowrap>集团产品密码</td>
        <td>
            <jsp:include page="/npage/common/pwd_8.jsp">
                <jsp:param name="width1" value="16%"  />
                <jsp:param name="width2" value="34%"  />
                <jsp:param name="pname" value="product_pwd"  />
                <jsp:param name="pwd" value="<%=iProductPwd%>"  />
            </jsp:include>
            <input type='button' class='b_text' id='chk_productPwd' name='chk_productPwd' onClick='chkProductPwd()' value='校验' />
            <font class="orange">*</font>
        </td>

        <td class='blue' nowrap>
			<span id='requestTab1' name='requestTab1' style="display:<%=requestListShow%>">
			操作类型
			</span>&nbsp;
		</td>
		<td >
			<span id='requestTab2' name='requestTab2' style="display:<%=requestListShow%>">
				<select name="request_type" id="request_type">
				    <option value=' '>---请选择---</option>
				    <option value='01'
				    <%
				        if("01".equals(iRequestType)){
				            out.print(" selected ");
				        }
				    %>
				    >01->通用类</option>
				    <option value='02'
				    <%
				        if("02".equals(iRequestType)){
				            out.print(" selected ");
				        }
				    %>    
				    >02->IPT类</option>
				    <option value='03'
				    <%
				        if("03".equals(iRequestType)){
				            out.print(" selected ");
				        }
				    %>
				    >03->黑名单类</option>
				    <option value='04'
				    <%
				        if("04".equals(iRequestType)){
				            out.print(" selected ");
				        }
				    %>
				    >04->白名单类</option>
				</select>
			</span>&nbsp;
		</td>
    </tr>
     <%/*begin 点击下一步展示客户经理工号和姓名、集团类别 by diling@2012/5/14 */%>
     <input type='hidden' id='custManagerNoHiden' name='custManagerNoHiden'  value='' />
     <input type='hidden' id='custManagerNameHiden' name='custManagerNameHiden' value='' />
     <input type='hidden' id='unitTypeHiden' name='unitTypeHiden' value='' />
    <tr id="custManagerInfo" style="display:none">
        <td class='blue' nowrap>客户经理工号</td>
        <td>
            <input type='text' class="InputGrey" id='custManagerNo' name='custManagerNo' value='<%=iCustManagerNoHiden%>' readOnly/>
        </td>
        <td class='blue' nowrap>客户经理姓名</td>
        <td>
            <input type='text' class="InputGrey" id='custManagerName' name='custManagerName' value='<%=iCustManagerNameHiden%>' v_must='1' readOnly />
        </td>
    </tr>
    <tr id="unitTypeInfo" style="display:none">
        <td class='blue' nowrap>集团类别</td>
        <td colspan="3">
            <input type='text' class="InputGrey" id='unitType' name='unitType' value='<%=iUnitTypeHiden%>' readOnly/>
        </td>
    </tr>
    <%/*end by diling */%>
</table>
</div>

<div id="packInfo" name="packInfo" style="display:none">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">套餐信息</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue' nowrap width='18%'>附加套餐</td>
        <td colspan='3'>
            <input name="addProductName" id="addProductName" type="text" v_must=1 v_maxlength=8 v_type="string" readonly>
            <input class="b_text" id="selectAdditive" name="selectAdditive" onClick="getAdditiveBill()" style="cursor:hand" type="button" value="选择" />
            <font class='orange'>*</font>
            <input name="addProductId" id="addProductId" type="hidden" />
        </td>
    </tr>
</table>
</div>
</div>

<div id="payInfo" name="payInfo" style="display:none">
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">付费信息</div>
</div>
<TABLE cellSpacing=0>
    <TR>        
        <td class='blue' nowrap width='18%'>付费方式</td>
        <td width='32%'>
            <select name="pay_flag" id="pay_flag" onChange="changeOthers()">
                <%if("0".equals(payValue)){%>
                	<option value="0" selected>0--集团统付</option> 
            	<%}else if("1".equals(payValue)){%>
            	    <option value="0" selected>0--集团统付</option> 
                	<option value="1">1--个人付费</option>
            	<%}else if("2".equals(payValue)){%>
                	<option value="1" selected>1--个人付费</option>
            	<%}else if("3".equals(payValue)){%>
            	    <option value="0">0--集团统付</option> 
                	<option value="1" selected>1--个人付费</option>
            	<%}else{%>
                	<option value="0">0--集团统付</option> 
                	<option value="1">1--个人付费</option>
            	<%}%>
            </select>
            <font class='orange'>*</font>
        </td>
        
        <td class='blue' nowrap width='18%'>计费时间</TD>
        <TD>
            <input name="billTime" id="billTime" class="InputGrey" type="text" readOnly v_must=1 v_maxlength=8 v_type="string" value="<%=dateStr%>" maxlength=8>
        </TD>
    </tr>
    <%if("CR".equals(iSmCode)){%>
        <tr id="packInfoCR" name="packInfoCR" style="display:none">
        <td class='blue' nowrap width='18%'>附加套餐</td>
        <td colspan='3'>
            <input name="addProductNameCR" id="addProductNameCR" type="text" v_must=1 v_maxlength=8 v_type="string" readonly>
            <input class="b_text" id="selectAdditiveCR" name="selectAdditiveCR" onClick="getAdditiveBill()" style="cursor:hand" type="button" value="选择" />
            <font class='orange'>*</font>
            <input name="addProductIdCR" id="addProductIdCR" type="hidden" />
        </td>
    </tr>
    <tr>
        <td class="blue">产品周期</TD>
        <TD >
            <SELECT name="mebMonthFlag"  id="mebMonthFlag"  onChange="changeOthers()">
                <%if("N".equals(iMonthFlag)){%>
                    <option value="N" >包年</option>
                <%}else if("Y".equals(iMonthFlag)){%>
                    <option value="Y" >包月 </option>
                <%}else{%>
                    <option value="N" >包年</option>
                    <option value="Y" >包月 </option>
                <%}%>
            </SELECT>
            <font class="orange">*</font>
        </TD>
        
        <td class="blue">
            <span id=tbs2 style="display:none">包年到期转包月</span>&nbsp;
        </TD>								
        <TD >
            <span id=tbs3 style="display:none">																
                <SELECT name="matureFlag"  id="matureFlag" onChange="changeMatureFlag()" >
                    <option value="Y" >是 </option>
                    <option value="N" selected>否 </option>
                </SELECT>									         		      
                <input  type="text" id="matureProdName"  name="matureProdName" size="15" value="" readonly>
                <input name="matureProdCodeQuery" type="button" id="matureProdCodeQuery" disabled class="b_text" onClick="getmatureProdCodeQuery();" value="选择">
                <font class="orange">*</font>		 			   	  														 			
            </span>&nbsp;
        </TD>	
    </tr>
    <%}%>
</table>
</div>
</div>
<%
  /* diling update for 当品牌为“智慧城管”时，删除页面"品牌信息"展示区域 @2012/10/9
    if("ap".equals(iSmCode)||"ZH".equals(iSmCode)){
  */
%>
<%if("ap".equals(iSmCode)){%>
<div id="Operation_Table">
<div class="title" style="display:none">
	<div id="title_zi">品牌信息</div>
</div>
<table cellspacing=0 style="display:none">
    <tr>
        <td class='blue' nowrap width='18%'>APN号码</td>
        <td width='32%'>
            <select  size=1 name="apnNo" id="apnNo">
                <wtc:qoption name="sPubSelect" outnum="2">
                  <wtc:sql>select field_value,field_value from dgrpusermsgadd where id_no = '<%=id_no%>' and field_code ='10033'</wtc:sql>
                </wtc:qoption>
            </select>
        </td>
        <td class='blue' nowrap width='18%'>最大终端数量</td>
        <td>
            <input type='text' id='max_term_num' name='max_term_num' value='<%=iMaxTermNum%>' readOnly class='InputGrey' />
        </td>
    </tr>
    <tr>
        <td class='blue' nowrap width='18%'>已增加的终端数</td>
        <td>
            <input type='text' id='add_term_num' name='add_term_num' value='<%=iAddTermNum%>' readOnly class='InputGrey' />
        </td>
        <td class='blue' nowrap width='18%'>可用数量</td>
        <td>
            <input type='text' id='use_term_num' name='use_term_num' value='<%=iUseTermNum%>' readOnly class='InputGrey' />
        </td>
    </tr>
</table>
</div>
<%}%>
<%/*begin 点击下一步展示目前占比公式、上限占比公式、可添加智能网成员数 by diling@2012/6/12 */%>
<input type='hidden' id='preProportionHiden' name='preProportionHiden'  value='' />
<input type='hidden' id='highestLimitHiden' name='highestLimitHiden' value='' />
<input type='hidden' id='addVpMemberHiden' name='addVpMemberHiden' value='' />
<input type='hidden' id='regionNameHiden' name='regionNameHiden' value='' />
<input type='hidden' id='iRegionNameHiden' name='iRegionNameHiden' value='<%=iRegionNameHiden%>' />

<%/*end by diling@2012/6/12 */%>
<%if("vp".equals(iSmCode)){%>
<div id="Operation_Table" style="display:none">
<div class="title">
	<div id="title_zi">vp品牌信息</div>
</div>
<table cellspacing=0>
    <tr>
        <td class="blue" width='18%'>集团管理系统ID</td>
        <td>
            <input type='text' id='grp_unit_id' name='grp_unit_id' value='<%=iUnitId%>' class='InputGrey' readOnly />
        </td>
        <td class="blue" width='18%'>集团管理系统名称</td>
        <td>
            <input type='text' id='grp_unit_name' name='grp_unit_name' value='<%=iGrpName%>' class='InputGrey' readOnly />
        </td>
    </tr>
    <%/*begin 点击下一步展示目前占比、上限占比、可添加智能网成员数 by diling@2012/6/12 */%>
    <tr id="proportionInfo" >
        <td class='blue' nowrap>目前占比</td>
        <td>
            <input type='text' class="InputGrey" id='preProportion' name='preProportion' value='<%=iPreProportionHiden%>%' readOnly/>
        </td>
        <td class='blue' nowrap>上限占比</td>
        <td>
            <input type='text' class="InputGrey" id='highestLimit' name='highestLimit' value='<%=iHighestLimitHiden%>%' v_must='1' readOnly />
        </td>
    </tr>
    <tr id="addVpMemberInfo" >
        <td class='blue' nowrap>可添加智能网成员数</td>
        <td colspan="3">
            <input type='text' class="InputGrey" id='addVpMember' name='addVpMember' value='<%=iAddVpMemberHiden%>' readOnly/>
        </td>
    </tr>
    <%/*end by diling */%>
</table>
</div>
<%}%>

<%if("np".equals(iSmCode)){%>
<div id="Operation_Table" style="display:none">
<div class="title">
	<div id="title_zi">np品牌信息</div>
</div>
<table cellspacing=0 style="display:none">
    <TR id="line_0"> 		
        <TD class="blue" width='18%'>统付标志</TD>
        <TD  colspan=3>	              	
            <select name="allPayFlag" id="allPayFlag" onchange="changePayFlag()">	 
                <option value="1">统付</option>
                <option value="0">按账目项付费</option>
            </select>
            &nbsp;<font class="orange">*</font>
        </TD>
    </TR> 
    <TR id="line_1"> 		
        <TD class="blue">全额标志</TD>
        <TD colspan=3>	              	
            <select name="allFlag" id="allFlag" onchange="changeFlag()">
                <option value="0">定额交费</option>
                <option value="1">全额交费</option>
            </select>
            &nbsp;<font class="orange">*</font>
        </TD>
    </TR> 
    <TR id="line_111">    	              
        <TD class="blue">定额金额</TD>
        <TD colspan=3>
            <input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14" id="cycleMoney"  name="cycleMoney" maxlength="14" onBlur="if(this.value!=''){forMoney(this)}" >&nbsp;<font class="orange">*</font>
        </TD>
    </TR>
    
    <TR id="line_2"> 
        <TD class="blue" width='18%'>开始日期</TD>
        <TD height = 20 width='32%'>
            <input type="text"  name="beginDate" id="beginDate" maxlength="8" value="<%=dateStr%>" v_type="date"  v_must="1" v_format="yyyyMMdd" onBlur="if(this.value!='' && !forDate(this)){return false;}" style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)'>
            &nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>            	
        </TD> 			
        <TD class="blue" width='18%'>结束日期</TD>
        <TD height = 20 width='32%'>
            <input type="text" name="endDate" id="endDate" maxlength="8" value="<%=endDate%>" v_type="date"  v_must="1"  v_format="yyyyMMdd" onBlur="if(this.value!='' && !forDate(this)){return false;}" style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)'>
            &nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>  
        </TD> 		            	              
    </TR>
</table>
</div>
<%}%>

<%if("2".equals(nextFlag)){%>

<!---- 隐藏的列表-->
	<%
		//为include文件提供数据 
		int fieldCount=0;
		boolean isGroup = true;
		
		if (resultList != null)
		{
			fieldCount = resultList.length;
		}
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldGroupNo=new String[fieldCount];
		String []fieldGroupName=new String[fieldCount];
		String []fieldMaxRows=new String[fieldCount];
		String []fieldMinRows=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		int iField=0;
		while(iField<fieldCount)
		{
			fieldCodes[iField]=resultList[iField][0];
			fieldNames[iField]=resultList[iField][1];
			fieldPurposes[iField]=resultList[iField][2];
			fieldValues[iField]=resultList[iField][10];
			dataTypes[iField]=resultList[iField][3];
			fieldLengths[iField]=resultList[iField][4];
			fieldGroupNo[iField]=resultList[iField][5];
			fieldGroupName[iField]=resultList[iField][6];
			fieldMaxRows[iField]=resultList[iField][7];
			fieldMinRows[iField]=resultList[iField][8];
			fieldCtrlInfos[iField]=resultList[iField][9];
			iField++;
		}
		if(fieldCount>0){
		%>
	<%@ include file="fpubDynaFields.jsp"%>
	<%}%>
<div id="Operation_Table" >
<%if("vp".equals(iSmCode)){%><!--wanghfa修改判断语句 2010-12-2 14:51 关于移动总计业务接入BOSS系统需求-->
<div class="title" style="display:none">
	<div id="title_zi">VPMN号码输入</div>
</div>
<table  cellspacing="0" style="display:none">
    <tr>
        <td class='blue' nowrap width='18%'>号码输入方式</td>
        <td width='32%'>
            <input type='radio' id='vpmn_input_type' name='vpmn_input_type' onClick='chkVpmnMulti()' value='vpmnMulti' checked/>号码输入
            <input type='radio' id='vpmn_input_type' name='vpmn_input_type' onClick='chkVpmnFile()' value='vpmnFile' />文件录入
        </td>
    <td class="blue"  width='18%'>号码运营商</td>
    <td class="formTd" colspan='3'>
        <select name=phone_type id=phone_type> 
            <option value="0">移动</option>	
            <option value="1">铁通</option>	
            <!--
            <option value="2">联通</option>
            <option value="3">网通</option>	
            <option value="4">电信</option>
            -->
        </select>	
        <font class="orange">*</font>
    </td>    
    </tr>
</table>
<span id="vpmnMulti" name="vpmnMulti" style="display:none">
<table  cellspacing="0" style="display:none">
    <tr id="SHOWADD1" >
        <td  class="blue" width='18%'>短号</td>
        <td  width='32%'>
            <input name="PHONENO" type="text"  id="PHONENO" maxlength="8" style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type=0_9 v_minlength=3 v_maxlength=8  onblur="checkElement(this)" > 
            <font class="orange">*</font>
        </td>
        <td  class="blue"  width='18%'>真实号码</td>
        <td >
            <input name="ISDNNO" type="text"  id="ISDNNO" maxlength='11' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type=0_9 v_minlength=1 v_maxlength=12  onblur="checkElement(this)">
            <font class="orange">*</font>		
        </td>
    </tr>
    <tr id="UserId">
        <td  class="blue">用户姓名</td>
        <td>
            <input name="USERNAME" type="text"  id="USERNAME" maxlength="18">
        </td>
        <td  class="blue">证件号码</td>
        <td>
            <input name="IDCARD" type="text"  id="IDCARD" maxlength="36">
        </td>
    </tr>
    <tr>
        <td class="blue">描述信息对应关系</td>
        <td>
            <input name="PCOMMENT" type="text"  id="PCOMMENT" maxlength="36">
        </td>
        <td >
            <input name="addCondConfirm" type="button" class="b_text" id="addCondConfirm" value="增加" onClick="call_ISDNNOINFO();">
        </td>
        <td  class="blue">已增加记录数
            <input name="addRecordNum" type="text"  class="InputGrey" id="addRecordNum" value="" size=7 readonly>
        </td>
    </tr>	
</table>		
          
<table cellspacing="0" id="dyntb" style="display:none">	
    <tr>
        <th>删除操作</th>
        <th>短号</th>
        <th>真实号码</th>
        <th>用户姓名</th>
        <th>证件号码</th>
        <th>描述信息</th>
        <th>执行状态</th>
    </tr>
    <tr id="tr0" style="display:none">
        <td>
            <input type="checkBox" id="R0" value="">
        </td>
        <td>
            <input type="text" id="R1" value="">
        </td>
        <td>
            <input type="text" id="R2" value="">
        </td>
        <td>
            <input type="text" id="R3" value="">
        </td>
        <td>
            <input type="text" id="R4" value="">
        </td>
        <td>
            <input type="text" id="R5" value="">
        </td>
        <td>
            <input type="text" id="R6" value="">
        </td>
    </tr>
</table>
</span>
<span id="vpmnFile" name="vpmnFile" style="display:none">
<table cellspacing=0 style="display:none">
    <TR>
        <TD align="left" class=blue width=18%>录入文件</TD>	   
        <TD colspan='3'> 
            <input type="file" name="vpmnPosFile" id="vpmnPosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
        </TD>
    </TR>
    <tr>
        <td colspan="6"> 
            &nbsp;&nbsp;文件格式说明<br>
            &nbsp;&nbsp; 上传文件文本格式为，示例如下：<br>
            <font class='orange'>&nbsp;&nbsp; 6位短号码 11位真实号码 附加信息</font>
            <br>
            &nbsp;&nbsp; 
            <b>
            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每一项必须以" "（空格）为间隔符。每次最多50个。
            </b> 
        </td>
    </tr>
</table>
</span>
<%} else if ("j1".equals(iSmCode)) {%>
<!--wanghfa添加 2010-12-2 14:51 关于移动总计业务接入BOSS系统需求 start-->
<div class="title" style="display:none"> 
	<div id="title_zi">分机号码输入</div>
</div>
<table  cellspacing="0" style="display:none">
    <tr>
        <td class='blue' nowrap width='18%'>号码输入方式</td>
        <td width='32%'>
            <input type='radio' id='j1_input_type' name='j1_input_type' onClick='chkMulti()' value='j1Multi' checked/>号码输入
            <input type='radio' id='j1_input_type' name='j1_input_type' onClick='chkFile()' value='j1File' />文件录入
        </td>
	    <td class="blue"  width='18%'>号码运营商</td>
	    <td colspan='3'>
	        <select name="j1Provider" id="j1Provider"> 
	            <option value="0">移动</option>	
	            <option value="1">其他</option>	
	        </select>
	        <font class="orange">*</font>
	    </td>
    </tr>
</table>
<span id="multi" name="multi" style="display:none">
<table  cellspacing="0" style="display:none">
    <tr>
        <td  class="blue" width='18%'>分机号码</td>
        <td  width='32%'>
            <input name="j1No" type="text"  id="j1No" maxlength="6" style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type=0_9 v_minlength=4 v_maxlength=6  onblur="checkElement(this)" > 
            <font class="orange">*</font>
        </td>
        <td class="blue"  width='18%'>电话号码</td>
        <td >
            <input name="j1PhoneNo" type="text" id="j1PhoneNo" maxlength='12' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type=0_9 v_minlength=1 v_maxlength=12 onblur="checkElement(this)">
            <font class="orange">*</font>		
        </td>
    </tr>
    <tr>
        <td  class="blue">成员姓名</td>
        <td>
            <input name="j1UserName" type="text" v_must=1 id="j1UserName" maxlength="18">
        </td>
        <td  class="blue">成员姓名拼音首字母</td>
        <td>
            <input name="j1ShortName" type="text" v_must=1 id="j1ShortName" maxlength="36">
        </td>
    </tr>
    <tr>
        <td >
            <input name="addCondConfirm" type="button" class="b_text" id="addCondConfirm" value="增加" onClick="j1AddPhoneNo();">
        </td>
        <td class="blue" colspan="3">已增加记录数
            <input name="addRecordNum" type="text"  class="InputGrey" id="addRecordNum" value="" size=7 readonly>
        </td>
    </tr>	
</table>		
          
<table cellspacing="0" id="dyntb" style="display:none">	
    <tr>
        <th>删除操作</th>
        <th>分机号码</th>
        <th>电话号码</th>
        <th>成员姓名</th>
        <th>成员姓名拼音首字母</th>
    </tr>
    <tr id="j1Tr0" style="display:none">
        <td>
            <input type="checkBox" id="R0" value="">
        </td>
        <td>
            <input type="text" id="R1" value="">
        </td>
        <td>
            <input type="text" id="R2" value="">
        </td>
        <td>
            <input type="text" id="R3" value="">
        </td>
        <td>
            <input type="text" id="R5" value="">
        </td>
    </tr>
</table>
</span>
<span id="file" name="file" style="display:none">
<table cellspacing=0 style="display:none">
    <TR>
        <TD align="left" class=blue width=18%>录入文件</TD>	   
        <TD colspan='3'> 
            <input type="file" name="j1PosFile" id="j1PosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
        </TD>
    </TR>
    <tr>
        <td colspan="6"> 
            &nbsp;&nbsp;文件格式说明<br>
            &nbsp;&nbsp; 上传文件文本格式为，示例如下：<br>
            <font class='orange'>&nbsp;&nbsp; 4-6位短号码 11位真实号码 成员姓名 成员姓名拼音首字母</font>
            <br>
            &nbsp;&nbsp; 
            <b>
            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每一项必须以" "（空格）为间隔符。每次最多50个。
            </b> 
        </td>
    </tr>
</table>
</span>
<%} else if ("ap".equals(iSmCode)||"ZH".equals(iSmCode)) {%><!--wanghfa添加 2011/9/5 10:06 关于BOSS系统APN数据卡绑定静态IP地址绑定添加批量导入功能-->
<div class="title" style="display:none">
	<div id="title_zi">号码输入</div>
</div>
<table  cellspacing="0" style="display:none">
	<tr>
		<td class='blue' nowrap width='18%'>
			号码输入方式
		</td>
		<td>
			<input type='radio' id='input_type' name='input_type' onClick='chkSingle()' value='single' checked />单个输入
			<span style="display:none"><input type='radio' id='input_type' name='input_type' onClick='chkMulti()' value='multi' />批量输入</span>
			<input type='radio' id='input_type' name='input_type' onClick='chkFile()' value='file' />文件录入
		</td>
	</tr>
</table>
<span id="single" name="single" style="display:none">
<table cellspacing="0" style="display:none">
	<tr>
		<td class='blue' nowrap width='18%'>成员用户手机号码</td>
		<td colspan='3'>
			<input type='text' id='single_phoneno' name='single_phoneno' value="" onChange="document.all.sure.disabled=true" maxlength='11' onblur='if(this.value!=""){if(!forMobil(this)){return false;}}' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' />
			<input type='button' id='checkPhoneNo' name='checkPhoneNo' value="校验" onClick='phoneNoCheck()' class='b_text' />
			<font class='orange'>*</font>
		</td>
	</tr>
</table>

</span>
<span id="file" name="file" style="display:none" >
<table cellspacing=0 style="display:none">
	<TR>
		<TD align="left" class=blue width=18%>录入文件</TD>	   
		<TD colspan='3'> 
			<input type="file" name="PosFile" id="PosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
		</TD>
	</TR>
	<tr>
		<td colspan="6">
			&nbsp;&nbsp;文件格式说明<br>
			&nbsp;&nbsp; 上传文件文本格式为，示例如下：<br>
			<font class='orange'>
			  <%if ("ZH".equals(iSmCode)) {/*diling update for 当集团“智慧城管”集团产品品牌时，“号码输入”为文件录入的，修改上传文件文本格式修改为11位真实号码 @2012/10/9 */%>
			    &nbsp;&nbsp;11位真实号码
			  <%}else{%>
				  &nbsp;&nbsp;11位真实号码 IP地址
				<%}%>
			</font>
			<br>
			&nbsp;&nbsp;
			<b>
			<br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每一项必须以" "（空格）为间隔符。每次最多50个。
			</b>
		</td>
	</tr>
</table>
</span>
<%} else {%><!--wanghfa修改判断语句 2010-12-2 14:51 关于移动总计业务接入BOSS系统需求-->
<div class="title" style="display:none">
	<div id="title_zi">号码输入</div>
</div>
<table cellspacing=0 style="display:none">
    <tr id="inputFlag" name="inputFlag" style='display:<%=phoneListShow%>'>
        <td class='blue' nowrap width='18%'>号码输入方式</td>
        <td colspan='3'>
            <span id='single_type' name='single_type'><input type='radio' id='input_type' name='input_type' onClick='chkSingle()' value='single' checked />单个输入</span>
            <input type='radio' id='input_type' name='input_type' onClick='chkMulti()' value='multi' />批量输入
            <input type='radio' id='input_type' name='input_type' onClick='chkFile()' value='file' />文件录入
        </td>
    </tr>
    <tbody id='single' name='single' style="display:none">
    <tr>
        <td class='blue' nowrap width='18%'>成员用户手机号码</td>
        <td colspan='3'>
            <input type='text' id='single_phoneno' name='single_phoneno' value="" onChange="document.all.sure.disabled=true" maxlength='11' onblur='if(this.value!=""){if(!forMobil(this)){return false;}}' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' />
            <input type='button' id='checkPhoneNo' name='checkPhoneNo' value="校验" onClick='phoneNoCheck()' class='b_text' />
            <font class='orange'>*</font>
        </td>
    </tr>
    </tbody>
    <tbody id='multi' name='multi' style='display:none'>
    <tr>
        <TD class=blue>号码</TD>
        <TD>
            <textarea cols=30 rows=8 name="multi_phoneNo" id="multi_phoneNo" style="overflow:auto" /></textarea>
        </TD>
        <TD colspan='2'>
            注：批量增加号码时,请用"|"作为分隔符,并且最后一个号码也请用"|"作为结束.
            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每次最多50个,彩铃30个。
            <br>&nbsp;例如：
            <br>&nbsp;13900000001|
            <br>&nbsp;13900000002|
        </TD>
        </TR>
    </tbody>
    <tbody id='file' name='file' style='display:none'>
        <TR>
        <TD align="left" class=blue width=12%>录入文件</TD>	   
        <TD> 
            <input type="file" name="PosFile" id="PosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
        </TD>
        <TD colspan="2"><font color='red'>文件说明:一个号码一行
            (注意：上传文件格式必须为文本文件，不支持EXCEL格式上传文件)。每次最多50个,彩铃30个。</font>
        </TD>
    </tr>
    </tbody>
        <tbody id='expTime' name='expTime' style='display:none'>
        <td class='blue' nowrap>期望日期</td>
        <td colspan='3'>
            <input type='text' id='expect_time' name='expect_time' v_must="1" value="<%=dateStr%>" v_format = "yyyyMMdd" style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)'/>
            &nbsp;<font class="orange">*&nbsp;(格式:yyyymmdd)</font>
        </td>
    </tbody>
</table>
<%}%>

    <TABLE cellSpacing=0>
    	            <TR  id="grpnew">
    	<TD class="blue">手机号码</TD>
        <TD >
           <input type='text' id='single_phoneno1' name='single_phoneno1' maxlength='11' onblur='if(this.value != ""){if(!forMobil(this)){return false;}}' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_type="string" value="" />
             <input class="b_text" id="selectNo" onClick="Getsingle_phoneno()" type=button value="查询" />
            <font class='orange'>*</font>
                	<TD class="blue">成员用户ID</TD>
        <TD>
           <input type='text' id='single_phonenoname' name='single_phonenoname'  v_type="string" value="" />
            <font class='orange'>*</font>
        </TD>
        </TD>

    </TR>

    	<TR  id="grpnewoldoffer" style="display:none">
    	<TD class="blue">成员资费代码</TD>
        <TD >
           <input type='text' id='single_oldoffers' name='single_oldoffers'  v_type="string" value="" />
            <font class='orange'>*</font>
                	<TD class="blue">成员资费名称</TD>
        <TD>
           <input type='text' id='single_oldoffernames' name='single_oldoffernames'  v_type="string" value="" />
            <font class='orange'>*</font>
        </TD>
        </TD>

    </TR>
    <div id="chengyuanzifei"></div>
                    <TR  id="grpnewoffer">
    	<TD class="blue">原包年资费</TD>
        <TD>
           <input type='text' id='old_offerids' name='old_offerids' v_type="string" value="" readOnly/>
            <font class='orange'>*</font>
        </TD>
    	<TD class="blue">原包年资费名称</TD>
        <TD>
           <input type='text' id='old_offernames' name='old_offernames'   readOnly/>
            <font class='orange'>*</font>
        </TD>
    </TR>
                <TR  id="grpnewoffer">
    	<TD class="blue">新包年资费</TD>
        <TD>
           <input type='text' id='new_offerids' name='new_offerids' v_type="string" value="" />
             <input class="b_text" id="selectNo" onClick="Getbaonianzifei()" type=button value="选择" />
            <font class='orange'>*</font>
        </TD>
    	<TD class="blue">新包年资费名称</TD>
        <TD>
           <input type='text' id='new_offernames' name='new_offernames'  onblur='if(this.value != ""){if(!forMobil(this)){return false;}}' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' v_type="string" value="" />
            <font class='orange'>*</font>
        </TD>
    </TR>
  </talbe>
<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="previous" id="previous" type=button value="上一步" onclick="previouStep()" style='display:none'/>
            <input class="b_foot" name="sure" id="sure" type=button value="确认" onclick="
            if(document.all.inputType.value == 'file' || document.all.vpmnInputType.value == 'vpmnFile'){
                doUpload();
            }else{
                refMain();
            }
            " 
            <%
            if(!"vp".equals(iSmCode)){
                out.print(" disabled='true' ");
            }
            %>/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="清除" onClick="resetJsp()" />
            <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
    </TR>
</table>
<%}%>
<%if("1".equals(nextFlag)){%>

<div id="Operation_Table">
<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input name="next" id="next" class="b_foot"  type=button value="下一步" onclick="nextStep()" disabled />
            <input class="b_foot" name='clear1' id='clear1' type='button' value="清除" onClick="resetJsp()" />
            <input class="b_foot" name="close1"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
    </TR>
</table>
<%}%>
<input type='hidden' id='iRegionCode' name='iRegionCode' value='<%=regionCode%>' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<input type='hidden' id='work_no' name='work_no' value='<%=workNo%>' />
<input type='hidden' id='id_no' name='id_no' value='<%=id_no%>' />
<input type='hidden' id='org_code' name='org_code' value='<%=orgCode%>' />
<input name="ZHWW" type="hidden" id="ZHWW" value="0">
<input type='hidden' id='month_flag' name='month_flag' />
<input type="hidden" name="matureProdCode" id="matureProdCode" value="">
<input type='hidden' id='sysAccept' name='sysAccept' value='<%=sysAccept%>' />
<input type='hidden' id='op_note' name='op_note' />
<input type='hidden' id='user_type' name='user_type' value='<%=iUserType%>' />
<input type="hidden" name="nameList">
<input type="hidden" name="nameGroupList">	
<input type="hidden" name="fieldNamesList">
<input type="hidden" name="tmpR1" id="tmpR1" value="">
<input type="hidden" name="tmpR2" id="tmpR2" value="">
<input type="hidden" name="tmpR3" id="tmpR3" value="">
<input type="hidden" name="tmpR4" id="tmpR4" value="">
<input type="hidden" name="tmpR5" id="tmpR5" value="">
<input type='hidden' id='grp_name' name='grp_name' value='<%=iGrpName%>' />
<input type='hidden' id='iBizCode' name='iBizCode' value='<%=iBizCode%>' />
<input type='hidden' id='add_mode_flag' name='add_mode_flag' value='<%=addModeFlag%>' />
<input type='hidden' id='pay_list_show' name='pay_list_show' value='<%=payListShow%>' />
<input type='hidden' id='inputType' name='inputType' value='single' />
<input type='hidden' id='vpmnInputType' name='vpmnInputType' value='vpmnMulti' />
<input type='hidden' id='inputFile' name='inputFile' value='' />
<input type='hidden' id='request_type_flag' name='request_type_flag' value='' />
<input type='hidden' id='max_term_num_tmp' name='max_term_num_tmp' value='' />
<input type='hidden' id='add_term_num_tmp' name='add_term_num_tmp' value='' />
<input type='hidden' id='use_term_num_tmp' name='use_term_num_tmp' value='' />
<input type='hidden' id='attr' name='attr' value='' /><!--wanglma 20110428 存放默认的套餐名称 -->
<input type='hidden' id='phonNosLength' name='phonNosLength' value='' /><!--wanglma 20110428 存放提交号码的个数 -->
<input type='hidden' id='mobile_phone' name='mobile_phone' value='' /><!--wuxy 20100331 -->
<input type='hidden' id='phoneFlag' name='phoneFlag' value='' />
<input type='hidden' id='limitcount' name='limitcount'  value='<%=limitcount%>' /> <!--wangzn 091205-->
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<script type="text/javascript">
    /*提交到f7983_upload.jsp页面，用于上传附件，上传成功后调用refMain()方法。*/
    function doUpload()
	{
        <% if(resultList.length>0){ %>
        if(!checkDynaFieldValues(false)){
			return false;
		}
		<%}%>
        
        var ind1Str ="";
        var ind2Str ="";
        var ind3Str ="";
        var ind4Str ="";
        var ind5Str ="";
        
        /* vpmn时,拼写数据 */
        if($("#sm_code").val() == "vp"){
            if($("#vpmnInputType").val() == "vpmnMulti"){         //vpmn号码录入
                if( dyntb.rows.length == 2){//缓冲区没有数据
                    rdShowMessageDialog("没有指定成员号码，请增加数据!",0);
                    return false;
                }else{
                    for(var a=1; a<document.all.R0.length ;a++)//删除从tr1开始，为第三行
                    {
                        ind1Str =ind1Str +document.all.R1[a].value+"|";
                        ind2Str =ind2Str +document.all.R2[a].value+"|";
                        ind3Str =ind3Str +document.all.R3[a].value+"|";
                        ind4Str =ind4Str +document.all.R4[a].value+"|";
                        ind5Str =ind5Str +document.all.R5[a].value+"|";
                    }
                }
                
                //2.对form的隐含字段赋值
                
                document.all.tmpR1.value = ind1Str;
                document.all.tmpR2.value = ind2Str;
                document.all.tmpR3.value = ind3Str;
                document.all.tmpR4.value = ind4Str;
                document.all.tmpR5.value = ind5Str;
            }else{  //vpmn文件录入
                if($("#vpmnPosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#vpmnPosFile").focus();
                    return false;
                }
            }
            
            //wangzn 091205 B
           
            if(document.all.limitcount.value=="1"&&document.all.F80003.value=="0")
					{
							rdShowMessageDialog("该集团主资费不可使用，请为集团成员选择个人套餐资费!");
			        return false;
					}
					if(document.all.limitcount.value=="1"&&document.all.F80004.value=="0")
					{
							rdShowMessageDialog("该集团主资费不可使用，请为集团成员选择个人套餐资费!");
			        return false;
					}
            //wangzn 091205 E
            
        }else if($("#sm_code").val() == "np"){
            if($("#allPayFlag").val() == "1"){
                if($("#allFlag").val() == "0"){
                    if($("#cycleMoney").val() == ""){
                        rdShowMessageDialog("请您输入定额金额！",0);
                        $("#cycleMoney").focus();
                        return false;
                    }else{
                        if(!forMoney(document.all.cycleMoney)){
                            $("#cycleMoney").val("");
                            $("#cycleMoney").focus();
                            return false;
                       }
                    }
                }
                if($("#beginDate").val() == ""){
                    rdShowMessageDialog("请您输入开始时间！",0);
                    $("#beginDate").focus();
                    return false;
                }else{
                    if(!forDate(document.all.beginDate)){
                        $("#beginDate").val("");
                        $("#beginDate").focus();
                        return false;
                    }
                }
                
                if($("#endDate").val() == ""){
                    rdShowMessageDialog("请您输入结束时间！",0); 
                    $("#endDate").focus();
                    return false;
                }else{
                    if(!forDate(document.all.endDate)){
                        $("#endDate").val("");
                        $("#endDate").focus();
                        return false;
                    }
                }
                
                if($("#beginDate").val()<"<%=dateStr%>"){
                    rdShowMessageDialog("开始时间应不小于当前日期！",0);
                    $("#beginDate").val("");
                    $("#beginDate").focus();
                    return false;
                }
                
                if($("#beginDate").val() > $("#endDate").val()){
                    rdShowMessageDialog("结束时间应不小于开始日期！",0);
                    $("#endDate").val("");
                    $("#endDate").focus();
                    return false;
                }
            }
            
            if(document.all.input_type[0].checked){         //单个录入
                if($("#single_phoneno").val() == ""){
                    rdShowMessageDialog("成员用户手机号码不能为空！",0);
                    $("#single_phoneno").focus();
                    return false;
                }else{
                    if(!forMobil(document.all.single_phoneno)){
                        return false;
                    }
                }
            }else if(document.all.input_type[1].checked){    //批量录入
                if($("#multi_phoneNo").val() == ""){
                    rdShowMessageDialog("号码不能为空！",0);
                    $("#multi_phoneNo").focus();
                    return false;
                } else {	//2011/7/7 wanghfa添加 解决入参空格导致服务down掉
                	while ($("#multi_phoneNo").val().indexOf(" ") != -1) {
	                	$("#multi_phoneNo").val($("#multi_phoneNo").val().replace(" ", ""));
                	}
                }
            }else{
                if($("#PosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#PosFile").focus();
                    return false;
                }
            }
            
        } else if($("#sm_code").val() == "j1"){	//wanghfa添加此判断体 2010-12-6 10:40 移动总机j1接入BOSS系统
        	if ($("#inputType").val() == "file") {  //j1文件录入
                if($("#j1PosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#j1PosFile").focus();
                    return false;
                }
            }
        } else{
            if(document.all.input_type[0].checked){         //单个录入
                if($("#single_phoneno").val() == ""){
                    rdShowMessageDialog("成员用户手机号码不能为空！",0);
                    $("#single_phoneno").focus();
                    return false;
                }else{
                    if(!forMobil(document.all.single_phoneno)){
                        return false;
                    }
                }
            }else if(document.all.input_type[1].checked){    //批量录入
                if($("#multi_phoneNo").val() == ""){
                    rdShowMessageDialog("号码不能为空！",0);
                    $("#multi_phoneNo").focus();
                    return false;
                } else {	//2011/7/7 wanghfa添加 解决入参空格导致服务down掉
                	while ($("#multi_phoneNo").val().indexOf(" ") != -1) {
	                	$("#multi_phoneNo").val($("#multi_phoneNo").val().replace(" ", ""));
                	}
                }
            }else{
                if($("#PosFile").val() == ""){    //文件录入
                    rdShowMessageDialog("请选择文件！",0);
                    $("#PosFile").focus();
                    return false;
                }else{
                    var uploadfile = document.all.PosFile.value;
                	var ext = "*.txt";
                	var file_name = uploadfile.substr(uploadfile.lastIndexOf(".")); 
                	if(ext.indexOf("*"+file_name)==-1){   
                        rdShowMessageDialog("程序只支持txt格式文件(*.txt)！",0);  
                        return;  
                    }
                }
            }
            
            if($("#sm_code").val() == "AD" || $("#sm_code").val() == "ML" || $("#sm_code").val() == "MA"){
                if($("#request_type").val() == '03' || $("#request_type").val() == '04'){
                    if($("#expect_time").val() == ""){
                        rdShowMessageDialog("请输入期望日期！",0);
                        $("#expect_time").select();
                        $("#expect_time").focus();
                        return false;
                    }else{
						if(validDate(document.all.expect_time)==false) return false;
                    }
                }
            }
        }
        
        if($("#sm_code").val() == "ap" && document.all.input_type[0].checked){
            if(document.all.F81008 != null && document.all.F81008.value == "0"){
                if($("#F81002").val() == ""){
                    rdShowMessageDialog("请输入IP地址！",0);
                    $("#F81002").focus();
                    return false;
                }else{
                    if(!forIp(document.all.F81002)){
                        return false;
                    }
                }
            }
        }
        
        <%if("".equals(packFlag)){%>
            if($("#sm_code").val() != "CR"){
                if($("#addProductId").val() == ""){
                    rdShowMessageDialog("请您选择附加资费！",0);
                    $("#selectAdditive").focus();
                    return false;
                }
            }else{
                if($("#addProductIdCR").val() == ""){
                    rdShowMessageDialog("请您选择附加资费！",0);
                    $("#selectAdditiveCR").focus();
                    return false;
                }
            }
        <%}%>
        
        if($("#pay_flag").val()=="1" && $("#mebMonthFlag").val()=="N" && $("#matureFlag").val()=="Y" && $("#matureProdCode").val()==""){
            rdShowMessageDialog("请您选择包年转包月产品！",0);
            $("#matureProdCodeQuery").focus();
            return false;
        }
	    document.frm.target="hidden_frame";
	    document.frm.encoding="multipart/form-data";
	    document.frm.action="f7983_upload.jsp";
	    document.frm.method="post";
	    document.frm.submit();
	    $("#sure").attr("disabled",true);
	    //loading();
	}
	
</script>