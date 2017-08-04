
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>

<%
String opName  = "设置属性关系";
String opCode = "";
String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));

String[][] smparasetArr = new String[][]{};
String[][] fieldcodeArr = new String[][]{};
String sqlStr2 = "select distinct b.param_set as code,b.param_set||'-->'||b.set_name as name from sbizparamdetail a,sbizparamset b where a.param_set=b.param_set";
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
    smparasetArr = retArr;
    sqlStr2 = "select b.param_code as param_code,b.param_code||'-->'||b.param_name as param_name from sbizparamdetail a,sbizparamcode b where a.param_set='1001' and a.param_code=b.param_code " +
			 " union " +
			 " select 'YWDM0' as param_code,'YWDM0-->业务代码' as param_name  from dual ";
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode2" retmsg="retMsg2" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr2%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr2" scope="end"/>
<%
    fieldcodeArr = retArr2;
%>

<head>


<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script language="javascript">
	
	function queryMod(vcharacternum,v_id)
{	
	  
     var packet = new AJAXPacket("s2039EndPro.jsp","请稍候......");
	  packet.data.add("vcharacternum",vcharacternum);
	  packet.data.add("v_id",v_id);
	  packet.data.add("tempflag","3");
	  
	   core.ajax.sendPacket(packet);
	  
		 packet =null;				
}

	function queryMod1(vcharacternum,v_id,productspec_number)
{	
	  var smparasetValue=document.getElementById('smparaset'+v_id.trim()).value;
	  var selectObj = document.getElementById('fieldcode'+v_id.trim());
	  //alert(selectObj.value);
	  var fieldValue=document.getElementById('fieldcode'+v_id.trim()).value;
	  var fieldtxt = selectObj.options[selectObj.selectedIndex].text;
	  fieldtxt = fieldtxt.substring(fieldtxt.indexOf("-->")+3);
	  
	  //alert(fieldtxt);
	  
	  //alert(document.getElementById('fieldcode'+v_id.trim()).value);
    var packet = new AJAXPacket("s2039EndPro.jsp","请稍候......");
	  packet.data.add("vcharacternum",vcharacternum);
	  packet.data.add("smparasetValue",smparasetValue);
	  packet.data.add("fieldValue",fieldValue);
	  packet.data.add("fieldtxt",fieldtxt);
	  packet.data.add("v_id",v_id);
	  packet.data.add("tempflag","4");
	  packet.data.add("productNum",productspec_number);
	  
	  core.ajax.sendPacket(packet);
	  
		packet =null;				
}

function tochange(v_id)
{
	
	document.getElementById('fieldcode'+v_id.trim()).length=0;
	
	var mode_type=document.getElementById('smparaset'+v_id.trim()).value;

	
	var sqlStr ="";
	
	if(mode_type.length==4)
	{
			  //sqlStr= " select b.param_code,b.param_code||'-->'||b.param_name as param_name from sbizparamdetail a,sbizparamcode b where a.param_set='"+mode_type+"' and a.param_code=b.param_code   union select 'YWDM0' as param_code,'YWDM0-->业务代码' as param_name  from dual ";	
			  
			  var sqlStr = "90000083" ;
				var params = mode_type+"|";
				var outNum = "2";
	}
	else
	{
		   //sqlStr="select  b.field_code,b.field_code||'-->'||b.field_name from sgrpsmfieldrela a,suserfieldcode b where a.user_type='"+mode_type+"' and a.field_code=b.field_code ";
		    var sqlStr = "90000084" ;
				var params = mode_type+"|";
				var outNum = "2";
	}
		var myPacket = new AJAXPacket("select_rpc.jsp","正在获得属性代码信息，请稍候......");
		myPacket.data.add("retType","changSmParaSet");
		myPacket.data.add("sqlStr",sqlStr);
		myPacket.data.add("params",params);
		myPacket.data.add("outNum",outNum);
		myPacket.data.add("v_id",v_id);
		core.ajax.sendPacket(myPacket);
		myPacket=null;

}

