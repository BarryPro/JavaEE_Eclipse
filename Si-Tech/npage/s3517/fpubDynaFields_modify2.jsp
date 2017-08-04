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
			out.print("<TR bgcolor='E8E8E8'>");
			out.print("<TD width='18%' colspan='4' align='center'><font color=red>以下输入域为该用户需要新增的项</font></TD>");
			out.print("</TR>");
		}
		//----添加其他行
		int i=0;
		int colspan = 1;
		//calcButtonFlag=0;
		
			while(i<fieldCount2)
			{
				out.print("<TR bgcolor='E8E8E8'>");
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
						out.print("<TD width='18%'><font color=green>"+fieldNames2[i]+"</font></TD>");
					}
					else
					{
						out.print("<TD width='18%'>"+fieldNames2[i]+"</TD>");
					}
					//判断是否是boolean型
					if (dataTypes2[i].equals("16"))//选择框
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' datatype="+dataTypes2[i]+"><option value='Y' ");
						if (fieldValues2[i].equals("Y"))
							out.print("selected");
						out.print(" >是</option><option value='N'>否</option></select> </TD>");
					}
					else if (dataTypes2[i].equals("17"))//下拉框
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' datatype="+dataTypes2[i]+" onchange='clearCalcFields(frm.F"+fieldCodes2[i]+");'>");
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
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes2[i]+"'";
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
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+i+"' name='F"+fieldCodes2[i]+"' class='button' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' readonly><label name=blue"+fieldCodes2[i]+" id=blue"+fieldCodes2[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes2[i]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+fieldCodes2[i]+");' value='"+fieldValues2[i]+"'></TD>");
					}
					else if (dataTypes2[i].equals("21"))//动态SQL下拉框
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes2[i]+"\" name=\"F"+fieldCodes2[i]+"\" datatype="+dataTypes2[i]+" onchange=\"clearCalcFields(frm.F"+fieldCodes2[i]+");\">");
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
					else {
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes2[i]+"' name='F"+fieldCodes2[i]+"' class='button' type='text' datatype="+dataTypes2[i]+" maxlength='"+fieldLengths2[i]+"' value='"+fieldValues2[i]+"'>");
						if(fieldCtrlInfos2[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
					
					i++;
				}
				out.print("</TR>");
			}
		
%>