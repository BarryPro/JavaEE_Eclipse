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
	
	//int intField = fieldCount+fieldCount2;
	int intField = fieldCount;
	System.out.println("22222222222222222222222222222222222222 intField = "+intField);
	System.out.println("22222222222222222222222222222222222222 fieldCount = "+fieldCount);
	System.out.println("22222222222222222222222222222222222222 fieldCount2 = "+fieldCount2);
	String[]fieldCodes_all = new String[intField];
	String []fieldNames_all = new String[intField];
	String []fieldCtrlInfos_all=new String[intField];
	String []fieldLengths_all = new String[intField];
	String []dataTypes_all =  new String[intField];
	String []fieldGrpNo_all =  new String[intField];
	for(int i=0;i<fieldCount;i++)
	{
	
		fieldCodes_all[i]=fieldCodes[i];
		fieldNames_all[i]=fieldNames[i];
		fieldCtrlInfos_all[i]=fieldCtrlInfos[i];
		fieldLengths_all[i]=fieldLengths[i];
		dataTypes_all[i]=dataTypes[i];
		fieldGrpNo_all[i]=fieldGrpNo[i];
	}
	
	int tempFieldCount = fieldCount;
	for(int i=0;tempFieldCount<intField;tempFieldCount++,i++)
	{
		fieldCodes_all[tempFieldCount]=fieldCodes2[i];
		fieldNames_all[tempFieldCount]=fieldNames2[i];
		fieldCtrlInfos_all[tempFieldCount]=fieldCtrlInfos2[i];
		fieldLengths_all[tempFieldCount]=fieldLengths2[i];
		dataTypes_all[tempFieldCount]=dataTypes2[i];
		fieldGrpNo_all[tempFieldCount]="0";
	}
for(int i=0;i<fieldCodes_all.length;i++){
    System.out.println("-----------------------"+i+"-----"+fieldCodes_all[i]);
    System.out.println("-----------------------"+i+"-----"+fieldNames_all[i]);
}
	String [][]fieldCalcFieldReadOnlys=null;
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	
	
	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode); 
	if(!hm.containsKey("workno"))       hm.put("workno",workno);
	if(!hm.containsKey("org_code"))     hm.put("org_code",org_code);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);
	
//	try{
	    
			//动态下拉列表
			sqlStr = "select field_code,nvl(param_sql,' ') from sUserFieldParamCode where user_type='"+ userType+ "' and param_code='99'";
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldParamSql1" scope="end" />
			<%
			//retArray = callView.sPubSelect("2",sqlStr);
			//fieldParamSql = (String[][])retArray.get(0);
			fieldParamSql=fieldParamSql1;
//			}
//			catch(Exception e)
//			{
				
//			}
			//out.println("huaxm:"+sqlStr);
%>
<%
	String  inParams_10818 [] = new String[2];
	inParams_10818[0] = "select region_code from dgrpusermsg where id_no=:idNo";
	inParams_10818[1] = "idNo="+paramsArray[0];
	String v_region_code = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_10818" retmsg="retMsg_10818" outnum="1"> 
		<wtc:param value="<%=inParams_10818[0]%>"/>
		<wtc:param value="<%=inParams_10818[1]%>"/> 
		</wtc:service>  
	<wtc:array id="ret_10818"  scope="end"/>
<%
	if("000000".equals(retCode_10818)){
		if(ret_10818.length > 0){
			v_region_code = ret_10818[0][0];
		}
	}
%>

<script language="javascript">
function validTime(inval)
{
  inval=inval+"";
  var theTime="";
  var one="";
  var flag="0123456789";
  for(i=0;i<inval.length;i++)
  { 
     one=inval.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTime+=one;
  }

  if(theTime.length!=6)
  {
	
	//obj.value="";
	
	return false;
  }
  else
  {
     var hour=theTime.substring(0,2);
	 var minute=theTime.substring(2,4);
	 var second=theTime.substring(4,6);
	 if(myParseInt(hour)<0 || myParseInt(hour)>24)
	 {
       
	   //obj.value="";
	   
       
	   return false;
	 }
     if(myParseInt(minute)<0 || myParseInt(minute)>60)
	 {
       
	   //
	   
       
	   return false;
	 }
     if(myParseInt(second)<0 || myParseInt(second)>60)
	 {
       
	   //
	   
       
	   return false;
	 }
  }
  return true;
}	
function segmentAdd(objBtn){
	var objTab = $(objBtn).parent().parent().parent().parent();
	
	
	if($(objTab).find("TR[class='content_tr']").size()<$(objTab).attr("maxRow"))
	{
		$(objTab).find("TR:last").after($(objTab).find("TR[class='pattern_tr']:last").clone());
		$(objTab).find("TR:last").attr("class","content_tr");
		$(objTab).find("TR:last").show();
	}
	else
	{
		return;	
	}
	
}
function segmentDel(objBtn){
	var objTr = $(objBtn).parent().parent();
	$(objTr).remove(); 
}
	
