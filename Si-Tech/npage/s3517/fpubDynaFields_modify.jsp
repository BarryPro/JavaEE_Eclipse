 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>
<TABLE  cellSpacing=0  style="display:<%=listShow%>">
<TABLE  cellSpacing=0  style="display:<%=listShow%>">


<%
//将原有数据和新增数据组成一个新的数组，用于数据验证，下拉菜单清空数据。
	int intField = fieldCount+fieldCount2;
	String[]fieldCodes_all = new String[intField];
	String []fieldCtrlInfos_all=new String[intField];
	String []fieldLengths_all = new String[intField];
	String []dataTypes_all =  new String[intField];
	String []fieldGrpNo_all =  new String[intField];
	for(int i=0;i<fieldCount;i++)
	{
		fieldCodes_all[i]=fieldCodes[i];
		fieldCtrlInfos_all[i]=fieldCtrlInfos[i];
		fieldLengths_all[i]=fieldLengths[i];
		dataTypes_all[i]=dataTypes[i];
		fieldGrpNo_all[i]=fieldGrpNo[i];
	}
	
	int tempFieldCount = fieldCount;
	for(int i=0;tempFieldCount<intField;tempFieldCount++,i++)
	{
		fieldCodes_all[tempFieldCount]=fieldCodes2[i];
		fieldCtrlInfos_all[tempFieldCount]=fieldCtrlInfos2[i];
		fieldLengths_all[tempFieldCount]=fieldLengths2[i];
		dataTypes_all[tempFieldCount]=dataTypes2[i];
		fieldGrpNo_all[tempFieldCount]="0";
	}


	String [][]fieldCalcFieldReadOnlys=null;
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	
	
	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode); 
	if(!hm.containsKey("workno"))       hm.put("workno",workno);
	if(!hm.containsKey("org_code"))     hm.put("org_code",org_code);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);
	
	try{
			//动态下拉列表
			sqlStr = "select field_code,nvl(param_sql,' ') from sUserFieldParamCode where busi_type = '1000' and user_type='"+ userType+ "' and param_code='99'";
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldParamSql1" scope="end" />
			<%
			//retArray = callView.sPubSelect("2",sqlStr);
			//fieldParamSql = (String[][])retArray.get(0);
			fieldParamSql=fieldParamSql1;
			}
			catch(Exception e)
			{
				
			}
			//out.println("huaxm:"+sqlStr);
%>

