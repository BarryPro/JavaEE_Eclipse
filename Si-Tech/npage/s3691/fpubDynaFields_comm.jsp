<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String regionCode = (String)session.getAttribute("regCode");
String workno = (String)session.getAttribute("workNo");
String powerRight = (String)session.getAttribute("powerRight");
System.out.println("gaopengSeeLog=====s3691==init=");
String z_G = request.getParameter("z");
String i_G = request.getParameter("i");
String userType = request.getParameter("userType");
String groupUserId = request.getParameter("groupUserId");
String addDate = request.getParameter("addDate");
String smCode = request.getParameter("smCode");
String busiFlag = request.getParameter("busiFlag");
String v_region_code = request.getParameter("v_region_code");

int z = Integer.parseInt(z_G);
int i = Integer.parseInt(i_G);
String m2mFlag1 = "N";
String m2mFlag2 = "N";

String[] dataTypes = (String[])request.getAttribute("dataTypes");
String[] fieldCodes = (String[])request.getAttribute("fieldCodes");
String[] updateFlag = (String[])request.getAttribute("updateFlag");
String[] fieldValues = (String[])request.getAttribute("fieldValues");
String[] fieldLengths = (String[])request.getAttribute("fieldLengths");
String[] fieldCtrlInfos = (String[])request.getAttribute("fieldCtrlInfos");
String[] fieldNames = (String[])request.getAttribute("fieldNames");

HashMap hm = (HashMap)request.getAttribute("hm");
String[][] fieldParamSql = (String[][])request.getAttribute("fieldParamSql");
String[][] fieldParamCodes = (String[][])request.getAttribute("fieldParamCodes");