function doProcess(packet)
{
		var retType = packet.data.findValueByName("retType");
	   	var retFlag = packet.data.findValueByName("retFlag");
	   	var v_id= packet.data.findValueByName("v_id");
	   	var fieldValue=packet.data.findValueByName("fieldValue");
	   	var fieldtxt=packet.data.findValueByName("fieldtxt");
	   //alert(retFlag);
	   	
	  if(retType == "changSmParaSet")
	  {  	
	  	
	  	var triListData = packet.data.findValueByName("tri_list"); 
  
	 		var triList=new Array(triListData.length);

	  	triList[0]="fieldcode"+v_id.trim();
	
	  	document.getElementById('fieldcode'+v_id.trim()).length=0;

	  	document.getElementById('fieldcode'+v_id.trim()).options.length=triListData.length;

	  	for(j=0;j<triListData.length;j++)
	  	{
			document.getElementById('fieldcode'+v_id.trim()).options[j].text=triListData[j][1];
			document.getElementById('fieldcode'+v_id.trim()).options[j].value=triListData[j][0];
	  	}
	  	if(triListData.length!=0){
	  		 document.getElementById('fieldcode'+v_id.trim()).options[0].selected=true; 
	  		 //alert(document.all("subsm_code").options[0].value);
	  		}
	  	
    }
    else
    { 
	   	
	   	if(retType!="3")
	   	{
	   			if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("设置属性关系失败"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("操作成功！");
	   				document.getElementById('code'+v_id.trim()).value=fieldValue;
	   				document.getElementById('codename'+v_id.trim()).value=fieldtxt;
	   				//window.refresh();
	   			}
	   }
	   else
	   {
	   	  if(retFlag!="0")
	   			{
	   				rdShowMessageDialog("删除属性对应关系失败"+retType);
					  return;
	   			}
	   			else
	   			{
	   				rdShowMessageDialog("操作成功！");
	   				
	   				  document.getElementById('code'+v_id.trim()).value="";
	   				 	 document.getElementById('codename'+v_id.trim()).value="";
	   				 	 //document.getElementById('operdel'+v_id.trim()).disabled=true;
	   				
	   				//window.refresh();
	   			}
	   	
	   }
	  }
}
	
	
</script>

</head>

<%
	Logger logger = Logger.getLogger("f5102.jsp");
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String  implRegion = baseInfo[0][16].substring(0,2);
%>

<%
	String sqlStr = " select a.pospec_number,a.productspec_number,c.productspec_name, "
	              + " a.productcharacter_num,a.productcharacter_name,b.field_code,b.character_name "
	              +" from dproductcharacterinfo a,sprodcharactercode b,dproductspecinfo c "
                +" where a.productcharacter_num=b.character_number(+) and a.pospec_number=c.pospec_number "
                + " and a.productspec_number=c.productspec_number "
                +" and a.pospec_number like '?%' "
                +" and a.productspec_number like '?%' "
                +" order by a.productspec_number ";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	
	String PospecNum = request.getParameter("PospecNum")==null?"":request.getParameter("PospecNum"); 
	String PospecProNum = request.getParameter("PospecProNum")==null?"":request.getParameter("PospecProNum"); 
	
	System.out.println("PospecNum="+PospecNum);
	System.out.println("PospecProNum="+PospecProNum);
	
		System.out.println("sqlStr="+sqlStr);
		
		String vregion="";
		String v_id="";
		String vmode="";
		 
	
%>

<wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		 select a.pospec_number,a.productspec_number,c.productspec_name,a.productcharacter_num,a.productcharacter_name,b.field_code,b.character_name,decode(substr(a.character_attr_code,1,1),'0','否','1','是') from dproductcharacterinfo a,sprodcharactercode b,dproductspecinfo c
    where a.productcharacter_num=b.character_number(+) and a.pospec_number=c.pospec_number and a.productspec_number=c.productspec_number
    and a.pospec_number like '?%'
    and a.productspec_number like '?%'
    order by a.productspec_number
</wtc:sql>
	<wtc:param value="<%=PospecNum%>" />	
	<wtc:param value="<%=PospecProNum%>" />	
</wtc:pubselect>