<script language="javascript">
function calcFieldValue(calaField)//根据公式计算单个字段的值
{
<%
	String [][]str1 = null;
	try
	{
		sqlStr= "select field_code, ref_field_code,ref_field_value, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type = '"+ userType+ "'"
				+" order by field_code, ref_field_code,ref_field_value";
			//retArray = callView.sPubSelect("4",sqlStr);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="4">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldCalcFieldReadOnlys1" scope="end" />
			<%
		  
  			//fieldCalcFieldReadOnlys = (String[][])retArray.get(0);
		  	fieldCalcFieldReadOnlys=fieldCalcFieldReadOnlys1;
        		
		}
	catch(Exception e)
	{
		
	}
	
	int iPos=0;

		for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
		{
			System.out.println("=================");
			System.out.println("================="+fieldCalcFieldReadOnlys[i][0].trim());
			System.out.println("=================");
			if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
			{
			    out.println("//目标字段是组外字段");
			    
	    		out.println("if(typeof(document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".length)==\"undefined\")");
	    		out.println("{");
				out.println("	if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".id == calaField.id)");
				out.println("	{");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("		if (document.frm.F" + fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
				out.println("		{");
				}
				//:12006+(:12002*:12005)
				//eval(frm.F12006.value)+(eval(frm.F12002.value)*eval(frm.F12005.value))
				out.println("		  var length = 1;");
				 String fma =fieldCalcFieldReadOnlys[i][3];
				while(true)
				{
				   
					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}
					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					
					       //如果参与运算的字段是组内的
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					          
					
					
					fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F"
								+fma.substring(iPos+1,iPos+1+5)
								+"\"+flagN"+fma.substring(iPos+1,iPos+1+5)+"+\".value\"))"
								+ fma.substring(iPos + 6, fma.length());
					out.println("			}");
						
					
				}
				out.println("       		var result = 0;");
				out.println("			if (calaField.readOnly)");
				out.println("			{");
				out.println("				for(var n = 0 ; n < length ; n++)");
	            out.println("				{");
				out.println("				result =result + eval(" + fma + ");");
				out.println("				}");
				out.println("				calaField.value = result;");
				out.println("			}");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("		}");
				}
				out.println("	}");
				out.println("}");
				
				out.println("//目标字段是组内字段");
	    		out.println("else{");
	    		out.println("	for(var n = 0 ; n < document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".length ; n++)");
	    		out.println("	{");
	    		out.println("		if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + "[n].id == calaField.id)");
	 			out.println("		{");
	 			if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
	 			out.println("			if (document.frm.F" + fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
				out.println("			{");
				}
				out.println("			var length = 1;");
				
				 fma =fieldCalcFieldReadOnlys[i][3];
				while(true)
				{
					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}
					
					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					
					         //如果参与运算的字段是组内的
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					            fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F"
								+fma.substring(iPos+1,iPos+1+5)
								+"\"+flagN"+fma.substring(iPos+1,iPos+1+5)+"+\".value\"))"
								+ fma.substring(iPos + 6, fma.length());
					out.println("			}");
					
					
				}
				out.println("		 	var result = 0;");
				out.println("			if (calaField.readOnly)");
				out.println("			{");
				
				out.println("				result =result + eval(" + fma + ");");
				
				out.println("				calaField.value = result;");
				out.println("			}");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("			}");
				}
				out.println("		}");
	    		out.println("	}");
				out.println("	}");
			}
		}
		out.println("return true;");
%>
}


function clearCalcFields(selectId)//当下拉框发生变化时,清空计算字段,并且重值各个编辑框的状态
{
<%
	String [][]fieldCalcFields=null;
	try
	{
		if (isGroup)
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sGrpSmFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.busi_type = '1000'"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE = '"+ userType+ "'";
		}
		else
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sUserTypeFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.busi_type = '1000'"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE = '"+ userType+ "'";
		}
		//retArray = callView.sPubSelect("1",sqlStr);
		%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="fieldCalcFields2" scope="end" />
		<%
		//fieldCalcFields = (String[][])retArray.get(0);
		fieldCalcFields=fieldCalcFields2;
			//out.println("huaxm3:"+sqlStr);
			
			
			
	}
	catch(Exception e)
	{
		
	}
	
	//使用新的数组，原有2个数组拼成的新书组
	int c = 0;
	while(c<intField)
	{
		if(dataTypes_all[c].equals("19"))
		{
			if(fieldGrpNo_all[c].equals("0"))
			{
				out.println("document.frm.F" + fieldCodes_all[c]+ ".value = ''");
			}
			else
			{
				out.println("for(var n = 0 ; n < document.frm.F" + fieldCodes_all[c] + ".length ; n++){");
				out.println("document.frm.F" + fieldCodes_all[c] + "[n].value = ''");
				out.println("}");
			}
		}
		c++;
	}
	


	for(int i = 0; i < fieldCalcFields.length; i ++)
	{
		if (!fieldCalcFields[i][0].trim().equals(""))
		{
			out.println("document.frm.F" + fieldCalcFields[i][0] + ".value = ''");
		}
	}

	
	try
	{
		sqlStr= "select ref_field_code,ref_field_value,field_code, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type = '"+ userType+ "'"
				+" order by ref_field_code,ref_field_value,field_code";
			//retArray = callView.sPubSelect("4",sqlStr);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="4">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldCalcFieldReadOnlys2" scope="end" />
			<%
			//fieldCalcFieldReadOnlys = (String[][])retArray.get(0);
			fieldCalcFieldReadOnlys=fieldCalcFieldReadOnlys2;
		}
	catch(Exception e)
	{
		
	}
	for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
	{
		if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
		{
			out.println("if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".id == selectId.id)");
			out.println("{");
			out.println("	if (selectId.value == '" + fieldCalcFieldReadOnlys[i][1] + "')");
			out.println("	{");
			out.println("		if(typeof(document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".length)!=\"undefined\")");
			out.println("		{");
			out.println("			for(var n = 0 ; n < document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".length ; n++)");
			out.println("			{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=false;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=true;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='';");
			}
			out.println("			}");
			out.println("		}");
			out.println("		else");
			out.println("		{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".readOnly=false;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "').style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".readOnly=true;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "').style.display='';");
			}
			out.println("		}");
			out.println("	}");
			out.println("}");
		}
	}
