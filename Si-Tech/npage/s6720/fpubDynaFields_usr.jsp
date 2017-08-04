<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%
/*
	名称：动态生成字段
	调用外部变量：
		int fieldCount=resultList.length;
		boolean isGroup = true;
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
		String []fieldDefValue=new String[fieldCount];
		String listShow;
	使用方法介绍：
		该文件不能单独使用，需要其他文件include这个文件
	参照OPCODE：3505、3508
	Author:lugz,yinyx
*/
%>
<%
	    		//组个数
    			int grpCount = 0;
    			iField = 0;
    			Vector vecGrp = new Vector();
    			Hashtable htGrp= new Hashtable();
    			
    			while(iField<fieldGroupNo.length)
    			{
    			    if(!fieldGroupNo[iField].equals("0"))
    			    {
	    			    if(vecGrp.contains(fieldGroupNo[iField]))
	    			    {
	    			    }
	    			    else
	    			    {
	    			        vecGrp.add(fieldGroupNo[iField]);
	    			        //组no,序号
	    			        htGrp.put(fieldGroupNo[iField],new Integer(iField));
	    			        grpCount++;
	    			    }
    			    }
    			  	    iField++;
    			}
	
	String [][]fieldCalcFieldReadOnlys=null;
	//下拉列表数据
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	String [] paraIn3 = new String[2];
	
	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode); 
	if(!hm.containsKey("workNo"))       hm.put("workNo",workNo);
	if(!hm.containsKey("org_code"))     hm.put("org_code",org_code);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);
	
