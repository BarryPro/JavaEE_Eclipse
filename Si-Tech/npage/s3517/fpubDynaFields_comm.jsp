<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
//判断是否是boolean型
					if (dataTypes[z].equals("16"))//选择框
					{
						out.print("<TD width='32%' > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+"><option value='Y' ");
						if (fieldValues[z].equals("Y"))
							out.print("selected");
						out.print(" >是</option><option value='N'>否</option></select> </TD>");
					}
					else if (dataTypes[z].equals("17"))//下拉框
					{
						out.print("<TD width='32%' > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange='clearCalcFields(frm.F"+fieldCodes[z]+");'>");
						for (int l=0; l < fieldParamCodes.length; l++)
						{
					
							if (fieldParamCodes[l][0].equals(fieldCodes[z]))
							{
								out.print("<option ");
								if (fieldValues[z].equals(fieldParamCodes[l][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[z].equals("19"))//计算字段
					{
						calcButtonFlag=1;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes[z]+"'";
							
							//retArray = callView.sPubSelect("1",sqlStr);
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="1">
							<wtc:sql><%=sqlStr%></wtc:sql>
							</wtc:pubselect>
							<wtc:array id="formula1" scope="end" />
								
							<%

							//formula = (String[][])retArray.get(0);
							formula=formula1;
						}
						catch(Exception e)
						{
							
						}
						out.print("<TD width='32%' > <input id='F"+fieldCodes[z]+z+"' name='F"+fieldCodes[z]+"' class='button' type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' readonly><label name=blue"+fieldCodes[z]+" id=blue"+fieldCodes[z]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[z]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+fieldCodes[z]+");' value='"+fieldValues[z]+"'></TD>");
					}
					else if (dataTypes[z].equals("21"))//动态SQL下拉框
					{
						out.print("<TD width=\"32%\" > <select id=\"F"+fieldCodes[z]+"\" name=\"F"+fieldCodes[z]+"\" datatype="+dataTypes[z]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[z]+");\">");
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
                               
								System.out.println("sqlStr="+sqlStr);
								
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
						out.print("<TD width='32%' > <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' class='button' type='password' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"'>");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
					else if (dataTypes[z].equals("65"))//下拉框
					{
						out.print("<TD width='32%' > <select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange='ctrlF10340(frm.F"+fieldCodes[z]+");'>");
						for (int l=0; l < fieldParamCodes.length; l++)
						{
					
							if (fieldParamCodes[l][0].equals(fieldCodes[z]))
							{
								out.print("<option ");
								if (fieldValues[z].equals(fieldParamCodes[l][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[z].equals("66"))//下拉框
					{		if(fieldValues[z] == null || fieldValues[z].equals(""))
							{
								out.print("<TD width='32%'> <div name ='divF10340' id='divF10340'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"'  class='button' type='hidden' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='0'>&nbsp;");
								if(fieldCtrlInfos[z].equals("N"))
								{out.print("&nbsp;<font color=\"#FF0000\">*</font>");}
								out.print("</div></TD>");							
							}
					    	else
					    	{
								out.print("<TD width='32%' > <div name ='divF10340' id='divF10340'><select id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' datatype="+dataTypes[z]+" onchange='clearCalcFields(frm.F"+fieldCodes[z]+");'>");
								for (int l=0; l < fieldParamCodes.length; l++)
								{
		
							
									if (fieldParamCodes[l][0].equals(fieldCodes[z]))
									{
										out.print("<option ");
										if (fieldValues[z].equals(fieldParamCodes[l][1]))
											out.print("selected");
										out.print(" value='" + fieldParamCodes[l][1] + "'>"+fieldParamCodes[l][1]+"--" + fieldParamCodes[l][2]+ "</option>");
									}
								}
								out.print("</select> </div></TD>");
							}
					}
					else if (dataTypes[z].equals("67"))//下拉框
					{
						if(fieldValues[z] == null || fieldValues[z].equals(""))
						{
							out.print("<TD width='32%' > <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"'  class='button' type='hidden' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='0' >&nbsp;");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font>");}
							out.print("</div></TD>");
						}
						else
						{
							out.print("<TD width='32%' > <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' class='button' type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"'>");
							if(fieldCtrlInfos[z].equals("N"))
							{out.print("&nbsp;<font color=\"#FF0000\">*</font>");}
							out.print("</div></TD>");
						}
					}																
					else {
						out.print("<TD width='32%' > <input id='F"+fieldCodes[z]+"' name='F"+fieldCodes[z]+"' class='button' type='text' datatype="+dataTypes[z]+" maxlength='"+fieldLengths[z]+"' value='"+fieldValues[z]+"'>");
						if(fieldCtrlInfos[z].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					
					}
%>