%>
}
function calcAllFieldValues()//计算所有计算字段的值
{


	
	if (!checkDynaFieldValues(false))
		return false;
		
	<%
	int fieldCalcFieldsLen=0;
	fieldCalcFieldsLen = fieldCalcFields.length;
	System.out.println("*******************************"+fieldCalcFields.length);
	if(fieldCalcFields!=null&&fieldCalcFields.length>0&&fieldCalcFields[0][0].equals(""))
	{	
		fieldCalcFieldsLen=0;	
	}
	
		for(int i = 0; i < fieldCalcFieldsLen; i ++)
		{
		
		out.println("if(typeof(document.frm.F" + fieldCalcFields[i][0] + ".length)==\"undefined\"){");
		out.println("if(!calcFieldValue(frm.F" + fieldCalcFields[i][0] + "))");
		out.println("return false;");
		out.println("}");
		out.println("else{");
		out.println("for(var n = 0 ; n < document.frm.F" + fieldCalcFields[i][0] + ".length ; n++){");
		out.println("if(!calcFieldValue(frm.F" + fieldCalcFields[i][0] + "[n]))");
		out.println("return false;");
		out.println("}");
		out.println("}");
		}
	
%>
	return true;
}
function JHshStrLen(sString)//计算字符串长度
{
	var sStr,iCount,i,strTemp ; 
	iCount = 0 ;
	sStr = sString.split("");
	for (i = 0 ; i < sStr.length ; i ++)
	{
		strTemp = escape(sStr[i]); 
		if (strTemp.indexOf("%u",0) == -1) // 表示是汉字
		{ 
		iCount = iCount + 1 ;
		} 
		else 
		{
		iCount = iCount + 2 ;
		}
	}
	return iCount ;
}