function calcFieldValue(calaField)//根据公式计算单个字段的值
{
<%
	String [][]str1 = null;
//	try
//	{
		sqlStr= "select field_code, ref_field_code,ref_field_value, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where user_type = '"+ userType+ "'"
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
        		
//		}
//	catch(Exception e)
//	{
		
//	}
	
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
//	try
//	{
		if (isGroup)
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sGrpSmFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE = '"+ userType+ "'";
		}
		else
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sUserTypeFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
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
			
			
			
//	}
//	catch(Exception e)
//	{
		
//	}
	
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

	
//	try
//	{
		sqlStr= "select ref_field_code,ref_field_value,field_code, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where user_type = '"+ userType+ "'"
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
//		}
//	catch(Exception e)
//	{
		
//	}
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
function checkInvalidTime()
{
	var chekTimeFlag = true;
	var invalidTimeList  = new Array();
	$('#segMentTab7').find("TR[class='content_tr']").each(function(i){
		var invalidTime = new Object();
		invalidTime.begin = Number($(this).find('#F00034').val());
		invalidTime.end = Number($(this).find('#F00035').val());
		invalidTime.index = i;
		if($(this).find('#F00034').val() != ""){
			if(!validTime($(this).find('#F00034').val())){
				rdShowMessageDialog("不允许下发开始时间格式有误，正确格式为“时时分分秒秒”，请重新输入！");
				//return false;
				chekTimeFlag = false;
			}
		}
		if($(this).find('#F00035').val() != ""){
			if(!validTime($(this).find('#F00035').val())){
				rdShowMessageDialog("不允许下发结束时间格式有误，正确格式为“时时分分秒秒”，请重新输入！");
				//return false;
				chekTimeFlag = false;
			}
		}
		
		invalidTimeList.push(invalidTime);
		if(($(this).find('#F00034').val() != "" )&& ($(this).find('#F00035').val() != "")){
			if($(this).find('#F00034').val()>=$(this).find('#F00035').val())
			{
				rdShowMessageDialog("不允许下发开始时间 应小于 不允许下发结束时间,请检查!");
				//return false;
				chekTimeFlag = false;
			}
		}
		
	});
	$(invalidTimeList).each(function(){
		var invalidTime = $(this);
		$(invalidTimeList).each(function(){
			if(invalidTime.index = this.index)
			{
				
			}else if((invalidTime.begin>=this.begin&&invalidTime.begin<=this.end)||
				(invalidTime.end>=this.begin&&invalidTime.end<=this.end)
			)
			{
				rdShowMessageDialog("不允下发时间段之间不能有交叉和包含,请检查!");
				//return false;
				chekTimeFlag = false;
			}
		});
	});
	return chekTimeFlag ;
}
//使用新的数组，原有2个数组拼成的新书组
function checkDynaFieldValues(haveCalc)//检查编辑框内数据是否合法，haveCalc:是否包含对计算字段的检查
{
	
	var ret=true;
	var reta=true;
	var retb=true;
	var checkValues_flag = false;
	
	var chekInvFlag = true;
	chekInvFlag = checkInvalidTime();
	if(!chekInvFlag){
		return false;
	}
	
<%
		
	int iLen=0;
	
	while(iLen<intField)
	{ 
%>
checkValues_flag = false;
<%
	//如果字段可空，且为空，则正确return true ,Y-可空 N-不可空		
			if(!fieldCtrlInfos_all[iLen].equals("N"))
			{
			//System.out.println(" zhoubys ++");
			%>
			if(frm.F<%=fieldCodes_all[iLen]%>.value=='' || frm.F<%=fieldCodes_all[iLen]%>.value==undefined)
				checkValues_flag = true;
			
			<%
			}%>	
		//wangzn add 模板里面的内容不校验
		var objTr = $("#F<%=fieldCodes_all[iLen]%>").parent().parent();
		if($(objTr).attr("class")=="pattern_tr")
		{
			checkValues_flag = true;
		}
		if($(objTr).size()==0){
			checkValues_flag = true;
		}
		
		if(!checkValues_flag)
		{
			if(typeof(document.frm.F<%=fieldCodes_all[iLen]%>.length)=="undefined"){
			
				frm.F<%=fieldCodes_all[iLen]%>.datatype=<%out.println(dataTypes_all[iLen]);%>;
				
				if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='10'){//整型
				     if(frm.F<%=fieldCodes_all[iLen]%>.value != ""){
				     	if (frm.F<%=fieldCodes_all[iLen]%>.value.substring(0,1) == "0") {
				     		reta = true;
				     	} else {
						    reta=parseInt(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
				     	}
					 }else{
					    reta=true;   
					 }
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
						
						flag=frm.F<%=fieldCodes_all[iLen]%>.value=='';
						reta=!flag;
						if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>.value) > "<%=fieldLengths_all[iLen]%>"){
						 retb = false;
					 }
						ret = reta && retb;
					if ("<%=fieldCodes_all[iLen]%>" == "10625") 
					{	
						var re10625=/^([0-9a-zA-Z\-]*)$/; 

						if(re10625.test(frm.F<%=fieldCodes_all[iLen]%>.value)==false)
						{
						 	ret = false;
						}
					}								
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 start*/
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='30'){//字母和数字的组合
					ret=forNumChar(frm.F<%=fieldCodes_all[iLen]%>);
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='31'){//中国移动手机号码
					ret=formobilesPhone(frm.F<%=fieldCodes_all[iLen]%>);
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 end*/
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='13'){//金额
					ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>.value)==frm.F<%=fieldCodes_all[iLen]%>.value;
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='14'){//日期
					ret=forDate(frm.F<%=fieldCodes_all[iLen]%>);
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
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='33') {
					if ("<%=fieldCodes_all[iLen]%>" == "10604") {	//wanghfa修改 移动总机接入BOSS需求
						var patrn=/^[a-zA-Z0-9]{6,12}$/;
						if(frm.F<%=fieldCodes_all[iLen]%>.value.search(patrn) == -1) ret = false;
					}
				}
				else ret=true;
				if (!ret) {
							if(typeof($("input[name='F10984']").val()) != "undefined" && "<%=flag_10635%>"!="0" ){
								
							}else{
								
					rdShowMessageDialog("<%=fieldNames_all[iLen]%>数据输入类型不对1!");
					frm.F<%=fieldCodes_all[iLen]%>.focus();
					return ret;
						}
				}
				if(!checkValues_flag) {
					if(frm.F<%=fieldCodes_all[iLen]%>!=null && frm.F<%=fieldCodes_all[iLen]%>.value=='') {
						rdShowMessageDialog("<%=fieldNames_all[iLen]%>不能为空!",0);
						frm.F<%=fieldCodes_all[iLen]%>.focus();
						return false;
					}
				}
			}
			else {
				for(var m = 0 ; m < document.frm.F<%=fieldCodes_all[iLen]%>.length ; m ++){//zhouby开始循环

			//alert(document.frm.F<%=fieldCodes_all[iLen]%>[m].value);
			frm.F<%=fieldCodes_all[iLen]%>[m].datatype=<%out.println(dataTypes_all[iLen]);%>;
			
			if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='10'){//整型
				 reta=parseInt(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
				 
				// zhouby alert("F<%=fieldCodes_all[iLen]%>[" + m + "]" + "  " + "F<%=fieldCodes_all[iLen]%>[" + m + "]");
				 //alert(frm.F<%=fieldCodes_all[iLen]%>[m].value + "  " + frm.F<%=fieldCodes_all[iLen]%>[m].value);
				 
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
					flag=frm.F<%=fieldCodes_all[iLen]%>[m].value=='';
					<% if (fieldCtrlInfos[iLen].equals("N")){%> // zhouby add 
					reta=!flag;
					<% }else {%>
					reta = true;
					<% }%>
					if(JHshStrLen(frm.F<%=fieldCodes_all[iLen]%>[m].value) > "<%=fieldLengths_all[iLen]%>"){
					 retb = false;
				 }
				 //alert(reta + ' ' + retb);
					ret = reta && retb;
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 start*/
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='30'){//字母和数字的组合
					ret=forNumChar(frm.F<%=fieldCodes_all[iLen]%>);
				}
				else if (frm.F<%=fieldCodes_all[iLen]%>.datatype=='31'){//中国移动手机号码
					ret=formobilesPhone(frm.F<%=fieldCodes_all[iLen]%>);
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 end*/
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='13'){//金额
				ret=parseFloat(frm.F<%=fieldCodes_all[iLen]%>[m].value)==frm.F<%=fieldCodes_all[iLen]%>[m].value;
			}
			else if (frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='14' || frm.F<%=fieldCodes_all[iLen]%>[m].datatype=='60'){//日期
				ret=forDate(frm.F<%=fieldCodes_all[iLen]%>[m]);
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
			if(typeof($(this).find('#F10984').val()) != "undefined" && "<%=flag_10635%>"!="0" ){
								
							}else{
				rdShowMessageDialog("<%=fieldNames_all[iLen]%>数据输入类型不对!" + frm.F<%=fieldCodes_all[iLen]%>[m].datatype);
				//alert("数据输入类型不对!");
				frm.F<%=fieldCodes_all[iLen]%>[m].focus();
				return ret;
				}
			}
			if(!checkValues_flag)
    		    {
    		    	if("<%=fieldNames_all[iLen]%>"=="账期"){
    		    	checkValues_flag==true;
    		    	}
    		    	if("<%=fieldNames_all[iLen]%>"=="营销区域"){
    		    	checkValues_flag==true;
    		    	}
        			else if(frm.F<%=fieldCodes_all[iLen]%>[m]!=null && frm.F<%=fieldCodes_all[iLen]%>[m].value==''){
        			    rdShowMessageDialog("<%=fieldNames_all[iLen]%>[m]不能为空!" + "<%=fieldCtrlInfos[iLen]%>",0);
        			    frm.F<%=fieldCodes_all[iLen]%>[m].focus();
        			    return false;
        			}
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

function cascadeFields(obj){
	var subCode =document.getElementById($(obj).find('option:selected').attr("subFieldCode"));
	//alert($(obj).find('option:selected').attr("subFieldValues"));
	var subValues =  $(obj).find('option:selected').attr("subFieldValues");
	var subValArr = eval(subValues);

	//alert(subCode.options.length);
	subCode.options.length=0;

	$(subValArr).each(function(){
		subCode.options.add(new Option(this[0]+'--'+this[1],this[0])); 
	});
	
	
}

$(document).ready(function(){
	
	//wangzn add 2012/2/19 16:21:27 初始化级联
	$("select").each(function(){
		
		if($(this).attr("datatype")=="08")
		{
			cascadeFields($(this));
		}
	}); 
	//计费类型  00免费，“单价”需填写0
  	if($('#F00022').val()=='00')
  	{
  		$('#F00051').val("0");
  		$('#F00051').attr("readOnly",true);
  		$('#F00051').attr("class",'InputGrey');
  	}
  	else
  	{
  		$('#F00051').removeAttr("readOnly");
  		$('#F00051').removeAttr("class");
  	}	
  	$("#F00022").bind("propertychange", function() { 
		
		if($('#F00022').val()=='00')
	  	{
	  		$('#F00051').val("0");
	  		$('#F00051').attr("readOnly",true);
	  		$('#F00051').attr("class",'InputGrey');
	  	}
	  	else
	  	{
	  		$('#F00051').removeAttr("readOnly");
  			$('#F00051').removeAttr("class");
	  	}
	});
	
	
  	
  	
}); 
var params = "";
// 查询交换机端口号
function selExchgPorts(){
		var grpIdNo = "<%=grpIdNo%>";
    var pageTitle = "交换机设备端口号查询";
    var fieldName = "端口号代码|设备端口号名称|集团客户名称|";
		var sqlStr="90000159";
    params = "<%=grpIdNo%>|";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "4|0|1|2|3|";
    var retToField = "F10775|";
    PubSimpSelExchgPorts(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelExchgPorts(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3690/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path += "&params="+params;
    var retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    $("#F10775").val(retInfo); //交换机端口号
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

//		try
//		{
		    if("AD".equals(userType) || "ML".equals(userType) || "MA".equals(userType) || "hj".equals(userType) || "hl".equals(userType) ||"RH".equals(userType)){
  				sqlStr = "select param_code,config_code,config_name,substr(config_sql,1,INSTR(config_sql,'|')-1),substr(config_sql,INSTR(config_sql,'|')+1,LENGTH(config_sql)) from sbizparamconfig where config_code != '99'";
  			}else{
  			   /*begin diling add for 合作类物联网业务BOSS功能开发及经分报表需求 @2012/8/6 */
  			  if("HW".equals(userType)){
  			    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~paramsArray[0]="+paramsArray[0]);
  			    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~paramsArray[9]="+paramsArray[9]);
  			    String inPar_HW [] = new String[2];
  			    inPar_HW[0] = "SELECT e.field_value "
                          +" FROM CGRPSMLIMIT D, dgrpusermsgadd E "
                          +" WHERE trim(D.LIMIT_VALUE) = E.field_value "
                          +" AND E.field_code = '1010' "
                          +" AND E.id_no = :idno "
                          +" AND D.LIMIT_TYPE = '11' "
                          +" AND D.LIMIT_FLAG = 'Y' "
                          +" AND D.SM_CODE = :smcode ";
            inPar_HW[1]="idno="+paramsArray[0]+",smcode="+paramsArray[9];
      %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_HW" retmsg="retMsg_HW" outnum="1" >
            <wtc:param value="<%=inPar_HW[0]%>"/>
            <wtc:param value="<%=inPar_HW[1]%>"/> 
            </wtc:service>
            <wtc:array id="ret_HW" scope="end"/>
      <%
             if("000000".equals(retCode_HW)){
              if(ret_HW.length>0){
                if(ret_HW[0][0]!=""){
                  System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~ret_HW[0][0]="+ret_HW[0][0]);
                  sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type='"+ ret_HW[0][0]+ "'";
                }
              }
            }else{
              sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type='"+ userType+ "'";
            }
  			    /*end diling add @2012/8/6*/
  			  }else{
  			    sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type='"+ userType+ "'";
  			  }
  			}
  			System.out.println("gaopengSeeLog=====s3691===sqlStr=="+sqlStr);
			//retArray = callView.sPubSelect("3",sqlStr);
			%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="5">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="fieldParamCodes3" scope="end" />
			<%

			//fieldParamCodes = (String[][])retArray.get(0);
			fieldParamCodes=fieldParamCodes3;
//		}
//		catch(Exception e)
//		{
			
//		}
			//out.println("huaxm2:"+sqlStr);
		
        if(fieldCount>0){		
    		out.print("</table>");
    		out.print("</div>");
            out.print("<div id='Operation_Table'>    ");
            out.print("<div class='title'>");
            out.print("<div id='title_zi'>用户资料信息</div> ");
            out.print("</div>");
            out.print("<table cellspacing=0>");
        }
        
        if("LL".equals(paramsArray[9])){
        	String appendTr="<tr style='display:none'><td class='blue' width='11%'>流量包类型</td><td colspan='5'><select  name='LLTypeSel' onchange='LLTypeSelChg();'><option value='0'>日包</option><option value='1' selected>月包</option><option value='2'>半年包</option><option value='3'>年包</option></select></td></tr>";
        	out.print(appendTr);
        }
        
for(int i=0;i<fieldCodes.length;i++)
{
	if(fieldGrpNo[i].equals("0"))
	{
	  if(fieldCodes.length == 1){
	    out.print("<TR style='display:block'>");
		if (fieldPurposes[i].equals("10"))
		{
			out.print("<TD class=blue><font color=green>"+fieldNames[i]+"</font></TD>");
		}
		else
		{
			
			if("LL".equals(paramsArray[9])){ //行业应用流量包
				out.print("<TD style='display:block' class=blue width='11%'>"+fieldNames[i]+"</TD>");
			}else{
				out.print("<TD class=blue width='18%'>"+fieldNames[i]+"</TD>");
			}
		}
		z = i;
		//diling update@2011/10/8 针对页面代码过大引发的报错问题，对页面引用方式进行修改。
		request.setAttribute("dataTypes",dataTypes);
		request.setAttribute("fieldCodes",fieldCodes);
		request.setAttribute("updateFlag",updateFlag);
		request.setAttribute("fieldValues",fieldValues);
		request.setAttribute("fieldParamCodes",fieldParamCodes);
		request.setAttribute("fieldLengths",fieldLengths);
		request.setAttribute("fieldParamSql",fieldParamSql);
		request.setAttribute("hm",hm);
		request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
		request.setAttribute("fieldNames",fieldNames);
		%>
		    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
		    	<jsp:param name="z" value="<%=z%>"  />
		    	<jsp:param name="userType" value="<%=userType%>"  />
		    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
		    	<jsp:param name="addDate" value="<%=addDate%>"  />
		    	<jsp:param name="i" value="<%=i%>"  />
		    	<jsp:param name="smCode" value="<%=paramsArray[9]%>"  />
		    	<jsp:param name="busiFlag" value="<%=busiFlag%>"  />
		    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
        </jsp:include>
		<%
		out.println("<TD class=blue colspan='2'>&nbsp;</TD></TR>");
	  }else{
		if((i%2)==0)
		{
			out.print("<TR style='display:block'>");
			if (fieldPurposes[i].equals("10"))
			{
				out.print("<TD class=blue><font color=green>"+fieldNames[i]+"</font></TD>");
			}
			else
			{
				if("LL".equals(paramsArray[9])){ //行业应用流量包
					out.print("<TD style='display:block' name='liuliangB' LLtype='"+liuliangs[i]+"'  class=blue width='14%'>"+fieldNames[i]+"</TD>");
				}else{
					out.print("<TD class=blue width='18%'>"+fieldNames[i]+"</TD>");
				}
			}
			z = i;
			
		request.setAttribute("dataTypes",dataTypes);
		request.setAttribute("fieldCodes",fieldCodes);
		request.setAttribute("updateFlag",updateFlag);
		request.setAttribute("fieldValues",fieldValues);
		request.setAttribute("fieldParamCodes",fieldParamCodes);
		request.setAttribute("fieldLengths",fieldLengths);
		request.setAttribute("fieldParamSql",fieldParamSql);
		request.setAttribute("hm",hm);
		request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
		request.setAttribute("fieldNames",fieldNames);
		%>
		    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
		    	<jsp:param name="z" value="<%=z%>"  />
		    	<jsp:param name="userType" value="<%=userType%>"  />
		    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
		    	<jsp:param name="addDate" value="<%=addDate%>"  />
		    	<jsp:param name="i" value="<%=i%>"  />
		    	<jsp:param name="smCode" value="<%=paramsArray[9]%>"  />
		    	<jsp:param name="busiFlag" value="<%=busiFlag%>"  />
		    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
        </jsp:include>
			<%
		}
	else
	{
		if (fieldPurposes[i].equals("10"))
		{
			out.print("<TD class=blue><font color=green>"+fieldNames[i]+"</font></TD>");
		}
		else
		{
			if("LL".equals(paramsArray[9])){ //行业应用流量包
				out.print("<TD class=blue width='10%'>"+fieldNames[i]+"</TD>");
			}else{
				out.print("<TD class=blue width='18%'>"+fieldNames[i]+"</TD>");
			}
		}
		z = i;
		request.setAttribute("dataTypes",dataTypes);
		request.setAttribute("fieldCodes",fieldCodes);
		request.setAttribute("updateFlag",updateFlag);
		request.setAttribute("fieldValues",fieldValues);
		request.setAttribute("fieldParamCodes",fieldParamCodes);
		request.setAttribute("fieldLengths",fieldLengths);
		request.setAttribute("fieldParamSql",fieldParamSql);
		request.setAttribute("hm",hm);
		request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
		request.setAttribute("fieldNames",fieldNames);
		%>
		    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
		    	<jsp:param name="z" value="<%=z%>"  />
		    	<jsp:param name="userType" value="<%=userType%>"  />
		    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
		    	<jsp:param name="addDate" value="<%=addDate%>"  />
		    	<jsp:param name="i" value="<%=i%>"  />
		    	<jsp:param name="smCode" value="<%=paramsArray[9]%>"  />
		    	<jsp:param name="busiFlag" value="<%=busiFlag%>"  />
		    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
        </jsp:include>
			<%
		if("LL".equals(paramsArray[9])){ //行业应用流量包
			//如后续新增流量包，则追加。如集团定义流量包fieldCode区间，可在此进行修改。
			System.out.println("gaopengSeeLog3691======fieldCodes[z]==="+fieldCodes[z]);
			//if("10681".equals(fieldCodes[z]) || "10682".equals(fieldCodes[z]) || "10683".equals(fieldCodes[z]) || "10762".equals(fieldCodes[z]) || "10763".equals(fieldCodes[z]) || "10764".equals(fieldCodes[z]) || "10765".equals(fieldCodes[z]) || "10766".equals(fieldCodes[z]) || "10767".equals(fieldCodes[z]) || "10778".equals(fieldCodes[z]) || "10822".equals(fieldCodes[z]) || "10823".equals(fieldCodes[z]) || "10824".equals(fieldCodes[z]) || "10830".equals(fieldCodes[z]) || "10831".equals(fieldCodes[z]) || "10832".equals(fieldCodes[z])|| "10906".equals(fieldCodes[z])|| "10907".equals(fieldCodes[z])){
				//System.out.println("gaopengSeeLog3691======fieldPurposes["+i+"]==="+fieldPurposes[i]);
				//System.out.println("gaopengSeeLog3691======fieldCodes[z]==="+fieldCodes[z]);
			if("0".equals(liuliangs[z]) || "1".equals(liuliangs[z]) || "2".equals(liuliangs[z]) || "3".equals(liuliangs[z])){
				if (fieldPurposes[i].equals("10")){
					System.out.println("gaopengSeeLog3691======fieldPurposes["+i+"]==="+fieldPurposes[i]);
					out.print("<TD id='acquScaleTd1' name='acquScaleTd1' class=blue style='display:none'><font color=green>赠送比例</font></TD>");
				}else{
					out.print("<TD id='acquScaleTd1' name='acquScaleTd1' class=blue width='10%' style='display:none'>赠送比例</TD>");
				}
				if("10906".equals(fieldCodes[z]) || "10907".equals(fieldCodes[z]) || "10962".equals(fieldCodes[z])
					|| "10990".equals(fieldCodes[z])
					|| "10992".equals(fieldCodes[z])
					|| "10994".equals(fieldCodes[z])
				){
					out.print("<TD id='acquScaleTd2' name='acquScaleTd2' width='22%' style='display:none'> <input id='F"+fieldCodes[z]+"' name='acquiescentScale'  type='text' v_fieldCodes='"+fieldCodes[z]+"' class='InputGrey' readonly value='0' onblur='checkshuzi(this)' /></TD>");
				}else{
					out.print("<TD id='acquScaleTd2' name='acquScaleTd2' width='22%' style='display:none'> <input id='F"+fieldCodes[z]+"' name='acquiescentScale'  type='text' v_fieldCodes='"+fieldCodes[z]+"' value='' onblur='checkshuzi(this)' /></TD>");
			 	}
			}
		}
		out.println("</TR>");
  }
      }	
	}
	else
		
	{
		if(flag)
		{
			if(i%2!=0)
			out.println("<TD class=blue>&nbsp;</TD><TD class=blue>&nbsp;</TD></TR>");
			flag=false;
		}
		
		if(isNextGroup==1)
		{
			beginGroup=i;
			isNextGroup=0;
		}
		
		String v_bordercolor = "#FFFFFF"; 
		String v_bgcolor = "E8E8E8";
		if(!"0".equals(manyPropertys[i])){ //为成组属性值时，改变样式
		  v_bordercolor = "#99BBDD"; 
		  v_bgcolor = "";
		}
		//<画最后一个组>
		if(i==fieldCodes.length-1)
		{
			//<从beginGroup开始画组--beginGroup有组名>
  		if(!"0".equals(manyPropertys[i])){//成组属性值时，在展示属性值下方增加滚轮
  	  %>
  	    </TABLE>
			  <div style="overflow-x:scroll;padding:0px;width:auto;" > 
  	  <%
  		}
			%>
			<TABLE  id="segMentTab<%=fieldGrpNo[i]%>" maxRow="<%=fieldMaxRow[i]%>"  minRow="<%=fieldMinRow[i]%>" width=98% height=27 border=1 align="center" cellSpacing=0  bordercolor="<%=v_bordercolor%>"  bgcolor="<%=v_bgcolor%>" style="display:<%=listShow%>">
				<TR bgcolor='<%=v_bgcolor%>'>
					<TD width='100%' colspan=100><b><%=fieldGrpName[i]%></b>
						&nbsp;
						&nbsp;最大行数<%=fieldMaxRow[i]%>
					</TD>
				</TR>
				<TR bgcolor='<%=v_bgcolor%>'>
					<TD width='1%'>
						<input type="button" name="addSegment<%=fieldGrpNo[i]%>" class="b_text"  value="增加" onclick="segmentAdd(this)">	
					</TD>
			<%
			//out.print("<TD width='1%'>&nbsp;</TD>");
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
				//<画一个用于新增行的隐藏模板>
				if(k==0)
				{
					out.print("<TR bgcolor='"+v_bgcolor+"' class='pattern_tr' style='display:none' >");
					out.print("<TD width='1%'><input type='button' name='addSegment"+fieldGrpNo[i]+"' class='b_text'  value='删除' onclick='segmentDel(this)'></TD>");
					for(int j=0;j<colNum;j++)
					{
						String[] fieldValuesNull = new String[fieldValues.length];
						for(int f=0;f<fieldValues.length;f++)
						{
							fieldValuesNull[f] = "";
						}
						
						p=beginGroup+k+j*rowNum;
						z = p;
						request.setAttribute("dataTypes",dataTypes);
						request.setAttribute("fieldCodes",fieldCodes);
						request.setAttribute("updateFlag",updateFlag);
						request.setAttribute("fieldValues",fieldValuesNull);
						request.setAttribute("fieldParamCodes",fieldParamCodes);
						request.setAttribute("fieldLengths",fieldLengths);
						request.setAttribute("fieldParamSql",fieldParamSql);
						request.setAttribute("hm",hm);
						request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
						request.setAttribute("fieldNames",fieldNames);
			%>
					    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
					    	<jsp:param name="z" value="<%=z%>"  />
					    	<jsp:param name="userType" value="<%=userType%>"  />
					    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
					    	<jsp:param name="addDate" value="<%=addDate%>"  />
					    	<jsp:param name="i" value="<%=i%>"  />
					    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
			       		</jsp:include>
			<%
					}
					out.print("</TR>");
				}
				//<画行>
				out.print("<TR bgcolor='"+v_bgcolor+"'class='content_tr'>");
				out.print("<TD width='1%'><input type='button' name='addSegment"+fieldGrpNo[i]+"' class='b_text'  value='删除' onclick='segmentDel(this)'></TD>");
				for(int j=0;j<colNum;j++)
				{
					p=beginGroup+k+j*rowNum;
					z = p;
		request.setAttribute("dataTypes",dataTypes);
		request.setAttribute("fieldCodes",fieldCodes);
		request.setAttribute("updateFlag",updateFlag);
		request.setAttribute("fieldValues",fieldValues);
		request.setAttribute("fieldParamCodes",fieldParamCodes);
		request.setAttribute("fieldLengths",fieldLengths);
		request.setAttribute("fieldParamSql",fieldParamSql);
		request.setAttribute("hm",hm);
		request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
		request.setAttribute("fieldNames",fieldNames);
		%>
		    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
		    	<jsp:param name="z" value="<%=z%>"  />
		    	<jsp:param name="userType" value="<%=userType%>"  />
		    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
		    	<jsp:param name="addDate" value="<%=addDate%>"  />
		    	<jsp:param name="i" value="<%=i%>"  />
		    	    <jsp:param name="smCode" value="<%=paramsArray[9]%>"  />
		    	<jsp:param name="busiFlag" value="<%=busiFlag%>"  />
		    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
        </jsp:include>
					<%
				}
				out.print("</TR>");
			}
			out.println("</TABLE>");
			if(!"0".equals(manyPropertys[i])){
			  out.println("</div>");
			}
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
			if(!"0".equals(manyPropertys[i])){
  	  %>
  	    </TABLE>
			  <div style="overflow-x:scroll;padding:0px;width:auto;" > 
  	  <%
  		}
			%>
			<TABLE  id="segMentTab<%=fieldGrpNo[i]%>" maxRow="<%=fieldMaxRow[i]%>"  minRow="<%=fieldMinRow[i]%>" width=98% height=27 border=0 align="center" cellSpacing=0  bordercolor="<%=v_bordercolor%>"  bgcolor="<%=v_bgcolor%>" style="display:<%=listShow%>">
				<TR bgcolor='<%=v_bgcolor%>'>
					<TD width='100%' colspan=100><b><%=fieldGrpName[i]%></b>
						&nbsp;
						&nbsp;最大行数<%=fieldMaxRow[i]%>
					</TD>
				</TR>
				<TR bgcolor='<%=v_bgcolor%>'>
					<TD width='1%'>
						<input type="button" name="addSegment<%=fieldGrpNo[i]%>" class="b_text"  value="增加" onclick="segmentAdd(this)">
					</TD>
			<%
				//out.print("<TD width='1%'>&nbsp;</TD>");
				for(int j=0;j<colNum;j++)
				{
					p=beginGroup+j*rowNum;
					
					System.out.println(" zhoubyx + + + " + fieldNames[p]);
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
					//<画一个用于新增行的隐藏模板>
					if(k==0)
					{
						out.print("<TR bgcolor='"+v_bgcolor+"' class='pattern_tr' style='display:none' >");
						out.print("<TD width='1%'><input type='button' name='addSegment"+fieldGrpNo[i]+"' class='b_text'  value='删除' onclick='segmentDel(this)'></TD>");
						for(int j=0;j<colNum;j++)
						{
							String[] fieldValuesNull = new String[fieldValues.length];
							for(int f=0;f<fieldValues.length;f++)
							{
								fieldValuesNull[f] = "";
							}
							p=beginGroup+k+j*rowNum;
							z = p;
							request.setAttribute("dataTypes",dataTypes);
							request.setAttribute("fieldCodes",fieldCodes);
							request.setAttribute("updateFlag",updateFlag);
							request.setAttribute("fieldValues",fieldValuesNull);
							request.setAttribute("fieldParamCodes",fieldParamCodes);
							request.setAttribute("fieldLengths",fieldLengths);
							request.setAttribute("fieldParamSql",fieldParamSql);
							request.setAttribute("hm",hm);
							request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
							request.setAttribute("fieldNames",fieldNames);
				%>
						    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
						    	<jsp:param name="z" value="<%=z%>"  />
						    	<jsp:param name="userType" value="<%=userType%>"  />
						    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
						    	<jsp:param name="addDate" value="<%=addDate%>"  />
						    	<jsp:param name="i" value="<%=i%>"  />
						    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
				       		</jsp:include>
				<%
						}
						out.print("</TR>");
					}
					//<画行>
					out.print("<TR bgcolor='"+v_bgcolor+"'class='content_tr' >");
					out.print("<TD width='1%'><input type='button' name='addSegment"+fieldGrpNo[i]+"' class='b_text'  value='删除' onclick='segmentDel(this)'></TD>");
					for(int j=0;j<colNum;j++)
					{
						p=beginGroup+k+j*rowNum;
						z = p;
		request.setAttribute("dataTypes",dataTypes);
		request.setAttribute("fieldCodes",fieldCodes);
		request.setAttribute("updateFlag",updateFlag);
		request.setAttribute("fieldValues",fieldValues);
		request.setAttribute("fieldParamCodes",fieldParamCodes);
		request.setAttribute("fieldLengths",fieldLengths);
		request.setAttribute("fieldParamSql",fieldParamSql);
		request.setAttribute("hm",hm);
		request.setAttribute("fieldCtrlInfos",fieldCtrlInfos);
		request.setAttribute("fieldNames",fieldNames);
		%>
		    <jsp:include page="/npage/s3691/fpubDynaFields_comm.jsp">
		    	<jsp:param name="z" value="<%=z%>"  />
		    	<jsp:param name="userType" value="<%=userType%>"  />
		    	<jsp:param name="groupUserId" value="<%=groupUserId%>"  />
		    	<jsp:param name="addDate" value="<%=addDate%>"  />
		    	<jsp:param name="i" value="<%=i%>"  />
		    	    <jsp:param name="smCode" value="<%=paramsArray[9]%>"  />
		    	<jsp:param name="busiFlag" value="<%=busiFlag%>"  />
		    	<jsp:param name="v_region_code" value="<%=v_region_code%>"  />
        </jsp:include>
						<%
					}
					out.print("</TR>");
				}
				
				isNextGroup=1;
				haveField=0;
				rowNum=1;
				colNum=1;
				
				//out.println("</TABLE>");
				if(!"0".equals(manyPropertys[i])){
			    out.println("</div>");
			  }
			}
			
		}//如果不是最后一行
	}
}
		
		%>
	</tr>
		<TABLE cellSpacing=0>
			 
			 
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
var openFlagJS = "";
var openFlagJSNew = "";
<%
int len=0;
        
        
        	Vector v = new Vector();
     		
     		//组nei
        	while(len<fieldCount)
        	{
        	
	        	if(v.contains(fieldCodes[len]))
	        	{
	        			if(!fieldGrpNo[len].equals("0"))
	        	    {
	        	    System.out.println("gaopengooo121111111111111111===="+len);
				        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
				        	out.println("		rowno=rowno+eval("+manyPropertys[len]+")"+"+\"|\";");
				        	out.println("       openFlagJS=openFlagJS+\""+openFlag[len]+"\"+\"|\";");
		        	 }
	        	}
	        	else
	        	{
	        	  	 //组nei
	        	    if(!fieldGrpNo[len].equals("0"))
	        	    {
	        	    System.out.println("gaopengooo123333333333333333====="+len);
	        	    //int num = new Integer(fieldGroupNo[len]).intValue()+1;
	        	   		out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
				        	out.println("		rowno=rowno+eval("+manyPropertys[len]+")"+"+\"|\";");
				        	out.println("       openFlagJS=openFlagJS+\""+openFlag[len]+"\"+\"|\";");
		        	 }
		        	 //组wai
	        	    else
	        	    {
	        	    System.out.println("gaopengooo12444444444444444====="+len);
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno"+"+\"0|\";");
		        	out.println("       openFlagJS=openFlagJS+\""+openFlag[len]+"\"+\"|\";");
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
		        	out.println("       openFlagJSNew=openFlagJSNew+\""+openFlagNew[len]+"\"+\"|\";");
		        	len++;
        	}

%>
document.frm.nameList.value=nl;
document.frm.nameGroupList.value=rowno;
document.frm.openFlagList.value = openFlagJS;
document.frm.nameListNew.value=nlNew;
document.frm.nameGroupListNew.value=rownoNew;
document.frm.openFlagListNew.value = openFlagJSNew;
	
}

//alert(calcFieldValue);

function checkshuzi(obj) {
	
	        if(!isNaN(obj.value)){
            var dot = obj.value.indexOf(".");
            if(dot != -1){
                var dotCnt = obj.value.substring(dot+1,obj.value.length);
                if(dotCnt.length > 2){
                    rdShowMessageDialog("小数点后最多保留两位，请重新输入！");
				            obj.select();
				            obj.focus();                    
                }
            }
        }else{
            rdShowMessageDialog("输入的值不合法，请重新输入！");
            obj.select();
            obj.focus();
        }
}

</script>