int calcButtonFlag;
String sqlStr = "";
String iGrp_Id  = request.getParameter("grpIdNo");          //集团用户ID	add by haoyy
//判断是否是boolean型

					if (dataTypes[z].equals("16"))//选择框
					{
						out.print("<TD class=blue > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" ");
						if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
						out.print(" ><option value='Y' ");
						if (fieldValues[z].equals("Y"))
							out.print(" selected ");
						out.print(" >是</option><option value='N' ");
						if (fieldValues[z].equals("N"))
							out.print(" selected ");
						out.print(" >否</option></select> </TD>");
					}
					else if (dataTypes[z].equals("17"))//下拉框
					{
					
						out.print("<TD class=blue > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange='clearCalcFields(frm.F"+fieldCodes[z]+");' ");
						if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
						out.print(" >");
					boolean atLeastOne = false;
					System.out.println(" zhoubynnn " + fieldCodes[z]);
					System.out.println(" zhoubynnn " + smCode);
					System.out.println(" zhoubynnn " + busiFlag);
					if (("hl".equals(smCode)) || ("hj".equals(smCode) && "211".equals(busiFlag))){
					    for (int l=0; l < fieldParamCodes.length; l++){
							if (fieldParamCodes[l][0].equals(fieldCodes[z])){
							System.out.println("====fieldValues["+z+"]===="+fieldValues[z]);
							System.out.println("====fieldParamCodes["+l+"][1]===="+fieldParamCodes[l][1]);
								if (fieldValues[z].equals(fieldParamCodes[l][1])){
									atLeastOne = true;
								}
							} 
						}
					}else{
					    atLeastOne = true;
					}
						
System.out.println("s3691-1-1-1-1-1-1-1-1-1-1-1--1-1-"+atLeastOne);						
					if (atLeastOne){
								System.out.println("gaopengSeeLog=====s3691==atLeastOne="+atLeastOne);
								if("10818".equals(fieldCodes[z])){
    							System.out.println("gaopengSeeLog=====s3691===v_region_code=="+v_region_code);
    						
    							for (int l=0; l < fieldParamCodes.length; l++){
	    							if (fieldParamCodes[l][0].equals(fieldCodes[z])){
	    								
	    								String v_sub_fieldParamCodes = fieldParamCodes[l][1].substring(0,2);
	    								System.out.println("gaopengSeeLog=====s3691===v_sub_fieldParamCodes=="+v_sub_fieldParamCodes);
	    								if(v_region_code != null && !"".equals(v_region_code)){
	    									if(v_region_code.equals(v_sub_fieldParamCodes)){
	    										if(!"".equals(fieldParamCodes[l][1])){
			    									out.print("<option ");
			    									if (fieldValues[z].equals(fieldParamCodes[l][1])){
					    									out.print("selected");
				    								}
			    									out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
		    									}
		    									System.out.println("gaopengSeeLog=====s3691===fieldParamCodes["+l+"][1]=="+fieldParamCodes[l][1]);
		    									System.out.println("gaopengSeeLog=====s3691===fieldParamCodes["+l+"][2]=="+fieldParamCodes[l][2]);
		    								}
	    								}
	    							}
	    						}
	    					/*end add 对"营销区域"下拉列表内容进行处理 for 在CRM系统增加“营销区域”字段的需求@2015/4/22 */
    					}else{
    						for (int l=0; l < fieldParamCodes.length; l++)
    						{
    
    							if (fieldParamCodes[l][0].equals(fieldCodes[z]))
    							{
    								out.print("<option ");
    								if (fieldValues[z].equals(fieldParamCodes[l][1])){
    									out.print("selected");
    								}
    								out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
    							}
    						}
    					}
    						
    				} else {   				    
    				      if("10817".equals(fieldCodes[z])) {
    				      System.out.println("fieldParamCodes.length===================="+fieldParamCodes.length);	
    						  for (int l=0; l < fieldParamCodes.length; l++)
    						{  
    						if (fieldParamCodes[l][0].equals(fieldCodes[z]))
    							{
    							out.print("<option ");
    							out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
    							}
    							}
    						/*begin add 对"营销区域"下拉列表内容进行处理 for 在CRM系统增加“营销区域”字段的需求@2015/4/22 */
    						}else if("10818".equals(fieldCodes[z])){
    							System.out.println("gaopengSeeLog=====s3691===v_region_code=="+v_region_code);
    						
    							for (int l=0; l < fieldParamCodes.length; l++){
	    							if (fieldParamCodes[l][0].equals(fieldCodes[z])){
	    								
	    								String v_sub_fieldParamCodes = fieldParamCodes[l][1].substring(0,2);
	    								System.out.println("gaopengSeeLog=====s3691===v_sub_fieldParamCodes=="+v_sub_fieldParamCodes);
	    								if(v_region_code != null && !"".equals(v_region_code)){
	    									if(v_region_code.equals(v_sub_fieldParamCodes)){
		    									out.print("<option ");
		    									if (fieldValues[z].equals(fieldParamCodes[l][1])){
			    									out.print("selected");
			    								}
		    									out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
		    								}
	    								}
	    							}
	    						}
	    					/*end add 对"营销区域"下拉列表内容进行处理 for 在CRM系统增加“营销区域”字段的需求@2015/4/22 */
    						}else {
    				    out.print("<option value='' ></option>");
    				    }
    				}
    				
						out.print("</select> </TD>");
					}
					else if (dataTypes[z].equals("08"))//级联下拉列表
					{
						String outStr = "";
						out.print("<TD class=blue > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange=\"cascadeFields(this);\" ");
						if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
						out.print(" >");
						for (int l=0; l < fieldParamCodes.length; l++)
						{
					
							if (fieldParamCodes[l][0].equals(fieldCodes[z]))
							{
								out.print("<option ");
								if (fieldValues[z].equals(fieldParamCodes[l][1]))
									out.print("selected");
								%>
									<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode10" retmsg="retMsg10" outnum="2" >
								    	<wtc:sql>select config_code,config_name from sbizparamconfig where config_code != '99' and config_code IN(<%=fieldParamCodes[l][4]%>) and param_code = '<%=fieldParamCodes[l][3]%>' order by config_order  </wtc:sql>
								    </wtc:pubselect>
								    <wtc:array id="retArr10" scope="end"/>
						    	<%
						    	String[][] subFieldValues  = new String[][]{};
								String subFieldValue = "";
								if("000000".equals(retCode10)){
									subFieldValues = (String[][])retArr10;
									for(int k = 0 ;k < subFieldValues.length;k++)
									{
										subFieldValue = subFieldValue + "[\""+subFieldValues[k][0] +"\",\"" + subFieldValues[k][1]+"\"]" ;
										if(k < subFieldValues.length -1)
										{
										 subFieldValue = subFieldValue + ",";
										}
									}
								}
								out.print(" value='" + fieldParamCodes[l][1] + "'  subFieldCode=F"+fieldParamCodes[l][3]+" subFieldValues='["+subFieldValue+"]' >"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
						//out.print(outStr);
					}
					else if (dataTypes[z].equals("19"))//计算字段
					{
						calcButtonFlag=1;
						String [][] formula=null;
//						try
//						{
							sqlStr = "select formula from sUserFieldFormula where user_type='"+ userType+ "' and field_code='"+fieldCodes[z]+"'";

							//retArray = callView.sPubSelect("1",sqlStr);
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="1">
							<wtc:sql><%=sqlStr%></wtc:sql>
							</wtc:pubselect>
							<wtc:array id="formula1" scope="end" />

							<%

							formula=formula1;
//						}
//						catch(Exception e)
//						{
							
//						}
						out.print("<TD class=blue> <input id='F"+fieldCodes[z]+z+"' name='F"+fieldCodes[z]+"' class='button' type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' readonly><label name=blue"+fieldCodes[z]+" id=blue"+fieldCodes[z]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[z]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+fieldCodes[z]+");' value='"+fieldValues[z]+"'></TD>");
					}
					else if (dataTypes[z].equals("21"))//动态SQL下拉框
					{
						out.print("<TD class=blue > <select id=\"F"+fieldCodes[z]+"\" name=\"F"+fieldCodes[z]+"\" datatype="+dataTypes[z]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[z]+");\" ");
						if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
						out.print(" >");
						for (int s=0; s < fieldParamSql.length; s++)
						{
							if (fieldParamSql[s][0].equals(fieldCodes[z]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql[s][1];

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



								//retArray = callView.sPubSelect("2",sqlStr);
								%>
								<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="2">
									<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="dynParamCodes1" scope="end" />
								<%
								//dynParamCodes = (String[][])retArray.get(0);
								dynParamCodes=dynParamCodes1;

								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues[z].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[z].equals("22"))//密码输入框
					{
						out.print("<TD class=blue > <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' type='password' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"' ");
						if("N".equals(updateFlag[z])){
						    out.print(" readOnly class='InputGrey' ");
						}
						out.print(" >");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("43"))//VPMN中集团类型下拉框静态获取
					{
						out.print("<TD width='32%'    >");

                        out.print("<select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' ");
                        if("N".equals(updateFlag[z])){
                            out.print(" disabled ");
                        }
                        out.print(" >");

                        if(workno.equals("aavg21")){

								out.print("<option value='0' selected >0->本地集团</option>");
                                out.print("<option value='1'>1->全省集团</option>");
                                out.print("<option value='2'>2->全国集团</option>");
                                out.print("<option value='3'>3->本地化省级集团</option>");

							}else{
                                    out.print("<option value='0' selected >0->本地集团</option>");
                            }
                        out.print("</select>");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("45"))//VPMN中用户功能集带默认值带按钮
					{
						out.print("<TD width='32%'    >");

                        out.print("<input type='text' id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' size='36' value='"+fieldValues[z]+"' readonly  Class='InputGrey'>");

						out.print("<input type='button' class='b_text' name='updateFlsg'  value='修改' onclick='call_flags()' v_must=1 v_type='string' ");
						if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
						out.print(" >");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}

					else if (dataTypes[z].equals("47") || dataTypes[z].equals("78"))//VPMN中网内费率索引下拉框动态获取
					{
					    /* add by  wanglm 2010-8-12  显示以前选的胆识现在失效的网内费率信息 start*/
					    /*add by haoyy 2011-11-18 begin*/
					    if(workno.equals("aavg21"))/*aavg21工号可以办理13个地市的信息，获取办理的集团归属地市*/
					    {
							String sql2 = "";
							sql2="select b.region_code from dgrpusermsg a,dcustdoc b where a.cust_id=b.cust_id  and a.id_no="+iGrp_Id+" " ;
							System.out.println("aavg21 sql2==="+sql2);
							%>
                                 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg111" retcode="code111" routerKey="region" routerValue="<%=regionCode%>">
                  	                <wtc:sql><%=sql2%></wtc:sql>
                 	             </wtc:pubselect>
                	             <wtc:array id="resultnew" scope="end"/>

                              <%
							regionCode=resultnew[0][0];
							System.out.println("regionCode==="+regionCode);
					    }
					    /*add by haoyy 2011-11-18 end*/
					    String sql = "";
					    String offer_attr_type_sql = "VpJ0";
					    if(dataTypes[z].equals("78")) {
					    	offer_attr_type_sql = "VpW0";
					    }
					       /* yuanqs add 2011/6/16 10:46:50 */
					    sql =" select c.offer_id,c.offer_id||'-->'||c.offer_name from dgrpusermsgadd a,dgrpusermsg b ,product_offer c ,region d,sregioncode e where a.id_no=b.id_no and b.region_code=e.region_code and d.group_id=e.group_id and a.field_code='"+ fieldCodes[z] +"' and TO_NUMBER(trim(a.field_value)) = c.offer_id and a.id_no='"+groupUserId+"' and c.offer_id=d.offer_id ";

						out.print("<TD width='32%'    >");

                        out.print("<select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' v_must=1 v_type='0_9' ");
                        if("N".equals(updateFlag[z])){
						    out.print(" disabled ");
						}
                        out.print(" >");
                        String[][] result33 = null;

                        String dateStr1SqlStr33 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new java.util.Date()); //diling update@2011/10/8 增加分
			            String strTime[] = new String[5]; //diling update
	                    strTime = dateStr1SqlStr33.split("-");
	                    StringBuffer sqlBufSqlStr33 = new StringBuffer();

	                    sqlBufSqlStr33.append( " select a.offer_id,a.offer_id||'-->'||a.offer_name from  product_offer a ,svpmnfeeindexconfig b,region d,sregioncode e where a.offer_id != 0  and a.offer_attr_type='"+ offer_attr_type_sql +"'");
						sqlBufSqlStr33.append( " and a.offer_id=d.offer_id and d.group_id=e.group_id");
						sqlBufSqlStr33.append( " and e.region_code='"+regionCode+"' and a.exp_date>=sysdate ");
						sqlBufSqlStr33.append( " and a.eff_date<=sysdate");
						sqlBufSqlStr33.append( " and ( to_number(d.right_limit)<="+powerRight+")");
						sqlBufSqlStr33.append( " and ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null) )");
						sqlBufSqlStr33.append( " and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null) )");
						sqlBufSqlStr33.append( " and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null) )");
						sqlBufSqlStr33.append( " and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null) ) and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null) ) and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null) )  and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null) ) and ( to_number('"+strTime[3]+"')<=to_number(b.end_hours) or (b.end_hours is null) ) " );
						/** diling add@2011/10/2 增加开始分，结束分判断：新增系统时间的分钟数不小于svpmnfeeindex中的start_minute，小于svpmnfeeindex中的end_minute。 begin  **/
                        sqlBufSqlStr33.append(" and ( to_number('"+strTime[4]+"')>=to_number(b.start_minute) or (b.start_minute is null) )");

						sqlBufSqlStr33.append(" and ( to_number('"+strTime[4]+"')<to_number(b.end_minute) or (b.end_minute is null) )");
						/** diling add@2011/10/2 增加开始分，结束分判断：新增系统时间的分钟数不小于svpmnfeeindex中的start_minute，小于svpmnfeeindex中的end_minute。 end  **/
						sqlBufSqlStr33.append( " and a.offer_id = b.feeindex(+)");
						sqlBufSqlStr33.append( " and not exists(select 1 from  dgrpusermsgadd c where c.id_no= to_number('"+groupUserId+"') and c.field_code = '"+ fieldCodes[z]+"' and c.field_value = a.offer_id )");
						sqlBufSqlStr33.append( " order by a.offer_id");
//						 try
//                        {
                              %>
                                 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg111" retcode="code111" routerKey="region" routerValue="<%=regionCode%>">
                  	                <wtc:sql><%=sql%></wtc:sql>
                 	             </wtc:pubselect>
                	             <wtc:array id="result111" scope="end"/>

                              <%

								for(int ii=0;ii<result111.length;ii++){

								   out.println("<option class='button' value='" + result111[ii][0] + "' selected>" + result111[ii][1] + "</option>");
								}

                                /* add by  wanglm 2010-8-12  显示以前选的胆识现在失效的网内费率信息 end*/
                                //String sqlStr33 ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"+regionCode+"' and stop_time>=sysdate and power_right<="+powerRight+" order by feeindex";
                                String sqlStr33 = sqlBufSqlStr33.toString();
                                System.out.println("sqlStr33===="+sqlStr33);
                                %>

								<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
									<wtc:sql><%=sqlStr33%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_tu7" scope="end"/>

                                <%

                                result33 = result_tu7;
                                int recordNum = result33.length;
                                for(int xCoTt=0;xCoTt<recordNum;xCoTt++){
                                    if (fieldValues[z].equals(result33[xCoTt][0])){
                                        out.println("<option class='button' value='" + result33[xCoTt][0] + "' selected >" + result33[xCoTt][1] + "</option>");
                                    }else{
                                        out.println("<option class='button' value='" + result33[xCoTt][0] + "'>" + result33[xCoTt][1] + "</option>");
                                    }
                                }
//                        }catch(Exception e){
//                               logger.error("Call sunView is Failed!");
//                        }

                        out.print("</select>");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if(dataTypes[z].equals("79")){ //交易端口号
						out.print("<TD width='32%'    >");
						out.print("<input type='text' id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' maxlength='128' value='"+fieldValues[z]+"' size='20' readOnly>");
          	out.print("&nbsp;<input type='button' id='selExchgPortBtn' name='selExchgPortBtn' class='b_text' value='查询' onClick='selExchgPorts()' >&nbsp; ");
      	    if("N".equals(updateFlag[z])){
      	        out.print(" disabled ");
      	    }
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("71"))//ADC业务不允许下发时间段列表带弹出窗口设置
					{
						out.print("<TD width='32%'    >");

                    	out.print("<input type='text' id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' maxlength='128' value='' size='30' readOnly>");
                    	out.print("&nbsp;<input type='button' name='setTimeBtn1' class='b_text' value='设置' onClick='setTime()' ");
                	    if("N".equals(updateFlag[z])){
                	        out.print(" disabled ");
                	    }
                    	out.print(" >&nbsp;");

						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("72"))//ADC业务上行业务指令带弹出窗口设置
					{
						out.print("<TD width='32%'    >");

                    	out.print("<input type='text' id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' maxlength='128' size='30' readOnly>");
                    	out.print("&nbsp;<input type='button' class='b_text' name='setMOBtn1' value='设置' onClick='setMO()' ");
                    	if("N".equals(updateFlag[z])){
                	        out.print(" disabled ");
                	    }
                    	out.print(" >&nbsp;");

						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("14") || dataTypes[z].equals("60"))//日期
					{
							String datestrss22="";
							String vmuststr="";
							if("10835".equals(fieldCodes[z])) {
								datestrss22="";
							}else {
								datestrss22=addDate;
							}	
							if(fieldCtrlInfos[z].equals("N"))
						{
							 vmuststr="v_must=1";
						}else {
							 vmuststr="v_must=0";
						}	
							
						out.print("<TD width='32%'    ><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' type='text' onKeyPress='return isKeyNumberdot(0)' value='"+(("".equals(fieldValues[z]))?datestrss22:fieldValues[z])+"' size='20' maxlength='8'  "+vmuststr+"  v_type='date' v_format='yyyyMMdd' ");
						if("N".equals(updateFlag[z])){
                	        out.print(" readOnly class='InputGrey' ");
                	    }
						out.print(" >");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}

					else if (dataTypes[z].equals("65"))//M2M
					{
						out.print("<TD width='32%'  > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange='ctrlF10340(frm.F"+fieldCodes[z]+");' >");
						for (int t=0; t < fieldParamCodes.length; t++)
						{
							if (fieldParamCodes[t][0].equals(fieldCodes[z]))
							{
								out.print("<option ");
								if (fieldValues[z].equals(fieldParamCodes[t][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[t][1] + "'>"+fieldParamCodes[t][1]+"--" + fieldParamCodes[t][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");

						if ("11".equals(fieldValues[z])){
						    m2mFlag1 = "Y";
						}
					}
					else if (dataTypes[z].equals("66"))//M2M
					{
                        if("N".equals(m2mFlag1)){
    						out.print("<TD width='32%'> <div name ='divF10340' id='divF10340'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"'  class='button' type='hidden' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='0'>&nbsp;");
    					}else{
    					    out.print("<TD width='32%'> <div name ='divF10340' id='divF10340'><select id='F10340' name='F10340' datatype=66 onchange='ctrlF10341(frm.F10340);'><option  value='01' ");
                            if("00".equals(fieldValues[z])){
                                out.print(" selected ");
                            }
                            out.print(" >01--无专用APN</option><option  value='00' ");
                            if("01".equals(fieldValues[z])){
                                out.print(" selected ");
                            }
                            out.print(" >00--专用APN</option></select>");
    					}
						out.print("</div></TD>");

						if ("01".equals(fieldValues[z])){
						    m2mFlag2 = "Y";
						}
					}
					else if (dataTypes[z].equals("67"))//M2M
					{
					    if("N".equals(m2mFlag2)){
						    out.print("<TD width='32%'  > <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"'  class='button' type='hidden' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='0' >&nbsp;");
						}else{
						    out.print("<TD width='32%'  > <div name ='divF10341' id='divF10341'><input id='F10341' name='F10341'  class='button' type='text' datatype=67  value='"+fieldValues[z]+"'>&nbsp;<font class='orange'>*</font>");
						}
						out.print("</div></TD>");
					}
					else if (dataTypes[z].equals("74")) {//个性化行业应用 PAY_SI
            	out.print("<TD width='32%'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' maxlength=20 onkeyup='if(event.keyCode==13)getSi();' index='60' value='"+fieldValues[z]+"'>");
            	out.print("&nbsp;<input name=siQuery type=button id='siQuery' class='b_text' onMouseUp='getSi();' onKeyUp='if(event.keyCode==13)getSi();' style='cursor:hand' value=查询>&nbsp;");

            	if(fieldCtrlInfos[z].equals("N"))
            	{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
            }
            else if (dataTypes[z].equals("10"))//整型
					{
						if("LL".equals(smCode)){
							out.print("<TD width='22%'> <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)'  type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"' ");
						}else{
							out.print("<TD width='32%'> <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)'  type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"' ");
						}
						if("N".equals(updateFlag[z])){
      	      out.print(" readOnly class='InputGrey' ");
      	    }
      	    else
      	    {
      	    	out.print("  class='button' ");
      	    }
            out.print(" >");
						//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 start
						if ("10603".equals(fieldCodes[z])) out.print("&nbsp;(前四位区号+号码)");
						//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 end
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else {
						out.print("<TD> <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' type='");
						if ("10604".equals(fieldCodes[z])) out.print("password");
						//else out.print("text");
						out.print("' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"' ");
						if("N".equals(updateFlag[z])){
						    out.print(" readOnly class='InputGrey' ");
						}
						out.print(">");
						//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 start
						if ("10604".equals(fieldCodes[z])) out.print("&nbsp;(6-12位数字、字母或组合)");
						//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 end
						if(fieldCtrlInfos[z].equals("N")) out.print("&nbsp;<font class=\"orange\">*</font></TD>");
					}
%>