//使用新的数组，原有2个数组拼成的新书组
function checkDynaFieldValues(haveCalc)//检查编辑框内数据是否合法，haveCalc:是否包含对计算字段的检查
{
	
	var ret=true;
	var reta=true;
	var retb=true;
	var checkValues_flag = false;
	
<%
		
	int iLen=0;
	
	while(iLen<intField)
	{ 
%>
checkValues_flag = false;
<%
	//如果字段可空，且为空，则正确return true ,Y-可空 N-不可空		
			if(fieldCtrlInfos_all[iLen].equals("Y"))
			{
			%>
			if(frm.F<%=fieldCodes_all[iLen]%>.value=='')
				checkValues_flag = true;
			
			<%
			}%>	
		
		if(!checkValues_flag)
		{
			if(typeof(document.frm.F<%=fieldCodes_all[iLen]%>.length)=="undefined"){
			
				frm.F<%=fieldCodes_all[iLen]%>.datatype=<%out.println(dataTypes_all[iLen]);%>;
				
				if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='10'){//整型
					 reta=parseInt(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
					 if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>.value) > "<%=fieldLengths_all[iLen]%>"){
						 retb = false;
					   }
						 ret = reta && retb;
					}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='11'){//浮点型
					reta=parseFloat(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
					if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>.value) > "<%=fieldLengths_all[iLen]%>"){
						 retb = false;
					   }
						ret = reta && retb;
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='12'){//字符型
					//ret=true;
						//var reg = new RegExp(/^(\s)*$/);
						//var flag= reg.test(frm.F<%=fieldCodes_all[iLen]%>.value);
						
						flag=frm.F<%=fieldCodes_all[iLen]%>.value=='';
						reta=!flag;
						if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>.value) > "<%=fieldLengths_all[iLen]%>"){
						 retb = false;
					 }
						ret = reta && retb;
					}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='13'){//金额
					ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='14'){//日期
					ret=validDate(frm.F<%=fieldCodes_all[iLen]%>);
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='15')//日期时间
				{
					frm.F<%=fieldCodes_all[iLen]%>.value = frm.F<%=fieldCodes_all[iLen]%>.value.substr(0,8)
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(9,2)
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(12,2)
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(15,2)
					ret=validTotalDate(frm.F<%=fieldCodes_all[iLen]%>);
					frm.F<%=fieldCodes_all[iLen]%>.value = frm.F<%=fieldCodes_all[iLen]%>.value.substr(0,8)
										+ " "
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(8,2)
										+":"
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(10,2)
										+":"
										+ frm.F<%=fieldCodes_all[iLen]%>.value.substr(12,2)
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='16')//BOOL
					ret=true;
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='17')//下拉框
					ret=true;
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='18')//其他
					ret=true;
				else if ((frm.F<%=fieldCodes_all[iLen]%>.datatype=='19')&&(haveCalc))//公式计算
					ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='20')//ip地址 add
				    ret=forIP(frm.F<%=fieldCodes_all[iLen]%>);//add
				if (!ret)
				{
					rdShowMessageDialog("数据输入类型不对!");
					frm.F<%=fieldCodes_all[iLen]%>.focus();
					return ret;
				}
			}
			else
			{
			for(var m = 0 ; m < document.frm.F<%=fieldCodes_all[iLen]%>.length ; m ++){

			//alert(document.frm.F<%=fieldCodes_all[iLen]%>[m].value);
			frm.F<%=fieldCodes_all[iLen]%>[m].datatype=<%out.println(dataTypes_all[iLen]);%>;
			
			if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='10'){//整型
				 reta=parseInt(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
				 if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>[m].value) > "<%=fieldLengths_all[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='11'){//浮点型
				reta=parseFloat(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
				if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>[m].value) > "<%=fieldLengths_all[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='12'){//字符型
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=fieldCodes_all[iLen]%>.value);
					flag=frm.F<%=fieldCodes_all[iLen]%>[m].value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>[m].value) > "<%=fieldLengths_all[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='13'){//金额
				ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
			}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='14'){//日期
				ret=validDate(frm.F<%=fieldCodes_all[iLen]%>[m]);
			}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='15')//日期时间
			{
				frm.F<%=fieldCodes_all[iLen]%>[m].value = frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(0,8)
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(9,2)
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(12,2)
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(15,2)
				ret=validTotalDate(frm.F<%=fieldCodes_all[iLen]%>[m]);
				frm.F<%=fieldCodes_all[iLen]%>[m].value = frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(0,8)
									+ " "
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(8,2)
									+":"
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(10,2)
									+":"
									+ frm.F<%=fieldCodes_all[iLen]%>[m].value.substr(12,2)
			}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='17')//下拉框
				ret=true;
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='18')//其他
				ret=true;
			else if ((frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='19')&&(haveCalc))//公式计算
				ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='20')//ip地址 add
			    ret=forIP(frm.F<%=fieldCodes_all[iLen]%>[m]);//add
			if (!ret)
			{
				rdShowMessageDialog("数据输入类型不对!");
				//alert("数据输入类型不对!");
				frm.F<%=fieldCodes_all[iLen]%>[m].focus();
				return ret;
			}
			}
		}
	}//end if(!checkValues_flag)
<%
		iLen++;
	}//end while

%>	

	return true;
}


</script>