<wtc:array id="rateCodeStr" scope="end" />
	
	
<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="/npage/include/header_pop.jsp" %>   
<form name="form1" method="post" action="">	
	 <div style="height: 360px;width: 99%;overflow: auto">
  <table cellspacing=0>		

			<tr>		
				<th nowrap align='center'><b>商品规格编码</b></th>
				<th nowrap align='center'><b>产品规格编码</b></th>
				<th nowrap align='center'><b>产品规格名称</b></th>
				<th nowrap align='center'><b>BBOSS属性代码</b></th>
				<th nowrap align='center'><b>BBOSS属性名称</b></th>
				<th nowrap align='center'><b>对应BOSS属性代码</b></th>
				<th nowrap align='center'><b>对应BOSS属性名称</b></th>
				<th nowrap align='center'><b>品牌或参数集</b></td>
				<th nowrap align='center'><b>BOSS属性代码</b></td>
				<th nowrap align='center' colspan="2"><b>操作</b></th>
				
		</tr>
		
<%	
	
		for(int i = 0; i < rateCodeStr.length; i++)
		{		
		    
%>		
		<tr>			
				<td nowrap align='center'><%=rateCodeStr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=rateCodeStr[i][4].trim()%>&nbsp;</td>
				
				<td nowrap align='center'>
					<input name="code<%=i+1%>" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][5].trim()%>" />&nbsp;
				</td>
				<td nowrap align='center'><input name="codename<%=i+1%>" type="text" style="text-align:center" Class="InputGrey" value="<%=rateCodeStr[i][6].trim()%>" />&nbsp;</td>
				<td nowrap style='width:180px;'>
					
					<select name="smparaset<%=i+1%>" v_must="1" onChange="tochange('<%=i+1%>')" >

		            </select>
				</td>
				<td nowrap style='width:200px;'>
					
					<select name="fieldcode<%=i+1%>" v_must="1"  >

		            </select>
				</td>	
				<td align="center">
					
				  <input name="operdel<%=i+1%>" style="cursor:hand"  type="button" value="设置" class="b_text" onclick="queryMod1('<%=rateCodeStr[i][3].trim()%>','<%=i+1%>','<%=rateCodeStr[i][1].trim()%>')"  />
				  
				</td>
			<td align="center">
				
				  <input name="operde2<%=i+1%>" style="cursor:hand"  type="button" value="删除" class="b_text" onclick="queryMod('<%=rateCodeStr[i][3].trim()%>','<%=i+1%>')"   />
				
				</td>
				</td>	
			</tr>
<%
    }
%>	
		
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
</TABLE>
</div>

</form>
<%@ include file="/npage/include/footer.jsp" %>      
<script type="text/javascript">
    $(document).ready(function(){
        <%
        String strArray = WtcUtil.createArray("smparasetArr",smparasetArr.length);
        System.out.println(strArray);
        %>
            <%=strArray%>
        <%
        for(int i = 0 ; i < smparasetArr.length ; i ++){
            for(int j = 0 ; j < smparasetArr[i].length; j ++){
                System.out.println(smparasetArr[i][j].trim());
            %>
                smparasetArr[<%=i%>][<%=j%>] = "<%=smparasetArr[i][j].trim()%>";
            <%
            }
        }
        %>
        
        var temLength = smparasetArr.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+smparasetArr[i][0]+">" +smparasetArr[i][1] + "</OPTION>";
		}
		$("select[name^='smparaset']").empty();
      	$(arr.join("")).appendTo("select[name^='smparaset']");
      	
        <%
        strArray = WtcUtil.createArray("fieldcodeArr",fieldcodeArr.length);
        System.out.println(strArray);
        %>
            <%=strArray%>
        <%
        for(int i = 0 ; i < fieldcodeArr.length ; i ++){
            for(int j = 0 ; j < fieldcodeArr[i].length; j ++){
                System.out.println(fieldcodeArr[i][j].trim());
            %>
                fieldcodeArr[<%=i%>][<%=j%>] = "<%=fieldcodeArr[i][j].trim()%>";
            <%
            }
        }
        %>
        
        temLength = fieldcodeArr.length;
		arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+fieldcodeArr[i][0]+">" +fieldcodeArr[i][1] + "</OPTION>";
		}
		$("select[name^='fieldcode']").empty();
      	$(arr.join("")).appendTo("select[name^='fieldcode']");
    })
</script>
</body>
</html>