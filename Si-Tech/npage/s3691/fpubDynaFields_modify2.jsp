<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
/*
	名称：动态生成字段
	
	使用方法介绍：
	该文件不能单独使用，需要fubDynaFields_modify.jsp include这个文件
	参照OPCODE：3508
	Author:wuln
*/
%>
<%
//----添加第一行

		if(fieldCount2>0){
		out.print("</table>");
		out.print("</div>");
        out.print("<div id='Operation_Table'>    ");
        out.print("<div class='title'>");
        out.print("<div id='title_zi'>该用户需要新增的项</div> ");
        out.print("</div>");
        out.print("<table cellspacing=0>");
			//out.print("<TR>");
			//out.print("<TD colspan='4' align='center'><font color=red>以下输入域为该用户需要新增的项</font></TD>");
			//out.print("</TR>");
		}
		//----添加其他行
		int i=0;
		int colspan = 1;
		//calcButtonFlag=0;
		
			while(i<fieldCount2)
			{
				out.print("<TR>");
				for (int colNum2 = 0; (colNum2 < 2) && (i < fieldCount2); colNum2 ++)
				{
					if (fieldCount2 - 1 == i)
					{
						colspan = 3;
					}
					else
					{
						colspan = 1;
					}
					if (fieldPurposes2[i].equals("10"))
					{
						out.print("<TD class=blue>"+fieldNames2[i]+"</TD>");
					}
					else
					{
						out.print("<TD class=blue>"+fieldNames2[i]+"</TD>");
					}
					//判断是否是boolean型
					if (dataTypes2[i].equals("16"))//选择框
					{
						out.print("<TD class=blue colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' datatype="+dataTypes2[i]+"><option value='Y' ");
						if (fieldValues2[i].equals("Y"))
							out.print("selected");
						out.print(" >是</option><option value='N'>否</option></select> </TD>");
					}
					else if (dataTypes2[i].equals("17"))//下拉框
					{
						out.print("<TD class=blue colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' datatype="+dataTypes2[i]+" onchange='clearCalcFields(frm.F"+fieldCodes2[i]+");'>");
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes2[i]))
							{
								out.print("<option ");
								if (fieldValues2[i].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes2[i].equals("19"))//计算字段
					{
						calcButtonFlag=1;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where user_type='"+ userType+ "' and field_code='"+fieldCodes2[i]+"'";
							//retArray = callView.sPubSelect("1",sqlStr);
							%>
								<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode20" retmsg="retMsg20" outnum="1">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="formula20" scope="end" />
							<%
							//formula = (String[][])retArray.get(0);
							formula=formula20;
						}
						catch(Exception e)
						{
							//logger.error("Call sunView is Failed!");
						}
						out.print("<TD class=blue colspan="+colspan+"> <input id='F"+fieldCodes2[i]+i+"' name='F"+fieldCodes2[i]+"' class='button' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' readonly><label name=blue"+fieldCodes2[i]+" id=blue"+fieldCodes2[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes2[i]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+fieldCodes2[i]+");' value='"+fieldValues2[i]+"'></TD>");
					}
					else if (dataTypes2[i].equals("21"))//动态SQL下拉框
					{
						out.print("<TD class=blue colspan="+colspan+"> <select id=\"F"+fieldCodes2[i]+"\" name=\"F"+fieldCodes2[i]+"\" datatype="+dataTypes2[i]+" onchange=\"clearCalcFields(frm.F"+fieldCodes2[i]+");\">");
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes2[i]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql[j][1];
								
								while(true)
                                {
                                    int startPos = sqlStr.indexOf('<');
                                    if(startPos<0)
                                        break;
                                        
                                    int endPos = sqlStr.indexOf('>');
                                    if(endPos<0)
                                    	break;
                                    
                                    String tempName = sqlStr.substring(startPos+1,endPos);
                                    String tempValue = "";
                                    if(hm.containsKey(tempName))
                                    	tempValue = (String)hm.get(tempName);
                                    	
                                    sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
                                }                                
                                  
								System.out.println("sqlStr="+sqlStr);
								
								//retArray = callView.sPubSelect("2",sqlStr);
								%>
									<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode21" retmsg="retMsg21" outnum="2">
										<wtc:sql><%=sqlStr%></wtc:sql>
										</wtc:pubselect>
									<wtc:array id="dynParamCodes20" scope="end" />
								<%
								//dynParamCodes = (String[][])retArray.get(0);
								dynParamCodes=dynParamCodes20;
								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues2[i].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
								   
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes2[i].equals("74"))//个性化行业应用 PAY_SI
                    {
                    	out.print("<TD width='32%'    >");
                    	
                    	out.print("<input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' maxlength=20 onkeyup='if(event.keyCode==13)getSi();' index='60'>");
                    	out.print("&nbsp;<input name=siQuery type=button id='siQuery' class='b_text' onMouseUp='getSi();' onKeyUp='if(event.keyCode==13)getSi();' style='cursor:hand' value=查询>&nbsp;");
                    	
                    	if(fieldCtrlInfos2[i].equals("N"))
                    	{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
                    }
                    
                    else if (dataTypes2[i].equals("22"))//密码输入框
					{
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' class='button' type='password' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='"+fieldValues2[i]+"'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}	
					else if (dataTypes2[i].equals("32"))//彩铃业务中管理员帐户带校验按钮
					{
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='"+fieldValues2[i]+"'>&nbsp;<input class='b_text' name='check_Mng_user' type='button' onClick='check_mnguser()' size='30' value=校验>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("33"))//彩铃业务中帐户密码带默认值，且只能是数字
					{
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' type='password' v_type='0_9' v_minlength=6 maxlength=6 pwdlengthth='6' value='111111'>&nbsp;(6位数字)");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else if (dataTypes2[i].equals("09"))//BOSS侧VPMN中集团主费率或集团可选费率下拉框动态获取
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' v_must=0 v_type='string' index='10' ");
						if("10001".equals(fieldCodes2[i])){
						    out.print(" MULTIPLE='TRUE' ");						
						}
						out.print(" >");
                            String[][] result33 = null;
							
						try
							{
							    String mode_type_tmp = "";
    							if("10000".equals(fieldCodes2[i])){
    							    mode_type_tmp = "VpM0";
    							}else if("10001".equals(fieldCodes2[i])){
    							    mode_type_tmp = "VpA0";
    							}else{
    							    
    							}
    							
    							String[] inParams = new String[2];
								inParams[0] = "select mode_code,mode_code || '->' || mode_name"
								+"  from sBillModeCode"
								+" where region_code = substr(:org_code,1,2)"
								+"   and mode_type =:mode_type"
								+" and stop_time>=sysdate and power_Right<=:powerRight";
								inParams[1] = "org_code="+org_code+",mode_type="+mode_type_tmp+",powerRight="+powerRight;
		%>
								<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode444" retmsg="retMsg444" outnum="2">			
								<wtc:param value="<%=inParams[0]%>"/>	
								<wtc:param value="<%=inParams[1]%>"/>	
								</wtc:service>	
								<wtc:array id="resultTemp"  scope="end"/>
		<%
								result33 = resultTemp;
							}
							catch(Exception e)
							{
								System.out.println("取集团可选费率信息出错!");
							}
							if (result33 != null && result33.length>0)
							{
								System.out.println("result33.length"+result33.length);
								for(int xcott=0; xcott < result33.length; xcott ++)
								{
									out.println("<option value='" + result33[xcott][0] + "'>" + result33[xcott][1] + "</option>");
								}
							}
								
						out.print("</select>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("40"))//VPMN中业务区号带默认值
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        String[][] result33 = null;
                        String agentProvCode = "";
                        String servArea = "";
                        try
        {
                String sqlStr40 = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                
               <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
              	 <wtc:sql><%=sqlStr40%></wtc:sql>
             	  </wtc:pubselect>
            	 <wtc:array id="result_tu4" scope="end"/>             
                            
                            <%
                            if (result_tu4.length <= 0)
                            {
                            	logger.error("查询省代码出错失败!");
                            }
                            agentProvCode = result_tu4[0][0];
                    }catch(Exception e){
                            logger.error("查询集团省区号失败!");
                    }
        
                        try
                        {
                            String sqlStr40 = "select trim(toll_no) from sRegionCode where region_code = '" + regionCode + "'";
                            
                            %>
                            
                     <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                  	 <wtc:sql><%=sqlStr40%></wtc:sql>
                 	  </wtc:pubselect>
                	 <wtc:array id="result_tu5" scope="end"/>              
                            
                            <%
                            result33 = result_tu5;
                            int tollNum = result33.length;
                            if (tollNum <= 0)
                            {
                            	logger.error("查询业务区号失败!");
                            }
                			servArea = agentProvCode + "0" + result33[0][0] + "01";
                        }catch(Exception e){
                                logger.error("查询业务区号失败!");
                        }
                							
						
						out.print("<input  type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' size='20'  value='"+servArea+"' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type='0_9' index='12' readonly  Class='InputGrey'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else if (dataTypes2[i].equals("42"))//VPMN中SCP号带默认值
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        String[][] result33 = null;
                        
                        try																			
                        {
                                sqlStr ="select scp_id from  svpmnscp Where region_code='" + regionCode + "'"; 
                               //retArray = callView.sPubSelect("1",sqlStr);
                                %>
                                
                		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                  	 <wtc:sql><%=sqlStr%></wtc:sql>
                 	  </wtc:pubselect>
                	 <wtc:array id="result_tu6" scope="end"/>                
                                
                                
                                <%
                                result33 = result_tu6;
                        }catch(Exception e){
                                logger.error("Call sunView is Failed!");
                        }                        
                							
						
						out.print("<input  type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"'  size='20' onKeyPress='return isKeyNumberdot(0)' value='"+result33[0][0]+"' v_must=1 v_type='0_9' index='13'> (各地市不同)");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("43"))//VPMN中集团类型下拉框静态获取
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        
                        out.print("<select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"'>");
                        
                        if(workno.equals("aavg21")){

								out.print("<option value='0' selected >0->本地集团</option>");
                                out.print("<option value='1'>1->全省集团</option>");
                                out.print("<option value='2'>2->全国集团</option>");
                                out.print("<option value='3'>3->本地化省级集团</option>");

							}else{

                                out.print("<option value='0' selected >0->本地集团</option>");
                            }
                        out.print("</select>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("45"))//VPMN中用户功能集带默认值带按钮
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        
                        out.print("<input type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' size='36' value='220000221110000000010100000000000000' readonly  Class='InputGrey'>");
                        
						out.print("<input type='button' class='b_text' name='updateFlsg'  value='修改' onclick='call_flags()' v_must=1 v_type='string'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("47"))//VPMN中网内费率索引下拉框动态获取
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        
                        out.print("<select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' v_must=1 v_type='0_9'>");
                        String[][] result33 = null;
						 try
                        {
                                String sqlStr33 ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"+regionCode+"' and stop_time>=sysdate and power_right<="+powerRight+" order by feeindex";
                                %>
                                
                 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                  	 <wtc:sql><%=sqlStr33%></wtc:sql>
                 	  </wtc:pubselect>
                	 <wtc:array id="result_tu7" scope="end"/>               
                                
                                <%
                               
                                result33 = result_tu7;
                                int recordNum = result33.length;
                                for(int xCoTt=0;xCoTt<recordNum;xCoTt++){
                                        out.println("<option class='button' value='" + result33[xCoTt][0] + "'>" + result33[xCoTt][1] + "</option>");
                                }
                        }catch(Exception e){
                                logger.error("Call sunView is Failed!");
                        }

                        out.print("</select>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("48"))//只读文本框带静态默认值
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        
                        out.print("<input type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' size='20' value='"+fieldValues2[i]+"' readonly  Class='InputGrey' onKeyPress='return isKeyNumberdot(0)' v_must=0 v_type='0_9'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("60"))//VPMN中资费套餐生效日期带默认值动态获取
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                    	
                    	out.print("<input type='text'  id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' v_must=0 v_type='date' onKeyPress='return isKeyNumberdot(0)' value='"+addDate+"' size='20' >");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else if (dataTypes2[i].equals("70"))//ADC业务业务接入号带默认值动态获取
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                    	
                    	out.print("<input type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' v_type='0_9' v_must='1' v_maxlength='128' readOnly class='InputGrey' onblur='hiddenTip(this);'>");
                    	
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("71"))//ADC业务不允许下发时间段列表带弹出窗口设置
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                    	
                    	out.print("<input type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' maxlength='128' value='' size='30' readOnly>");
                    	out.print("&nbsp;<input type='button' name='setTimeBtn1' class='b_text' value='设置' onClick='setTime()' >&nbsp;");
                    	
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("72"))//ADC业务上行业务指令带弹出窗口设置
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                    	
                    	out.print("<input type='text' id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' maxlength='128' size='30' readOnly>");
                    	out.print("&nbsp;<input type='button' class='b_text' name='setMOBtn1' value='设置' onClick='setMO()' >&nbsp;");
                    	
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes2[i].equals("14"))//日期
					{
						String datestrss="";
						String vmuststr="";
							if("10835".equals(fieldCodes2[i])) {
								datestrss="";
							}else {
								datestrss=dateStr;
							}	
						if(fieldCtrlInfos[z].equals("N"))
						{
							 vmuststr="v_must=1";
						}else {
							 vmuststr="v_must=0";
						}	
										
						out.print("<TD width='32%' colspan="+colspan+">");
						out.print("<input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' type='text' onKeyPress='return isKeyNumberdot(0)' value='"+datestrss+"' size='20' maxlength='8'  "+vmuststr+"   v_type='date' v_format='yyyyMMdd'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
                    
                    
                    else if (dataTypes2[i].equals("65"))//M2M
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' datatype="+dataTypes2[i]+" onchange='ctrlF10340(frm.F"+fieldCodes2[i]+");' >");
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes2[i]))
							{
								out.print("<option ");
								if (fieldValues[i].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes2[i].equals("66"))//M2M
					{

						out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10340' id='divF10340'><input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"'  class='button' type='hidden' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='0'>&nbsp;");
						out.print("</div></TD>");
					}
					else if (dataTypes2[i].equals("67"))//M2M
					{
						out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"'  class='button' type='hidden' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='0' >&nbsp;");
						out.print("</div></TD>");
					}	
                    else if (dataTypes2[i].equals("10"))//整型
					{
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' class='button' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='"+fieldValues2[i]+"'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else {
						out.print("<TD class=blue colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' class='button' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='"+fieldValues2[i]+"'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					i++;
				}
				out.print("</TR>");
			}
		
%>