<%
int beginGroup=0;
int isNextGroup=1;
int rowNum=1;
int colNum=1;
int haveField=0;
int p=0;
int z =0;
boolean flag = true;
int calcButtonFlag=0;

		try
		{
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where busi_type = '1000' and user_type='"+ userType+ "'";
			//retArray = callView.sPubSelect("3",sqlStr);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="3">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldParamCodes3" scope="end" />
			<%

			//fieldParamCodes = (String[][])retArray.get(0);
			fieldParamCodes=fieldParamCodes3;
		}
		catch(Exception e)
		{
			
		}
			//out.println("huaxm2:"+sqlStr);
		
for(int i=0;i<fieldCodes.length;i++)
{
	if(fieldGrpNo[i].equals("0"))
	{
			
		if((i%2)==0)
		{
			out.print("<TR bgcolor='E8E8E8'>");
			if (fieldPurposes[i].equals("10"))
			{
				out.print("<TD width='18%'><font color=green>"+fieldNames[i]+"</font></TD>");
			}
			else
			{
				out.print("<TD width='18%'>"+fieldNames[i]+"</TD>");
			}
			z = i;
			%>
			  <%@ include file="fpubDynaFields_comm.jsp"%>
			<%
		}
		else
		{
			if (fieldPurposes[i].equals("10"))
			{
				out.print("<TD width='18%'><font color=green>"+fieldNames[i]+"</font></TD>");
			}
			else
			{
				out.print("<TD width='18%'>"+fieldNames[i]+"</TD>");
			}
			z = i;
			%>
			  <%@ include file="fpubDynaFields_comm.jsp"%>
			<%
			out.println("</TR>");
		}
			
	}
	else
	{
		if(flag)
		{
			if(i%2!=0)
			out.println("<TD width='18%'>&nbsp;</TD><TD width='18%'>&nbsp;</TD></TR>");
			flag=false;
		}
		
		if(isNextGroup==1)
		{
			beginGroup=i;
			isNextGroup=0;
		}
		
		//<画最后一个组>
		if(i==fieldCodes.length-1)
		{
			//<从beginGroup开始画组--beginGroup有组名>
			%>
			<TABLE  id="segMentTab<%=fieldGrpNo[i]%>" width=98% height=27 border=1 align="center" cellSpacing=1  bordercolor="#FFFFFF"  bgcolor="E8E8E8" style="display:<%=listShow%>">
				<TR bgcolor='E8E8E8'><TD width='100%' colspan=100><b><%=fieldGrpName[i]%></b></TD></TR>
				<TR bgcolor='E8E8E8'>
			<%
			for(int j=0;j<colNum;j++)
			{
				p=beginGroup+j*rowNum;
				if (fieldPurposes[p].equals("10"))
				{
					out.print("<TD width='18%'><font color=green>"+fieldNames[p]+"</font></TD>");
				}
				else
				{
					out.print("<TD width='18%'>"+fieldNames[p]+"</TD>");
				}
			}
			out.print("</TR>");
			
			//<画表格内容>
			for(int k=0;k<rowNum;k++)
			{
				//<画行>
				out.print("<TR bgcolor='E8E8E8'>");
				for(int j=0;j<colNum;j++)
				{
					p=beginGroup+k+j*rowNum;
					z = p;
					%>
			 		 <%@ include file="fpubDynaFields_comm.jsp"%>
					<%
				}
				out.print("</TR>");
			}
			out.println("</TABLE>");
			isNextGroup=1;
			haveField=0;
		}//如果是最后一行
		else
		{
		if(fieldGrpNo[i].equals(fieldGrpNo[i+1]))
			{
				if(fieldCodes[i].equals(fieldCodes[i+1]))
				{
					if(haveField==0)
						rowNum++;
				}
				else
				{
					colNum++;
					haveField=1;
				}
			}
			else
			{
			//<从beginGroup开始画组--beginGroup有组名>
			%>
			<TABLE  id="segMentTab<%=fieldGrpNo[i]%>" width=98% height=27 border=1 align="center" cellSpacing=1  bordercolor="#FFFFFF"  bgcolor="E8E8E8" style="display:<%=listShow%>">
				<TR bgcolor='E8E8E8'><TD width='100%' colspan=100><b><%=fieldGrpName[i]%></b></TD></TR>
				<TR bgcolor='E8E8E8'>
			<%
				for(int j=0;j<colNum;j++)
				{
					p=beginGroup+j*rowNum;
					if (fieldPurposes[p].equals("10"))
					{
						out.print("<TD width='18%'><font color=green>"+fieldNames[p]+"</font></TD>");
					}
					else
					{
						out.print("<TD width='18%'>"+fieldNames[p]+"</TD>");
					}
				}
				out.print("</TR>");
				
				//<画表格内容>
				for(int k=0;k<rowNum;k++)
				{
					//<画行>
					out.print("<TR bgcolor='E8E8E8'>");
					for(int j=0;j<colNum;j++)
					{
						p=beginGroup+k+j*rowNum;
						z = p;
						%>
			 			 <%@ include file="fpubDynaFields_comm.jsp"%>
						<%
					}
					out.print("</TR>");
				}
				
				isNextGroup=1;
				haveField=0;
				rowNum=1;
				colNum=1;
				
				out.println("</TABLE>");
			}
			
		}//如果不是最后一行
	}
}
		
		%>
	</tr>
		<TABLE width=98% height=27 border=1 align="center" cellSpacing=1 bordercolor="#FFFFFF"  bgcolor="E8E8E8" style="display:<%=listShow%>">
			 
			 
			  <%@ include file="fpubDynaFields_modify2.jsp"%>
		<%			  
		if (calcButtonFlag==1)//如果有计算字段则显示计算按钮
		{
		%>
		<TABLE width=98% height=27 border=1 align="center" cellSpacing=1 bordercolor="#FFFFFF"  bgcolor="E8E8E8" style="display:<%=listShow%>">
			<TR bgcolor="E8E8E8">
				<TD colspan="4" align="center">
					<input value="计算蓝色星号的值" name=calcAll type=button id="calcAll" class="button" onMouseUp="calcAllFieldValues();" onKeyUp="if(event.keyCode==13)calcAllFieldValues();" style="cursor：hand">
				</TD>
			</TR>
			</TABLE>
		<%	}%>
		
		<TABLE width=98% height=27 border=1 align="center" cellSpacing=1 bordercolor="#FFFFFF"  bgcolor="E8E8E8" style="display:<%=listShow%>">
		