%>
<%

	if (nextFlag==2)
	{
%>
<script language="javascript">
function calcFieldValue(calaField)//根据公式计算单个字段的值
{
<%
	
	try
	{
		sqlStr= "select field_code, ref_field_code,ref_field_value, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type =:userType"
				+" order by field_code, ref_field_code,ref_field_value";
			//retArray = callView.sPubSelect("4",sqlStr);
			
			paraIn3[0] = sqlStr;    
            paraIn3[1]="userType="+userType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode31" retmsg="retMsg31" outnum="4" >
            	<wtc:param value="<%=paraIn3[0]%>"/>
            	<wtc:param value="<%=paraIn3[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr31" scope="end"/>
<%

  			//fieldCalcFieldReadOnlys= (String[][])retArray.get(0);
        	if(retCode31.equals("000000")){
  			    fieldCalcFieldReadOnlys = retArr31;
  			}
		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	int iPos=0;

		for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
		{

			if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
			{
			    out.println("//目标字段是组外字段");
	    		out.println("if(typeof(document.frm.F" +userType+ fieldCalcFieldReadOnlys[i][0] + ".length)==\"undefined\")");
	    		out.println("{");
				out.println("	if ( document.frm.F" +userType+ fieldCalcFieldReadOnlys[i][0] + ".id == calaField.id)");
				out.println("	{");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("		if (document.frm.F" +userType+ fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
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
					out.println("			if(typeof(document.frm.F" +userType+ fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+userType+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					          
					
					
					fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F" + userType  
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
	    		out.println("	for(var n = 0 ; n < document.frm.F" +userType+ fieldCalcFieldReadOnlys[i][0] + ".length ; n++)");
	    		out.println("	{");
	    		out.println("		if ( document.frm.F" + userType + fieldCalcFieldReadOnlys[i][0] + "[n].id == calaField.id)");
	 			out.println("		{");
	 			if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
	 			out.println("			if (document.frm.F" +userType+ fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
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
					out.println("			if(typeof(document.frm.F" + userType + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+ userType + fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					            fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F" + userType
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
					+"	   and b.USER_TYPE =:userType";
		}
		else
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sUserTypeFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.busi_type = '1000'"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE =:userType";
		}
		//retArray = callView.sPubSelect("1",sqlStr);
		
		paraIn3[0] = sqlStr;    
        paraIn3[1]="userType="+userType;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode32" retmsg="retMsg32" outnum="1" >
        	<wtc:param value="<%=paraIn3[0]%>"/>
        	<wtc:param value="<%=paraIn3[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr32" scope="end"/>
<%

/*		//TODO 虚拟数据填充
			 String [][]s={
    		         {"10008"},
	    	         {"10004"}         
    		 };
    		  retArray.add(0,s);
	*/		
			//fieldCalcFields = (String[][])retArray.get(0);
			if(retCode32.equals("000000")){
			    fieldCalcFields = retArr32;
			}
			
			
	}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	
	int c = 0;
	while(c<fieldCount)
	{
		if(dataTypes[c].equals("19"))
		{
			if(fieldGroupNo[c].equals("0"))
			{
				out.println("document.frm.F" + userType +  fieldCodes[c]+ ".value = ''");
			}
			else
			{
				out.println("for(var n = 0 ; n < document.frm.F" + userType + fieldCodes[c] + ".length ; n++){");
				out.println("document.frm.F" +  userType + fieldCodes[c] + "[n].value = ''");
				out.println("}");
			}
		}
		c++;
	}

	for(int i = 0; i < fieldCalcFields.length; i ++)
	{
		if (!fieldCalcFields[i][0].trim().equals(""))
		{
			out.println("document.frm.F" +  userType + fieldCalcFields[i][0] + ".value = ''");
		}
	}

	//String [][]fieldCalcFieldReadOnlys=null;
	try
	{
		sqlStr= "select ref_field_code,ref_field_value,field_code, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type =:userType"
				+" order by ref_field_code,ref_field_value,field_code";
			//retArray = callView.sPubSelect("4",sqlStr);
			
			paraIn3[0] = sqlStr;    
            paraIn3[1]="userType="+userType;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode33" retmsg="retMsg33" outnum="4" >
            	<wtc:param value="<%=paraIn3[0]%>"/>
            	<wtc:param value="<%=paraIn3[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr33" scope="end"/>
    <%
/*			//TODO 虚拟数据填充
			//retArry = 
			String [][]s={
    		       	 {"10010","a","10008",":10005+10"}, 
    		         {"10010","a","10004",":10005*10+:10006"}    
    		 };
    		  retArray.add(0,s);
*/
			//fieldCalcFieldReadOnlys = (String[][])retArray.get(0);
			if(retCode33.equals("000000")){
			    fieldCalcFieldReadOnlys = retArr33;
			}
		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
	{
		if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
		{
			out.println("if ( document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][0] + ".id == selectId.id)");
			out.println("{");
			out.println("	if (selectId.value == '" + fieldCalcFieldReadOnlys[i][1] + "')");
			out.println("	{");
			out.println("		if(typeof(document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + ".length)!=\"undefined\")");
			out.println("		{");
			out.println("			for(var n = 0 ; n < document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + ".length ; n++)");
			out.println("			{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=false;");
				out.println("		document.all('blue" +  userType + fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=true;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='';");
			}
			out.println("			}");
			out.println("		}");
			out.println("		else");
			out.println("		{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + ".readOnly=false;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys[i][2] + "').style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys[i][2] + ".readOnly=true;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys[i][2] + "').style.display='';");
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

	
	
		for(int i = 0; i < fieldCalcFieldsLen; i ++)
		{
		
		out.println("if(typeof(document.frm.F" +  userType + fieldCalcFields[i][0] + ".length)==\"undefined\"){");
		out.println("if(!calcFieldValue(frm.F" +  userType + fieldCalcFields[i][0] + "))");
		out.println("return false;");
		out.println("}");
		out.println("else{");
		out.println("for(var n = 0 ; n < document.frm.F" +  userType + fieldCalcFields[i][0] + ".length ; n++){");
		out.println("if(!calcFieldValue(frm.F" +  userType + fieldCalcFields[i][0] + "[n]))");
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
function checkDynaFieldValues(haveCalc)//检查编辑框内数据是否合法，haveCalc:是否包含对计算字段的检查
{
	
	var ret=true;
	var reta=true;
	var retb=true;
	var checkValues_flag = false;
<%
	int iLen=0;
	while(iLen<fieldCount)
	{
		%>
		checkValues_flag = false;
		<%
			//如果字段可空，且为空，则正确return true ,Y-可空 N-不可空		
			if(fieldCtrlInfos[iLen].equals("Y"))
			{
			%>
			if(frm.F<%=userType%><%=fieldCodes[iLen]%>.value=='')
			checkValues_flag = true;
			<%
			}%>	
		if(!checkValues_flag)
		{			
		if(typeof(document.frm.F<%=userType%><%=fieldCodes[iLen]%>.length)=="undefined"){
		
			frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='10'){//整型
				 reta=parseInt(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
				 if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='11'){//浮点型
				reta=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
				if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='12'){//字符型
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=userType%><%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=userType%><%=fieldCodes[iLen]%>.value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='13'){//金额
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='14'){//日期
				ret=validDate(frm.F<%=userType%><%=fieldCodes[iLen]%>);
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='15')//日期时间
			{
				frm.F<%=userType%><%=fieldCodes[iLen]%>.value = frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(0,8)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(9,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(12,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(15,2)
				ret=validTotalDate(frm.F<%=userType%><%=fieldCodes[iLen]%>);
				frm.F<%=userType%><%=fieldCodes[iLen]%>.value = frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(0,8)
									+ " "
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(8,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(10,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(12,2)
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='17')//下拉框
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='18')//其他
				ret=true;
			else if ((frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='19')&&(haveCalc))//公式计算
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='20')//ip地址 add
			    ret=forIP(frm.F<%=userType%><%=fieldCodes[iLen]%>);//add
			if (!ret)
			{
				rdShowMessageDialog("数据输入类型不对!");
				//alert("数据输入类型不对!");
				frm.F<%=userType%><%=fieldCodes[iLen]%>.focus();
				return ret;
			}
		}
		else
		{
			for(var m = 0 ; m < document.frm.F<%=userType%><%=fieldCodes[iLen]%>.length ; m ++){

			//alert(document.frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value);
			frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='10'){//整型
				 reta=parseInt(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
				 if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='11'){//浮点型
				reta=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
				if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='12'){//字符型
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=userType%><%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='13'){//金额
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='14'){//日期
				ret=validDate(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='15')//日期时间
			{
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value = frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(9,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(12,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(15,2)
				ret=validTotalDate(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value = frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ " "
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(8,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(10,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(12,2)
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='17')//下拉框
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='18')//其他
				ret=true;
			else if ((frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='19')&&(haveCalc))//公式计算
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='20')//ip地址 add
			    ret=forIP(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);//add
			if (!ret)
			{
				rdShowMessageDialog("数据输入类型不对!");
				//alert("数据输入类型不对!");
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].focus();
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

        
<script language="javascript">
<%
		
		try
		{
			//静态下拉列表
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where busi_type = '1000' and user_type=:userType and param_code!='99'  order by param_order";
			//retArray = callView.sPubSelect("3",sqlStr);
			
			paraIn3[0] = sqlStr;    
            paraIn3[1]="userType="+userType;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode34" retmsg="retMsg34" outnum="3" >
            	<wtc:param value="<%=paraIn3[0]%>"/>
            	<wtc:param value="<%=paraIn3[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr34" scope="end"/>
    <%
    
			//fieldParamCodes = (String[][])retArray.get(0);
			if(retCode34.equals("000000")){
			    fieldParamCodes = retArr34;
			}
			//动态下拉列表
			sqlStr = "select field_code,param_sql from sUserFieldParamCode where busi_type = '1000' and user_type=:userType and param_code='99'  order by param_order";
			//retArray = callView.sPubSelect("2",sqlStr);
			
			paraIn3[0] = sqlStr;    
            paraIn3[1]="userType="+userType;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode35" retmsg="retMsg35" outnum="2" >
            	<wtc:param value="<%=paraIn3[0]%>"/>
            	<wtc:param value="<%=paraIn3[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr35" scope="end"/>
    <%
    
			//fieldParamSql = (String[][])retArray.get(0);
			if(retCode35.equals("000000")){
			    fieldParamSql = retArr35;
			}
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
//有几个组就做几次循环
for(Iterator i = vecGrp.iterator();i.hasNext();)
{
	String str = 	(String)i.next();
	int jsi = Integer.parseInt(str);
%>

var index<%=jsi%> = 0;
var varId = 50;
function segmentAdd<%=jsi%>(){
	<%
	htGrp.get(str);
	Vector v = new Vector();
	int ii = ((Integer)htGrp.get(str)).intValue();
	%>
	if(segMentTab<%=jsi%>.rows.length< eval(eval(<%out.print(fieldMaxRows[ii]);%>)+eval(2)))
	{
	segMentTab<%=jsi%>.bgcolor="#FFFFFF";
	var tr1 = "tr"+index<%=jsi%>;
	tr1=segMentTab<%=jsi%>.insertRow();
	tr1.bgcolor="E8E8E8";
	tr1.insertCell().innerHTML = '<td width="30"><input class=button type="button" name="del" value="删除" onclick="deleteIt<%=jsi%>(this)"></td>';
	
	while(true){
	<%
		
	int calcButtonFlag=0;
	String a = fieldGroupNo[ii];
   do{
    	 v.add(fieldCodes[ii]);			   
	%>
	tr1.insertCell().innerHTML = '<%
	int colspan = 1;
	if (fieldCount - 1 == ii)
	{
	colspan = 3;
	}
	else
	{
	colspan = 1;
	}
	
	
	//判断是否是boolean型
					if (dataTypes[ii].equals("16"))//选择框
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+"><option value=\"Y\" ");
						if (fieldValues[ii].equals("Y"))
							out.print("selected");
						out.print(" >是</option><option value=\"N\">否</option></select> </TD>");
					}
					else if (dataTypes[ii].equals("17"))//下拉框
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+ userType+ fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes[ii]))
							{
								out.print("<option ");
								if (fieldValues[ii].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value=\"" + fieldParamCodes[j][1] + "\">"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[ii].equals("19"))//计算字段
					{
						calcButtonFlag=1;
						calcButtonFlag_all=true;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes[ii]+"'";
							//retArray = callView.sPubSelect("1",sqlStr);
							
						%>
                        	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode36" retmsg="retMsg36"  outnum="1">
                            	<wtc:sql><%=sqlStr%></wtc:sql>
                            </wtc:pubselect>
                            <wtc:array id="retArr36" scope="end" />
                    	<%
							//formula = (String[][])retArray.get(0);
							if(retCode36.equals("000000")){
							    formula = retArr36;
							}
						}
						catch(Exception e)
						{
							logger.error("Call sunView is Failed!");
						}
						
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+ userType+ fieldCodes[ii]+"'+varId+'\" name=\"F"+ userType+ fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" readonly><label name=blue"+ userType +fieldCodes[ii]+" id=blue"+ userType +fieldCodes[ii]+" style=\"display:\"><font color=blue>*</font></label><input style=\"display:none\" name=\"calc"+fieldCodes[ii]+"\" type=button class=\"button\" value=计算 onclick=\"calcFieldValue(frm.F"+ userType+ fieldCodes[ii]+");\" value=\""+fieldValues[ii]+"\"></TD>");
					
						
					}
					else if (dataTypes[ii].equals("21"))//动态SQL下拉框
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+ userType+ fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes[ii]))
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
                            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode37" retmsg="retMsg37"  outnum="2">
                                	<wtc:sql><%=sqlStr%></wtc:sql>
                                </wtc:pubselect>
                                <wtc:array id="retArr37" scope="end" />
                        	<%
								//dynParamCodes = (String[][])retArray.get(0);
								if(retCode37.equals("000000")){
								    dynParamCodes = retArr37;
								}
								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues[ii].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
							}
						}
						out.print("</select> </TD>");
					}
					else {
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" value=\""+fieldValues[ii]+"\">");
						if(fieldCtrlInfos[ii].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
	
	
	
	%>';
			
					<%

	 ii++;
    if(ii>=iField)
    {
    	break;
    }
    }while(!v.contains(fieldCodes[ii])&&a.equals(fieldGroupNo[ii]));%>
    
						varId++;
						break;
						}	
	index<%=jsi%>= eval(index<%=jsi%>)+eval(1);
	}
}

function deleteIt<%=jsi%>(){

var args=deleteIt<%=jsi%>.arguments[0];
var objTD =args.parentElement;
var objTR =objTD.parentElement;
var currRowIndex = objTR.rowIndex;

segMentTab<%=jsi%>.deleteRow(currRowIndex); 

}
<%}%>


function spellList()
{
var nl = "";
var rowno = "";
var nameL = "";
<%
int len=0;
        
        
         
        	Vector v = new Vector();
     		
        	while(len<fieldCount)
        	{
        	
	        	if(v.contains(fieldCodes[len]))
	        	{
	        	
	        	}
	        	else
	        	{
	        	  	 //组nei
	        	    if(!fieldGroupNo[len].equals("0"))
	        	    {
	        	    //int num = new Integer(fieldGroupNo[len]).intValue()+1;
	        	    out.println("	for(var n = 0 ; n < eval(segMentTab" +fieldGroupNo[len] + ".rows.length-eval(2)) ; n++)");
		        	out.println("	{");
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno+eval(eval(n)+1)"+"+\"|\";");
		        	out.println("	}");
		        	 }
		        	 //组wai
	        	    else
	        	    {
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno"+"+\"0|\";");
		        	}
		        	v.add(fieldCodes[len]);
	        	}
        	len++;
        	}

%>
document.frm.nameList_usr.value=nl;
document.frm.nameGroupList_usr.value=rowno;
document.frm.fieldNamesList_usr.value = nameL;
	
}
</script>        
<%
	}//end if nextFlag==2
%>
                
   	  <TABLE cellSpacing=0 style="display:<%=listShow%>">
<%

	if (nextFlag==2)
	{
	
/*			String[][] fieldParamCodes = new String[][]{};
		try
		{
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where busi_type = '1000' and user_type='"+ userType+ "'";
			retArray = callView.sPubSelect("3",sqlStr);
			fieldParamCodes = (String[][])retArray.get(0);
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
	*/	
		int i=0;
		int colspan = 1;
		int calcButtonFlag=0;
		boolean tableFlag = false;
		boolean trFlag = false;
		Vector tr = new Vector();
		Vector trGrpNo = new Vector();
		Vector vecFieldCodes = new Vector();
		Vector vecGroupNo = new Vector();
		if (resultList_usr != null)
		{
			while(i<fieldCount)
			{
			
				if(tableFlag||i==0)
				{%>
				
				<TABLE id="segMentTab<%=fieldGroupNo[i]%>" cellSpacing=0 style="display:<%=listShow%>">
				<%}
				if(trFlag||i==0)
				{
				
					if(!fieldGroupNo[i].equals("0"))
					{
					//增加按钮
    				%>
    				<TR bgcolor='E8E8E8'><TD width='100%' colspan=100><b><%=fieldGroupName[i]%></b>&nbsp;&nbsp;最大行数<%=fieldMaxRows[i]%></TD></TR>
    				<TR bgcolor='E8E8E8'>
    				<TD width='20'><input type="button" name="addSegment<%=fieldGroupNo[i]%>" class="button"  value="增加" onclick="segmentAdd<%=fieldGroupNo[i]%>()"></TD>
    				<%
					}
					else
					{
					out.print("<TR bgcolor='E8E8E8'>");
					}
				//画同一个组的表头
    			int k=i;
    			if(!fieldGroupNo[k].equals("0"))
    			{
    				do{
    					 if(trGrpNo.contains(fieldCodes[k]))
    					  {
        					break;
    					  }
        				 else
        				  {
        					 trGrpNo.add(fieldCodes[k]);
        					 if (fieldPurposes[k].equals("10"))
									{
										out.print("<TD width='18%'><font color=green>"+fieldNames[k]+"</font></TD>");
									}
									else
									{
        						 out.print("<TD width='18%'>"+fieldNames[k]+"</TD>");
        					}
    					     k++;
        				  }
    				  }
    				while(k<fieldCount&&fieldGroupNo[k-1].equals(fieldGroupNo[k]));
    				
    				out.print("</TR>");
    				out.println("<TR bgcolor='E8E8E8'>");
    				out.print("<TD width='1%'></TD>");
    			}
    			    					
    			//同一个组分行时计数变量
    			int trGrpi = 0;
    			int trGrpk = 0;
				for (int colNum = 0; (colNum < 2) && (i < fieldCount)||!fieldGroupNo[i].equals("0"); colNum ++)
				{
					if (fieldCount - 1 == i)
					{
						colspan = 3;
					}
					else
					{
						colspan = 1;
					}
					
					if (fieldPurposes[i].equals("10")&&fieldGroupNo[i].equals("0"))
					{
						out.print("<TD width='18%'><font color=green>"+fieldNames[i]+"</font></TD>");
					}
					else
					{
						 if(!fieldGroupNo[i].equals("0"))
    					 {
    						if(tr.contains(fieldCodes[i]))
    						 {
	    						  trGrpk++;
	    						  if(trGrpk==trGrpi+1||trGrpk-1==0)
	    						   {
	    						      out.println("</TR>");
	    						      out.println("<TR bgcolor='E8E8E8'>");
	    						      out.print("<TD width='2%'></TD>");
	    						    }
    						  }
    					     else
    					      {
	    						  trGrpi++;
	    						  tr.add(fieldCodes[i]);
    					      }
    					  }
    					 else
    					 {
    						out.print("<TD width='18%'>"+fieldNames[i]+"</TD>");
    					 }
					}
					//判断是否是boolean型
					if (dataTypes[i].equals("16"))//选择框
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
						if (fieldValues[i].equals("Y"))
							out.print("selected");
						out.print(" >是</option><option value='N'>否</option></select> </TD>");
					}
					else if (dataTypes[i].equals("17"))//下拉框
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='clearCalcFields(frm.F"+ userType+ fieldCodes[i]+");'>");
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes[i]))
							{
								out.print("<option ");
								if (fieldValues[i].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[i].equals("19"))//计算字段
					{
						calcButtonFlag=1;
						calcButtonFlag_all=true;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes[i]+"'";
							//retArray = callView.sPubSelect("1",sqlStr);
						%>
                        	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode38" retmsg="retMsg38"  outnum="1">
                            	<wtc:sql><%=sqlStr%></wtc:sql>
                            </wtc:pubselect>
                            <wtc:array id="retArr38" scope="end" />
                    	<%
							//formula = (String[][])retArray.get(0);
							if(retCode38.equals("000000")){
							    formula = retArr38;
							}
						}
						catch(Exception e)
						{
							logger.error("Call sunView is Failed!");
						}
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+ userType+ fieldCodes[i]+i+"' name='F"+ userType+ fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' readonly><label name=blue"+ userType +fieldCodes[i]+" id=blue"+ userType +fieldCodes[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[i]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+ userType+ fieldCodes[i]+");' value='"+fieldValues[i]+"'></TD>");
					}
					else if (dataTypes[i].equals("21"))//动态SQL下拉框
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[i]+"\" name=\"F"+ userType+ fieldCodes[i]+"\" datatype="+dataTypes[i]+" onchange=\"clearCalcFields(frm.F"+ userType+ fieldCodes[i]+");\">");
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes[i]))
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
                            	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode39" retmsg="retMsg39"  outnum="2">
                                	<wtc:sql><%=sqlStr%></wtc:sql>
                                </wtc:pubselect>
                                <wtc:array id="retArr39" scope="end" />
                        	<%
								//dynParamCodes = (String[][])retArray.get(0);
								if(retCode39.equals("000000")){
								    dynParamCodes = retArr39;
								}
								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues[i].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
							}
						}
						out.print("</select> </TD>");
					}
					else {
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldDefValue[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
				
					//还有下一个字段
    				if((i+1)<fieldCount)
    				{
						//在同一个表中
						if(fieldGroupNo[i].equals(fieldGroupNo[i+1]))
						{
							tableFlag = false;
							trFlag = true;
						}
						//不再同一表中
						else if(!fieldGroupNo[i].equals(fieldGroupNo[i+1]))
						{
							tableFlag = true;
							trFlag = true;
							out.print("</TR>");
							i++;
							break;
						}
					}
					//没有下一个字段
    				else 
    				{
    					out.println("");
    					out.print("</TR>"); 
    					out.print("</TABLE>"); 
    					%>
    					
    					<TABLE cellSpacing=0 style="display:<%=listShow%>">
    					<%
    					i++;
    					break;
    				}
    						
    				i++;	
				}
				}
			}
		}
		if (calcButtonFlag==1)//如果有计算字段则显示计算按钮
		{
%>
<!--
			<TR bgcolor="E8E8E8">
				<TD colspan="4" align="center">
					<input value="计算蓝色星号的值" name=calcAll type=button id="calcAll" class="button" onMouseUp="calcAllFieldValues();" onKeyUp="if(event.keyCode==13)calcAllFieldValues();" style="cursor：hand">
				</TD>
			</TR>
-->
<%
		}
	}
%>