<script language="javascript">
function spellList()//拼名字和行号
{
var nl = "";
var rowno = "";
var nlNew = "";
var rownoNew = "";
<%
int len=0;
        
        
        	Vector v = new Vector();
     		
     		//组nei
        	while(len<fieldCount)
        	{
        	
	        	if(v.contains(fieldCodes[len]))
	        	{
	        	
	        	}
	        	else
	        	{
	        	  	 //组nei
	        	    if(!fieldGrpNo[len].equals("0"))
	        	    {
	        	    //int num = new Integer(fieldGroupNo[len]).intValue()+1;
	        	    out.println("	for(var n = 0 ; n < eval(segMentTab" +fieldGrpNo[len] + ".rows.length-eval(2)) ; n++)");
		        	out.println("	{");
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno+eval(eval(n)+1)"+"+\"|\";");
		        	out.println("	}");
		        	 }
		        	 //组wai
	        	    else
	        	    {
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno"+"+\"0|\";");
		        	}
		        	v.add(fieldCodes[len]);
	        	}
        	len++;
        	}
        	
        	//新加域
        	len=0;
        	while(len<fieldCount2)
        	{
        			out.println("		nlNew=nlNew+\""+fieldCodes2[len]+"\"+\"|\";");
		        	out.println("		rownoNew=rownoNew"+"+\"0|\";");
		        	len++;
        	}

%>
document.frm.nameList.value=nl;
document.frm.nameGroupList.value=rowno;
document.frm.nameListNew.value=nlNew;
document.frm.nameGroupListNew.value=rownoNew;
	
}
</script>